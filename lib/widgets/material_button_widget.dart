
import 'package:flutter/material.dart';
import 'package:wechat_app/resources/dimension.dart';


class MaterialButtonWidget extends StatelessWidget {
  const MaterialButtonWidget({
    Key? key,
    required this.onPressed,
    required this.color,
    required this.textColor,
    required this.childText,
    this.miniWidth=kMaterialButtonWidth
  }) : super(key: key);
  final Function onPressed;
  final Color color;
  final Color textColor;
  final String childText;
  final double miniWidth;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: textColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kPadSpace5x)
        ),
        minWidth: miniWidth,
        height: kMaterialButtonHeight,
        color: color,
        onPressed:()=> onPressed(),
      child:  Text(
        childText,
        style: const TextStyle(fontWeight: FontWeight.w700,fontSize: kFontSize17x),
      ),
    );
  }
}