import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/bloc/we_chat_discover_page_bloc.dart';
import 'package:wechat_app/resources/dimension.dart';

import 'package:wechat_app/view_items/we_chat_discover_item_views/we_chat_discover_item_views.dart';
import 'package:wechat_app/widgets/loading_widget.dart';
import 'package:wechat_app/widgets/video_player_widget.dart';

class WeChatAddPostPage extends StatelessWidget {
  WeChatAddPostPage({Key? key, this.id = -1}) : super(key: key);
  final int id;
  final formKey = GlobalKey<FormState>();



  Widget addOrEditImage(WeChatDiscoverPageBloc bloc){
    if(id==-1){
      return
        (bloc.getPhotos == null)
          ? Container()
          : Stack(
        children: [
          Image.file(
            bloc.getPhotos!,
            fit: BoxFit.cover,
          ),
          IconButton(
              onPressed: () => _removePhoto(bloc),
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ))
        ],
      );
    }
    return (bloc.getImageNetWorkLink.isEmpty)
        ? Container()
        : Stack(
      children: [
        Image.network(bloc.getImageNetWorkLink),
        IconButton(
            onPressed: () => _removePhoto(bloc),
            icon: const Icon(
              Icons.cancel,
              color: Colors.red,
            ))
      ],
    );

  }

  Widget addOrEditVideo(WeChatDiscoverPageBloc bloc){
    if(id==-1){
      return
        (bloc.getVideos == null)
            ? Container()
            : VideoItemView(
            videoPlayerController:
            bloc.getVideos!,
            onPressed: () => _removeVideos(bloc)
        );
    }
    return (bloc.getVideoNetWorkLink.isEmpty)
        ? Container()
        : Stack(
      children: [
        VideoPlayerWidget(url: bloc.getVideoNetWorkLink),
        IconButton(
            onPressed: () => _removeVideos(bloc),
            icon: const Icon(
              Icons.cancel,
              color: Colors.red,
            ))
      ],
    );

  }

  void _openBottomSheet(
      BuildContext context, WeChatDiscoverPageBloc weChatAddPostPageBloc) {
    showModalBottomSheet(
        context: context,
        builder: (context) => PhotoAndVideosChooseItemView(
              onTap: (text) async {
                navigateBack(context);
                if (text == 'Photos') {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'png'],
                  );

                  if (result != null) {
                    List<File> files =
                        result.paths.map((path) => File(path ?? '')).toList();
                    weChatAddPostPageBloc.setPhotos(files.first);
                  }
                } else if (text == 'Videos') {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['mp4'],
                  );
                  if (result != null) {
                    File file = File(result.files.single.path ?? '');
                    weChatAddPostPageBloc.setVideos(
                        VideoPlayerController.file(file), file);
                  }
                }
              },
            ));
  }

  void _removePhoto(WeChatDiscoverPageBloc weChatAddPostPageBloc) {
    weChatAddPostPageBloc.removePhoto();
  }

  void _removeVideos(WeChatDiscoverPageBloc weChatAddPostPageBloc) {
    weChatAddPostPageBloc.removeVideo();
  }

  void _post(
      WeChatDiscoverPageBloc weChatAddPostPageBloc, BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      weChatAddPostPageBloc.addPost(id).then((_) => navigateBack(context));
    }
  }

  void _changeDescription(
      String description, WeChatDiscoverPageBloc weChatAddPostPageBloc) {
    weChatAddPostPageBloc.setDescription(description);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatDiscoverPageBloc>(
      create: (context) => WeChatDiscoverPageBloc((id == -1)?null:id),
      child: Scaffold(
          appBar: AppBar(
            title: Text((id == -1) ? 'Add Post' : 'Edit Post'),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
            actions: [
              Consumer<WeChatDiscoverPageBloc>(
                builder: (context, bloc, child) => GestureDetector(
                    onTap: () => _post(bloc, context),
                    child: Center(child: Text((id == -1) ? 'POST' : 'EDIT'))),
              ),
              const SizedBox(
                width: kPadSpace10x,
              ),
            ],
          ),
          body: Selector<WeChatDiscoverPageBloc, bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) => Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: kPadSpace10x),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Consumer<WeChatDiscoverPageBloc>(
                            builder: (context, bloc, child) => ProfileItemView(
                                onPressed: () =>
                                    _openBottomSheet(context, bloc)),
                          ),
                          Selector<WeChatDiscoverPageBloc, String>(
                            selector: (context, bloc) => bloc.getDescription,
                            builder: (context, desc, child) =>
                                PostTextFieldView(
                                    formState: formKey,
                                    onChanged: (string) => _changeDescription(
                                        string,
                                        context.read<WeChatDiscoverPageBloc>()),
                                    preText: desc),
                          ),
                          Consumer<WeChatDiscoverPageBloc>(
                            builder: (context, bloc, child) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadSpace20x,
                                    vertical: kPadSpace20x),
                                child: ListView(
                                  children: [
                                    addOrEditVideo(bloc),
                                    const SizedBox(
                                      height: kPadSpace20x,
                                    ),
                                    addOrEditImage(bloc),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Visibility(visible: isLoading, child: const LoadingWidget()),
              ],
            ),
          )),
    );
  }
}
