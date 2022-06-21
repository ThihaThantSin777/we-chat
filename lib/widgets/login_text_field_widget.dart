import 'package:flutter/material.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/utils/enums.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({
    Key? key,
    required this.preFixText,
    required this.hintText,
    required this.textInput,
    required this.onPressedShowPassword,
    required this.textEditingController,
    this.isShowSuffix = false,
    this.isShowPassword = false,
  }) : super(key: key);
  final String preFixText;
  final String hintText;
  final bool isShowSuffix;
  final bool isShowPassword;
  final Function onPressedShowPassword;
  final TextFieldInputType textInput;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {

    return ListTile(

        minLeadingWidth: kPadSpace30x,
        shape: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38)),
        contentPadding: const EdgeInsets.all(0),
        leading: Text(
          preFixText,
          style: const TextStyle(color: Colors.white, fontSize: kFontSize15x),
        ),
        title: TextField(
          controller: textEditingController,
          obscureText: (isShowPassword) ? true : false,
          style: const TextStyle(color: Colors.white),
          keyboardType: (textInput == TextFieldInputType.email)
              ? TextInputType.emailAddress
              : TextInputType.text,
          decoration: InputDecoration(
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

