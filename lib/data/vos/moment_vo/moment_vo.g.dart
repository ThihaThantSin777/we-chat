// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentVO _$MomentVOFromJson(Map<String, dynamic> json) => MomentVO(
      id: json['id'] as int,
      userName: json['user_name'] as String,
      profilePicture: json['profile_picture'] as String,
      postImage: json['post_image'] as String,
      postVideo: json['post_video'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$MomentVOToJson(MomentVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'profile_picture': instance.profilePicture,
      'post_image': instance.postImage,
      'post_video': instance.postVideo,
      'description': instance.description,
    };
