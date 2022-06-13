
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
  ShowMoreVO(text: kFileText, icon: const Icon(Icons.broken_image_outlined,size: kShowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kCameraText, icon: const Icon(Icons.camera_alt_outlined,size: kShowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kSightsText, icon: const Icon(Icons.preview_outlined,size: kShowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kVideoCallText, icon: const Icon(Icons.videocam_outlined,size: kShowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kLuckyMoneyText, icon: const Icon(Icons.wallet_outlined,size: kShowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kTransferText, icon: const FaIcon(FontAwesomeIcons.exchange,size: kShowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kFavoriteText, icon: const FaIcon(FontAwesomeIcons.heart,size: kShowMoreIconSize,color: Colors.black38,)),
  ShowMoreVO(text: kLocationText, icon: const FaIcon(FontAwesomeIcons.locationPin,size: kShowMoreIconSize,color: Colors.black38,)),

];


List<ShowMoreVO>accountVOList=[
  ShowMoreVO(text: kNewFriendText,  icon: const Icon(Icons.person_add_alt_1_outlined,size: kContactIconSize,color: Colors.black38,) ),
  ShowMoreVO(text: kGroupChatText,  icon: const Icon(Icons.group_add_outlined,size: kContactIconSize,color: Colors.black38,) ),
  ShowMoreVO(text: kTagsText,  icon:const  FaIcon(FontAwesomeIcons.tags,size: kContactIconSize,color: Colors.black38,) ),
  ShowMoreVO(text: kOfficialAccountText,  icon: const Icon(Icons.switch_account_outlined,size: kContactIconSize,color: Colors.black38,) ),
];

List<ShowMoreVO>settingVOList=[
  ShowMoreVO(text: kPhotoText,  icon: const Icon(Icons.photo,size: kShowMoreIconSize,color: Colors.black38,) ),
  ShowMoreVO(text: kFavoriteText,  icon: const Icon(Icons.favorite,size: kShowMoreIconSize,color: Colors.black38,) ),
  ShowMoreVO(text: kWalletText,  icon:const  FaIcon(FontAwesomeIcons.wallet,size: kShowMoreIconSize,color: Colors.black38,) ),
  ShowMoreVO(text: kCardText,  icon: const Icon(Icons.credit_card,size: kShowMoreIconSize,color: Colors.black38,) ),
  ShowMoreVO(text: kStickerText,  icon:const  Icon(Icons.sentiment_satisfied_outlined,size: kShowMoreIconSize,color: Colors.black38,) ),
  ShowMoreVO(text: kSettingText,  icon: const Icon(Icons.settings,size: kShowMoreIconSize,color: Colors.black38,) ),
];



