import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_chatting_and_chat_history_pages_bloc.dart';
import 'package:wechat_app/data/vos/user_vo.dart';
import 'package:wechat_app/pages/we_chat_chatting_room_page.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/view_items/we_chat_home_item_views/we_chat_home_item_views.dart';
import 'package:wechat_app/widgets/tween_animation_builder_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

class WeChatChatHistoryPage extends StatelessWidget {
  const WeChatChatHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatChattingAndChatHistoryPagesBloc>(
      create: (context) => WeChatChattingAndChatHistoryPagesBloc(),
      child: TweenAnimatedOpacityWidget(
        child: Selector<WeChatChattingAndChatHistoryPagesBloc, List<UserVO>>(
            shouldRebuild: (pre, next) => pre != next,
            selector: (context, bloc) => bloc.getUserVOList,
            builder: (context, userVOList, child) {
              WeChatChattingAndChatHistoryPagesBloc weChatHomePageBloc =
                  context.read<WeChatChattingAndChatHistoryPagesBloc>();
              return (userVOList.isEmpty)
                  ? const WaitingWidget()
                  : ListView.builder(
                      itemCount: (userVOList.length),
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          key: UniqueKey(),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            dismissible: DismissiblePane(onDismissed: () {
                              weChatHomePageBloc.remove(userVOList[index]);
                            }),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  weChatHomePageBloc.remove(userVOList[index]);
                                },
                                foregroundColor: Colors.red,
                                icon: Icons.cancel_rounded,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: kPadSpace10x),
                            child: GestureDetector(
                              onTap: () => navigatePush(
                                  context,
                                  WeChatChattingRoomPage(
                                      title: userVOList[index].name)),
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
    );
  }
}