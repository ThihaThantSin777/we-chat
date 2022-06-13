import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/resources/strings.dart';


class FlickManagerVideoWidget extends StatefulWidget {
  const FlickManagerVideoWidget({Key? key,required this.url,required this.filePath}) : super(key: key);
  final String url;
  final String filePath;
  @override
  State<FlickManagerVideoWidget> createState() => _FlickManagerVideoWidgetState();
}

class _FlickManagerVideoWidgetState extends State<FlickManagerVideoWidget> {
  late FlickManager flickManager;

  @override
  void initState(){
    super.initState();
    if(widget.url!=kDefaultImage && widget.url.isNotEmpty){
      flickManager = FlickManager(
        autoPlay: false,
        videoPlayerController:
        VideoPlayerController.network(widget.url),
      );
    }else{
      flickManager = FlickManager(
        autoPlay: true,
        videoPlayerController:
        VideoPlayerController.file(File(widget.filePath)),
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
