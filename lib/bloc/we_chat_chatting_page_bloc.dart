import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model_impl.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_user_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/enums.dart';



class WeChatChattingPagesBloc extends ChangeNotifier {
  ///State Variable
  ShowMoreIconForm _showMoreIcon = ShowMoreIconForm.add;
  bool _showMoreWidget = false;
  bool _isDisposed = false;
  File? _file;
  final TextEditingController _message=TextEditingController();
  String _friendID='';
  String _loggedInUserID='';
  List<ChattingUserVO>_chattingUserVo=[];
  ///getter
  ShowMoreIconForm get getShowMoreIcon => _showMoreIcon;
  bool get isShowMoreWidget => _showMoreWidget;
  File? get getFile => _file;
  List<ChattingUserVO> get getChattingUserVO=>_chattingUserVo;
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


  void sendMessage(){
    String tempMessage=_message.text;
    String tempFilePath=_file?.path??'';
    _file=null;
    _message.clear();

    if(tempMessage.isNotEmpty){

    String id=_weChatAuthModel.getLoggedInUserID();
    _weChatAuthModel.getLoggedInUserInfoByID(id).then((userVO) {
      if(tempFilePath.isNotEmpty) {
        _weChatAuthModel.uploadFileToFirebase(File(tempFilePath)).then((
            imageURL) {
          ChattingUserVO chattingUserVO = _getChattingVO(userVO, imageURL,tempMessage);
          _weChatRealTimeModel.addChatToServer(chattingUserVO, _friendID);
        });
      }else{
        ChattingUserVO chattingUserVO = _getChattingVO(userVO, '',tempMessage);
        _weChatRealTimeModel.addChatToServer(chattingUserVO, _friendID);
      }

    });
    _notifySafely();
    }
  }

  ChattingUserVO _getChattingVO(UserVO? userVO,String imageURL,String message){
    return ChattingUserVO(userID: userVO?.id??'', name: userVO?.userName??'', profilePic: userVO?.profileImage??kDefaultImage, message: message, file: imageURL, timeStamp: DateTime.now());
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
