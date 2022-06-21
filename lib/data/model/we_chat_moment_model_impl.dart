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
    final dateTime = DateTime.now();
    UserVO ? userVO=await _weChatDataAgent.getLoggedInUserInfo();
    List<String> tempArrayImage=(imageURL.isEmpty)?[]:imageURL.split('-');
    List<String> tepArrayVideo=(videoURL.isEmpty)?[]:videoURL.split('-');
         var momentVO = MomentVO(
          id: dateTime.millisecond,
          userID: _weChatDataAgent.getLoggedInUserID(),
          userName: userVO?.userName ?? '',
          profilePicture: userVO?.profileImage ?? kDefaultImage,
          postImage:tempArrayImage.isEmpty?'':tempArrayImage.first,
          postVideo: tepArrayVideo.isEmpty?'':tepArrayVideo.first,
          description: description,
          timeStamp: dateTime,
           postImageID: '',
           postVideoID: '',
      );

         if(tempArrayImage.isNotEmpty){
           momentVO.postImageID=tempArrayImage.last;
         }
         if(tepArrayVideo.isNotEmpty){
           momentVO.postVideoID=tepArrayVideo.last;
         }




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
  Future<void> delete(int postID) {
    MomentVO? momentVO=_momentDAO.getSingleMomentVO(postID);
    if(momentVO!=null){
     if(momentVO.postImageID.isNotEmpty){
       _weChatDataAgent.deleteMomentFileFromFirebase(momentVO.postImageID);
     }
     if(momentVO.postVideoID.isNotEmpty){
       _weChatDataAgent.deleteMomentFileFromFirebase(momentVO.postVideoID);
     }
    }
    _momentDAO.deleteMomentVO(postID);
    return  _weChatDataAgent.delete(postID);
  }

  @override
  Stream<MomentVO> getMomentByID(int newsFeedID) =>
      _weChatDataAgent.getMomentByID(newsFeedID);

  /// _weChatDataAgent.getMoments();
  @override
  Stream<List<MomentVO>> getMoments(){
    return _weChatDataAgent.getMoments();
  }

  @override
  Future<void> editNewPost(
      MomentVO momentVO, File? postImageURL, File? videoURL) {

      return _weChatDataAgent
          .uploadMomentsFileToFirebase(postImageURL??File(''))
          .then((imageLink) {
        _weChatDataAgent.uploadMomentsFileToFirebase(videoURL??File('')).then((videoLink) {
          MomentVO moment = momentVO;
          List<String> tempArrayImage=(imageLink.isEmpty)?[]:imageLink.split('-');
          List<String> tepArrayVideo=(videoLink.isEmpty)?[]:videoLink.split('-');
          MomentVO ? tempMoment=_momentDAO.getSingleMomentVO(moment.id);
          if(tempArrayImage.isNotEmpty){
            _weChatDataAgent.deleteMomentFileFromFirebase(tempMoment?.postImageID??'');
            moment.postImage =tempArrayImage.first;
            moment.postImageID=tempArrayImage.last;
          }
          if(tepArrayVideo.isNotEmpty){
            _weChatDataAgent.deleteMomentFileFromFirebase(tempMoment?.postVideoID??'');
            moment.postVideo = tepArrayVideo.first;
            moment.postVideoID=tepArrayVideo.last;
          }

          _momentDAO.save(moment);
          _weChatDataAgent.addNewPost(moment);
        });
      });



  }

  @override
  Future<void> deleteMomentFileFromFirebase(String id) =>_weChatDataAgent.deleteMomentFileFromFirebase(id);

}
