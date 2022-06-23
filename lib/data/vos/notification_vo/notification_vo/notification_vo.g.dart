// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationVO _$NotificationVOFromJson(Map<String, dynamic> json) =>
    NotificationVO(
      title: json['title'] as String?,
      body: json['body'] as String?,
      priority: json['priority'] as String?,
      contentAvailable: json['content_available'] as bool?,
    );

Map<String, dynamic> _$NotificationVOToJson(NotificationVO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'priority': instance.priority,
      'content_available': instance.contentAvailable,
    };
