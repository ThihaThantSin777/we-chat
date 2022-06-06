class UserVO {
  String imagePath;
  String name;
  String subMessage;
  String time;

  UserVO(
      {required this.imagePath,
      required this.name,
      required this.subMessage,
      required this.time});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVO &&
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
    return 'UserVO{imagePath: $imagePath, name: $name, subMessage: $subMessage, time: $time}';
  }
}

List<UserVO> userVOList = [
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'AA Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
  UserVO(
      imagePath:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      name: 'Thomas Willian',
      subMessage:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution',
      time: '4:57 PM'),
];
