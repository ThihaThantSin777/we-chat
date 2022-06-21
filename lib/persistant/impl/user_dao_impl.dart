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
  UserVO? getUserVO(String id){
   UserVO? temp=_getUserVOBox().get(id);
   if(temp!=null){
     return temp;
   }
   return null;
  }

  @override
  Stream getUserVOStream() =>_getUserVOBox().watch();

  @override
  void save(UserVO userVO) =>_getUserVOBox().put(userVO.id,userVO);

  Box<UserVO> _getUserVOBox() => Hive.box<UserVO>(kBoxNameForUserVO);

  @override
  bool isUserLoggedOut(String id) {
    UserVO ? userVo=_getUserVOBox().get(id);
    if(userVo!=null){
      if(userVo.isLogout??false){
        return true;
      }else{
        return false;
      }
    }

    return true;
  }

  @override
  Stream<UserVO?> getUserVoStreamEvent(String id)=>Stream.value(getUserVO(id));

}