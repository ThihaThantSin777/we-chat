
import 'package:dio/dio.dart';
import 'package:wechat_app/network/data_agent/we_chat_notification_data_agent.dart';
import 'package:wechat_app/network/response/notification_response.dart';

import '../api/we_chat_api.dart';

class WeChatNotificationDataAgentImpl extends WeChatNotificationDataAgent{
  late WeChatAPI _weChatAPI;
  WeChatNotificationDataAgentImpl._internal(){
    final dio = Dio();
    _weChatAPI=WeChatAPI(dio);
  }

  static final WeChatNotificationDataAgentImpl _singleton=WeChatNotificationDataAgentImpl._internal();

  factory WeChatNotificationDataAgentImpl()=>_singleton;


  @override
  Future<void> getNotificationResponse(String contentType,String authorization,NotificationResponse notificationResponse) =>_weChatAPI.getNotificationResponse(contentType, authorization, notificationResponse);

}