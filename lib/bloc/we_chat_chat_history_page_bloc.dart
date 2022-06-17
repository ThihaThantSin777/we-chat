


import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model_impl.dart';
import 'package:wechat_app/data/vos/chat_user_vo/chat_user_vo.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_user_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_real_time_data_agent_impl.dart';
import 'package:wechat_app/resources/strings.dart';

import '../data/model/we_chat_real_time_model.dart';
import '../network/data_agent/we_chat_real_tim_data_gent.dart';


class WeChatChatHistoryPageBloc extends ChangeNotifier{

  ///State Variable
  List<ChattingUserVO>_chattingUserVOList=[];
  bool _isDisposed = false;
  bool _loading=false;

  ///Getter
  List<ChattingUserVO> get getChattingUserVOList=>_chattingUserVOList;
  bool get isLoading=>_loading;

  ///Model
 final WeChatRealTimeModel _weChatRealTimeDataAgent=WeChatRealTimeModelImpl();
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();
  WeChatChatHistoryPageBloc(){
    List<ChattingUserVO>temp=[];
    _weChatRealTimeDataAgent.chatHistoryIDList().listen((friID) {
      if(friID.isNotEmpty){
        for (var id in friID) {
          _weChatAuthModel.getLoggedInUserInfoByID(id??'').then((userVO) {
            _weChatRealTimeDataAgent.getAllChatByID(id??'').listen((event) {
             if(event.isNotEmpty){
               ChattingUserVO chattingUserVO=ChattingUserVO(userID: id??'', name: userVO?.userName??'', profilePic: userVO?.profileImage??kDefaultImage, message: event.last.message, file: event.last.file, timeStamp: event.last.timeStamp);
               temp.add(chattingUserVO);
               _chattingUserVOList=temp;
               _notifySafely();
             }
            });
          });
        }
      }

    });
  }
  Future<void> remove(String friID) {
    _loading=true;
    _notifySafely();
    return _weChatRealTimeDataAgent.deleteChat(friID).then((value) {
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