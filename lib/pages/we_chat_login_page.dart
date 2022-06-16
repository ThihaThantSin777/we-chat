import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_login_page_bloc.dart';
import 'package:wechat_app/pages/we_chat_home_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/enums.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/view_items/we_chat_login_item_views/we_chat_login_item_view.dart';
import 'package:wechat_app/widgets/error_textfield_widget.dart';
import 'package:wechat_app/widgets/loading_widget.dart';
import 'package:wechat_app/widgets/material_button_widget.dart';
import 'package:wechat_app/widgets/register_text_field_widget.dart';

class WeChatLoginPage extends StatelessWidget {
  const WeChatLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatLoginPageBloc>(
      create: (context) => WeChatLoginPageBloc(),
      child: Selector<WeChatLoginPageBloc,bool>(
        selector: (context,bloc)=>bloc.isLoading,
        builder: (context,loading,child)=>
        Stack(
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
              body: Padding(
                padding: const EdgeInsets.all(kPadSpace40x),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const LoginTitleItemView(),
                    const SizedBox(
                      height: kPadSpace30x,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Selector<WeChatLoginPageBloc, String>(
                            selector: (context, bloc) => bloc.getEmail,
                            builder: (context, email, child) {
                              WeChatLoginPageBloc weChatLoginPageBloc =
                                  context.read<WeChatLoginPageBloc>();
                              return RegisterTextFieldWidget(
                                  onChange: (text) {
                                    weChatLoginPageBloc.setEmailText(text);
                                    weChatLoginPageBloc.validate(text,kAccountText);
                                  },
                                  preFixText: kAccountText,
                                  hintText: kAccountHintText,
                                  textInput: TextFieldInputType.email,
                                  onPressedShowPassword: () {});
                            }),
                        const SizedBox(
                          height: kPadSpace5x,
                        ),
                        Selector<WeChatLoginPageBloc, String>(
                            selector: (context, bloc) => bloc.getEmailErrorText,
                            builder: (context, errorText, child) =>
                                ErrorTextFieldWidget(
                                    isError: errorText.startsWith('Error:'),
                                    errorText: errorText))
                      ],
                    ),
                    const SizedBox(
                      height: kPadSpace10x,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Selector<WeChatLoginPageBloc, String>(
                            selector: (context, bloc) => bloc.getPassword,
                            builder: (context, password, child) {
                              WeChatLoginPageBloc weChatLoginPageBloc =
                                  context.read<WeChatLoginPageBloc>();
                              return RegisterTextFieldWidget(
                                isShowPassword: true,
                                  onChange: (text) {
                                    weChatLoginPageBloc.setPasswordText(text);
                                    weChatLoginPageBloc.validate(text,kPasswordText);
                                  },
                                  preFixText: kPasswordText,
                                  hintText: kHintTextForPassword,
                                  textInput: TextFieldInputType.text,
                                  onPressedShowPassword: () {});
                            }),
                        Selector<WeChatLoginPageBloc, String>(
                            selector: (context, bloc) => bloc.getPasswordErrorText,
                            builder: (context, errorText, child) =>
                                ErrorTextFieldWidget(
                                    isError: errorText.startsWith('Error:'),
                                    errorText: errorText))
                      ],
                    ),
                    const SizedBox(
                      height: kPadSpace20x,
                    ),
                    const LoginWithMobileItemView(),
                    const SizedBox(
                      height: kPadSpace250x,
                    ),
                    const VerificationItemView(),
                    const SizedBox(
                      height: kPadSpace20x,
                    ),
                    MaterialButtonWidget(
                        onPressed: () {
                          WeChatLoginPageBloc weChatLoginBloc=context.read<WeChatLoginPageBloc>();
                          weChatLoginBloc.login().then((value) {
                            navigatePushReplacement(context, const WeChatHomePage());
                          }).catchError((error)=>showSnackBar(context,error.toString()));
                        },
                        color: kButtonColor,
                        textColor: Colors.white,
                        childText: kAcceptAndLoginText),
                    const SizedBox(
                      height: kPadSpace30x,
                    ),
                    const MoreOptionItemView()
                  ],
                ),
              ),
            ),
            Visibility(
              visible: loading,
                child: const LoadingWidget())
          ],
        ),
      ),
    );
  }
}
