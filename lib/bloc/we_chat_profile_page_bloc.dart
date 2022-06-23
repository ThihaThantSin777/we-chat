import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/resources/strings.dart';

class WeChatProfilePageBloc extends ChangeNotifier {
  ///State Variable
  bool _isDisposed = false;
  bool _loading = false;
  bool _showBioText = false;
  String _id = '';
  String _name = '';
  String _profilePicture = '';
  String _bioText = '';
  String _enterBioText='';
  ///Getter
  bool get isLoading => _loading;

  String get getID => _id;

  String get getName => _name;

  String get getProfilePicture => _profilePicture;

  String get getBioText => _bioText;

  bool get isShowBioText => _showBioText;

  String get getEnterBioText=>_enterBioText;

  final WeChatAuthModel _auth = WeChatAuthModelImpl();

  WeChatProfilePageBloc() {
    _auth.getUserVoStreamEvent(_auth.getLoggedInUserID()).listen((userVO) {
      if (userVO != null) {
        String id = userVO.id ?? '';
        _name = userVO.userName ?? '';
        _bioText = userVO.bioText ?? '';
        _id = '$_name#${id[0]}${id[1]}${id[2]}${id[3]}${id[4]}${id[5]}';
        _profilePicture = (userVO.profileImage?.isEmpty ?? true)
            ? kDefaultImage
            : userVO.profileImage ?? '';
        _notifySafely();
      }
    });
  }

  void uploadProfileImage(File image){
    _loading=true;
    _notifySafely();
    _auth.getLoggedInUserInfo().then((userVO) {
      _auth.uploadProfileFileToFirebase(image).then((downloadURL) {
        List<String>tempImage=downloadURL.split('|');
        userVO?.profileImage=tempImage.first;
        userVO?.imageID=tempImage.last;
        _auth.saveUser(userVO??UserVO.normal());
        _auth.addNewUser(userVO??UserVO.normal());
        _notifySafely();
      }).whenComplete(() {
        _loading=false;
        _notifySafely();
      });
    });
  }


  void removeProfileImage(){
    _loading=true;
    _notifySafely();
    _auth.getLoggedInUserInfo().then((userVO) {
      _auth.deleteProfileFileFromFirebase(userVO?.imageID??'').then((value) {
        userVO?.profileImage=kDefaultImage;
        userVO?.imageID='';
        _auth.saveUser(userVO??UserVO.normal());
        _auth.addNewUser(userVO??UserVO.normal());
        _notifySafely();
      }).whenComplete(() {
        _loading=false;
        _notifySafely();
      });
    });
  }

  void setBioText(String text){
    _enterBioText=text;
    _notifySafely();
  }

  void saveBioText(String text){
    setShowBioText();
   if(text.isNotEmpty){
     _loading=true;
     _notifySafely();
     _auth.getLoggedInUserInfo().then((userVO) {
       userVO?.bioText=_enterBioText;
       _auth.saveUser(userVO??UserVO.normal());
       _auth.addNewUser(userVO??UserVO.normal());
       _notifySafely();
     }).whenComplete(() {
       _loading=false;
       _notifySafely();
     });
   }
  }

  void setShowBioText(){
    _showBioText=!_showBioText;
    _notifySafely();

  }
  Future<void> logout() {
    _loading = true;
    _notifySafely();
    return _auth.logout().then((value) {
      _loading = false;
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
