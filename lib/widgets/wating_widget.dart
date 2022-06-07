import 'package:flutter/material.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({Key? key,this.isAddCircularProgressIndicator=true}) : super(key: key);
  final bool isAddCircularProgressIndicator;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: isAddCircularProgressIndicator? const CircularProgressIndicator():const Text('No data'),
    );
  }
}
