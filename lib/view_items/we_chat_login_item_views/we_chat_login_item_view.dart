import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';


class MoreOptionItemView extends StatelessWidget {
  const MoreOptionItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(kUnableToLoginText,style: TextStyle(
            color: Colors.white30,
            fontSize: kFontSize15x
        ),),
        SizedBox(
          width: kPadSpace10x,
        ),
        Text('|',style: TextStyle(
            color: Colors.white30,
            fontSize: kFontSize15x
        )),
        SizedBox(
          width: kPadSpace10x,
        ),
        Text(kMoreOptionText,style: TextStyle(
            color: Colors.white30,
            fontSize: kFontSize15x
        ))
      ],
    );
  }
}

class VerificationItemView extends StatelessWidget {
  const VerificationItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      kVerificationText,
      style: TextStyle(color: Colors.white30),
    );
  }
}

class LoginWithMobileItemView extends StatelessWidget {
  const LoginWithMobileItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: const Text(
        kLoginViaMobileText,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}

class LoginTitleItemView extends StatelessWidget {
  const LoginTitleItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      kLoginWithEmailText,
      style: TextStyle(color: Colors.white, fontSize: kFontSize25x),
    );
  }
}

class RecentLoginItemView extends StatelessWidget {
  const RecentLoginItemView({
    Key? key,
    required this.onTapForBack,
    required this.onTapForUserVO,
    required this.userVOList
  }) : super(key: key);

  final Function onTapForBack;
  final Function(UserVO) onTapForUserVO;
  final List<UserVO>userVOList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: ()=>onTapForBack(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: kPadSpace20x),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kPadSpace10x),
                color: Colors.white,
              ),
              width: double.infinity,
              height: null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: userVOList.map((data) {
                  return ListTile(
                    onTap: ()=>onTapForUserVO(data),
                    leading: const Icon(Icons.email),
                    title: Text(data.email??''),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}