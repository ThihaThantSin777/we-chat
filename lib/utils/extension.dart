import 'package:flutter/material.dart';
import 'package:wechat_app/resources/colors.dart';

extension Navigation on Widget {
  void navigatePush(BuildContext context, Widget nextScreen) =>
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => nextScreen));

  void navigatePushReplacement(BuildContext context, Widget nextScreen) =>
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => nextScreen));

  void navigateBack(BuildContext context)=>Navigator.of(context).pop();

  void showSnackBar(BuildContext context,String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,style: const TextStyle(color: Colors.white),),
      backgroundColor: kPrimaryLightColor,
    ));
  }
}
