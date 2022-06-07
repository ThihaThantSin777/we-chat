import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_contact_page_bloc.dart';
import 'package:wechat_app/data/vos/show_more_vo.dart';
import 'package:wechat_app/data/vos/strings_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/view_items/we_chat_contact_item_views/we_chat_contact_item_views.dart';
import 'package:wechat_app/widgets/tween_animation_builder_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';
import 'package:azlistview/azlistview.dart';

class WeChatContactPage extends StatelessWidget {
  const WeChatContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatContactPageBloc>(
        create: (context) => WeChatContactPageBloc(),
        child: Selector<WeChatContactPageBloc, List<StringVO>>(
            selector: (context, bloc) => bloc.getStringVOList,
            builder: (context, contactList, child) {
              WeChatContactPageBloc weChatContactPageBloc =
                  context.read<WeChatContactPageBloc>();
              return TweenAnimatedOpacityWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SearchTextFieldItemView(
                      onChange: (string) {
                        weChatContactPageBloc.searchContactList(string);
                      },
                    ),
                    const Divider(
                      color: Colors.black38,
                    ),
                    const ContactSettingItemView(),
                    (contactList.isEmpty)
                        ? const WaitingWidget(
                            isAddCircularProgressIndicator: false,
                          )
                        : Expanded(
                            child: AzListView(
                                data: contactList,
                                itemCount: contactList.length,
                                indexBarOptions: const IndexBarOptions(
                                    indexHintAlignment: Alignment.centerRight,
                                    indexHintOffset: Offset(-kAtoZOffsetX, 0)),
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
                                  return Selector<WeChatContactPageBloc,Map<String,int>>(
                                    selector: (context,bloc)=>bloc.getCountFriend,
                                    builder: (context,countFriends,child)=>
                                     AtoZContactItemView(
                                        stringVO: contactList[index],
                                     countFriends: countFriends,
                                     ),
                                  );
                                }),
                          )
                  ],
                ),
              );
            }));
  }
}

class AtoZContactItemView extends StatelessWidget {
  const AtoZContactItemView({Key? key, required this.stringVO,required this.countFriends})
      : super(key: key);
  final StringVO stringVO;
  final Map<String,int>countFriends;
  @override
  Widget build(BuildContext context) {
    int count=int.parse(countFriends[stringVO.tag].toString());
    String totalFriends='$count ${(count<=1)?'friend':'friends'}';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: stringVO.isShowSuspension,
          child: Container(
            color: kBarColor,
            padding: const EdgeInsets.only(left: kPadSpace10x),
            margin: const EdgeInsets.only(left: kPadSpace10x),
            height: kAtoZHeaderHeight,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  stringVO.getSuspensionTag(),
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: kFontSize17x,color: Colors.black38),),
                const SizedBox(
                  width: kPadSpace250x,
                ),
                Text(
                  totalFriends,
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: kFontSize17x,color: Colors.black38),),
              ],
            ),
          ),
        ),
        ListTile(
          title: Text(stringVO.title),
        ),
      ],
    );
  }
}

class ContactSettingItemView extends StatelessWidget {
  const ContactSettingItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: accountVOList
            .map(
              (data) => Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(color: Colors.black38, width: 1))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      data.icon,
                      const SizedBox(
                        height: kPadSpace5x,
                      ),
                      SizedBox(
                          child: Text(
                        data.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black38),
                      )),
                    ],
                  ),
                ),
              ),
            )
            .toList());
  }
}
