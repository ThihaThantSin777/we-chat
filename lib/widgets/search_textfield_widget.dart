
import 'package:flutter/material.dart';
import 'package:wechat_app/resources/dimension.dart';


class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({Key? key, required this.onChange,required this.color,required this.textColor})
      : super(key: key);
  final Function(String) onChange;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: kPadSpace10x, vertical: kPadSpace10x),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(kPadSpace10x),
          border: Border.all(color: Colors.black38)),
      child: Center(
        child: IntrinsicWidth(
          stepWidth: kIntrinsicWidth,
          child: TextField(
            style: TextStyle(
              color: textColor
            ),
            onChanged: (string) => onChange(string),
            textAlignVertical: TextAlignVertical.center,
            decoration:  InputDecoration(
                prefixIcon:  Icon(Icons.search,color: textColor,),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: textColor
                ),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}