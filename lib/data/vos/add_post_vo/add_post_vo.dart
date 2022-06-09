import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wechat_app/resources/dimension.dart';

class AddPostVO {
  String name;
  Widget icon;

  AddPostVO({
    required this.name,
    required this.icon,
  });

  @override
  String toString() => 'AddPostVO(name: $name, icon: $icon)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddPostVO && other.name == name && other.icon == icon;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode;
}

List<AddPostVO> addPostVoList = [
  AddPostVO(
    name: 'Photos',
    icon: const Icon(
      Icons.photo,
      color: Colors.green,
    ),
  ),
  AddPostVO(
    name: 'Videos',
    icon: const Icon(
      Icons.video_call,
      color: Colors.orange,
    ),
  ),
  AddPostVO(
    name: 'Tag peoples',
    icon: const FaIcon(
      FontAwesomeIcons.userTag,
      color: Colors.blue,
      size: kPadSpace20x,
    ),
  ),
  AddPostVO(
    name: 'Feelings/Activity',
    icon: const Icon(
      Icons.sentiment_satisfied_outlined,
      color: Colors.amber,
    ),
  ),
  AddPostVO(
    name: 'Check in',
    icon: const Icon(
      Icons.location_on,
      color: Colors.purple,
    ),
  ),
  AddPostVO(
    name: 'Live videos',
    icon: const Icon(
      Icons.videocam,
      color: Colors.red,
    ),
  ),
];
