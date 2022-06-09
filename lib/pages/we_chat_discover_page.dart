import 'package:flutter/material.dart';
import 'package:wechat_app/pages/we_chat_add_post_page.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/extension.dart';
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
          IconButton(
              onPressed: () {
                navigatePush(context, WeChatAddPostPage());
              },
              icon: const Icon(Icons.photo_camera))
        ],
      ),
    );
  }
}
