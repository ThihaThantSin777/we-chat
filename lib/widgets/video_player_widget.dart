import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/resources/strings.dart';


class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key,required this.url}) : super(key: key);
  final String url;
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late FlickManager flickManager;

  @override
  void initState(){
    super.initState();
    if(widget.url!=kDefaultImage){
      flickManager = FlickManager(
        autoPlay: false,
        videoPlayerController:
        VideoPlayerController.network(widget.url),
      );
    }
  }

  @override
  void dispose(){
    super.dispose();
    flickManager.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(flickManager: flickManager);
  }
}
