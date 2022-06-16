import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';

class QRScannerWidget extends StatefulWidget {
  const QRScannerWidget({Key? key}) : super(key: key);

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  final qrKey=GlobalKey(debugLabel: 'QR');
  late final QRViewController qrViewController;


  @override
  void dispose(){
    qrViewController.dispose();
    super.dispose();

  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController.pauseCamera();
    } else if (Platform.isIOS) {
      qrViewController.resumeCamera();
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
              overlay:  QrScannerOverlayShape(
                  borderColor: kPrimaryLightColor,
                  borderRadius: kPadSpace20x,
                  borderWidth: kPadSpace10x,
                  cutOutSize: MediaQuery.of(context).size.width*0.8
              ),
              key: qrKey, onQRViewCreated: (qrCodeController){
              qrViewController=qrCodeController;
              qrViewController.resumeCamera();
              qrCodeController.scannedDataStream.listen((event) {
                print('QR Data ${event.code}');
              });

          })
        ],
      ),
    ));
  }
}
