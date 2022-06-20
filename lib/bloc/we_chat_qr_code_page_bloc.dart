
import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';


class WeChatQRCodePageBloc extends ChangeNotifier{
  ///Satae Variable
  bool _isDisposed=false;
  String _qrCode='';
  UserVO? _scanUserVO;

  ///Getter
  String get getQrCode=>_qrCode;
  UserVO? get getScanUserVO=>_scanUserVO;


  /// Model
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();


  WeChatQRCodePageBloc(){

      String id=_weChatAuthModel.getLoggedInUserID();
      _weChatAuthModel.getUserInfoByID(id).then((value) {
        _qrCode=value?.qrCode??'None';
        _notifySafely();
      });
  }

  void cancelScan(){
    _scanUserVO=null;
    _notifySafely();
}

  // Future<UserVO?> searchUserVoByID(String id){
  //   _loading=true;
  //   _notifySafely();
  //   return _weChatAuthModel.getLoggedInUserInfoByID(id).then((value) {
  //     _loading=false;
  //     _notifySafely();
  //     return value;
  //   }).catchError((error){
  //     _loading=false;
  //     _notifySafely();
  //   });
  // }

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