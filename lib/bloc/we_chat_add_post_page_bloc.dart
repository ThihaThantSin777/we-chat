import 'dart:io';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';

class WeChatAddPostPageBloc extends ChangeNotifier {
  ///State Variable
  List<File>? _photos;
  bool _isDisposed = false;
  List<FlickManager>? _flicks;

  List<FlickManager>? get getFlicks => _flicks;
  List<File>? get getPhotos => _photos;

  void setPhotos(List<File> photos) {
    _photos = photos;
    _notifySafely();
  }

  void setVideos(List<File> vidoes) {
    List<FlickManager> temp = [];
    vidoes.forEach((file) {
      FlickManager flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.file(file),
      );
      temp.add(flickManager);
    });

    _flicks = temp;
    print('Flickersss =>$_flicks');
    _notifySafely();
  }

  void removePhoto(File file) {
    _photos?.remove(file);
    List<File> temp = _photos?.map((data) => data).toList() ?? [];
    _photos = temp;
    _notifySafely();
  }

  void removeVideo(FlickManager flickManager) {
    _flicks?.remove(flickManager);
    List<FlickManager> temp = _flicks?.map((data) => data).toList() ?? [];
    _flicks = temp;
    _notifySafely();
  }

  @override
  void dispose() {
    super.dispose();
    _flicks?.forEach((flickManager) {
      flickManager.dispose();
    });
    _isDisposed = true;
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
