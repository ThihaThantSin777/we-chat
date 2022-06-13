import 'package:flutter/material.dart';
import 'package:wechat_app/animation/tween_animated_opacity_animation.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/view_items/we_chat_profile_item_views/we_chat_profile_item_view.dart';

class WeChatProfilePage extends StatelessWidget {
  const WeChatProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimatedOpacityAnimation(
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Container(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top * 1.5),
                      color: kPrimaryLightColor,
                      child: const ProfileNameAndQrScanItemView(),
                    )),
                Expanded(
                    flex: 3,
                    child: Container(
                      color: kBarColor,
                      child:
                      const BioSettingIconLogoutItemView(),
                    ))
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top*3.4,
            left: MediaQuery.of(context).size.width*0.33,
            child:const  ProfileImageItemView(),
          )

        ],
      ),
    );
  }
}




