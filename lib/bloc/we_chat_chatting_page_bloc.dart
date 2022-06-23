import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model_impl.dart';
import 'package:wechat_app/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat_app/data/vos/notification_vo/data_vo/data_vo.dart';
import 'package:wechat_app/data/vos/notification_vo/notification_vo/notification_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/network/api_constant/we_chat_api_constant.dart';
import 'package:wechat_app/network/response/notification_response.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/enums.dart';

import '../data/model/we_chat_notification_model.dart';
import '../data/model/we_chat_notification_model_impl.dart';

class WeChatChattingPagesBloc extends ChangeNotifier {
  ///State Variable
  ShowMoreIconForm _showMoreIcon = ShowMoreIconForm.add;
  bool _showMoreWidget = false;
  bool _isDisposed = false;
  bool _loading = false;
  File? _file;
  File? _videoFile;
  final TextEditingController _message = TextEditingController();
  String _friendID = '';
  String _friName = '';
  String _loggedInUserID = '';
  List<ChatVO> _chattingUserVo = [];

  ///getter
  ShowMoreIconForm get getShowMoreIcon => _showMoreIcon;

  bool get isShowMoreWidget => _showMoreWidget;

  bool get isLoading => _loading;

  File? get getFile => _file;

  File? get getVideoFile => _videoFile;

  List<ChatVO> get getChattingUserVO => _chattingUserVo;

  String get getLoggedInUserID => _loggedInUserID;

  TextEditingController get getMessage => _message;

  String get getFriName => _friName;

  final WeChatRealTimeModel _weChatRealTimeModel = WeChatRealTimeModelImpl();
  final WeChatAuthModel _weChatAuthModel = WeChatAuthModelImpl();
  final WeChatNotificationModel _weChatNotificationModel =
      WeChatNotificationModelImpl();

  WeChatChattingPagesBloc(String friID) {
    _friendID = friID;
    _loggedInUserID = _weChatAuthModel.getLoggedInUserID();
    _weChatAuthModel.getUserInfoByID(friID).then((userVO) {
      _friName = userVO?.userName ?? '';
      _notifySafely();
    });
    _notifySafely();
    _weChatRealTimeModel.getChatList(friID).listen((event) {
      if (event != null || event.isNotEmpty) {
        _chattingUserVo = event;
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

  Future<void> _sendingMethods(
      String message, UserVO? userVO, String imageFile, String videoFile) {
    if (imageFile.isNotEmpty || message.isNotEmpty || videoFile.isNotEmpty) {
      return _weChatAuthModel
          .uploadChatsFilesToFirebase(File(imageFile))
          .then((imageURL) {
        _weChatAuthModel
            .uploadChatsFilesToFirebase(File(videoFile))
            .then((videoURL) {
          ChatVO chattingUserVO =
              _getChattingVO(userVO, imageURL, message, videoURL);
          return _weChatRealTimeModel.addChatToServer(
              chattingUserVO, _friendID);
        });
      });
    }
    return Future.value();
  }

  void sendMessage(String friID) {
    String tempMessage = _message.text;
    String tempFilePath = _file?.path ?? '';
    String tempVideoFilePath = _videoFile?.path ?? '';
    _file = null;
    _videoFile = null;
    _message.clear();
    if (tempMessage.isNotEmpty ||
        tempFilePath.isNotEmpty ||
        tempVideoFilePath.isNotEmpty) {
      _loading = true;
      _notifySafely();
      _weChatAuthModel.getLoggedInUserInfo().then((userVO) {
        _sendingMethods(tempMessage, userVO, tempFilePath, tempVideoFilePath)
            .whenComplete(() {
          _weChatAuthModel.getUserInfoByID(friID).then((otherUserVO) {
            NotificationVO notificationVO = NotificationVO(
                title: '${userVO?.userName ?? ''} sent a message',
                body: tempMessage,
                priority: 'high',
                contentAvailable: true);
            DataVO dataVO =
                DataVO(routeName: 'chat', receiverID: userVO?.id ?? '');
            NotificationResponse notificationResponse = NotificationResponse(
                to: otherUserVO?.fcmToken ?? '',
                notification: notificationVO,
                data: dataVO);
            _weChatNotificationModel.getNotificationResponse(
                kContactTypeData, kAuthorizationData, notificationResponse);
          }).whenComplete(() {
            _loading = false;
            _notifySafely();
          });
        });
      });
    }
  }

  ChatVO _getChattingVO(
      UserVO? userVO, String imageURL, String message, String videoURL) {
    return ChatVO(
        userID: userVO?.id ?? '',
        name: userVO?.userName ?? '',
        profilePic: userVO?.profileImage ?? kDefaultImage,
        message: message,
        file: imageURL,
        videoFile: videoURL,
        timeStamp: DateTime.now());
  }

  void setIsShowMoreIconState(String text) {
    if (text.isEmpty) {
      _showMoreIcon = ShowMoreIconForm.add;
    }
    _message.text = text;
    _message.selection =
        TextSelection.fromPosition(TextPosition(offset: _message.text.length));
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
