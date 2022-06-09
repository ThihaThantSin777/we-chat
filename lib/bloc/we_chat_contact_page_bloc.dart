import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/strings_vo/strings_vo.dart';

class WeChatContactPageBloc extends ChangeNotifier {
  ///State Variable
  List<String> _contactList = [];
  List<StringVO> _stringVoList = [];
  Map<String, int> _countFriend = {};
  bool _isDisposed = false;

  ///getter
  List<String> get getContactList => _contactList;
  List<StringVO> get getStringVOList => _stringVoList;
  Map<String, int> get getCountFriend => _countFriend;

  WeChatContactPageBloc() {
    _firstPrePopulateData();
    SuspensionUtil.setShowSuspensionStatus(getStringVOList);
    _countFriendListByAlphabet();
  }
  // 'A':0,
  // 'B':0,
  // 'C':0,
  // 'D':0,
  // 'E':0,
  // 'F':0,
  // 'G':0,
  // 'H':0,
  // 'I':0,
  // 'J':0,
  //
  // 'K':0,
  // 'L':0,
  // 'M':0,
  // 'N':0,
  // 'O':0,
  // 'P':0,
  // 'Q':0,
  // 'R':0,
  // 'S':0,
  // 'T':0,
  //
  // 'U':0,
  // 'V':0,
  // 'W':0,
  // 'X':0,
  // 'Y':0,
  // 'Z':0,

  void _countFriendListByAlphabet() {
    // int count = 1;
    List<String> nameListTags = (getStringVOList).map((e) => e.tag).toList();
    Set<String> nameSetTags = (getStringVOList).map((e) => e.tag).toSet();
    for (int i = 0; i < nameSetTags.length; i++) {
      var count = nameListTags
          .where((string) => string == nameSetTags.elementAt(i))
          .toList()
          .length;
      _countFriend[nameSetTags.elementAt(i)] = count;
    }

    // for (var element in nameTags) {
    //   if (!_countFriend.containsKey(element) || _countFriend.isEmpty) {
    //     print('New');
    //     print('Key ${_countFriend[element]}');
    //     _countFriend[element] = count;
    //     print('${_countFriend[element]} is added and it count $count');
    //   } else {
    //     print('Old');
    //     print('Key ${_countFriend[element]}');
    //     _countFriend[element] = (_countFriend[element])??0 + count;
    //     print('${_countFriend[element]} is added and it count $count');
    //   }
    //   print('');
    // }
    _notifySafely();
  }

  void searchContactList(String name) {
    _contactList.clear();
    _stringVoList.clear();

    if (name.isNotEmpty) {
      _firstPrePopulateData();
      _stringVoList = getStringVOList
          .map((data) => data)
          .where((element) =>
              element.title.toUpperCase().contains(name.toUpperCase()))
          .toList();
      _notifySafely();
    } else {
      _firstPrePopulateData();
    }
  }

  void _firstPrePopulateData() {
    _contactList.add('Devon');
    _contactList.add('Rishi');
    _contactList.add('Aidan');
    _contactList.add('Carson');
    _contactList.add('Elisha');
    _contactList.add('Brenden');
    _contactList.add('Frank');
    _contactList.add('Jared');
    _contactList.add('Myles');
    _contactList.add('Jairo');
    _contactList.add('Mathias');
    _contactList.add('Kaden');
    _contactList.add('Vincent');
    _contactList.add('Leo');
    _contactList.add('Makhi');
    _contactList.add('Kenny');
    _contactList.add('Jadon');
    _contactList.add('Philip');
    _contactList.add('Sterling');
    _contactList.add('Ellis');
    _contactList.add('Lee');
    _contactList.add('Layne');
    _contactList.add('Bridger');
    _contactList.add('Beau');
    _contactList.add('Byron');
    _contactList.add('Kamron');
    _contactList.add('Cornelius');
    _contactList.add('Ean');
    _contactList.add('John');
    _contactList.add('Riley');
    _contactList.add('Israel');
    _contactList.add('Ayaan');
    _contactList.add('Terrance');
    _contactList.add('Orlando');
    _contactList.add('Rex');
    _contactList.add('Liam');
    _contactList.add('Irvin');
    _contactList.add('Matteo');
    _contactList.add('Keyon');
    _contactList.add('Erik');
    _contactList.add('Amari');
    _contactList.add('Kaiden');
    _contactList.add('Arturo');
    _contactList.add('Brent');
    _contactList.add('Caden');
    _contactList.add('Slade');
    _contactList.add('Ronan');
    _contactList.add('Leonardo');
    _contactList.add('Fernando');
    _contactList.add('Jamarion');
    _contactList.add('Angelo');
    _contactList.add('Jimmy');
    _contactList.add('Kayden');
    _contactList.add('Dustin');
    _contactList.add('Lorenzo');
    _contactList.add('Heath');
    _contactList.add('Tristen');
    _contactList.add('Javon');
    _contactList.add('Jeremy');
    _contactList.add('Keagan');
    _contactList.add('Gordon');
    _contactList.add('Nathen');
    _contactList.add('Junior');
    _contactList.add('Talon');
    _contactList.add('Ethan');
    _contactList.add('Jalen');
    _contactList.add('Layton');
    _contactList.add('Konner');
    _contactList.add('Jase');
    _contactList.add('Teagan');
    _contactList.add('Cory');
    _contactList.add('Kellen');
    _contactList.add('Juan');
    _contactList.add('Grayson');
    _contactList.add('Chandler');
    _contactList.add('Miguel');
    _contactList.add('Odin');
    _contactList.add('Carlos');
    _contactList.add('Terry');
    _contactList.add('Saul');
    _contactList.add('Jaylen');
    _contactList.add('Maurice');
    _contactList.add('Nelson');
    _contactList.add('Dorian');
    _contactList.add('Jeffrey');
    _contactList.add('Roland');
    _contactList.add('Colby');
    _contactList.add('Eugene');
    _contactList.add('Erick');
    _contactList.add('Shaun');
    _contactList.add('Vicente');
    _contactList.add('George');
    _contactList.add('Zachery');
    _contactList.add('Eden');
    _contactList.add('Connor');
    _contactList.add('Antony');
    _contactList.add('Alfonso');
    _contactList.add('Kael');
    _contactList.add('Jordan');
    _contactList.add('Kyle');
    _contactList.sort();
    _stringVoList = _contactList
        .map((data) => StringVO(data, data[0].toUpperCase()))
        .toList();
    _notifySafely();
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
