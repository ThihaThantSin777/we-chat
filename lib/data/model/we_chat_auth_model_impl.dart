import 'dart:io';

import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_cloud_firestore_data_agent_impl.dart';
import 'package:wechat_app/network/data_agent/we_chat_data_agent.dart';
import 'package:wechat_app/persistant/dao/moment_dao.dart';
import 'package:wechat_app/persistant/dao/user_dao.dart';
import 'package:wechat_app/persistant/impl/moment_dao_impl.dart';
import 'package:wechat_app/persistant/impl/user_dao_impl.dart';
import 'package:stream_transform/stream_transform.dart';

class WeChatAuthModelImpl extends WeChatAuthModel {
  WeChatAuthModelImpl._internal();
  static final WeChatAuthModelImpl _singleton=WeChatAuthModelImpl._internal();

  factory WeChatAuthModelImpl()=>_singleton;
  final WeChatDataAgent _weChatDataAgent = WeChatCloudFireStoreDataAgentImpl();
  final UserDAO _userDAO=UserDAOImpl();
  final MomentDAO _momentDAO=MomentDaoImpl();

  @override
  String getLoggedInUserID() => _weChatDataAgent.getLoggedInUserID();

  @override
  bool isLoggedIn() => _weChatDataAgent.isLoggedIn() && !_userDAO.isUserLoggedOut(getLoggedInUserID());

  @override
  Future login(String email, String password) {

    return _weChatDataAgent.login(email, password).then((value) {
      UserVO ?userVO=_userDAO.getUserVO(getLoggedInUserID());
      if(userVO!=null){

        userVO.isLogout=false;

        _userDAO.save(userVO);
      }else{
        getLoggedInUserInfo().then((userVO) {
          _userDAO.save(userVO??UserVO.normal());
        });
      }
      _weChatDataAgent.getMoments().listen((data) {
        List<MomentVO>temp=data.where((element) => element.userID==getLoggedInUserID()).toList();
        _momentDAO.saveList(temp);
      });
    });
  }


  @override
  Future logout() {
    UserVO ?userVO=_userDAO.getUserVO(_weChatDataAgent.getLoggedInUserID());
    userVO?.isLogout=true;
    _userDAO.save(userVO??UserVO.normal());
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
  Stream<UserVO?> getUserVoStreamEvent(String id) {
    return _userDAO.getUserVOStream().startWith(_userDAO.getUserVoStreamEvent(id)).map((event) =>_userDAO.getUserVO(id));
  }

  @override
  Future<UserVO?> getLoggedInUserInfo() =>_weChatDataAgent.getLoggedInUserInfo();

  @override
  List<UserVO>? getUserVoList() =>_userDAO.getUserVoList();

  @override
  Future<void> addNewUser(UserVO newUser) =>_weChatDataAgent.addNewUser(newUser);

  @override
  void saveUser(UserVO userVO) {
   _userDAO.save(userVO);
  }

  @override
  Stream<List<String?>> getAllFCMTokenFromServer() =>_weChatDataAgent.getAllFCMTokenFromServer();

  @override
  Future<String> uploadChatsFilesToFirebase(File image) =>_weChatDataAgent.uploadChatsFilesToFirebase(image);

  @override
  Future<void> deleteProfileFileFromFirebase(String id) =>_weChatDataAgent.deleteProfileFileFromFirebase(id);
}
