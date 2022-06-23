


import 'package:json_annotation/json_annotation.dart';
import 'package:wechat_app/data/vos/notification_vo/data_vo/data_vo.dart';
import 'package:wechat_app/data/vos/notification_vo/notification_vo/notification_vo.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse{

  @JsonKey(name: 'to')
  String ? to;

  @JsonKey(name: 'notification')
  NotificationVO? notification;

  @JsonKey(name: 'data')
  DataVO ?data;

  NotificationResponse.normal();

  NotificationResponse({required this.to,required this.notification,required this.data});

  @override
  String toString() {
    return 'NotificationResponse{to: $to, notification: $notification, data: $data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationResponse &&
          runtimeType == other.runtimeType &&
          to == other.to &&
          notification == other.notification &&
          data == other.data;

  @override
  int get hashCode => to.hashCode ^ notification.hashCode ^ data.hashCode;

  factory NotificationResponse.fromJson(Map<String,dynamic>json)=>_$NotificationResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$NotificationResponseToJson(this);
}