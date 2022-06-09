import 'dart:io';

import 'package:wechat_app/data/model/we_chat_model.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_cloud_firestore_data_agent_impl.dart';
import 'package:wechat_app/network/data_agent/we_chat_data_agent.dart';
import 'package:wechat_app/persistant/impl/light_or_dark_dao_impl.dart';

import '../../persistant/dao/light_or_dark_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class WeChatModelImpl extends WeChatModel {
  final LightOrDarkDAO _lightOrDarkDAO = LightOrDarkDAOImpl();
  final WeChatDataAgent _weChatDataAgent = WeChatCloudFireStoreDataAgentImpl();
  @override
  Stream<bool> getThemeMode() => _lightOrDarkDAO
      .lightOrDarkEvent()
      .startWith(_lightOrDarkDAO.getModeStream())
      .map((event) => _lightOrDarkDAO.getMode());

  @override
  void saveThemeMode(bool mode) {
    _lightOrDarkDAO.save(mode);
  }

  Future<MomentVO> _createMoment(
      String description, String imageURL, String videoURL) {
    String url = imageURL.isEmpty
        ? 'https://www.chanchao.com.tw/images/default.jpg'
        : imageURL;
    int dateTime = DateTime.now().millisecond;
    var momentVO = MomentVO(
        id: dateTime,
        userName: 'Thiha Thant Sin',
        profilePicture:
            'https://st3.depositphotos.com/5392356/13703/i/1600/depositphotos_137037020-stock-photo-professional-software-developer-working-in.jpg',
        postImage: imageURL,
        postVideo: videoURL,
        description: description);

    return Future.value(momentVO);
  }

  @override
  Future<void> addNewPost(
          MomentVO momentVO, File? postImageURL, File? videoURL) =>
      _weChatDataAgent.addNewPost(momentVO);

  @override
  Future<void> delete(int postID) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<MomentVO> getMomentByID(int newsFeedID) {
    // TODO: implement getMomentByID
    throw UnimplementedError();
  }

  @override
  Stream<List<MomentVO>> getMoments() {
    // TODO: implement getMoments
    throw UnimplementedError();
  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    // TODO: implement uploadFileToFirebase
    throw UnimplementedError();
  }

  @override
  Future<void> editNewPost(
      MomentVO momentVO, File? postImageURL, File? videoURL) {
    // TODO: implement editNewPost
    throw UnimplementedError();
  }
}
