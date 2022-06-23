
import '../response/notification_response.dart';

abstract class WeChatNotificationDataAgent{
Future<void>getNotificationResponse(String contentType,String authorization,NotificationResponse notificationResponse);
}