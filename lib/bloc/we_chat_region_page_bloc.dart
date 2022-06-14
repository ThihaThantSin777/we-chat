
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/country_code_vo/country_code_vo.dart';

class WeChatRegionPageBloc extends ChangeNotifier{


  ///State Variable
  List<CountryCodeVO>_regionList=[];
  bool _isDisposed = false;

  ///Getter
  List<CountryCodeVO> get getRegionList=>_regionList;


  WeChatRegionPageBloc(){
    _regionList=countryCodeVoList;
    _regionList.sort((a,b)=>a.name.compareTo(b.name));
    _notifySafely();
    SuspensionUtil.setShowSuspensionStatus(getRegionList);
  }

  void searchRegionList(String name) {
    _regionList=[];
    if (name.isNotEmpty) {
      _regionList=countryCodeVoList;
      _regionList = _regionList
          .map((data) => data)
          .where((element) =>
          element.name.toUpperCase().contains(name.toUpperCase()))
          .toList();
      _notifySafely();
    } else {
      _regionList=countryCodeVoList;
    }
    _notifySafely();
  }


  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}