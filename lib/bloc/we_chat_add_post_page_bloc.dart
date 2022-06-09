import 'dart:io';

import 'package:flutter/material.dart';

class WeChatAddPostPageBloc extends ChangeNotifier {
  ///State Variable
  List<File>? _photos;
  bool _isDisposed = false;

  List<File>? get getPhotos => _photos;

  void setPhotos(List<File> photos) {
    _photos = photos;
    _notifySafely();
  }

  void removePhoto(File file) {
    _photos?.remove(file);
    List<File> temp = _photos?.map((data) => data).toList() ?? [];
    _photos = temp;
    _notifySafely();
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
