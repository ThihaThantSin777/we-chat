import 'package:wechat_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/resources/strings.dart';

class WeChatLoginPageBloc extends ChangeNotifier {
  ///State Variable
  bool _loading = false;
  bool _isDisposed = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String _emailErrorText = '';
  String _passwordErrorText = '';
  bool _showPassword = true;
  List<UserVO>? _userVoList = [];

  ///Getter
  bool get isLoading => _loading;

  TextEditingController get getEmail => _email;

  String get getEmailErrorText => _emailErrorText;

  TextEditingController get getPassword => _password;

  String get getPasswordErrorText => _passwordErrorText;

  final WeChatAuthModel _authModel = WeChatAuthModelImpl();

  bool get isShowPassword => _showPassword;

  List<UserVO>? get getUserVOList => _userVoList;

  WeChatLoginPageBloc() {
    _userVoList = _authModel.getUserVoList();
    _notifySafely();
  }

  void removeRecentUserVOEmails(){
    _userVoList=null;
    _notifySafely();
  }

  void setRecentUserVoEmail(UserVO userVO){
    String password=userVO.password??'';
    _email.text=userVO.email??'';
    _password.text=password.decrypt();
    _notifySafely();
  }

  void setIsShowPasswordState() {
    _showPassword = !_showPassword;
    _notifySafely();
  }

  void validate(String text, String preFix) {
    switch (preFix) {
      case kAccountText:
        _emailErrorText = _validateForEmail(text);
        break;
      case kPasswordText:
        _passwordErrorText = _validateForPassword(text);
        break;
    }
    _notifySafely();
  }

  List<UserVO>? getEmails() => _authModel.getUserVoList();

  String _validateForEmail(String text) {
    if (text.isEmpty) {
      return 'Error: Please enter email';
    } else if (!text.isValidEmail()) {
      return 'Error: Wrong email format';
    }
    return '';
  }

  String _validateForPassword(String text) {
    if (text.isEmpty) {
      return 'Error: Please enter password';
    }
    return '';
  }

  Future login() {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      validate('', kAccountText);
      validate('', kPasswordText);
    }
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      _loading = true;
      _notifySafely();
      return _authModel
          .login(_email.text, _password.text.encrypt())
          .whenComplete(() {
        _loading = false;
        _notifySafely();
      });
    }
    return Future.error('');
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _isDisposed = true;
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
