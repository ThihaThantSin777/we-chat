import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

abstract class UserDAO{
  void save(UserVO userVO);

  UserVO ? getUserVO(String id);

  void deleteUserVO();

  Stream getUserVOStream();

  bool isUserLoggedOut(String id);

  Stream<UserVO?>getUserVoStreamEvent(String id);
}