import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_moment_model_impl.dart';
import 'package:wechat_app/data/model/we_chat_moment_model.dart';

class WeChatSettingPageBloc extends ChangeNotifier {
  bool _lightMode = true;
  bool _isDisposed = false;
  final WeChatMomentModel _weChatModel = WeChatMomentModelImpl();

  bool get isLightMode => _lightMode;

  WeChatSettingPageBloc() {
    _weChatModel.getThemeMode().listen((mode) {
      _lightMode = mode;
      _notifySafely();
    }, onError: (error) => debugPrint(error));
  }
  void saveThemeMode(bool mode) {
    _lightMode = mode;
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
