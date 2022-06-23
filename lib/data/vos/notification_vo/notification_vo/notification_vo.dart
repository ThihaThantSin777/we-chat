import 'package:json_annotation/json_annotation.dart';
import 'package:wechat_app/data/vos/notification_vo/data_vo/data_vo.dart';

part 'notification_vo.g.dart';


@JsonSerializable()
class NotificationVO {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'body')
  String? body;

  @JsonKey(name: 'priority')
  String? priority;

  @JsonKey(name: 'content_available')
  bool? contentAvailable;

  NotificationVO(
      {required this.title,
      required this.body,
      required this.priority,
      required this.contentAvailable,
     });

  @override
  String toString() {
    return 'NotificationVO{title: $title, body: $body, priority: $priority, contentAvailable: $contentAvailable}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationVO &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          body == other.body &&
          priority == other.priority &&
          contentAvailable == other.contentAvailable ;

  @override
  int get hashCode =>
      title.hashCode ^
      body.hashCode ^
      priority.hashCode ^
      contentAvailable.hashCode ;


  NotificationVO.normal();

  factory NotificationVO.fromJson(Map<String,dynamic>json)=>_$NotificationVOFromJson(json);

  Map<String,dynamic>toJson()=>_$NotificationVOToJson(this);
}
