import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_qr_code_page_bloc.dart';
import 'package:wechat_app/pages/we_chat_qr_scanner_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/widgets/wating_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WeChatQRCodePage extends StatelessWidget {
  const WeChatQRCodePage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatQRCodePageBloc>(
      create: (context) => WeChatQRCodePageBloc(),
      builder: (context, child) =>
         Stack(
          children: [
            Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: kPrimaryLightColor,
                onPressed: () {
                  navigatePush(context, WeChatQrScannerPage());
                },
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
              appBar: AppBar(
                title: const Text(
                  'Your QR Code',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: kPrimaryLightColor,
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    navigateBack(context);
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(kPadSpace20x),
                child: Center(
                  child: Selector<WeChatQRCodePageBloc, String>(
                    selector: (context, bloc) => bloc.getQrCode,
                    builder: (context, qrCode, child) {
                      if (qrCode.isEmpty) {
                        return const WaitingWidget();
                      }
                      return QrImage(data: qrCode);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),

    );
  }
}


