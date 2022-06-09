import 'package:flutter/material.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/widgets/leading_widget.dart';

class WeChatSettingPage extends StatelessWidget {
  const WeChatSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kSettingText),
        leading: const LeadingWidget(text: 'Profile'),
      ),
      body: ListView(
        children: [
          Card(
              child: ListTile(
            title: const Text('Theme'),
            trailing: Switch(value: false, onChanged: (value) {
              print(value);
            }),
          )),
        ],
      ),
    );
  }
}
