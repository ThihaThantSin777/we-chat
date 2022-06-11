import 'package:json_annotation/json_annotation.dart';

part 'moment_vo.g.dart';

@JsonSerializable()
class MomentVO {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'user_name')
  String userName;

  @JsonKey(name: 'profile_picture')
  String profilePicture;

  @JsonKey(name: 'post_image')
  String postImage;

  @JsonKey(name: 'post_video')
  String postVideo;

  @JsonKey(name: 'description')
  String description;

  bool isLiked;
  MomentVO({
    required this.id,
    required this.userName,
    required this.profilePicture,
    required this.postImage,
    required this.postVideo,
    required this.description,
    this.isLiked=false
  });


  @override
  String toString() {
    return 'MomentVO{id: $id, userName: $userName, profilePicture: $profilePicture, postImage: $postImage, postVideo: $postVideo, description: $description, isLiked: $isLiked}';
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MomentVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userName == other.userName &&
          profilePicture == other.profilePicture &&
          postImage == other.postImage &&
          postVideo == other.postVideo &&
          description == other.description &&
          isLiked == other.isLiked;

  @override
  int get hashCode =>
      id.hashCode ^
      userName.hashCode ^
      profilePicture.hashCode ^
      postImage.hashCode ^
      postVideo.hashCode ^
      description.hashCode ^
      isLiked.hashCode;

  factory MomentVO.fromJson(Map<String, dynamic> json) =>
      _$MomentVOFromJson(json);

  Map<String, dynamic> toJson() => _$MomentVOToJson(this);
}
