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
      id: fields[0] as int,
      userID: fields[1] as String,
      userName: fields[2] as String,
      profilePicture: fields[3] as String,
      postImage: fields[4] as String,
      postVideo: fields[5] as String,
      description: fields[6] as String,
      timeStamp: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MomentVO obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.timeStamp);
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
      id: json['id'] as int,
      userID: json['user_id'] as String,
      userName: json['user_name'] as String,
      profilePicture: json['profile_picture'] as String,
      postImage: json['post_image'] as String,
      postVideo: json['post_video'] as String,
      description: json['description'] as String,
      timeStamp: DateTime.parse(json['time_stamp'] as String),
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
      'isLiked': instance.isLiked,
    };
