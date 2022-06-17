

import 'package:flutter/material.dart';

class WeChatImageDetailsPageBloc extends ChangeNotifier {
///State Variable
  bool _isDisposed=false;
  String _imageLink='';


  ///Getter
  String get getImageLink=>_imageLink;

  WeChatImageDetailsPageBloc(String imageLink){
    _imageLink=imageLink;
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

