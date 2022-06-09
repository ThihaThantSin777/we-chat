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
  MomentVO({
    required this.id,
    required this.userName,
    required this.profilePicture,
    required this.postImage,
    required this.postVideo,
    required this.description,
  });

  @override
  String toString() {
    return 'MomentVO(id: $id, userName: $userName, profilePicture: $profilePicture, postImage: $postImage, postVideo: $postVideo, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MomentVO &&
        other.id == id &&
        other.userName == userName &&
        other.profilePicture == profilePicture &&
        other.postImage == postImage &&
        other.postVideo == postVideo &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userName.hashCode ^
        profilePicture.hashCode ^
        postImage.hashCode ^
        postVideo.hashCode ^
        description.hashCode;
  }

  factory MomentVO.fromJson(Map<String, dynamic> json) =>
      _$MomentVOFromJson(json);

  Map<String, dynamic> toJson() => _$MomentVOToJson(this);
}
