import 'dart:io';

import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

abstract class WeChatDataAgent {
  ///Cloud FireStore
  Stream<List<MomentVO>> getMoments();

  Future<void> addNewPost(MomentVO momentVO);

  Future<void> delete(String postID);

  Stream<MomentVO> getMomentByID(String newsFeedID);

  Future<String> uploadMomentsFileToFirebase(File image);

  Future<void> deleteMomentFileFromFirebase(String id);

  Future<void> deleteProfileFileFromFirebase(String id);

  Future<String> uploadProfileFilesToFirebase(File image);

  Future<String> uploadChatsFilesToFirebase(File image);

  Stream<List<String?>>getAllFCMTokenFromServer();

  Future<void> addNewUser(UserVO newUser);

  ///Auth
  Future registerNewUser(UserVO newUser);

  Future login(String email, String password);

  bool isLoggedIn();

  String getLoggedInUserID();

  Future logout();

  Future<UserVO?> getLoggedInUserInfo();

  Future<UserVO?> getUserInfoByID(String id);

  Stream<List<UserVO>> getContactList();

  Future<void> addContact(String friendID, UserVO friendUserVO);
}
