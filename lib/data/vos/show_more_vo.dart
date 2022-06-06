
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';

class ShowMoreVO{
  String text;
  Widget icon;

  ShowMoreVO({required this.text, required this.icon});

  @override
  String toString() {
    return 'ShowMoreVO{text: $text, icon: $icon}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShowMoreVO &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          icon == other.icon;

  @override
  int get hashCode => text.hashCode ^ icon.hashCode;
}

List<ShowMoreVO>showMoreVOList=[
  ShowMoreVO(text: kFileText, icon: const Icon(Icons.broken_image_outlined,size: kSHowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kCameraText, icon: const Icon(Icons.camera_alt_outlined,size: kSHowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kSightsText, icon: const Icon(Icons.preview_outlined,size: kSHowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kVideoCallText, icon: const Icon(Icons.videocam_outlined,size: kSHowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kLuckyMoneyText, icon: const Icon(Icons.wallet_outlined,size: kSHowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kTransferText, icon: const FaIcon(FontAwesomeIcons.exchange,size: kSHowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kFavoriteText, icon: const FaIcon(FontAwesomeIcons.heart,size: kSHowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kLocationText, icon: const FaIcon(FontAwesomeIcons.locationPin,size: kSHowMoreIconSize,color: Colors.black38,)),

];



