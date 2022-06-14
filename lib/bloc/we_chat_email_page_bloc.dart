

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

class WeChatEmailPageBloc extends ChangeNotifier{

  ///State Variable
  String _email='';
  String _errorEmailText='';
  bool _loading = false;
  bool _isDisposed = false;
  late UserVO _userVO;

  ///Getter
  String get getEmail=>_email;
  String get getErrorEmailText=>_errorEmailText;
  bool get isLoading=>_loading;

  ///Model
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();
  WeChatEmailPageBloc(UserVO userVO){
    _userVO=_userVO;
  }

  Future<void> registerNewUser(){
    _loading=true;
    _notifySafely();
    UserVO newUser=_userVO;
    newUser.email=_email;
  return  _weChatAuthModel.registerNewUser(newUser).then((value) {
      _loading=false;
      _notifySafely();
    });
  }
  void setEmail(String email){
    _email=email;
    _notifySafely();
  }

  void setErrorEmailText(String text){

    if(text.isEmpty){
      _errorEmailText='Error: Please enter email';
    }

    else if(!EmailValidator.validate(text)){
          _errorEmailText='Error: email is wrong format';
        }else{
      _errorEmailText='';
    }
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