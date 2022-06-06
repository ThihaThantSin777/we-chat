import 'package:flutter/material.dart';

extension Navigation on Widget {
  void navigatePush(BuildContext context, Widget nextScreen) =>
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => nextScreen));

  void navigatePushReplacement(BuildContext context, Widget nextScreen) =>
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => nextScreen));

  void navigateBack(BuildContext context)=>Navigator.of(context).pop();
}
