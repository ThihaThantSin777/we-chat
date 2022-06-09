import 'dart:io';

import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';

abstract class WeChatDataAgent {
  Stream<List<MomentVO>> getMoments();
  Future<void> addNewPost(MomentVO momentVO);
  Future<void> delete(int postID);
  Stream<MomentVO> getMomentByID(int newsFeedID);
  Future<String> uploadFileToFirebase(File image);
}
