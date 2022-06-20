import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/bloc/we_chat_add_post_page_bloc.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/view_items/we_chat_discover_item_views/we_chat_add_post_item_views.dart';
import 'package:wechat_app/widgets/flick_manager_video.dart';
import 'package:wechat_app/widgets/loading_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

class WeChatAddPostPage extends StatelessWidget {
  WeChatAddPostPage({Key? key, this.id = -1}) : super(key: key);
  final int id;
  final formKey = GlobalKey<FormState>();

  Future<void> showMyDialog(BuildContext context,String title,String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Widget addOrEditImage(WeChatAddPostPageBloc bloc) {
    if (bloc.getPhotos != null) {
      return Stack(
        children: [
          Image.file(
            bloc.getPhotos!,
            fit: BoxFit.cover,
          ),
          IconButton(
              onPressed: () => removePhoto(bloc),
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ))
        ],
      );
    }

    if (bloc.getPhotos == null && bloc.getImageNetWorkLink.isNotEmpty) {
      return Stack(
        children: [
          CachedNetworkImage(
            imageUrl: bloc.getImageNetWorkLink,
            placeholder: (context,string)=>const WaitingWidget(),
            fit: BoxFit.cover,
          ),

          IconButton(
              onPressed: () => removePhoto(bloc),
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ))
        ],
      );
    }
    return Container();
  }

  Widget addOrEditVideo(WeChatAddPostPageBloc bloc) {
    if(bloc.getVideoFiles!=null){
      return   Stack(
        children: [
          FlickManagerVideoWidget(url: '',filePath: bloc.getVideoFiles?.path??'',),
          IconButton(
              onPressed: () => removeVideos(bloc),
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ))
        ],
      );

    }

    if(bloc.getVideoFiles==null && bloc.getVideoNetWorkLink.isNotEmpty){
      return
        Stack(
          children: [
            FlickManagerVideoWidget(url: bloc.getVideoNetWorkLink,filePath: '',),
            IconButton(
                onPressed: () => removeVideos(bloc),
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ))
          ],
        );
    }
    return Container();
  }

  void openBottomSheet(
      BuildContext context, WeChatAddPostPageBloc weChatAddPostPageBloc) {
    showModalBottomSheet(
      context: context,
      builder: (context) => PhotoAndVideosChooseItemView(
        onTap: (text) async {
          Navigator.of(context).pop();
          if (text == 'Photos' && (weChatAddPostPageBloc.getPhotos==null && weChatAddPostPageBloc.getImageNetWorkLink.isEmpty )) {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'png', 'gif'],
            );

            if (result != null) {
              File file= File(result.files.single.path ?? '');
              weChatAddPostPageBloc.setPhotos(file);
            }
          } else if (text == 'Videos' &&(weChatAddPostPageBloc.getVideoFiles==null && weChatAddPostPageBloc.getVideoNetWorkLink.isEmpty)) {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['mp4'],
            );
            if (result != null) {
              File file = File(result.files.single.path ?? '');
              weChatAddPostPageBloc.setVideos(
                  VideoPlayerController.file(file), file);
            }
          }else{
            showMyDialog(context, 'Warning', 'You cant select this field unless you remove.');
          }
        },
        isEnable:true,
      ),
    );
  }

  void removePhoto(WeChatAddPostPageBloc weChatAddPostPageBloc) {
    weChatAddPostPageBloc.removePhoto();
  }

  void removeVideos(WeChatAddPostPageBloc weChatAddPostPageBloc) {
    weChatAddPostPageBloc.removeVideo();
  }

  Future<void> post(WeChatAddPostPageBloc weChatAddPostPageBloc, int id,
      BuildContext context, GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() ?? false) {
      return weChatAddPostPageBloc.addPost(id).then((value) {
        Navigator.of(context).pop();
        if(id==-1){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: kPrimaryLightColor,
                  content: Text('1 post added',style: TextStyle(color: Colors.white),)
              )
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: kPrimaryLightColor,
                  content: Text('1 post edit',style: TextStyle(color: Colors.white),)
              )
          );
        }
      });
    }
    return Future.value('');
  }

  void changeDescription(
      String description, WeChatAddPostPageBloc weChatAddPostPageBloc) {
    weChatAddPostPageBloc.setDescription(description);
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatAddPostPageBloc>(
      create: (context) => WeChatAddPostPageBloc((id == -1)?null:id),
      child: Consumer<WeChatAddPostPageBloc>(
          builder: (context, bloc, child) {
            return    Scaffold(
              appBar: AppBar(
                title: Text((id == -1) ? 'Add Post' : 'Edit Post'),
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
                actions: [
                  GestureDetector(
                      onTap: () => post(bloc, id, context, formKey),
                      child: Center(child: Text((id == -1) ? 'POST' : 'EDIT'))),

                  const SizedBox(
                    width: kPadSpace10x,
                  ),
                ],
              ),
              body:  Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: kPadSpace10x),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Selector<WeChatAddPostPageBloc,String>(
                              selector: (context,bloc)=>bloc.getProfileName,
                              builder: (context,profileName,child)=>
                            Selector<WeChatAddPostPageBloc,String>(
                                selector: (context,bloc)=>bloc.getProfileImage,
                                builder: (context,profileImage,child)=>
                                (profileName.isEmpty || profileImage.isEmpty)?const WaitingWidget():   ProfileItemView(
                                  profileName: profileName,
                                  profileImage: profileImage,
                                  onPressed: () {
                                    openBottomSheet(context, bloc);
                                  },
                                ),
                            ),
                            ),
                            PostTextFieldView(
                                formState: formKey,
                                onChanged: (string) => changeDescription(
                                    string,
                                    context.read<WeChatAddPostPageBloc>()),
                                controller: bloc.getController??TextEditingController()),

                            Expanded(
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

                          ],
                        )),
                  ),
                  Visibility(visible: bloc.isLoading, child: const LoadingWidget()),
                ],
              ),

            );
          }

      ),
    );
  }
}
