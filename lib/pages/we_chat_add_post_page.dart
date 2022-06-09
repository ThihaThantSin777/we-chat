import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/bloc/we_chat_add_post_page_bloc.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/view_items/we_chat_discover_item_views/we_chat_discover_item_views.dart';
import 'package:flick_video_player/flick_video_player.dart';

class WeChatAddPostPage extends StatefulWidget {
  const WeChatAddPostPage({Key? key, this.id = -1}) : super(key: key);
  final int id;

  @override
  State<WeChatAddPostPage> createState() => _WeChatAddPostPageState();
}

class _WeChatAddPostPageState extends State<WeChatAddPostPage> {
  FlickManager? flickManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network("https://youtu.be/CZQ9ox8RRyA"),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flickManager?.dispose();
  }

  void _openBottomSheet(
      BuildContext context, WeChatAddPostPageBloc weChatAddPostPageBloc) {
    showModalBottomSheet(
        context: context,
        builder: (context) => PhotoAndVideosChooseItemView(
              onTap: (text) async {
                Navigator.of(context).pop();
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
                    allowMultiple: true,
                    type: FileType.custom,
                    allowedExtensions: ['mp4'],
                  );
                  if (result != null) {
                    List<File> files =
                        result.paths.map((path) => File(path ?? '')).toList();
                    weChatAddPostPageBloc.setVideos(files);
                  }
                }
              },
            ));
  }

  void _removePhoto(File file, WeChatAddPostPageBloc weChatAddPostPageBloc) {
    weChatAddPostPageBloc.removePhoto(file);
  }

  void _removeVideos(
      FlickManager flickManager, WeChatAddPostPageBloc weChatAddPostPageBloc) {
    weChatAddPostPageBloc.removeVideo(flickManager);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatAddPostPageBloc>(
      create: (context) => WeChatAddPostPageBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: Text((widget.id == -1) ? 'Add Post' : 'Edit Post'),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
            actions: [
              GestureDetector(
                  onTap: () {},
                  child:
                      Center(child: Text((widget.id == -1) ? 'POST' : 'EDIT'))),
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
                        const PostTextFieldView(),
                        Expanded(
                            child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadSpace10x,
                                  vertical: kPadSpace10x),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Selector<WeChatAddPostPageBloc, List<File>?>(
                                      shouldRebuild: (pre, next) => pre != next,
                                      selector: (context, bloc) =>
                                          bloc.getPhotos,
                                      builder: (context, files, child) =>
                                          Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: files
                                                      ?.map((data) => Stack(
                                                            children: [
                                                              Image.file(
                                                                data,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              IconButton(
                                                                  onPressed: () =>
                                                                      _removePhoto(
                                                                          data,
                                                                          context.read<
                                                                              WeChatAddPostPageBloc>()),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .cancel,
                                                                    color: Colors
                                                                        .red,
                                                                  ))
                                                            ],
                                                          ))
                                                      .toList() ??
                                                  [])),
                                  FlickVideoPlayer(flickManager: flickManager!)
                                ],
                              ),
                            )
                          ],
                        ))
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
