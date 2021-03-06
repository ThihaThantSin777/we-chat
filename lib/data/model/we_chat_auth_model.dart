import 'dart:io';

import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

abstract class WeChatAuthModel{

  ///Network
  Future<String> uploadProfileFileToFirebase(File image);
  Future registerNewUser(UserVO newUser);
  Future login(String email,String password);
  bool isLoggedIn();
  String getLoggedInUserID();
  Future logout();
  Future<UserVO?> getUserInfoByID(String id);
  Future<UserVO?>getLoggedInUserInfo();
  Future<void>addContact(String friendID,UserVO friendUserVO);
  Stream<List<UserVO>> getContactList();
  Future<void> addNewUser(UserVO newUser);
  Stream<List<String?>>getAllFCMTokenFromServer();
  Future<String> uploadChatsFilesToFirebase(File image);
  Future<void> deleteProfileFileFromFirebase(String id);


  void saveUser(UserVO userVO);


  ///Database
  Stream<UserVO?>getUserVoStreamEvent(String id);
  List<UserVO>? getUserVoList();
}