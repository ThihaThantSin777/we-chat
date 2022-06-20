import 'package:azlistview/azlistview.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wechat_app/persistant/constant/hive_constant.dart';

part 'user_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeUserVo)
class UserVO extends ISuspensionBean{
  @JsonKey(name: 'id')
  @HiveField(0)
  String ?id;

  @JsonKey(name: 'region')
  @HiveField(1)
  String ?region;

  @JsonKey(name: 'phone')
  @HiveField(2)
  String? phone;

  @JsonKey(name: 'user_name')
  @HiveField(3)
  String? userName;

  @JsonKey(name: 'email')
  @HiveField(4)
  String? email;

  @JsonKey(name: 'password')
  @HiveField(5)
  String ?password;

  @JsonKey(name: 'profile_image')
  @HiveField(6)
  String? profileImage;

  @JsonKey(name: 'qr_code')
  @HiveField(7)
  String? qrCode;

  @JsonKey(name: 'fcm_token')
  @HiveField(8)
  String? fcmToken;

  @JsonKey(name: 'background_image')
  @HiveField(9)
  String? backgroundImage;

  @JsonKey(name: 'bio_text')
  @HiveField(10)
  String? bioText;

  UserVO.normal();
  UserVO({
    required this.id,
    required this.userName,
    required this.region,
    required this.phone,
    required this.password,
    required this.email,
    required this.qrCode,
    required this.profileImage,
    required this.fcmToken,
    required this.backgroundImage,
    required this.bioText
  });


  @override
  String toString() {
    return 'UserVO{id: $id, region: $region, phone: $phone, userName: $userName, email: $email, password: $password, profileImage: $profileImage, qrCode: $qrCode, fcmToken: $fcmToken, backgroundImage: $backgroundImage, bioText: $bioText}';
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          region == other.region &&
          phone == other.phone &&
          userName == other.userName &&
          email == other.email &&
          password == other.password &&
          profileImage == other.profileImage &&
          qrCode == other.qrCode &&
          fcmToken == other.fcmToken &&
          backgroundImage == other.backgroundImage &&
          bioText == other.bioText;

  @override
  int get hashCode =>
      id.hashCode ^
      region.hashCode ^
      phone.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      profileImage.hashCode ^
      qrCode.hashCode ^
      fcmToken.hashCode ^
      backgroundImage.hashCode ^
      bioText.hashCode;

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);

  @override
  String getSuspensionTag()=>userName?[0].toUpperCase()??'';
}
