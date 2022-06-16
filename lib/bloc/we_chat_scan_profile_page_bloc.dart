

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

class WeChatScanProfilePageBloc extends ChangeNotifier{
///State Variable
  bool _isDisposed=false;
  bool _loading=false;
  UserVO ? _userVO;


  ///Getter
  UserVO ? get getUserVO=>_userVO;
  bool get isLoading=>_loading;

  ///Model
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();


  WeChatScanProfilePageBloc(String? id){
     if(id!=null && id.isNotEmpty){
       _weChatAuthModel.getLoggedInUserInfoByID(id).then((value) {
         _userVO=value;
         _notifySafely();
       });
     }

  }

  Future<void> addFriend(){
    _loading=true;
    _notifySafely();
   return _weChatAuthModel.addContact(_userVO?.id??'', _userVO??UserVO.normal()).then((value) {
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