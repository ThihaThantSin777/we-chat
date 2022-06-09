import 'package:flutter/material.dart';

class WeChatAddPostPageBloc extends ChangeNotifier {
  ///State Variable
  bool _showBottomSheet = true;

  bool _isDisposed = false;

  bool get isShowBottomSheet => _showBottomSheet;

  void setShowBottomSheetState(bool cond) {
    _showBottomSheet =cond;
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
