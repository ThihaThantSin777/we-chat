import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

abstract class UserDAO{
  void save(UserVO userVO);

  UserVO ? getUserVO();

  void deleteUserVO();

  Stream getUserVOStream();

  bool isUserLoggedOut();

  Stream<UserVO?>getUserVoStreamEvent();
}