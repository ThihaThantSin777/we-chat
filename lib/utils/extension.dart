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

  void showSnackBar(BuildContext context, String message,{Color color =kPrimaryLightColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    ));
  }
  Future<bool?> showMyDialog(BuildContext context,String text) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
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


extension EmailValidation on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
