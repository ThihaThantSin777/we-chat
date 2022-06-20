import 'dart:io';

import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_cloud_firestore_data_agent_impl.dart';
import 'package:wechat_app/network/data_agent/we_chat_data_agent.dart';
import 'package:wechat_app/persistant/dao/user_dao.dart';
import 'package:wechat_app/persistant/impl/user_dao_impl.dart';
import 'package:stream_transform/stream_transform.dart';

class WeChatAuthModelImpl extends WeChatAuthModel {
  WeChatAuthModelImpl._internal();
  static final WeChatAuthModelImpl _singleton=WeChatAuthModelImpl._internal();

  factory WeChatAuthModelImpl()=>_singleton;
  final WeChatDataAgent _weChatDataAgent = WeChatCloudFireStoreDataAgentImpl();
  final UserDAO _userDAO=UserDAOImpl();

  @override
  String getLoggedInUserID() => _weChatDataAgent.getLoggedInUserID();

  @override
  bool isLoggedIn() => _weChatDataAgent.isLoggedIn() || _userDAO.isUserLoggedOut();

  @override
  Future login(String email, String password) =>
      _weChatDataAgent.login(email, password);

  @override
  Future logout() {
    _userDAO.deleteUserVO();
    return _weChatDataAgent.logout();
  }

  @override
  Future registerNewUser(UserVO newUser) =>
      _weChatDataAgent.registerNewUser(newUser);

  @override
  Future<String> uploadProfileFileToFirebase(File image) =>
      _weChatDataAgent.uploadProfileFilesToFirebase(image);

  @override
  Future<UserVO?> getUserInfoByID(String id) {
    Future<UserVO?> userVO;
    try {
      userVO = _weChatDataAgent.getUserInfoByID(id);
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

  // @override
  // Future<UserVO?> getLoggedInUserInfoByID() =>_weChatDataAgent.getLoggedInUserInfo();

  @override
  Stream<UserVO?> getUserVoStreamEvent() {
    return _userDAO.getUserVOStream().startWith(_userDAO.getUserVoStreamEvent()).map((event) =>_userDAO.getUserVO());
  }

  @override
  Future<UserVO?> getLoggedInUserInfo() =>_weChatDataAgent.getLoggedInUserInfo();
}
