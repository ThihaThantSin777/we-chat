import 'package:flutter/material.dart';
import 'package:wechat_app/pages/we_chat_login_page.dart';
import 'package:wechat_app/pages/we_chat_register_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/utils/extension.dart';

import '../resources/colors.dart';
import '../view_items/we_chat_start_item_views/we_chat_start_item_view.dart';

class WeChatStartPage extends StatelessWidget {
  const WeChatStartPage({Key? key}) : super(key: key);

  void actionOnRegisterButton(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kPadSpace20x)),
        backgroundColor: kUploadImageBottomSheetColor,
        context: context,
        builder: (context) {
          return SignInBottomSheetItemView(
            onPressedForMobileNumber: () {
              navigateBack(context);
              navigatePush(context, const WeChatRegisterPage());
            },
          );
        });
  }

  void actionOnRLoginButton(BuildContext context) {
    navigatePush(context, const WeChatLoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImageItemView(),
          const LanguageItemView(),
          LoginSignUpButtonItemView(
            onPressedLogin: () => actionOnRLoginButton(context),
            onPressedSignup: () => actionOnRegisterButton(context),
          )
        ],
      ),
    );
  }
}
