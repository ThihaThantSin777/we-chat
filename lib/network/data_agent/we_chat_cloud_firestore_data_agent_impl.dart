import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_data_agent.dart';

const momentsCollection = 'moments';
const fileUploadPath = 'uploads';
const userCollection = 'users';

class WeChatCloudFireStoreDataAgentImpl extends WeChatDataAgent {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> addNewPost(MomentVO momentVO) => _firebaseFirestore
      .collection(momentsCollection)
      .doc(momentVO.id.toString())
      .set(momentVO.toJson());

  @override
  Future<void> delete(int postID) => _firebaseFirestore
      .collection(momentsCollection)
      .doc(postID.toString())
      .delete();

  @override
  Stream<List<MomentVO>> getMoments() => _firebaseFirestore
          .collection(momentsCollection)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map<MomentVO>((document) {
          return MomentVO.fromJson(document.data());
        }).toList();
      });

  @override
  Stream<MomentVO> getMomentByID(int newsFeedID) => _firebaseFirestore
      .collection(momentsCollection)
      .doc(newsFeedID.toString())
      .get()
      .asStream()
      .where((documentSnapShot) => documentSnapShot != null)
      .map((documentSnapShot) => MomentVO.fromJson(documentSnapShot.data()!));

  @override
  Future<String> uploadFileToFirebase(File image) {
    return firebaseStorage
        .ref(fileUploadPath)
        .child('${DateTime.now().millisecondsSinceEpoch}')
        .putFile(image)
        .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());
  }
}
