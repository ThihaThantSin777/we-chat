import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/show_more_vo/show_more_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';



class AtoZContactItemView extends StatelessWidget {
  const AtoZContactItemView(
      {Key? key, required this.userVO, required this.countFriends,required this.onTap})
      : super(key: key);
  final UserVO userVO;
  final Map<String, int> countFriends;
  final Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    String image=(userVO.profileImage?.isEmpty??true)?kDefaultImage:userVO.profileImage.toString();
    int count = int.parse(countFriends[userVO.userName?[0]].toString());
    String totalFriends = '$count ${(count <= 1) ? 'friend' : 'friends'}';
    return
      Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: userVO.isShowSuspension,
          child: Container(
            color: kBarColor,
            padding: const EdgeInsets.only(left: kPadSpace10x),
            margin: const EdgeInsets.only(left: kPadSpace10x),
            height: kAtoZHeaderHeight,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userVO.getSuspensionTag(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kFontSize17x,
                      color: Colors.black38),
                ),
                Container(
                  padding: const EdgeInsets.only(right: kPadSpace40x),
                  child: Text(
                    totalFriends,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kFontSize17x,
                        color: Colors.black38),
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: kPadSpace5x,horizontal: kPadSpace5x),
          onTap: ()=>onTap(userVO.userName??''),
          leading:  CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(image)
          ),
          title: Text(userVO.userName??''),
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
