import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wechat_app/persistant/constant/hive_constant.dart';

part 'moment_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeMomentVo)
class MomentVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  int id;

  @JsonKey(name: 'user_id')
  @HiveField(1)
  String userID;

  @JsonKey(name: 'user_name')
  @HiveField(2)
  String userName;

  @JsonKey(name: 'profile_picture')
  @HiveField(3)
  String profilePicture;

  @JsonKey(name: 'post_image')
  @HiveField(4)
  String postImage;

  @JsonKey(name: 'post_video')
  @HiveField(5)
  String postVideo;

  @JsonKey(name: 'description')
  @HiveField(6)
  String description;

  @JsonKey(name: 'time_stamp')
  @HiveField(7)
  DateTime timeStamp;


  bool isOriginalUploader;

  bool isLiked;
  MomentVO({
    required this.id,
    required this.userID,
    required this.userName,
    required this.profilePicture,
    required this.postImage,
    required this.postVideo,
    required this.description,
    required this.timeStamp,
    this.isOriginalUploader=false,
    this.isLiked=false
  });


  @override
  String toString() {
    return 'MomentVO{id: $id, userID: $userID, userName: $userName, profilePicture: $profilePicture, postImage: $postImage, postVideo: $postVideo, description: $description, timeStamp: $timeStamp, isOriginalUploader: $isOriginalUploader, isLiked: $isLiked}';
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MomentVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userID == other.userID &&
          userName == other.userName &&
          profilePicture == other.profilePicture &&
          postImage == other.postImage &&
          postVideo == other.postVideo &&
          description == other.description &&
          timeStamp == other.timeStamp &&
          isOriginalUploader == other.isOriginalUploader &&
          isLiked == other.isLiked;

  @override
  int get hashCode =>
      id.hashCode ^
      userID.hashCode ^
      userName.hashCode ^
      profilePicture.hashCode ^
      postImage.hashCode ^
      postVideo.hashCode ^
      description.hashCode ^
      timeStamp.hashCode ^
      isOriginalUploader.hashCode ^
      isLiked.hashCode;

  factory MomentVO.fromJson(Map<String, dynamic> json) =>
      _$MomentVOFromJson(json);

  Map<String, dynamic> toJson() => _$MomentVOToJson(this);
}
