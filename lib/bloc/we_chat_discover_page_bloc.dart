import 'dart:io';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_moment_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_moment_model.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/resources/strings.dart';

import '../data/model/we_chat_auth_model.dart';
import '../data/model/we_chat_auth_model_impl.dart';

class WeChatDiscoverPageBloc extends ChangeNotifier {
  ///State Variable
  bool _isDisposed = false;
  bool _showCommentTextField=false;
  List<MomentVO>?_momentVO;
  MomentVO ? _detailsMoment;
  String _profileImage='';

  ///Getter
  bool get isShowCommentTextField=>_showCommentTextField;
  List<MomentVO>?get getMomentVO=>_momentVO;
  MomentVO ? get getDetailsMoment=>_detailsMoment;
  String get getProfileImage=>_profileImage;


  ///Model
  final WeChatMomentModel _weChatModel = WeChatMomentModelImpl();
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();

  WeChatDiscoverPageBloc([int ? id]){
    String id=_weChatAuthModel.getLoggedInUserID();
    _weChatAuthModel.getLoggedInUserInfoByID(id).then((value) {
      _profileImage=value?.profileImage??kDefaultImage;
      _notifySafely();
    });
    _weChatModel.getMoments().listen((data) {
      _momentVO=data;
     _notifySafely();
    },
      onError: (error)=>debugPrint(error)
    );

  }
  Future<void> deletePost(int id){
    return _weChatModel.delete(id);
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
