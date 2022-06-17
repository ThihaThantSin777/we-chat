
import 'package:json_annotation/json_annotation.dart';

part 'chatting_user_vo.g.dart';

@JsonSerializable()
class ChattingUserVO {
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

  @JsonKey(name: 'time_stamp')
  DateTime timeStamp;

  ChattingUserVO(
      {required this.userID,
      required this.name,
      required this.profilePic,
      required this.message,
      required this.file,
      required this.timeStamp});
  @override
  String toString() {
    return 'ChattingUserVO{userID: $userID, name: $name, profilePic: $profilePic, message: $message, file: $file, timeStamp: $timeStamp}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChattingUserVO &&
          runtimeType == other.runtimeType &&
          userID == other.userID &&
          name == other.name &&
          profilePic == other.profilePic &&
          message == other.message &&
          file == other.file &&
          timeStamp == other.timeStamp;

  @override
  int get hashCode =>
      userID.hashCode ^
      name.hashCode ^
      profilePic.hashCode ^
      message.hashCode ^
      file.hashCode ^
      timeStamp.hashCode;


  factory ChattingUserVO.fromJson(Map<String,dynamic>json)=>_$ChattingUserVOFromJson(json);

  Map<String,dynamic>toJson()=>_$ChattingUserVOToJson(this);
}
