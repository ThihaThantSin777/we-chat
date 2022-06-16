// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatting_user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChattingUserVO _$ChattingUserVOFromJson(Map<String, dynamic> json) =>
    ChattingUserVO(
      userID: json['user_id'] as String,
      name: json['name'] as String,
      profilePic: json['profile_pic'] as String,
      message: json['message'] as String,
      file: json['file'] as String,
      timeStamp: DateTime.parse(json['time_stamp'] as String),
    );

Map<String, dynamic> _$ChattingUserVOToJson(ChattingUserVO instance) =>
    <String, dynamic>{
      'user_id': instance.userID,
      'name': instance.name,
      'profile_pic': instance.profilePic,
      'message': instance.message,
      'file': instance.file,
      'time_stamp': instance.timeStamp.toIso8601String(),
    };
