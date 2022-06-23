
import 'package:wechat_app/data/model/we_chat_notification_model.dart';
import 'package:wechat_app/network/data_agent/we_chat_notification_data_agent.dart';
import 'package:wechat_app/network/data_agent/we_chat_notification_data_agent_impl.dart';
import 'package:wechat_app/network/response/notification_response.dart';

class WeChatNotificationModelImpl extends WeChatNotificationModel{
  WeChatNotificationModelImpl._internal();

  static final WeChatNotificationModelImpl _singleton=WeChatNotificationModelImpl._internal();

  factory WeChatNotificationModelImpl()=>_singleton;

  final WeChatNotificationDataAgent _weChatNotificationDataAgent=WeChatNotificationDataAgentImpl();
  @override
  Future<void> getNotificationResponse(String contentType, String authorization, NotificationResponse notificationResponse)=>_weChatNotificationDataAgent.getNotificationResponse(contentType, authorization, notificationResponse);

}