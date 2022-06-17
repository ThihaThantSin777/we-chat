class ChatUserVO {
  String imagePath;
  String name;
  String subMessage;
  String time;

  ChatUserVO(
      {required this.imagePath,
      required this.name,
      required this.subMessage,
      required this.time});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatUserVO &&
          runtimeType == other.runtimeType &&
          imagePath == other.imagePath &&
          name == other.name &&
          subMessage == other.subMessage &&
          time == other.time;

  @override
  int get hashCode =>
      imagePath.hashCode ^ name.hashCode ^ subMessage.hashCode ^ time.hashCode;

  @override
  String toString() {
    return 'ChatUserVO{imagePath: $imagePath, name: $name, subMessage: $subMessage, time: $time}';
  }
}

