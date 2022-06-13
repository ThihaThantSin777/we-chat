import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';



class VideoPlayerControllerWidget extends StatefulWidget {
  const VideoPlayerControllerWidget(
      {Key? key, required this.videoPlayerController, required this.onPressed})
      : super(key: key);
  final VideoPlayerController videoPlayerController;
  final Function onPressed;

  @override
  State<VideoPlayerControllerWidget> createState() => _VideoPlayerControllerWidgetState();
}

class _VideoPlayerControllerWidgetState extends State<VideoPlayerControllerWidget> {


  @override
  void dispose(){
    super.dispose();
    widget.videoPlayerController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AspectRatio(
          aspectRatio: widget.videoPlayerController.value.aspectRatio,
          child: VideoPlayer(widget.videoPlayerController)),
      IconButton(
          onPressed: () => widget.onPressed(),
          icon: const Icon(
            Icons.cancel,
            color: Colors.red,
          ))
    ]);
  }
}