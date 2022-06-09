import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/bloc/we_chat_add_post_page_bloc.dart';
import 'package:wechat_app/resources/dimension.dart';

import 'package:wechat_app/view_items/we_chat_discover_item_views/we_chat_discover_item_views.dart';
import 'package:wechat_app/widgets/tween_animation_builder_widget.dart';

class WeChatAddPostPage extends StatelessWidget {
  WeChatAddPostPage({Key? key, this.id = -1}) : super(key: key);
  final int id;
  final formKey = GlobalKey<FormState>();
  void _openBottomSheet(
      BuildContext context, WeChatAddPostPageBloc weChatAddPostPageBloc) {
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
                    weChatAddPostPageBloc.setPhotos(files);
                  }
                } else if (text == 'Videos') {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['mp4'],
                  );
                  if (result != null) {
                    File file = File(result.files.single.path ?? '');
                    weChatAddPostPageBloc
                        .setVideos(VideoPlayerController.file(file));
                  }
                }
              },
            ));
  }

  void _removePhoto(File file, WeChatAddPostPageBloc weChatAddPostPageBloc) {
    weChatAddPostPageBloc.removePhoto(file);
  }

  void _removeVideos(WeChatAddPostPageBloc weChatAddPostPageBloc) {
    weChatAddPostPageBloc.removeVideo();
  }

  void _post() {
    if (formKey.currentState?.validate() ?? false) {}
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatAddPostPageBloc>(
      create: (context) => WeChatAddPostPageBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: Text((id == -1) ? 'Add Post' : 'Edit Post'),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
            actions: [
              GestureDetector(
                  onTap: () => _post(),
                  child: Center(child: Text((id == -1) ? 'POST' : 'EDIT'))),
              const SizedBox(
                width: kPadSpace10x,
              ),
            ],
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: kPadSpace10x),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Consumer<WeChatAddPostPageBloc>(
                          builder: (context, bloc, child) => ProfileItemView(
                              onPressed: () => _openBottomSheet(context, bloc)),
                        ),
                        PostTextFieldView(
                          formState: formKey,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadSpace20x,
                                vertical: kPadSpace20x),
                            child: ListView(
                              children: [
                                Selector<WeChatAddPostPageBloc,
                                        VideoPlayerController?>(
                                    shouldRebuild: (pre, next) => pre != next,
                                    selector: (context, bloc) => bloc.getVideos,
                                    builder: (context, videoPlayerController,
                                            child) =>
                                        (videoPlayerController == null)
                                            ? Container()
                                            : VideoItemView(
                                                videoPlayerController:
                                                    videoPlayerController,
                                                onPressed: () => _removeVideos(
                                                    context.read<
                                                        WeChatAddPostPageBloc>()))),
                                Selector<WeChatAddPostPageBloc, List<File>?>(
                                  shouldRebuild: (pre, next) => pre != next,
                                  selector: (context, bloc) => bloc.getPhotos,
                                  builder: (context, files, child) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: files
                                              ?.map((data) => Stack(
                                                    children: [
                                                      Image.file(
                                                        data,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      IconButton(
                                                          onPressed: () =>
                                                              _removePhoto(
                                                                  data,
                                                                  context.read<
                                                                      WeChatAddPostPageBloc>()),
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                          ))
                                                    ],
                                                  ))
                                              .toList() ??
                                          []),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
