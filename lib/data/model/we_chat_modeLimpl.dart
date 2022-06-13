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
    String imgUrl = imageURL.isEmpty
        ? ''
        : imageURL;

    String vURL = videoURL.isEmpty
        ? ''
        : videoURL;
    int dateTime = DateTime.now().millisecond;

      var momentVO = MomentVO(
          id: dateTime,
          userName: 'Thiha Thant Sin',
          profilePicture:
          'https://st3.depositphotos.com/5392356/13703/i/1600/depositphotos_137037020-stock-photo-professional-software-developer-working-in.jpg',
          postImage: imgUrl,
          postVideo: vURL,
          description: description
      );
      return Future.value(momentVO);

  }


  @override
  Future<void> addNewPost(
      String description, File? postImageURL, File? videoURL) {
    if(postImageURL!=null && videoURL!=null){
      return _weChatDataAgent.uploadFileToFirebase(postImageURL).then((imageLink) {
        _weChatDataAgent.uploadFileToFirebase(videoURL).then((videoLink) {
          _createMoment(description, imageLink, videoLink).then((momentVO) => _weChatDataAgent.addNewPost(momentVO));
        });
      });
    }

    if (postImageURL != null) {
      return _weChatDataAgent
          .uploadFileToFirebase(postImageURL)
          .then((downloadImageURL) =>
              _createMoment(description, downloadImageURL, ''))
          .then((momentVO) => _weChatDataAgent.addNewPost(momentVO));
    }
    if (videoURL != null) {
      return _weChatDataAgent
          .uploadFileToFirebase(videoURL)
          .then((downloadVideoURL) =>
              _createMoment(description, '',downloadVideoURL))
          .then((momentVO) => _weChatDataAgent.addNewPost(momentVO));
    }
    return _createMoment(description, '', '')
        .then((momentVO) => _weChatDataAgent.addNewPost(momentVO));
  }

  @override
  Future<void> delete(int postID) =>_weChatDataAgent.delete(postID);

  @override
  Stream<MomentVO> getMomentByID(int newsFeedID) =>_weChatDataAgent.getMomentByID(newsFeedID);

  @override
  Stream<List<MomentVO>> getMoments() => _weChatDataAgent.getMoments();


  @override
  Future<void> editNewPost(
      MomentVO momentVO, File? postImageURL, File? videoURL) {
    if(postImageURL!=null && videoURL!=null){
      return _weChatDataAgent.uploadFileToFirebase(postImageURL).then((imageLink) {
        _weChatDataAgent.uploadFileToFirebase(videoURL).then((videoLink) {
          MomentVO moment=momentVO;
          moment.postImage=imageLink;
          moment.postVideo=videoLink;
          _weChatDataAgent.addNewPost(moment);
        });
      });
    }

    if (postImageURL != null) {
      return _weChatDataAgent
          .uploadFileToFirebase(postImageURL)
          .then((downloadImageURL) {
        MomentVO moment=momentVO;
        moment.postImage=downloadImageURL;
        _weChatDataAgent.addNewPost(moment);
      });
    }
    if (videoURL != null) {
      return _weChatDataAgent
          .uploadFileToFirebase(videoURL)
          .then((downloadVideoURL) {
        MomentVO moment=momentVO;
        moment.postVideo=downloadVideoURL;
        _weChatDataAgent.addNewPost(moment);
    });
          }

    return _weChatDataAgent.addNewPost(momentVO);
  }
}
