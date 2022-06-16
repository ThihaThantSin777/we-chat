import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';

class WeChatProfilePageBloc extends ChangeNotifier{
  ///State Variable
  bool _isDisposed = false;
  bool _loading=false;


  ///Getter
  bool get isLoading=>_loading;

  final WeChatAuthModel _auth=WeChatAuthModelImpl();



  Future<void> logout(){
    _loading=true;
    _notifySafely();
    return _auth.logout().then((value) {
      _loading=false;
      _notifySafely();
    });
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