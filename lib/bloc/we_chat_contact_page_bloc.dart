import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';

class WeChatContactPageBloc extends ChangeNotifier {
  ///State Variable
  // List<String> _contactList = [];
  // List<StringVO> _stringVoList = [];
  List<UserVO>_userVOList=[];
  Map<String, int> _countFriend = {};

  bool _isDisposed = false;

  ///getter
  // List<String> get getContactList => _contactList;
  // List<StringVO> get getStringVOList => _stringVoList;
  Map<String, int> get getCountFriend => _countFriend;
  List<UserVO> get getUserVOList=>_userVOList;

  ///Model
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();

  WeChatContactPageBloc() {
    _weChatAuthModel.getContactList().listen((value) {

      _userVOList=value;
      _userVOList.sort((a,b){
        String firstUserName=a.userName??'';
        String secondUserName=b.userName??'';
        return firstUserName.compareTo(secondUserName);
      });
      SuspensionUtil.setShowSuspensionStatus(value);
      _countFriendListByAlphabet(value);
      _notifySafely();
    });
    // _firstPrePopulateData();
    // print('User VO List ====> $_userVOList');
    // SuspensionUtil.setShowSuspensionStatus(getUserVOList);
    // _countFriendListByAlphabet();
  }

  void _countFriendListByAlphabet(List<UserVO>userVOList) {

      List<String> nameListTags = (userVOList).map((data) {
        String value=data.userName?[0]??'';
        return value;
      }).toList();
      Set<String> nameSetTags =  (userVOList).map((data) {
        String value=data.userName?[0]??'';
        return value;
      }).toSet();
      int length=nameSetTags.length;
      for (int i = 0; i < length; i++) {
        var count = nameListTags
            .where((string) => string == nameSetTags.elementAt(i))
            .toList()
            .length;
        String index=nameSetTags.elementAt(i);
        _countFriend[index] = count;
      }
      _notifySafely();


  }

  void searchContactList(String name) {
    _weChatAuthModel.getContactList().listen((value) {
      if(name.isNotEmpty){
        _userVOList=value.map((data)=>data).where((element) {
          String inServerNames=element.userName?.toUpperCase()??'';
          return inServerNames.contains(name.toUpperCase());
        }).toList();
      }else{
        _userVOList=value;
      }
      _notifySafely();
    });
    // _userVOList=[];
    // if(name.isNotEmpty){
    //   _firstPrePopulateData();
    //   _userVOList=_userVOList.map((data)=>data).where((element) {
    //     String inServerNames=element.userName?.toUpperCase()??'';
    //     return inServerNames.contains(name.toUpperCase());
    //   }).toList();
    //   _notifySafely();
    // }else{
    //   _firstPrePopulateData();
    // }
    // _contactList.clear();
    // _stringVoList.clear();
    //
    // if (name.isNotEmpty) {
    //   _firstPrePopulateData();
    //   _stringVoList = getStringVOList
    //       .map((data) => data)
    //       .where((element) =>
    //           element.title.toUpperCase().contains(name.toUpperCase()))
    //       .toList();
    //   _notifySafely();
    // } else {
    //   _firstPrePopulateData();
    // }
  }

  void _firstPrePopulateData() {
    // _contactList.add('Devon');
    // _contactList.add('Rishi');
    // _contactList.add('Aidan');
    // _contactList.add('Carson');
    // _contactList.add('Elisha');
    // _contactList.add('Brenden');
    // _contactList.add('Frank');
    // _contactList.add('Jared');
    // _contactList.add('Myles');
    // _contactList.add('Jairo');
    // _contactList.add('Mathias');
    // _contactList.add('Kaden');
    // _contactList.add('Vincent');
    // _contactList.add('Leo');
    // _contactList.add('Makhi');
    // _contactList.add('Kenny');
    // _contactList.add('Jadon');
    // _contactList.add('Philip');
    // _contactList.add('Sterling');
    // _contactList.add('Ellis');
    // _contactList.add('Lee');
    // _contactList.add('Layne');
    // _contactList.add('Bridger');
    // _contactList.add('Beau');
    // _contactList.add('Byron');
    // _contactList.add('Kamron');
    // _contactList.add('Cornelius');
    // _contactList.add('Ean');
    // _contactList.add('John');
    // _contactList.add('Riley');
    // _contactList.add('Israel');
    // _contactList.add('Ayaan');
    // _contactList.add('Terrance');
    // _contactList.add('Orlando');
    // _contactList.add('Rex');
    // _contactList.add('Liam');
    // _contactList.add('Irvin');
    // _contactList.add('Matteo');
    // _contactList.add('Keyon');
    // _contactList.add('Erik');
    // _contactList.add('Amari');
    // _contactList.add('Kaiden');
    // _contactList.add('Arturo');
    // _contactList.add('Brent');
    // _contactList.add('Caden');
    // _contactList.add('Slade');
    // _contactList.add('Ronan');
    // _contactList.add('Leonardo');
    // _contactList.add('Fernando');
    // _contactList.add('Jamarion');
    // _contactList.add('Angelo');
    // _contactList.add('Jimmy');
    // _contactList.add('Kayden');
    // _contactList.add('Dustin');
    // _contactList.add('Lorenzo');
    // _contactList.add('Heath');
    // _contactList.add('Tristen');
    // _contactList.add('Javon');
    // _contactList.add('Jeremy');
    // _contactList.add('Keagan');
    // _contactList.add('Gordon');
    // _contactList.add('Nathen');
    // _contactList.add('Junior');
    // _contactList.add('Talon');
    // _contactList.add('Ethan');
    // _contactList.add('Jalen');
    // _contactList.add('Layton');
    // _contactList.add('Konner');
    // _contactList.add('Jase');
    // _contactList.add('Teagan');
    // _contactList.add('Cory');
    // _contactList.add('Kellen');
    // _contactList.add('Juan');
    // _contactList.add('Grayson');
    // _contactList.add('Chandler');
    // _contactList.add('Miguel');
    // _contactList.add('Odin');
    // _contactList.add('Carlos');
    // _contactList.add('Terry');
    // _contactList.add('Saul');
    // _contactList.add('Jaylen');
    // _contactList.add('Maurice');
    // _contactList.add('Nelson');
    // _contactList.add('Dorian');
    // _contactList.add('Jeffrey');
    // _contactList.add('Roland');
    // _contactList.add('Colby');
    // _contactList.add('Eugene');
    // _contactList.add('Erick');
    // _contactList.add('Shaun');
    // _contactList.add('Vicente');
    // _contactList.add('George');
    // _contactList.add('Zachery');
    // _contactList.add('Eden');
    // _contactList.add('Connor');
    // _contactList.add('Antony');
    // _contactList.add('Alfonso');
    // _contactList.add('Kael');
    // _contactList.add('Jordan');
    // _contactList.add('Kyle');
    // _contactList.sort();
    // _stringVoList = _contactList
    //     .map((data) => StringVO(data, data[0].toUpperCase()))
    //     .toList();


  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}
