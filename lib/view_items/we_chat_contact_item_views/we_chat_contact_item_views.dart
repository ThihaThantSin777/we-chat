import 'package:wechat_app/resources/dimension.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/show_more_vo/show_more_vo.dart';
import 'package:wechat_app/resources/colors.dart';

class SearchTextFieldItemView extends StatelessWidget {
  const SearchTextFieldItemView({Key? key, required this.onChange})
      : super(key: key);
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: kPadSpace10x, vertical: kPadSpace10x),
      decoration: BoxDecoration(
          color: kBarColor,
          borderRadius: BorderRadius.circular(kPadSpace10x),
          border: Border.all(color: Colors.black38)),
      child: Center(
        child: IntrinsicWidth(
          stepWidth: kIntrinsicWidth,
          child: TextField(
            onChanged: (string) => onChange(string),
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
