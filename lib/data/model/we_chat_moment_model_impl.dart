import 'dart:async';
import 'dart:io';

import 'package:stream_transform/stream_transform.dart';
import 'package:wechat_app/data/model/we_chat_moment_model.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_cloud_firestore_data_agent_impl.dart';
import 'package:wechat_app/network/data_agent/we_chat_data_agent.dart';
import 'package:wechat_app/persistant/dao/moment_dao.dart';
import 'package:wechat_app/persistant/impl/moment_dao_impl.dart';
import 'package:wechat_app/resources/strings.dart';


class WeChatMomentModelImpl extends WeChatMomentModel {
  WeChatMomentModelImpl._internal();

  static final WeChatMomentModelImpl _singleton =
      WeChatMomentModelImpl._internal();

  factory WeChatMomentModelImpl() => _singleton;

  final WeChatDataAgent _weChatDataAgent = WeChatCloudFireStoreDataAgentImpl();
  final MomentDAO _momentDAO=MomentDaoImpl();

  Future<MomentVO> _createMoment(
      String description, String imageURL, String videoURL) async{
    String imgUrl = imageURL.isEmpty ? '' : imageURL;

    String vURL = videoURL.isEmpty ? '' : videoURL;
    final dateTime = DateTime.now();
    UserVO ? userVO=await _weChatDataAgent.getLoggedInUserInfo();
      var momentVO = MomentVO(
          id: dateTime.millisecond,
          userID: _weChatDataAgent.getLoggedInUserID(),
          userName: userVO?.userName ?? '',
          profilePicture: userVO?.profileImage ?? kDefaultImage,
          postImage: imgUrl,
          postVideo: vURL,
          description: description,
          timeStamp: dateTime
      );

    return Future.value(momentVO);
  }

  @override
  Future<void> addNewPost(
      String description, File? postImageURL, File? videoURL) {
      return _weChatDataAgent
          .uploadMomentsFileToFirebase(postImageURL??File(''))
          .then((imageLink) {
        _weChatDataAgent.uploadMomentsFileToFirebase(videoURL??File('')).then((videoLink) {
          _createMoment(description, imageLink, videoLink)
              .then((momentVO) {
                _momentDAO.save(momentVO);
            _weChatDataAgent.addNewPost(momentVO);
          });
        });
      });


  }

  @override
  Future<void> delete(int postID) => _weChatDataAgent.delete(postID);

  @override
  Stream<MomentVO> getMomentByID(int newsFeedID) =>
      _weChatDataAgent.getMomentByID(newsFeedID);

  /// _weChatDataAgent.getMoments();
  @override
  Stream<List<MomentVO>> getMoments(){
    return _momentDAO.getMomentVOStream().startWith(_momentDAO.getMomentVoListStreamEvent()).map((event) =>_momentDAO.getMomentVOList()??[]);
  }

  @override
  Future<void> editNewPost(
      MomentVO momentVO, File? postImageURL, File? videoURL) {

      return _weChatDataAgent
          .uploadMomentsFileToFirebase(postImageURL??File(''))
          .then((imageLink) {
        _weChatDataAgent.uploadMomentsFileToFirebase(videoURL??File('')).then((videoLink) {
          MomentVO moment = momentVO;
          moment.postImage = imageLink;
          moment.postVideo = videoLink;
          _momentDAO.save(moment);
          _weChatDataAgent.addNewPost(moment);
        });
      });



  }

}
