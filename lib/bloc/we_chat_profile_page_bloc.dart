import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/resources/strings.dart';

class WeChatProfilePageBloc extends ChangeNotifier{
  ///State Variable
  bool _isDisposed = false;
  bool _loading=false;
  String _id='';
  String _name='';
  String _profilePicture='';
  String _bioText='';

  ///Getter
  bool get isLoading=>_loading;
  String get getID=>_id;
  String get getName=>_name;
  String get getProfilePicture=>_profilePicture;
  String get getBioText=>_bioText;

  final WeChatAuthModel _auth=WeChatAuthModelImpl();

  WeChatProfilePageBloc(){
    _auth.getUserVoStreamEvent().listen((userVO) {
    if(userVO!=null){
      String id=userVO.id??'';
      _name=userVO.userName??'';
      _bioText=userVO.bioText??'';
      _id='$_name#${id[0]}${id[1]}${id[2]}${id[3]}${id[4]}${id[5]}';
      _profilePicture=(userVO.profileImage?.isEmpty??true)?kDefaultImage:userVO.profileImage??'';
      _notifySafely();
    }
    });
  }



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