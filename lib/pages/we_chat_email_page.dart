import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_email_page_bloc.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/pages/we_chat_home_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/enums.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/widgets/error_textfield_widget.dart';
import 'package:wechat_app/widgets/loading_widget.dart';
import 'package:wechat_app/widgets/material_button_widget.dart';
import 'package:wechat_app/widgets/register_text_field_widget.dart';

class WeChatEmailPage extends StatelessWidget {
  const WeChatEmailPage({Key? key, required this.userVO}) : super(key: key);
  final UserVO userVO;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatEmailPageBloc>(
      create: (context) => WeChatEmailPageBloc(userVO),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kAzListColor,
            appBar: AppBar(
              backgroundColor: kAzListColor,
              leading: IconButton(
                onPressed: () => navigateBack(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white60,
                ),
              ),
            ),
            body: ListView(
              children: [
                Selector<WeChatEmailPageBloc, String>(
                    selector: (context, bloc) => bloc.getEmail,
                    builder: (context, email, child) {
                      WeChatEmailPageBloc weChatEmailPageBloc =
                          context.read<WeChatEmailPageBloc>();
                      return Padding(
                        padding: const EdgeInsets.all(kPadSpace30x),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              kEmailVerificationText,
                              style: TextStyle(
                                  fontSize: kFontSize23x,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: kPadSpace50x,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                kEnterVerificationInformationText,
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: kPadSpace5x,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RegisterTextFieldWidget(
                                    onChange: (string) {
                                      weChatEmailPageBloc.setEmail(string);
                                      weChatEmailPageBloc.setErrorEmailText(string);
                                    },
                                    preFixText: kEmailText,
                                    hintText: kEmailHintText,
                                    textInput: TextFieldInputType.email,
                                    onPressedShowPassword: () {}),
                                const SizedBox(
                                  height: kPadSpace10x,
                                ),
                                Selector<WeChatEmailPageBloc, String>(
                                    selector: (context, bloc) => bloc.getErrorEmailText,
                                    builder: (context, errorText, child) =>
                                        ErrorTextFieldWidget(
                                          isError: errorText.startsWith('Error:'),
                                          errorText: errorText,
                                        )),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.5,
                                ),
                                Selector<WeChatEmailPageBloc, String>(
                                  selector: (context, bloc) => bloc.getErrorEmailText,
                                  builder: (context, errorText, child) => Container(
                                    alignment: Alignment.center,
                                    child: MaterialButtonWidget(
                                        onPressed: () {
                                          weChatEmailPageBloc.setErrorEmailText(email);
                                          if (errorText.isEmpty) {
                                           weChatEmailPageBloc.registerNewUser().then((value) {
                                             navigatePushRemoveUntil(context, const WeChatHomePage());
                                           }).catchError((error)=> showSnackBar(context, error.toString(),color: Colors.red));
                                          }
                                        },
                                        color: kUploadImageBottomSheetColor,
                                        textColor: Colors.white30,
                                        childText: 'OK'),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
          Selector<WeChatEmailPageBloc,bool>(
            selector: (context,bloc)=>bloc.isLoading,
              builder: (context,isLoading,child)=>
              Visibility(
                visible: isLoading,
                  child:  const LoadingWidget()
              ),

          ),
        ],
      ),
    );
  }
}
