import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_data_agent.dart';

const momentsCollection = 'moments';
const fileUploadPath = 'uploads';
const userCollection = 'users';

class WeChatCloudFireStoreDataAgentImpl extends WeChatDataAgent {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;
  final _fireAuth=FirebaseAuth.instance;

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
    return _firebaseStorage
        .ref(fileUploadPath)
        .child('${DateTime.now().millisecondsSinceEpoch}')
        .putFile(image)
        .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());
  }


  @override
  bool isLoggedIn() =>_fireAuth.currentUser!=null;

  @override
  Future login(String email, String password) =>_fireAuth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future logout() =>_fireAuth.signOut();

  @override
  Future registerNewUser(UserVO newUser) =>_fireAuth
      .createUserWithEmailAndPassword(
  email: newUser.email, password: newUser.password)
      .then((credential) {
       User? user= credential.user;
       user?.updatePhotoURL(newUser.profileImage);
       user?.updateDisplayName(newUser.userName);
       newUser.id =newUser.qrCode= user?.uid??'';
    _addNewUser(newUser);
  });

  Future<void> _addNewUser(UserVO newUser) {
    return _firebaseFirestore
        .collection(userCollection)
        .doc(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  UserVO getLoggedInUser() {
    User? user=_fireAuth.currentUser;
    UserVO userVO=UserVO(id: user?.uid??'', userName: user?.displayName??'', region: '', phone: user?.phoneNumber??'', password: '', email: user?.email??'', qrCode: '', profileImage: user?.photoURL??'', fcmToken: '');
    return userVO;
  }
}
