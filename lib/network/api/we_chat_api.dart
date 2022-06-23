import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wechat_app/network/api_constant/we_chat_api_constant.dart';
import 'package:wechat_app/network/response/notification_response.dart';

part 'we_chat_api.g.dart';

@RestApi(baseUrl: kBaseURL)
abstract class WeChatAPI {
  factory WeChatAPI(Dio dio) = _WeChatAPI;

  @POST(kSendNotificationEndPoint)
  Future<NotificationResponse> getNotificationResponse(
      @Header(kContentTypeText) String contentType,
      @Header(kAuthorizationText) String authorization,
      @Body() NotificationResponse notificationResponse
      );
}
