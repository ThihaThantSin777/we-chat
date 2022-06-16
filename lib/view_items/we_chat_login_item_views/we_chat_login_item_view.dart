import 'package:flutter/material.dart';
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