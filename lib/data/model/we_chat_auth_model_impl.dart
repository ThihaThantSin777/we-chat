import 'dart:io';

import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_cloud_firestore_data_agent_impl.dart';
import 'package:wechat_app/network/data_agent/we_chat_data_agent.dart';

class WeChatAuthModelImpl extends WeChatAuthModel {
  WeChatAuthModelImpl._internal();
  static final WeChatAuthModelImpl _singleton=WeChatAuthModelImpl._internal();

  factory WeChatAuthModelImpl()=>_singleton;
  final WeChatDataAgent _weChatDataAgent = WeChatCloudFireStoreDataAgentImpl();

  @override
  String getLoggedInUserID() => _weChatDataAgent.getLoggedInUserID();

  @override
  bool isLoggedIn() => _weChatDataAgent.isLoggedIn();

  @override
  Future login(String email, String password) =>
      _weChatDataAgent.login(email, password);

  @override
  Future logout() => _weChatDataAgent.logout();

  @override
  Future registerNewUser(UserVO newUser) =>
      _weChatDataAgent.registerNewUser(newUser);

  @override
  Future<String> uploadFileToFirebase(File image) =>
      _weChatDataAgent.uploadFileToFirebase(image);

  @override
  Future<UserVO?> getLoggedInUserInfoByID(String id) {
    Future<UserVO?> userVO;
    try {
      userVO = _weChatDataAgent.getLoggedInUserInfoByID(id);
    } catch (e) {
      throw Exception('Wrong ID');
    }
    return userVO;
  }

  @override
  Future<void> addContact(String friendID, UserVO friendUserVO) =>
      _weChatDataAgent.addContact(friendID, friendUserVO);

  @override
  Stream<List<UserVO>> getContactList()=>_weChatDataAgent.getContactList();
}
