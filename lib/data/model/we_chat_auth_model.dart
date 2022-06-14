import 'dart:io';

import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

abstract class WeChatAuthModel{
  Future<String> uploadFileToFirebase(File image);
  Future registerNewUser(UserVO newUser);
  Future login(String email,String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logout();
}