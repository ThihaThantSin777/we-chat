import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_home_page_bloc.dart';
import 'package:wechat_app/data/vos/chatting_vo.dart';
import 'package:wechat_app/data/vos/show_more_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/view_items/we_chat_home_item_views/we_chat_chat_item_views.dart';
import 'package:wechat_app/widgets/leading_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

class WeChatChatPage extends StatelessWidget {
  const WeChatChatPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatHomePageBloc>(
      create: (context) => WeChatHomePageBloc(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(title),
          leadingWidth: kLeadingWidth,
          leading: const LeadingWidget(text: 'We chat'),
          actions: [
            IconButton(
                onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.user))
          ],
        ),
        body: Stack(
          children: [
            Selector<WeChatHomePageBloc, List<ChattingVO>>(
                selector: (context, bloc) => bloc.getChattingVOList,
                builder: (context, chatVoList, child) => (chatVoList.isEmpty)
                    ? const WaitingWidget()
                    : ListView.separated(
                        padding: const EdgeInsets.only(top: kPadSpace10x),
                        itemCount: chatVoList.length,
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: (chatVoList[index].isLeft)
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            CircleAvatarProfileItemView(
                              isLeft: chatVoList[index].isLeft,
                            ),
                            const SizedBox(
                              width: kPadSpace10x,
                            ),
                            ChattingItemView(
                              text: chatVoList[index].text,
                              isLeft: chatVoList[index].isLeft,
                            )
                          ],
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: kPadSpace20x,
                        ),
                      )),
            Consumer<WeChatHomePageBloc>(builder: (context, bloc, child) {
              WeChatHomePageBloc weChatHomePageBloc =
                  context.read<WeChatHomePageBloc>();
              return Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: kPadSpace10x),
                      alignment: Alignment.topCenter,
                      color: kBarColor,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(
                            width: kPadSpace5x,
                          ),
                          const MicroPhoneItemView(),
                          const SizedBox(
                            width: kPadSpace10x,
                          ),
                          TextFieldItemView(
                            onChange: (string) {
                              weChatHomePageBloc.setIsShowMoreIconState(string);
                            },
                          ),
                          ShowMoreIconItemView(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              bloc.setIsShowMoreWidgetState();
                            },
                            showMoreIcon: bloc.getShowMoreIcon,
                          ),
                        ],
                      ),
                    ),
                    AnimatedSize(
                      duration: kDurationIn500milliseconds,
                      child: Visibility(
                        visible: bloc.isShowMoreWidget,
                        child: const ShowMoreItemView(),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class ChattingItemView extends StatelessWidget {
  const ChattingItemView({Key? key, required this.text,required this.isLeft}) : super(key: key);
  final String text;
  final bool isLeft;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 200),
      padding: const EdgeInsets.symmetric(
          horizontal: kPadSpace10x, vertical: kPadSpace10x),
      alignment: (isLeft)?Alignment.topLeft:Alignment.topRight,
      decoration: BoxDecoration(
          color: kBarColor, borderRadius: BorderRadius.circular(kPadSpace20x)),
      child: Text(text),
    );
  }
}

class CircleAvatarProfileItemView extends StatelessWidget {
  const CircleAvatarProfileItemView({Key? key, required this.isLeft})
      : super(key: key);
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isLeft,
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
        ));
  }
}
