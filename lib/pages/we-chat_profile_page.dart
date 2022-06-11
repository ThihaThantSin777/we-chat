import 'package:flutter/material.dart';
import 'package:wechat_app/animation/tween_animated_opacity_animation.dart';
import 'package:wechat_app/pages/we_chat_settings_page.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/view_items/we_chat_profile_item_views/we_chat_profile_item_view.dart';
import 'package:wechat_app/utils/extension.dart';

class WeChatProfilePage extends StatelessWidget {
  const WeChatProfilePage({Key? key}) : super(key: key);
  void navigateToSetting(String settingName,BuildContext context){
    if(settingName==kSettingText){
      navigatePush(context, const WeChatSettingPage());
    }
  }
  @override
  Widget build(BuildContext context) {
    return TweenAnimatedOpacityAnimation(
      child: Stack(
        children: [
          const BackgroundLayoutItemView(),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.136,
              left: MediaQuery.of(context).size.width * 0.34,
              child: const CircleAvatarProfileItemView()),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: kPadSpace45x),
              child: ProfileNameAndIdItemView(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: kPadSpace45x, right: kPadSpace10x),
            child: QRCodeItemView(),
          ),
          Positioned(
              top: kPadSpace280x,
              child: Container(
                  margin: const EdgeInsets.only(left: kPadSpace10x),
                  width: kBioTextContainerWidth,
                  child: const BioTextItemView())),
          const Padding(
            padding: EdgeInsets.only(bottom: kPadSpace20x),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LogoutButtonItemView(),
            ),
          ),
           Align(
            alignment: Alignment.center,
            child: SettingItemView(
              onTap: (string)=>navigateToSetting(string, context),
            ),
          )
        ],
      ),
    );
  }
}
