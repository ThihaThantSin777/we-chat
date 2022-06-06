import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_home_page_bloc.dart';
import 'package:wechat_app/data/vos/user_vo.dart';
import 'package:wechat_app/pages/we_chat_chat_page.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/view_items/we_chat_home_item_views/we_chat_home_item_views.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

class WeChatHomePage extends StatelessWidget {
  const WeChatHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatHomePageBloc>(
      create: (context) => WeChatHomePageBloc(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.commentDots),
                label: kWeChatAppName),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.addressBook),
                label: kContactText),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.eye), label: kDiscoverText),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user), label: kProfileText),
          ],
        ),
        appBar: AppBar(
          title: const Text(kWeChatAppName),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        ),
        body: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          builder: (context, double opacity, child) => Opacity(
            opacity: opacity,
            child: child,
          ),
          duration: kDurationInOneSecond,
          child: Selector<WeChatHomePageBloc, List<UserVO>>(
              shouldRebuild: (pre, next) => pre != next,
              selector: (context, bloc) => bloc.getUserVOList,
              builder: (context, userVOList, child) {
                WeChatHomePageBloc weChatHomePageBloc =
                    context.read<WeChatHomePageBloc>();
                return (userVOList.isEmpty)
                    ? const WaitingWidget()
                    : ListView.builder(
                        itemCount: (userVOList.length),
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                            onDismissed: (onDismiss) {
                              weChatHomePageBloc.remove(userVOList[index]);
                            },
                            direction: DismissDirection.endToStart,
                            background: Container(),
                            secondaryBackground: Container(
                              padding: const EdgeInsets.only(
                                  left: kDismissibleSecondaryIconPaddingLeft),
                              child: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: kDismissibleSecondaryIconSize,
                              ),
                            ),
                            key: UniqueKey(),
                            child: Padding(
                              padding: const EdgeInsets.only(top: kPadSpace10x),
                              child: GestureDetector(
                                onTap: ()=>navigatePush(context,WeChatChatPage(title: userVOList[index].name)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProfileItemView(
                                      imageURL: userVOList[index].imagePath,
                                    ),
                                    const SizedBox(
                                      width: kPadSpace10x,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              UserNameItemView(
                                                name: userVOList[index].name,
                                              ),
                                              const Spacer(),
                                              ReceiveTimeItemView(
                                                time: userVOList[index].time,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: kPadSpace5x,
                                          ),
                                          SubMessageItemView(
                                            subMessage:
                                                userVOList[index].subMessage,
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.black12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }),
        ),
      ),
    );
  }
}
