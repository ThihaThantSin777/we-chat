import 'package:json_annotation/json_annotation.dart';

part 'chat_vo.g.dart';

@JsonSerializable()
class ChatVO {
  @JsonKey(name: 'user_id')
  String userID;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'profile_pic')
  String profilePic;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'file')
  String file;

  @JsonKey(name: 'video_file')
  String videoFile;

  @JsonKey(name: 'time_stamp')
  DateTime timeStamp;

  ChatVO(
      {required this.userID,
      required this.name,
      required this.profilePic,
      required this.message,
      required this.file,
      required this.videoFile,
      required this.timeStamp});


  @override
  String toString() {
    return 'ChattingUserVO{userID: $userID, name: $name, profilePic: $profilePic, message: $message, file: $file, videoFile: $videoFile, timeStamp: $timeStamp}';
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatVO &&
          runtimeType == other.runtimeType &&
          userID == other.userID &&
          name == other.name &&
          profilePic == other.profilePic &&
          message == other.message &&
          file == other.file &&
          videoFile == other.videoFile &&
          timeStamp == other.timeStamp;

  @override
  int get hashCode =>
      userID.hashCode ^
      name.hashCode ^
      profilePic.hashCode ^
      message.hashCode ^
      file.hashCode ^
      videoFile.hashCode ^
      timeStamp.hashCode;

  factory ChatVO.fromJson(Map<String, dynamic> json) =>
      _$ChatVOFromJson(json);

  Map<String, dynamic> toJson() => _$ChatVOToJson(this);
}
