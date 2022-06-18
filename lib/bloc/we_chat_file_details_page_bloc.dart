

import 'package:flutter/material.dart';

class WeChatFileDetailsPageBloc extends ChangeNotifier {
///State Variable
  bool _isDisposed=false;
  String _fileLink='';


  ///Getter
  String get getImageLink=>_fileLink;

  WeChatFileDetailsPageBloc(String fileLink){
    _fileLink=fileLink;
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

