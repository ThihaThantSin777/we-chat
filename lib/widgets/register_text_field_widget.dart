import 'package:flutter/material.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/utils/enums.dart';

class RegisterTextFieldWidget extends StatelessWidget {
  const RegisterTextFieldWidget({
    Key? key,
    required this.onChange,
    required this.preFixText,
    required this.hintText,
    required this.textInput,
    required this.onPressedShowPassword,
    this.isShowSuffix = false,
    this.isShowPassword = false,
    this.prefixPhoneNo=''
  }) : super(key: key);
  final Function(String) onChange;
  final String preFixText;
  final String hintText;
  final bool isShowSuffix;
  final bool isShowPassword;
  final Function onPressedShowPassword;
  final TextFieldInputType textInput;
  final String prefixPhoneNo;


  @override
  Widget build(BuildContext context) {

    return ListTile(
          minLeadingWidth: kPadSpace90x,
          shape: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38)),
          contentPadding: const EdgeInsets.all(0),
          leading: Text(
            preFixText,
            style: const TextStyle(color: Colors.white, fontSize: kFontSize15x),
          ),
          title: TextField(
            onChanged: (string){
              onChange(string);
            },
            obscureText: (isShowPassword) ? true : false,
            style: const TextStyle(color: Colors.white),
                  keyboardType: (textInput == TextFieldInputType.text)
              ? TextInputType.text
              : (textInput == TextFieldInputType.phone)
                  ? TextInputType.phone
                  : TextInputType.emailAddress,
            decoration: InputDecoration(
                      prefixIcon:(prefixPhoneNo.isEmpty)?null: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          prefixPhoneNo,
                          style: const TextStyle(
                              color: Colors.white30, fontSize: kFontSize15x),
                        ),
                      ),
              border: InputBorder.none,
                      hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white30),
                suffixIcon: (isShowSuffix)?IconButton(
                    onPressed: () =>onPressedShowPassword(),
                    icon:  Icon((isShowPassword)?Icons.visibility_off:Icons.visibility,
                      color: Colors.white30,
                    )):null
            ),
          )

        );

  }
}

