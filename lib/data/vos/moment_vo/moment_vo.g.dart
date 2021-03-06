// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MomentVOAdapter extends TypeAdapter<MomentVO> {
  @override
  final int typeId = 2;

  @override
  MomentVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return MomentVO(
      id: fields[0] as String,
      userID: fields[1] as String,
      userName: fields[2] as String,
      profilePicture: fields[3] as String,
      postImage: fields[4] as String,
      postVideo: fields[5] as String,
      description: fields[6] as String,
      timeStamp: fields[7] as DateTime,
      postImageID: fields[8] as String,
      postVideoID: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MomentVO obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userID)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.profilePicture)
      ..writeByte(4)
      ..write(obj.postImage)
      ..writeByte(5)
      ..write(obj.postVideo)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.timeStamp)
      ..writeByte(8)
      ..write(obj.postImageID)
      ..writeByte(9)
      ..write(obj.postVideoID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MomentVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentVO _$MomentVOFromJson(Map<String, dynamic> json) => MomentVO(
      id: json['id'] as String,
      userID: json['user_id'] as String,
      userName: json['user_name'] as String,
      profilePicture: json['profile_picture'] as String,
      postImage: json['post_image'] as String,
      postVideo: json['post_video'] as String,
      description: json['description'] as String,
      timeStamp: DateTime.parse(json['time_stamp'] as String),
      postImageID: json['post_image_id'] as String,
      postVideoID: json['post_video_id'] as String,
      isOriginalUploader: json['isOriginalUploader'] as bool? ?? false,
      isLiked: json['isLiked'] as bool? ?? false,
    );

Map<String, dynamic> _$MomentVOToJson(MomentVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userID,
      'user_name': instance.userName,
      'profile_picture': instance.profilePicture,
      'post_image': instance.postImage,
      'post_video': instance.postVideo,
      'description': instance.description,
      'time_stamp': instance.timeStamp.toIso8601String(),
      'post_image_id': instance.postImageID,
      'post_video_id': instance.postVideoID,
      'isOriginalUploader': instance.isOriginalUploader,
      'isLiked': instance.isLiked,
    };
