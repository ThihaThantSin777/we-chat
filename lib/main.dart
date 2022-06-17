import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_user_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_cloud_firestore_data_agent_impl.dart';
import 'package:wechat_app/network/data_agent/we_chat_data_agent.dart';
import 'package:wechat_app/network/data_agent/we_chat_real_tim_data_gent.dart';
import 'package:wechat_app/network/data_agent/we_chat_real_time_data_agent_impl.dart';
import 'package:wechat_app/pages/we_chat_home_page.dart';
import 'package:wechat_app/pages/we_chat_start_page.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/theme/we_chat_theme.dart';
import 'package:wechat_app/utils/extension.dart';

import 'data/model/we_chat_auth_model_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  WeChatAuthModel weChatAuthModel=WeChatAuthModelImpl();
  WeChatDataAgent weChatDataAgent=WeChatCloudFireStoreDataAgentImpl();
  WeChatRealTimeDataAgent weChatRealTimeDataAgent=WeChatRealTimeDataAgentImpl();
  //weChatRealTimeDataAgent.test('CigwtF2npsaU8hbkTWTegO6zOyk2');
 // weChatRealTimeDataAgent.test2().listen((event) {
 //  event.forEach((id) {
 //    String ids=id??'';
 //     weChatRealTimeDataAgent.test(ids).then((value) {
 //       // print(value);
 //     List<ChattingUserVO> a=  value.where((element) => element.userID==ids).toList();
 //     ChattingUserVO last=a.last;
 //     print('ID =====> ${last.userID}');
 //     print('Name =======> ${last.name}');
 //     print('Photo =====> ${last.profilePic}');
 //     print('Message =====> ${last.message}');
 //     print('');
 //     });
 //
 //  });
 //
 // });

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final WeChatAuthModel auth=WeChatAuthModelImpl();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kWeChatAppName,
        themeMode: ThemeMode.light,
        theme: WeChatTheme.weChatLightTheme,
        darkTheme: WeChatTheme.weChatDarkTheme,
        home: (auth.isLoggedIn()?const WeChatHomePage():const WeChatStartPage()));
  }
}
