import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/bloc/we_chat_add_post_page_bloc.dart';
import 'package:wechat_app/bloc/we_chat_discover_page_bloc.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/view_items/we_chat_discover_item_views/we_chat_add_post_item_views.dart';
import 'package:wechat_app/widgets/flick_manager_video.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

///AlertBox
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


///Add Post Methods
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

void postDelete(WeChatDiscoverPageBloc weChatDiscoverPageBloc,int id,BuildContext context){
  weChatDiscoverPageBloc.deletePost(id).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: kPrimaryLightColor,
            content: Text('1 post delete',style: TextStyle(color: Colors.white),)
        )
    );
  });
}
