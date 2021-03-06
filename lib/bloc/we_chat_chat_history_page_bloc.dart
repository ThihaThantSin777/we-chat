


import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_real_time_model_impl.dart';
import 'package:wechat_app/data/vos/chat_vo/chat_vo.dart';

import '../data/model/we_chat_real_time_model.dart';


class WeChatChatHistoryPageBloc extends ChangeNotifier{

  ///State Variable
  List<ChatVO>_chattingUserVOList=[];
  bool _isDisposed = false;
  bool _loading=false;

  ///Getter
  List<ChatVO> get getChattingUserVOList=>_chattingUserVOList;
  bool get isLoading=>_loading;

  ///Model
 final WeChatRealTimeModel _weChatRealTimeDataAgent=WeChatRealTimeModelImpl();
 final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();
  WeChatChatHistoryPageBloc(){

    _weChatRealTimeDataAgent.getFriendsID().listen((event) {
      List<ChatVO>temp=[];
      if(event.isEmpty){
       _chattingUserVOList=[];
       _notifySafely();
      }else{
        for (var id in event) {
          String ids=id??'';
          _weChatRealTimeDataAgent.getAllChattingList(ids).then((value) {
            _weChatAuthModel.getUserInfoByID(ids).then((userVO){
              if(value.isNotEmpty){
                ChatVO lastData=value.last;
                lastData.userID=userVO?.id??'';
                lastData.name=userVO?.userName??'';
                lastData.profilePic=userVO?.profileImage??'';
                String subMessage=lastData.message;
                if(lastData.message.isEmpty && lastData.file.isNotEmpty){
                  subMessage='photo';
                }
                if(lastData.message.isEmpty && lastData.videoFile.isNotEmpty){
                  subMessage='video';
                }
                if(lastData.message.isEmpty && lastData.file.isNotEmpty && lastData.videoFile.isNotEmpty){
                  subMessage='photo and a video';
                }
                lastData.message=subMessage;
                  temp.add(lastData);
                  _chattingUserVOList=temp;
                  _notifySafely();
                // }
              }
            });

          });
        }
      }


    });

  }
  Future<void> remove(String friID) {
    print('remove $friID');
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