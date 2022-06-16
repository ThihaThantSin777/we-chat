import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_contact_page_bloc.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/pages/we_chat_chatting_room_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/view_items/we_chat_contact_item_views/we_chat_contact_item_views.dart';
import 'package:wechat_app/animation/tween_animated_opacity_animation.dart';
import 'package:wechat_app/widgets/search_textfield_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';
import 'package:azlistview/azlistview.dart';

class WeChatContactPage extends StatelessWidget {
  const WeChatContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatContactPageBloc>(
        create: (context) => WeChatContactPageBloc(),
        child: Selector<WeChatContactPageBloc, List<UserVO>>(
          shouldRebuild: (pre,next)=>pre!=next,
            selector: (context, bloc) => bloc.getUserVOList,
            builder: (context, contactList, child) {
              WeChatContactPageBloc weChatContactPageBloc =
                  context.read<WeChatContactPageBloc>();
              return TweenAnimatedOpacityAnimation(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SearchTextFieldWidget(
                      textColor: Colors.black38,
                      color: kBarColor,
                      onChange: (string) {
                        weChatContactPageBloc.searchContactList(string);
                      },
                    ),
                    const Divider(
                      color: Colors.black38,
                    ),
                    const ContactSettingItemView(),
                    const SizedBox(
                      height: kPadSpace10x,
                    ),
                    (contactList.isEmpty)
                        ? const WaitingWidget(
                            isAddCircularProgressIndicator: false,
                          )
                        :  Expanded(
                                child: AzListView(
                                    data: contactList,
                                    itemCount: contactList.length,
                                    indexBarOptions: const IndexBarOptions(
                                        indexHintAlignment:
                                            Alignment.centerRight,
                                        indexHintOffset:
                                            Offset(-kAtoZOffsetX, 0)),
                                    indexBarMargin:
                                        const EdgeInsets.all(kPadSpace10x),
                                    indexHintBuilder: (context, hintText) =>
                                        Container(
                                          width: kAtoZHintWidthAndHeight,
                                          height: kAtoZHintWidthAndHeight,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                              color: kPrimaryLightColor,
                                              shape: BoxShape.circle),
                                          child: Text(
                                            hintText,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                    itemBuilder: (context, index) {
                                      return Selector<WeChatContactPageBloc,
                                          Map<String, int>>(
                                        shouldRebuild: (pre,next)=>pre!=next,
                                        selector: (context, bloc) =>
                                            bloc.getCountFriend,
                                        builder:
                                            (context, countFriends, child) {
                                         if(countFriends.isEmpty){
                                           return const WaitingWidget();
                                         }
                                          return   AtoZContactItemView(
                                            onTap: (name) => navigatePush(
                                                context,
                                                WeChatChattingRoomPage(
                                                  title: name,
                                                  friID: contactList[index].id.toString(),
                                                )
                                            ),
                                            userVO: contactList[index],
                                            countFriends: countFriends,
                                          );
                                            }

                                      );
                                    }),
                              )
                  ],
                ),
              );
            }));
  }
}
