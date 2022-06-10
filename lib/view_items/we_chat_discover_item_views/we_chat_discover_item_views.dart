import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/data/vos/add_post_vo/add_post_vo.dart';
import 'package:wechat_app/resources/dimension.dart';

class PostTextFieldView extends StatelessWidget {
  const PostTextFieldView(
      {Key? key, required this.formState, required this.onChanged})
      : super(key: key);
  final GlobalKey<FormState> formState;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kPadSpace10x, vertical: kPadSpace10x),
      child: Form(
          key: formState,
          child: TextFormField(
            onChanged: (string) => onChanged(string),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (string) {
              if (string?.isEmpty ?? true) {
                return 'required';
              }
              return null;
            },
            maxLines: null,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: 'What is in your mind?'),
          )),
    );
  }
}

class ProfileItemView extends StatelessWidget {
  const ProfileItemView({Key? key, required this.onPressed}) : super(key: key);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')),
      title: const Text('Thiha Thant Sin'),
      trailing: IconButton(
          onPressed: () => onPressed(), icon: const Icon(Icons.open_with)),
    );
  }
}

class PhotoAndVideosChooseItemView extends StatelessWidget {
  const PhotoAndVideosChooseItemView({Key? key, required this.onTap})
      : super(key: key);
  final Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kPadSpace20x),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: addPostVoList
              .map(
                (data) => Expanded(
                  child: ListTile(
                    onTap: () => onTap(data.name),
                    minLeadingWidth: 0,
                    contentPadding: const EdgeInsets.all(0),
                    leading: data.icon,
                    title: Text(data.name),
                  ),
                ),
              )
              .toList()),
    );
  }
}

class VideoItemView extends StatelessWidget {
  const VideoItemView(
      {Key? key, required this.videoPlayerController, required this.onPressed})
      : super(key: key);
  final VideoPlayerController videoPlayerController;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: VideoPlayer(videoPlayerController)),
      IconButton(
          onPressed: () => onPressed(),
          icon: const Icon(
            Icons.cancel,
            color: Colors.red,
          ))
    ]);
  }
}
