// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserVOAdapter extends TypeAdapter<UserVO> {
  @override
  final int typeId = 1;

  @override
  UserVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserVO(
      id: fields[0] as String?,
      userName: fields[3] as String?,
      region: fields[1] as String?,
      phone: fields[2] as String?,
      password: fields[5] as String?,
      email: fields[4] as String?,
      qrCode: fields[7] as String?,
      profileImage: fields[6] as String?,
      fcmToken: fields[8] as String?,
      backgroundImage: fields[9] as String?,
      bioText: fields[10] as String?,
      isLogout: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserVO obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.region)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.profileImage)
      ..writeByte(7)
      ..write(obj.qrCode)
      ..writeByte(8)
      ..write(obj.fcmToken)
      ..writeByte(9)
      ..write(obj.backgroundImage)
      ..writeByte(10)
      ..write(obj.bioText)
      ..writeByte(11)
      ..write(obj.isLogout);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: json['id'] as String?,
      userName: json['user_name'] as String?,
      region: json['region'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      qrCode: json['qr_code'] as String?,
      profileImage: json['profile_image'] as String?,
      fcmToken: json['fcm_token'] as String?,
      backgroundImage: json['background_image'] as String?,
      bioText: json['bio_text'] as String?,
      isLogout: json['isLogout'] as bool?,
    )..isShowSuspension = json['isShowSuspension'] as bool;

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'isShowSuspension': instance.isShowSuspension,
      'id': instance.id,
      'region': instance.region,
      'phone': instance.phone,
      'user_name': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'profile_image': instance.profileImage,
      'qr_code': instance.qrCode,
      'fcm_token': instance.fcmToken,
      'background_image': instance.backgroundImage,
      'bio_text': instance.bioText,
      'isLogout': instance.isLogout,
    };
