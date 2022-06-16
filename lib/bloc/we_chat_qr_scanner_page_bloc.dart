
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class WeChatQRScannerPageBloc extends ChangeNotifier{
  ///State Variable
  bool _isDisposed=false;
  QRViewController ? _qrViewController;


  ///Getter
  QRViewController? get getQRViewController=>_qrViewController;

  ///Setter
  set setQRViewController(QRViewController qrViewController){
    _qrViewController=qrViewController;
    _qrViewController?.resumeCamera();
    _notifySafely();
  }


  @override
  void dispose() {
    super.dispose();
    _qrViewController?.dispose();
    _isDisposed = true;
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}