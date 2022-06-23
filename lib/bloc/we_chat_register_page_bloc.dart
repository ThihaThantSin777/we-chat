import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/country_code_vo/country_code_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/extension.dart';


class WeChatRegisterPageBloc extends ChangeNotifier {
  ///State variable
  File? _imageFile;

  bool _radioButtonSelect = false;
  bool _showPassword = false;
  bool _isDisposed = false;

  late CountryCodeVO _regionObject;

  String _userName = '';
  String _phone = '';
  String _password = '';

  String _userNameErrorText = '';
  String _phoneErrorText = '';
  String _passwordErrorText = '';

  ///Getter
  File? get getImage => _imageFile;

  bool get isRadioButtonSelect => _radioButtonSelect;

  bool get isShowPassword => _showPassword;

  CountryCodeVO get getRegionObject => _regionObject;

  String get getUserName => _userName;

  String get getPhone => _phone;

  String get getPassword => _password;

  String get getUserNameErrorText => _userNameErrorText;

  String get getPhoneErrorText => _phoneErrorText;

  String get getPasswordErrorText => _passwordErrorText;

  ///Setter
  set setUserName(String userName) {
    _userName = userName;
    _notifySafely();
  }

  set setPhone(String phone) {
    _phone = phone;
    _notifySafely();
  }

  set setPassword(String password) {
    _password = password;
    _notifySafely();
  }

  WeChatRegisterPageBloc() {
    _regionObject = countryCodeVoList
        .map((data) => data)
        .where((element) => element.name == 'Myanmar')
        .first;
    _notifySafely();
  }
  void removePhoto(){
    _imageFile=null;
    _notifySafely();
  }
  void setRadioButtonSelectionState() {
    _radioButtonSelect = !_radioButtonSelect;
    _notifySafely();
  }

  void setIsShowPasswordState() {
    _showPassword = !_showPassword;
    _notifySafely();
  }

  void setImage(File file) {
    _imageFile = file;
    _notifySafely();
  }

  Future<bool> acceptAndContinue(bool isSelect){

      if(_userName.isEmpty){
        _userNameErrorText=_validationForUserName('');
      }
      if(_phone.isEmpty){
        _phoneErrorText=_validationForPhone('');
      }
      if(_password.isEmpty){
        _passwordErrorText=_validationForPassword('');
      }
      _notifySafely();

      if(isSelect && _userName.isNotEmpty && _phone.isNotEmpty && _password.isNotEmpty &&_password.length>=8){
        return Future.value(true);
      }
      return Future.value(false);

  }

  void setCountryCode(CountryCodeVO countryCodeVO) {
    _regionObject = countryCodeVO;
    _notifySafely();
  }

  UserVO getUserVO(){
    UserVO userVO=UserVO(id: 'id', userName: _userName, region: _regionObject.name, phone: '${_regionObject.phNo}$_phone', password: _password.encrypt(), email: '', profileImage: _imageFile?.path??'',qrCode: '',fcmToken: '',backgroundImage: kDefaultBackgroundImage,bioText: '',isLogout: false,backgroundImageID: '',imageID: '');
    return userVO;
  }

  void validation(String text, String preFixText) {
    switch (preFixText) {
      case kFullNameText:
        _userNameErrorText = _validationForUserName(text);
        break;
      case kPhoneText:
        _phoneErrorText = _validationForPhone(text);
        break;
      case kPasswordText:
        _passwordErrorText = _validationForPassword(text);
        break;
    }
    _notifySafely();
  }

  String _validationForUserName(String text) {
    if (text.isEmpty) {
      return 'Error: Please enter user name';
    }
    return '';
  }

  String _validationForPhone(String text) {
    if (text.isEmpty) {
      return 'Error: Please enter phone number';
    }
    return '';
  }

  String _validationForPassword(String text) {
    if (text.isEmpty) {
      return 'Error: Please enter password';
    }
    if (text.length < 8) {
      return 'Error: Weak Password';
    }
    return '';
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
