


import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model_impl.dart';
import 'package:wechat_app/data/vos/chat_user_vo/chat_user_vo.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_user_vo.dart';

import '../data/model/we_chat_real_time_model.dart';


class WeChatChatHistoryPageBloc extends ChangeNotifier{

  ///State Variable
  List<ChatUserVO> _userVOList = [];
  bool _isDisposed = false;


  ///Getter
  List<ChatUserVO> get getUserVOList => _userVOList;


  WeChatChatHistoryPageBloc(){

    _userVOList = userVOList;
  }
  void remove(ChatUserVO userVO) {
    bool cond = _userVOList.remove(userVO);
    List<ChatUserVO> temp = [];
    if (cond) {
      for (var element in _userVOList) {
        temp.add(element);
      }
    }
    _userVOList = temp;
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