import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'region')
  String region;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'user_name')
  String userName;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'profile_image')
  String profileImage;

  @JsonKey(name: 'qr_code')
  String qrCode;

  UserVO({
    required this.id,
    required this.userName,
    required this.region,
    required this.phone,
    required this.password,
    required this.email,
    required this.qrCode,
    required this.profileImage
  });


  @override
  String toString() {
    return 'UserVO{id: $id, region: $region, phone: $phone, userName: $userName, email: $email, password: $password, profileImage: $profileImage, qrCode: $qrCode}';
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
          qrCode == other.qrCode;

  @override
  int get hashCode =>
      id.hashCode ^
      region.hashCode ^
      phone.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      profileImage.hashCode ^
      qrCode.hashCode;

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
