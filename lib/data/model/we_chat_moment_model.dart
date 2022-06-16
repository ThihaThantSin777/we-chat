import 'dart:io';

import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

abstract class WeChatMomentModel {
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewPost(
      String description, File? postImageURL, File? videoURL);
  Future<void> editNewPost(
      MomentVO momentVO, File? postImageURL, File? videoURL);
  Future<void> delete(int postID);
  Stream<MomentVO> getMomentByID(int newsFeedID);

  Stream<bool> getThemeMode();
  void saveThemeMode(bool mode);

}