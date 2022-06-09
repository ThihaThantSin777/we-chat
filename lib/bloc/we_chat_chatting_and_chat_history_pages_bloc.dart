import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_vo.dart';
import 'package:wechat_app/utils/enums.dart';

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

class WeChatChattingAndChatHistoryPagesBloc extends ChangeNotifier {
  ///State Variable
  List<ChatUserVO> _userVOList = [];
  List<ChattingVO> _chatList = [];
  ShowMoreIconForm _showMoreIcon = ShowMoreIconForm.add;
  bool _showMoreWidget = false;
  bool _isDisposed = false;
  File? _file;

  ///getter
  List<ChatUserVO> get getUserVOList => _userVOList;

  List<ChattingVO> get getChattingVOList => _chatList;

  ShowMoreIconForm get getShowMoreIcon => _showMoreIcon;

  bool get isShowMoreWidget => _showMoreWidget;

  File? get getFile => _file;

  WeChatChattingAndChatHistoryPagesBloc() {
    _userVOList = userVOList;
    _setChatTalk();
    _notifySafely();
  }

  void addImage(File path) {
    _file = path;
    _notifySafely();
  }

  void removeImage() {
    _file = null;
    _notifySafely();
  }

  void _setChatTalk() {
    Random random = Random();

    for (int i = 1; i <= 100; i++) {
      int number = random.nextInt(10);
      bool isLeft = number % 2 == 0;
      ChattingVO chattingVO = ChattingVO(personChat[number], isLeft);
      _chatList.add(chattingVO);
    }
  }

  void setIsShowMoreIconState(String text) {
    if (text.isEmpty) {
      _showMoreIcon = ShowMoreIconForm.add;
    } else {
      _showMoreIcon = ShowMoreIconForm.send;
    }
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
