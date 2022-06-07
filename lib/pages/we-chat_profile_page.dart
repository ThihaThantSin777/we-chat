import 'package:flutter/material.dart';

class WeChatProfilePage extends StatelessWidget {
  const WeChatProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
         Column(
           mainAxisSize: MainAxisSize.min,
           children: [
              Expanded(
                child: Container(
                  color: Colors.greenAccent,
                ),
              ),
             Expanded(
               flex: 3,
               child: Container(
                 color: Colors.blue,
               ),
             ),
           ],
         ),
          const Positioned(
            top: 100,
            child: CircleAvatar(
              radius: 100,
            ),
          )
        ],
      );

  }
}
