import 'dart:io';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';

class WeChatAddPostPageBloc extends ChangeNotifier {
  ///State Variable
  List<File>? _photos;
  bool _isDisposed = false;
  VideoPlayerController? _videoPlayer;

  VideoPlayerController? get getVideos => _videoPlayer;
  List<File>? get getPhotos => _photos;

  void setPhotos(List<File> photos) {
    _photos = photos;
    _notifySafely();
  }

  void setVideos(VideoPlayerController vl) {
    vl
      ..addListener(() {
        // _notifySafely();
      })
      ..initialize().then((_) {
        _videoPlayer?.play();
      });
    _videoPlayer = vl;
    _notifySafely();
  }

  void removePhoto(File file) {
    _photos?.remove(file);
    List<File> temp = _photos?.map((data) => data).toList() ?? [];
    _photos = temp;
    _notifySafely();
  }

  void removeVideo() {
    _videoPlayer = null;
    _notifySafely();
  }

  @override
  void dispose() {
    super.dispose();
    // _flicks?.forEach((flickManager) {
    //   flickManager.dispose();
    // });
    _videoPlayer?.dispose();
    _isDisposed = true;
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
