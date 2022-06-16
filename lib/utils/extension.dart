import 'package:flutter/material.dart';
import 'package:wechat_app/resources/colors.dart';

extension Navigation on Widget {
  Future<Object?> navigatePush(BuildContext context, Widget nextScreen,
          [String animationName = 'slide']) =>
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => nextScreen));

  Future<Object?> navigatePushReplacement(
          BuildContext context, Widget nextScreen) =>
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => nextScreen));

  void navigateBack(BuildContext context, [Object? object]) =>
      Navigator.of(context).pop(object);

  void navigatePushRemoveUntil(BuildContext context, Widget nextScreen) =>
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => nextScreen),
          (route) => false);

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: kPrimaryLightColor,
    ));
  }
}

extension EncryptAndDecrypt on String {
  String encrypt() {
    List<int> results = [];
    for (var result in codeUnits) {
      int temp = result + 10;
      results.add(temp);
    }
    return results.join('|');
  }

  String decrypt() {
    List<String> strings = split('|');
    String decrypt = '';
    for (var result in strings) {
      int parse = int.parse(result);
      int convert = parse - 10;
      decrypt += String.fromCharCode(convert);
    }
    return decrypt;
  }
}
