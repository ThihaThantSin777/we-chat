
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/fcm/fcm_service.dart';
import 'package:wechat_app/pages/we_chat_home_page.dart';
import 'package:wechat_app/pages/we_chat_start_page.dart';
import 'package:wechat_app/persistant/constant/hive_constant.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/theme/we_chat_theme.dart';
import 'package:hive_flutter/adapters.dart';

import 'data/model/we_chat_auth_model_impl.dart';
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(MomentVOAdapter());
  await Hive.openBox<UserVO>(kBoxNameForUserVO);
  await Hive.openBox<MomentVO>(kBoxNameForMomentVO);


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FCMService().listenForMessage(navigatorKey);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final WeChatAuthModel auth=WeChatAuthModelImpl();
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: kWeChatAppName,
        themeMode: ThemeMode.light,
        theme: WeChatTheme.weChatLightTheme,
        darkTheme: WeChatTheme.weChatDarkTheme,
        home: (auth.isLoggedIn()?const WeChatHomePage():const WeChatStartPage()));
  }
}

