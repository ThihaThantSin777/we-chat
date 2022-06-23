
import '../../network/response/notification_response.dart';


abstract class WeChatNotificationModel{
  Future<void>getNotificationResponse(String contentType,String authorization,NotificationResponse notificationResponse);
}