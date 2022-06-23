



import 'package:flutter/material.dart';
import 'package:wechat_app/resources/dimension.dart';

class ChooseImageTypeWidget extends StatelessWidget {
  const ChooseImageTypeWidget({
    Key? key,
    required this.onChoose,
    required this.title,
    this.color=Colors.white,
  }) : super(key: key);
  final Function onChoose;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onChoose(),
        child: Container(
            padding: const EdgeInsets.all(kPadSpace10x),
            alignment: Alignment.center,
            width: double.infinity,
            child: Text(
              title,
              style:
              TextStyle(color: color, fontSize: kFontSize17x),
            )));
  }
}