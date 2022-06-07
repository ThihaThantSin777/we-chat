import 'package:flutter/material.dart';
import 'package:wechat_app/pages/we_chat_chat_history_page.dart';
import 'package:wechat_app/pages/we_chat_home_page.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/theme/we_chat_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kWeChatAppName,
      themeMode: ThemeMode.light,
      theme: WeChatTheme.weChatLightTheme,
      darkTheme: WeChatTheme.weChatDarkTheme,
      home: const WeChatHomePage()
    );
  }
}

