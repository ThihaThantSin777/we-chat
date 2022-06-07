import 'package:flutter/material.dart';
import 'package:wechat_app/utils/extension.dart';

class LeadingWidget extends StatelessWidget {
  const LeadingWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: IconButton(
            onPressed: () {
              navigateBack(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        )
      ],
    );
    // return MaterialButton(
    //   onPressed: ()=>navigateBack(context),
    //   child: Row(
    //     mainAxisSize: MainAxisSize.min,
    //   children: [
    //     const Icon(
    //       Icons.chevron_left,
    //       color: Colors.white,
    //     ),
    //     Text(
    //       text,
    //       style: const TextStyle(
    //         color: Colors.white,
    //          fontSize: 15,
    //       ),
    //     )
    //   ],
    // )
    // );
  }
}
