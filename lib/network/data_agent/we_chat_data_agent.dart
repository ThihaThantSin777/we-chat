import 'dart:io';

import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

abstract class WeChatDataAgent {
  ///Cloud FireStore
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewPost(MomentVO momentVO);
  Future<void> delete(int postID);
  Stream<MomentVO> getMomentByID(int newsFeedID);
  Future<String> uploadFileToFirebase(File image);


  ///Auth
  Future registerNewUser(UserVO newUser);
  Future login(String email,String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logout();
}
