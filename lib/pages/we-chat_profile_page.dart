import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/animation/tween_animated_opacity_animation.dart';
import 'package:wechat_app/bloc/we_chat_profile_page_bloc.dart';
import 'package:wechat_app/pages/we_chat_qr_code_page.dart';
import 'package:wechat_app/pages/we_chat_start_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/view_items/we_chat_profile_item_views/we_chat_profile_item_view.dart';
import 'package:wechat_app/widgets/loading_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

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
                            child: Selector<WeChatProfilePageBloc,String>(
                              selector: (context,bloc)=>bloc.getID,
                              builder: (context,id,child)=>

                            Selector<WeChatProfilePageBloc,String>(
                              selector: (context,bloc)=>bloc.getName,
                              builder: (context,name,child)=>
                               Container(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).viewPadding.top * 1.5),
                                  color: kPrimaryLightColor,
                                  child:  ProfileNameAndQrScanItemView(
                                    id: id,
                                    name: name,
                                    onTap: ()=>navigatePushRemoveUntil(context, const WeChatQRCodePage()),
                                  ),
                                ),
                            ),
                            )),
                        Selector<WeChatProfilePageBloc,String>(
                          selector: (context,bloc)=>bloc.getBioText,
                          builder: (context,bioText,child)=>
                         Expanded(
                              flex: 3,
                              child: Container(
                                color: kBarColor,
                                child: BioSettingIconLogoutItemView(
                                  onEdit: (){

                                  },
                                  bioText: (bioText.isEmpty)?kWriteYourBioText:bioText,
                                  onPressed: (){
                                    showMyDialog(context, 'Are you sure want to logout').then((value) {
                                      if(value??false){
                                        weChatProfilePageBloc.logout().then((value) => navigatePushRemoveUntil(context,const WeChatStartPage()));
                                      }
                                    });
                                  },
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Selector<WeChatProfilePageBloc,String>(
                  selector: (context,bloc)=>bloc.getProfilePicture,
                  builder: (context,imageURL,child)=>
                  (imageURL.isEmpty)?const WaitingWidget():  Positioned(
                    top: MediaQuery.of(context).viewPadding.top * 3.4,
                    left: MediaQuery.of(context).size.width * 0.33,
                    child:  ProfileImageItemView(
                      imageURL: imageURL,
                    ),
                  ),
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
