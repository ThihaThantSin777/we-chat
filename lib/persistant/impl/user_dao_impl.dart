import 'package:hive/hive.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/persistant/constant/hive_constant.dart';
import 'package:wechat_app/persistant/dao/user_dao.dart';

class UserDAOImpl extends UserDAO{

  UserDAOImpl._internal();
  static final UserDAOImpl _singleton=UserDAOImpl._internal();
  factory UserDAOImpl()=>_singleton;
  @override
  void deleteUserVO() =>_getUserVOBox().clear();

  @override
  UserVO? getUserVO() =>_getUserVOBox().values.first;

  @override
  Stream getUserVOStream() =>_getUserVOBox().watch();

  @override
  void save(UserVO userVO) =>_getUserVOBox().put(userVO.id,userVO);

  Box<UserVO> _getUserVOBox() => Hive.box<UserVO>(kBoxNameForUserVO);

  @override
  bool isUserLoggedOut() =>_getUserVOBox().isEmpty;

  @override
  Stream<UserVO?> getUserVoStreamEvent()=>Stream.value(getUserVO());

}