import 'package:flutter/material.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/widgets/leading_widget.dart';

class WeChatDiscoverPage extends StatelessWidget {
  const WeChatDiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kMomentsText),
        automaticallyImplyLeading: false,
        leadingWidth: kLeadingWidth,
        leading: const LeadingWidget(text: kDiscoverText),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.photo_camera))
        ],
      ),
    );
  }
}
