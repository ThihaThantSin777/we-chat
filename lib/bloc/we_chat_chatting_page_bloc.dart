import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_moment_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model_impl.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_user_vo.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/enums.dart';

import '../data/model/we_chat_moment_model.dart';
import '../data/vos/chat_user_vo/chat_user_vo.dart';

List<String> personChat = [
  'Hello Leave the door open baby',
  'I need it this millioon for a very long time',
  'Smoking out the window',
  'Belong to everyone else except me',
  'She belongs to everyone OKOK I was wrong',
  'Ohh!! looking bae this is nothing good for us',
  'How could you do this to me. Why?? I don\'t understand',
  'I was wrong to everyone Satisfy?? Haha Idiot',
  'What!!! These errors. Nothing is possible for anyone. Please try hard. One day, you can be like better',
  'I am leave door to open. I am leave door to open girl!! That you feel the way I feel for nothing! Tell me you can go to through'
];

class WeChatChattingPagesBloc extends ChangeNotifier {
  ///State Variable
  ShowMoreIconForm _showMoreIcon = ShowMoreIconForm.add;
  bool _showMoreWidget = false;
  bool _isDisposed = false;
  File? _file;
  String _message='';
  String _friendID='';
  String _loggedInUserID='';
  List<ChattingUserVO>_chattingUserVo=[];
  ///getter
  ShowMoreIconForm get getShowMoreIcon => _showMoreIcon;
  bool get isShowMoreWidget => _showMoreWidget;
  File? get getFile => _file;
  List<ChattingUserVO> get getChattingUserVO=>_chattingUserVo;
  String get getLoggedInUserID=>_loggedInUserID;


  final WeChatRealTimeModel _weChatRealTimeModel=WeChatRealTimeModelImpl();
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();

  WeChatChattingPagesBloc(String friID) {
    _friendID=friID;
    _loggedInUserID=_weChatAuthModel.getLoggedInUserID();
    _notifySafely();
    _weChatRealTimeModel.getChatList(friID).listen((event) {
      _chattingUserVo=event;
      _notifySafely();
    });

  }

  void addImage(File path) {
    _file = path;
    _notifySafely();
  }

  void removeImage() {
    _file = null;
    _notifySafely();
  }


  void sendMessage(){
    if(_message.isNotEmpty){
      if(_file!=null){
    String id=_weChatAuthModel.getLoggedInUserID();
    _weChatAuthModel.getLoggedInUserInfoByID(id).then((userVO) {
          _weChatAuthModel.uploadFileToFirebase(File(_file?.path??'')).then((imageURL) {
            ChattingUserVO chattingUserVO=_getChattingVO(userVO,imageURL);
            _weChatRealTimeModel.addChatToServer(chattingUserVO, _friendID);
          });
    });
    }
    }
  }

  ChattingUserVO _getChattingVO(UserVO? userVO,String imageURL){
    return ChattingUserVO(userID: userVO?.id??'', name: userVO?.userName??'', profilePic: userVO?.profileImage??kDefaultImage, message: _message, file: imageURL, timeStamp: DateTime.now());
  }

  void setIsShowMoreIconState(String text) {
    if (text.isEmpty) {
      _showMoreIcon = ShowMoreIconForm.add;
    }
    _message=text;
    _notifySafely();
  }

  void setIsShowMoreWidgetState() {
    _showMoreWidget = !isShowMoreWidget;
    if (_showMoreWidget) {
      _showMoreIcon = ShowMoreIconForm.close;
    } else {
      _showMoreIcon = ShowMoreIconForm.add;
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
