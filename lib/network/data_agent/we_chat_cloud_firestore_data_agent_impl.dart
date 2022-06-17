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
const contactCollection = 'contact';

class WeChatCloudFireStoreDataAgentImpl extends WeChatDataAgent{
  WeChatCloudFireStoreDataAgentImpl._internal();
  static final WeChatCloudFireStoreDataAgentImpl _singleton=WeChatCloudFireStoreDataAgentImpl._internal();

  factory WeChatCloudFireStoreDataAgentImpl()=>_singleton;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;
  final _fireAuth = FirebaseAuth.instance;

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
  bool isLoggedIn() => _fireAuth.currentUser != null;

  @override
  Future login(String email, String password) =>
      _fireAuth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future logout() => _fireAuth.signOut();

  @override
  Future registerNewUser(UserVO newUser) => _fireAuth
          .createUserWithEmailAndPassword(
              email: newUser.email ?? '', password: newUser.password ?? '')
          .then((credential) {
        User? user = credential.user;
        user?.updatePhotoURL(newUser.profileImage);
        user?.updateDisplayName(newUser.userName);
        newUser.id = newUser.qrCode = user?.uid ?? '';
        _addNewUser(newUser);
      });

  Future<void> _addNewUser(UserVO newUser) {
    return _firebaseFirestore
        .collection(userCollection)
        .doc(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  String getLoggedInUserID() => _fireAuth.currentUser?.uid ?? '';

  @override
  Future<UserVO?> getLoggedInUserInfoByID(String id) {
    Future<UserVO?> userVO;
    try {
      userVO = _firebaseFirestore
          .collection(userCollection)
          .doc(id)
          .get()
          .asStream()
          .where((event) => event != null)
          .map((event) => UserVO.fromJson(event.data() ?? {}))
          .first;
    } catch (e) {
      throw Exception('Wrong ID');
    }
    return userVO;
  }

  @override
  Future<void> addContact(String friendID, UserVO friendUserVO) {
    return getLoggedInUserInfoByID(_fireAuth.currentUser?.uid ?? '')
        .then((userVO) {
      ///Friend to Current
      _firebaseFirestore
          .collection(userCollection)
          .doc(friendUserVO.id)
          .collection(contactCollection)
          .doc(userVO?.id.toString())
          .set(userVO!.toJson());

      ///Current to Friend
      _firebaseFirestore
          .collection(userCollection)
          .doc(userVO.id.toString())
          .collection(contactCollection)
          .doc(friendUserVO.id)
          .set(friendUserVO.toJson());
    });
  }


  @override
  Stream<List<UserVO>> getContactList() {
    String id = _fireAuth.currentUser?.uid ?? '';
    return _firebaseFirestore
        .collection(userCollection)
        .doc(id)
        .collection(contactCollection)
        .snapshots()
        .where((event) => event != null)
        .map((querySnapshot) {
      return querySnapshot.docs.map<UserVO>((document) {
        return UserVO.fromJson(document.data());
      }).toList();
    });
  }
}
