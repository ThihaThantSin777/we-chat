import 'dart:io';

import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

abstract class WeChatAuthModel{
  Future<String> uploadFileToFirebase(File image);
  Future registerNewUser(UserVO newUser);
  Future login(String email,String password);
  bool isLoggedIn();
  String getLoggedInUserID();
  Future logout();
  Future<UserVO?> getLoggedInUserInfoByID(String id);
  Future<void>addContact(String friendID,UserVO friendUserVO);
  Stream<List<UserVO>> getContactList();
}