

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

class WeChatScanProfilePageBloc extends ChangeNotifier{
///State Variable
  bool _isDisposed=false;
  bool _loading=false;
  bool _alreadyFri=false;
  UserVO ? _userVO;


  ///Getter
  UserVO ? get getUserVO=>_userVO;
  bool get isLoading=>_loading;
  bool get isAlreadyFri=>_alreadyFri;

  ///Model
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();


  WeChatScanProfilePageBloc(String? id){
     if(id!=null && id.isNotEmpty){
       _weChatAuthModel.getLoggedInUserInfoByID(id).then((value) {
         _userVO=value;
         _notifySafely();
       });
     }
    _weChatAuthModel.getContactList().listen((event) {
      event.forEach((element) {
        if(element.id.toString()==_userVO?.id.toString()){
          _alreadyFri=true;
          _notifySafely();
        }
      });
    });
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