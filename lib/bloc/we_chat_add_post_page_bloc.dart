import 'dart:io';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_modeLimpl.dart';
import 'package:wechat_app/data/model/we_chat_model.dart';

class WeChatAddPostPageBloc extends ChangeNotifier {
  ///State Variable
  File? _photos;
  File? _videoFile;
  bool _isDisposed = false;
  VideoPlayerController? _videoPlayer;
  bool _loading = false;
  String _description = '';

  ///Getter
  VideoPlayerController? get getVideos => _videoPlayer;
  File? get getPhotos => _photos;
  File? get getVideoFiles => _videoFile;
  bool get isLoading => _loading;
  String get getDescription => _description;

  ///Model
  final WeChatModel _weChatModel = WeChatModelImpl();
  void setPhotos(File photos) {
    _photos = photos;
    _notifySafely();
  }

  Future<void> addPost(int id) {
    if (id == -1) {
      _loading = true;
      _notifySafely();
      return _weChatModel
          .addNewPost(_description, _photos, _videoFile)
          .then((_) {
        _loading = false;
        _notifySafely();
      });
    } else {
      return Future.value('Data');
    }
  }

  void setDescription(String description) {
    _description = description;
    _notifySafely();
  }

  void setVideos(VideoPlayerController vl, File file) {
    if (file.path.isNotEmpty) {
      _videoFile = file;
    }
    vl
      ..addListener(() {})
      ..initialize().then((_) {
        _videoPlayer?.play();
      });
    _videoPlayer = vl;
    _notifySafely();
  }

  void removePhoto() {
    _photos = null;
    _notifySafely();
  }

  void removeVideo() {
    _videoPlayer = null;
    _notifySafely();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayer?.dispose();
    _isDisposed = true;
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
