import 'package:flutter/material.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({Key? key,this.isAddCircularProgressIndicator=true,this.text='No data'}) : super(key: key);
  final bool isAddCircularProgressIndicator;
  final String text;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: isAddCircularProgressIndicator? const CircularProgressIndicator(): Text(text),
    );
  }
}
