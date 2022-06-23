import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_chat_history_page_bloc.dart';
import 'package:wechat_app/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat_app/pages/we_chat_chatting_room_page.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/animation/tween_animated_opacity_animation.dart';
import 'package:wechat_app/widgets/loading_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

import '../view_items/we_chat_chat_history_item_views/we_chat_chat_history_item_views.dart';

class WeChatChatHistoryPage extends StatelessWidget {
  const WeChatChatHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatChatHistoryPageBloc>(
      create: (context) => WeChatChatHistoryPageBloc(),
      child: TweenAnimatedOpacityAnimation(
        child: Stack(
          children: [
            Selector<WeChatChatHistoryPageBloc, List<ChatVO>>(
                shouldRebuild: (pre, next) => pre != next,
                selector: (context, bloc) => bloc.getChattingUserVOList,
                builder: (context, userVOList, child) {
                  WeChatChatHistoryPageBloc weChatHomePageBloc =
                      context.read<WeChatChatHistoryPageBloc>();
                  return (userVOList.isEmpty)
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: const[
                          Icon(Icons.sentiment_dissatisfied_outlined,color: Colors.grey,size: kPadSpace50x,),
                           SizedBox(
                            height: kPadSpace20x,
                          ),
                          WaitingWidget(
                    isAddCircularProgressIndicator: false,
                    text: 'There is no chat list now. Let\'s start chat!!!',
                  ),
                        ],
                      )
                      : ListView.builder(
                          itemCount: (userVOList.length),
                          itemBuilder: (BuildContext context, int index) {
                            return Slidable(
                              key: UniqueKey(),
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                dismissible: DismissiblePane(onDismissed: () {
                                  showMyDialog(context, 'Are you sure want to delete this conservation?').then((value) {
                                    if(value??false){
                                      weChatHomePageBloc
                                          .remove(userVOList[index].userID);
                                    }
                                  });

                                }),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      showMyDialog(context, 'Are you sure want to delete this conservation?').then((value) {
                                        if(value??false){
                                          weChatHomePageBloc
                                              .remove(userVOList[index].userID);
                                        }
                                      });
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
                                          friID: userVOList[index].userID)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ProfileItemView(
                                        imageURL:
                                            (userVOList[index].profilePic).isEmpty
                                                ? kDefaultImage
                                                : userVOList[index].profilePic,
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
                                                const ReceiveTimeItemView(
                                                  time: '3 min',
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: kPadSpace5x,
                                            ),
                                            SubMessageItemView(
                                              subMessage: userVOList[index].message,
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
            Selector<WeChatChatHistoryPageBloc, bool>(
                selector: (context, bloc) => bloc.isLoading,
                builder: (context, isLoading, child) =>
                    Visibility(visible: isLoading, child: const LoadingWidget()))
          ],
        ),
      ),
    );
  }
}
