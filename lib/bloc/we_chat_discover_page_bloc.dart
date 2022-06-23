import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_moment_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_moment_model.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/persistant/dao/moment_dao.dart';
import 'package:wechat_app/persistant/impl/moment_dao_impl.dart';
import 'package:wechat_app/resources/strings.dart';

import '../data/model/we_chat_auth_model.dart';
import '../data/model/we_chat_auth_model_impl.dart';
import 'package:timeago/timeago.dart' as timeago;

class WeChatDiscoverPageBloc extends ChangeNotifier {
  ///State Variable
  bool _isDisposed = false;
  bool _showCommentTextField=false;
  List<MomentVO>?_momentVO;
  MomentVO ? _detailsMoment;
  String _profileImage='';
  String _profileBackgroundImage='';
  String _profileName='';
  bool _loading=false;

  ///Getter
  bool get isShowCommentTextField=>_showCommentTextField;
  bool get isLoading=>_loading;
  List<MomentVO>?get getMomentVO=>_momentVO;
  MomentVO ? get getDetailsMoment=>_detailsMoment;
  String get getProfileImage=>_profileImage;
  String get getBackgroundImage=>_profileBackgroundImage;
  String get getProfileName=>_profileName;

  ///Model
  final WeChatMomentModel _weChatModel = WeChatMomentModelImpl();
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();
  WeChatDiscoverPageBloc([int ? id]){

   _weChatAuthModel.getUserVoStreamEvent(_weChatAuthModel.getLoggedInUserID()).listen((userVO) {
     _profileImage=(userVO?.profileImage?.isEmpty??true)?kDefaultImage:userVO?.profileImage??'';
     _profileBackgroundImage=userVO?.backgroundImage??'';
     _profileName=userVO?.userName??'';
     _notifySafely();
   });
    _weChatModel.getMoments().listen((data) {
      _momentVO=data.map((moments) {
        String id=_weChatAuthModel.getLoggedInUserID();
        if(id==moments.userID){
          moments.isOriginalUploader=true;
        }
        return moments;
      }).toList();
     _notifySafely();
    },
      onError: (error)=>debugPrint(error)
    );


  }
  Future<void> deletePost(String id){
    return _weChatModel.delete(id);
  }

void uploadBackgroundImage(File image){
    _loading=true;
    _notifySafely();
    _weChatAuthModel.getLoggedInUserInfo().then((userVO) {
      if(userVO?.backgroundImage!=kDefaultBackgroundImage){
        _weChatAuthModel.deleteProfileFileFromFirebase(userVO?.backgroundImageID??'');
      }
      _weChatAuthModel.uploadProfileFileToFirebase(image).then((downloadURL) {
        List<String>tempImage=downloadURL.split('|');
        userVO?.backgroundImage=tempImage.first;
        userVO?.backgroundImageID=tempImage.last;
        _weChatAuthModel.saveUser(userVO??UserVO.normal());
        _weChatAuthModel.addNewUser(userVO??UserVO.normal());
        _notifySafely();
      }).whenComplete(() {
        _loading=false;
        _notifySafely();
      });
    });
}
  void setIsLikedState(MomentVO momentVO){
    List<MomentVO>temp=_momentVO?.map((data) {
      if(data==momentVO){
        data.isLiked=!data.isLiked;
      }
      return data;
    }).toList()??[];
    _momentVO=temp;
    _notifySafely();
  }

  void removeBackgroundImage(){
    _loading=true;
    _notifySafely();
    _weChatAuthModel.getLoggedInUserInfo().then((userVO) {
      _weChatAuthModel.deleteProfileFileFromFirebase(userVO?.backgroundImageID??'').then((value) {
        userVO?.backgroundImage=kDefaultBackgroundImage;
        userVO?.backgroundImageID='';
        _weChatAuthModel.saveUser(userVO??UserVO.normal());
        _weChatAuthModel.addNewUser(userVO??UserVO.normal());
        _notifySafely();
      }).whenComplete(() {
        _loading=false;
        _notifySafely();
      });
    });
  }

  void setIsShowCommentTextFieldState(){
    _showCommentTextField=!_showCommentTextField;
    _notifySafely();
  }
  void setIsShowDetailsState([MomentVO? momentVO]){
    _detailsMoment=momentVO;
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
