import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model_impl.dart';
import 'package:wechat_app/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/enums.dart';



class WeChatChattingPagesBloc extends ChangeNotifier {
  ///State Variable
  ShowMoreIconForm _showMoreIcon = ShowMoreIconForm.add;
  bool _showMoreWidget = false;
  bool _isDisposed = false;
  bool _loading=false;
  File? _file;
  File? _videoFile;
  final TextEditingController _message=TextEditingController();
  String _friendID='';
  String _loggedInUserID='';
  List<ChatVO>_chattingUserVo=[];
  ///getter
  ShowMoreIconForm get getShowMoreIcon => _showMoreIcon;
  bool get isShowMoreWidget => _showMoreWidget;
  bool get isLoading=>_loading;
  File? get getFile => _file;
  File? get getVideoFile=>_videoFile;
  List<ChatVO> get getChattingUserVO=>_chattingUserVo;
  String get getLoggedInUserID=>_loggedInUserID;
  TextEditingController get getMessage=>_message;


  final WeChatRealTimeModel _weChatRealTimeModel=WeChatRealTimeModelImpl();
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();

  WeChatChattingPagesBloc(String friID) {
    _friendID=friID;
    _loggedInUserID=_weChatAuthModel.getLoggedInUserID();
    _notifySafely();
    _weChatRealTimeModel.getChatList(friID).listen((event) {
     if(event!=null || event.isNotEmpty){
       _chattingUserVo=event;
       _notifySafely();
     }

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


  void addVideo(File path) {
    _videoFile = path;
    _notifySafely();
  }

  void removeVideo() {
    _videoFile = null;
    _notifySafely();
  }

  Future<void>_sendingMethods(String message,UserVO? userVO,String imageFile,String videoFile){
    if(imageFile.isNotEmpty && videoFile.isNotEmpty){
      _weChatAuthModel.uploadProfileFileToFirebase(File(imageFile)).then((imageURL) {
        _weChatAuthModel.uploadProfileFileToFirebase(File(videoFile)).then((videoURL) {
          ChatVO chattingUserVO = _getChattingVO(userVO, imageURL, message, videoURL);
          return _weChatRealTimeModel.addChatToServer(chattingUserVO, _friendID);
        });
      });

    }else if(message.isNotEmpty && videoFile.isNotEmpty){
      _weChatAuthModel.uploadProfileFileToFirebase(File(videoFile)).then((videoURL) {
        ChatVO chattingUserVO = _getChattingVO(userVO, imageFile, message, videoURL);
        return _weChatRealTimeModel.addChatToServer(chattingUserVO, _friendID);
      });
    }else if( message.isNotEmpty && imageFile.isNotEmpty){
      _weChatAuthModel.uploadProfileFileToFirebase(File(imageFile)).then((imageURL) {
        ChatVO chattingUserVO = _getChattingVO(userVO, imageURL, message, videoFile);
        return _weChatRealTimeModel.addChatToServer(chattingUserVO, _friendID);
      });
    }else if(videoFile.isNotEmpty){
      _weChatAuthModel.uploadProfileFileToFirebase(File(videoFile)).then((videoURL) {
        ChatVO chattingUserVO = _getChattingVO(userVO, imageFile, message, videoURL);
        return _weChatRealTimeModel.addChatToServer(chattingUserVO, _friendID);
      });
    }else if(imageFile.isNotEmpty){
      _weChatAuthModel.uploadProfileFileToFirebase(File(imageFile)).then((imageURL) {
        ChatVO chattingUserVO = _getChattingVO(userVO, imageURL, message, videoFile);
        return _weChatRealTimeModel.addChatToServer(chattingUserVO, _friendID);
      });

    }else if(message.isNotEmpty){
      ChatVO chattingUserVO = _getChattingVO(userVO, imageFile, message, videoFile);
      return _weChatRealTimeModel.addChatToServer(chattingUserVO, _friendID);
    }
    return Future.value('');
  }
  void sendMessage(){
    String tempMessage=_message.text;
    String tempFilePath=_file?.path??'';
    String tempVideoFilePath=_videoFile?.path??'';
    _file=null;
    _videoFile=null;
    _message.clear();
    if(tempMessage.isNotEmpty || tempFilePath.isNotEmpty || tempVideoFilePath.isNotEmpty) {
      _loading=true;
      _notifySafely();
      String id=_weChatAuthModel.getLoggedInUserID();
      _weChatAuthModel.getUserInfoByID(id).then((userVO) {
        _sendingMethods(tempMessage, userVO, tempFilePath, tempVideoFilePath);
      }).then((value) {
        _loading=false;
        _notifySafely();
      });
    }
  }

  ChatVO _getChattingVO(UserVO? userVO,String imageURL,String message,String videoURL){
    return ChatVO(userID: userVO?.id??'', name: userVO?.userName??'', profilePic: userVO?.profileImage??kDefaultImage, message: message, file: imageURL, videoFile:  videoURL,timeStamp: DateTime.now());
  }

  void setIsShowMoreIconState(String text) {
    if (text.isEmpty) {
      _showMoreIcon = ShowMoreIconForm.add;
    }
    _message.text=text;
    _message.selection = TextSelection.fromPosition(TextPosition(offset: _message.text.length));
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
    _message.dispose();
    _isDisposed = true;
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
