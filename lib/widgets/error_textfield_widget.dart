import 'package:flutter/material.dart';

class ErrorTextFieldWidget extends StatelessWidget {
  const ErrorTextFieldWidget({Key? key, required this.isError, required this.errorText})
      : super(key: key);
  final bool isError;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isError,
      child: Text(
        errorText,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}