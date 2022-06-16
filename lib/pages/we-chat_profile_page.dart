import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/animation/tween_animated_opacity_animation.dart';
import 'package:wechat_app/bloc/we_chat_profile_page_bloc.dart';
import 'package:wechat_app/pages/we_chat_qr_code_page.dart';
import 'package:wechat_app/pages/we_chat_start_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/view_items/we_chat_profile_item_views/we_chat_profile_item_view.dart';
import 'package:wechat_app/widgets/loading_widget.dart';

class WeChatProfilePage extends StatelessWidget {
  const WeChatProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatProfilePageBloc>(
      create: (context) => WeChatProfilePageBloc(),
      builder: (context, child) {
        WeChatProfilePageBloc weChatProfilePageBloc=context.read<WeChatProfilePageBloc>();
        return   TweenAnimatedOpacityAnimation(
          child: Stack(
            children: [
              Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).viewPadding.top * 1.5),
                              color: kPrimaryLightColor,
                              child:  ProfileNameAndQrScanItemView(
                                onTap: ()=>navigatePush(context, const WeChatQRCodePage()),
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              color: kBarColor,
                              child: BioSettingIconLogoutItemView(
                                onPressed: (){
                                 weChatProfilePageBloc.logout().then((value) => navigatePushReplacement(context,const WeChatStartPage()));
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).viewPadding.top * 3.4,
                    left: MediaQuery.of(context).size.width * 0.33,
                    child: const ProfileImageItemView(),
                  ),

                ],
              ),
              Visibility(
                  visible: weChatProfilePageBloc.isLoading,
                  child: const LoadingWidget()
              ),
            ],
          ),
        );
      }

    );
  }
}
