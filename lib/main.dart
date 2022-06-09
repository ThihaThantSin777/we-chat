import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/pages/we_chat_home_page.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/theme/we_chat_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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

