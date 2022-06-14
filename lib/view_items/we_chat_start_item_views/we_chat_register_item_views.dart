import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/country_code_vo/country_code_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';

class ChooseImageItemView extends StatelessWidget {
  const ChooseImageItemView({
    Key? key,
    required this.onChoose,
    required this.file
  }) : super(key: key);
  final Function onChoose;
  final File file;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onChoose(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.15,
        height: MediaQuery.of(context).size.height*0.07,
        child: (file.path.isEmpty)?ClipRRect(
            borderRadius: BorderRadius.circular(kPadSpace10x),
            child: Image.asset('images/default.jpeg',fit: BoxFit.cover,)):Image.file(file)
      ),
    );
  }
}

class RegisterTitleItemView extends StatelessWidget {
  const RegisterTitleItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(kSignupWithMobile,style: TextStyle(
        fontSize: kFontSize19x,
        color: Colors.white
    ),);
  }
}

class TermsAndConditionItemView extends StatelessWidget {
  const TermsAndConditionItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          style: TextStyle(color: Colors.white30),
          text: 'I have read and accept the ',
          children: [
            TextSpan(
                text: 'Terms of Services.',
                style: TextStyle(color: Colors.grey)),
            TextSpan(
                text:
                'The information collected on this page is only used for account registration',
                style:
                TextStyle(color: Colors.white30)),
          ]),
    );
  }
}

class CheckBoxItemView extends StatelessWidget {
  const CheckBoxItemView({
    Key? key,
    required this.isSelect,
    required this.onTap
  }) : super(key: key);

  final bool isSelect;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: CircleAvatar(
        radius: kPadSpace10x,
        backgroundColor: isSelect ? kButtonColor : Colors.grey,
        child: Visibility(
          visible: isSelect,
          child: const Icon(
            Icons.check, color: Colors.white, size: kPadSpace20x,),
        ),
      ),
    );
  }
}


class ChooseImageTypeItemView extends StatelessWidget {
  const ChooseImageTypeItemView({
    Key? key,
    required this.onChoose,
    required this.title,
  }) : super(key: key);
  final Function onChoose;
  final String title;

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
              const TextStyle(color: Colors.white, fontSize: kFontSize17x),
            )));
  }
}

class RegionListItemView extends StatelessWidget {
  const RegionListItemView({
    Key? key,
    required this.countryCodeVO,
    required this.onTap
  }) : super(key: key);
  final CountryCodeVO countryCodeVO;
  final Function(CountryCodeVO)onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: countryCodeVO.isShowSuspension,
          child: Container(
            color: kRegionBackGroundColor,
            padding: const EdgeInsets.only(
                left: kPadSpace10x),
            height: kAtoZHeaderHeight,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  countryCodeVO
                      .getSuspensionTag(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kFontSize17x,
                      color: Colors.white30),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: ()=>onTap(countryCodeVO),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: kPadSpace10x,vertical: kPadSpace10x),
              decoration:const BoxDecoration(
                  color: kAzListColor,
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.white12
                      )
                  )
              ),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(countryCodeVO.name,style: const TextStyle(
                      fontSize: kFontSize17x,
                      color: Colors.white70
                  ),),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Text(countryCodeVO.phNo,style: const TextStyle(
                        color: Colors.white70
                    ),),
                  ),

                ],
              )
          ),
        ),
      ],
    );
  }
}