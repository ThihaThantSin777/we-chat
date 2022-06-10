import 'dart:io';

import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';

abstract class WeChatModel {
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewPost(
      String description, File? postImageURL, File? videoURL);
  Future<void> editNewPost(
      String description, File? postImageURL, File? videoURL);
  Future<void> delete(int postID);
  Stream<MomentVO> getMomentByID(int newsFeedID);
  Future<String> uploadFileToFirebase(File image);

  Stream<bool> getThemeMode();
  void saveThemeMode(bool mode);
}
