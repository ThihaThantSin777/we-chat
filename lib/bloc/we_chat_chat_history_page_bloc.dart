


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
  WeChatChatHistoryPageBloc(){

    _weChatRealTimeDataAgent.getFriendsID().listen((event) {
      List<ChattingUserVO>temp=[];
      for (var id in event) {
        String ids=id??'';
        _weChatRealTimeDataAgent.getAllChattingList(ids).then((value) {
          List<ChattingUserVO> a=  value.where((element) => element.userID==ids).toList();
          ChattingUserVO last=a.last;
         temp.add(last);
          _chattingUserVOList=temp;
          _notifySafely();
        });
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