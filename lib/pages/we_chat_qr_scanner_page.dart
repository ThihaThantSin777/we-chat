import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wechat_app/bloc/we_chat_qr_scanner_page_bloc.dart';
import 'package:wechat_app/pages/we_chat_qr_code_page.dart';
import 'package:wechat_app/pages/we_chat_scan_profile_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/utils/extension.dart';

class WeChatQrScannerPage extends StatelessWidget {
  WeChatQrScannerPage({Key? key}) : super(key: key);
  final qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatQRScannerPageBloc>(
      create: (context) => WeChatQRScannerPageBloc(),
      builder: (context, child) {
        WeChatQRScannerPageBloc weChatQRScannerPageBloc =
            context.read<WeChatQRScannerPageBloc>();
        return SafeArea(
            child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              QRView(
                  key: qrKey,
                  overlay: QrScannerOverlayShape(
                      borderColor: kPrimaryLightColor,
                      borderRadius: kPadSpace20x,
                      borderWidth: kPadSpace10x,
                      cutOutSize: MediaQuery.of(context).size.width * 0.8),
                  onQRViewCreated: (qrCodeController) {
                    weChatQRScannerPageBloc.setQRViewController =
                        qrCodeController;
                    qrCodeController.scannedDataStream.listen((event) {
                      navigatePushRemoveUntil(context,
                          WeChatScanProfilePage(id: event.code??''));
                      //   navigatePush(context, WeChatQRCodePage(id: event.code.toString(),));
                    });
                  })
            ],
          ),
        ));
      },
    );
  }
}
