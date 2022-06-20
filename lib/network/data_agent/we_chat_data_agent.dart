import 'dart:io';

import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

abstract class WeChatDataAgent {
  ///Cloud FireStore
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewPost(MomentVO momentVO);
  Future<void> delete(int postID);
  Stream<MomentVO> getMomentByID(int newsFeedID);
   Future<String> uploadMomentsFileToFirebase(File image);
  Future<String> uploadProfileFilesToFirebase(File image);


  ///Auth
  Future registerNewUser(UserVO newUser);
  Future login(String email,String password);
  bool isLoggedIn();
  String getLoggedInUserID();
  Future logout();
  Future<UserVO?>getLoggedInUserInfo();
  Future<UserVO?> getUserInfoByID(String id);
  Stream<List<UserVO>> getContactList();
  Future<void>addContact(String friendID,UserVO friendUserVO);

}
