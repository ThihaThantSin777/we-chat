import 'dart:io';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_moment_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_moment_model.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';

class WeChatDiscoverPageBloc extends ChangeNotifier {
  ///State Variable
  bool _isDisposed = false;
  bool _showCommentTextField=false;
  List<MomentVO>?_momentVO;
  MomentVO ? _detailsMoment;

  ///Getter
  bool get isShowCommentTextField=>_showCommentTextField;
  List<MomentVO>?get getMomentVO=>_momentVO;
  MomentVO ? get getDetailsMoment=>_detailsMoment;


  ///Model
  final WeChatMomentModel _weChatModel = WeChatMomentModelImpl();

  WeChatDiscoverPageBloc([int ? id]){
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
