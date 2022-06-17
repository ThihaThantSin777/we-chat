import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/extension.dart';

class WeChatLoginPageBloc extends ChangeNotifier{
  ///State Variable
  bool _loading = false;
  bool _isDisposed = false;
  String _email='';
  String _password='';
  String _emailErrorText='';
  String _passwordErrorText='';
  ///Getter
  bool get isLoading=>_loading;
  String get getEmail=>_email;
  String get getEmailErrorText=>_emailErrorText;
  String get getPassword=>_password;
  String get getPasswordErrorText=>_passwordErrorText;

  final WeChatAuthModel _authModel=WeChatAuthModelImpl();

  void setEmailText(String email){
    _email=email;
    _notifySafely();
  }
  void setPasswordText(String password){
    _password=password;
    _notifySafely();
  }

  void validate(String text,String preFix){
    switch(preFix){
      case kAccountText:
        _emailErrorText=_validateForEmail(text);
        break;
      case kPasswordText:
        _passwordErrorText=_validateForPassword(text);
        break;
    }
     _notifySafely();
  }
String _validateForEmail(String text){
   if(text.isEmpty){
    return 'Error: Please enter email';
   }else if(!text.isValidEmail()){
     return 'Error: Wrong email format';
   }
   return '';
}

  String _validateForPassword(String text){
    if(text.isEmpty){
      return 'Error: Please enter password';
    }
    return '';
  }
  Future login(){
    if(_email.isEmpty || _password.isEmpty){
      validate('', kAccountText);
      validate('', kPasswordText);
      
    }
    if(_email.isNotEmpty && _password.isNotEmpty){
      _loading=true;
      _notifySafely();
      return _authModel.login(_email, _password.encrypt()).whenComplete(() {
        _loading=false;
        _notifySafely();
      });
    }
    return Future.error('');
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