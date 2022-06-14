import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_register_page_bloc.dart';
import 'package:wechat_app/data/vos/country_code_vo/country_code_vo.dart';
import 'package:wechat_app/pages/we_chat_email_page.dart';
import 'package:wechat_app/pages/we_chat_region_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/enums.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/view_items/we_chat_start_item_views/we_chat_register_item_views.dart';
import 'package:wechat_app/widgets/error_textfield_widget.dart';
import 'package:wechat_app/widgets/material_button_widget.dart';
import 'package:wechat_app/widgets/register_text_field_widget.dart';

class WeChatRegisterPage extends StatelessWidget {
  const WeChatRegisterPage({Key? key}) : super(key: key);

  void _showModelBottomSheetForImagePicker(
      BuildContext context, WeChatRegisterPageBloc weChatRegisterPageBloc) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kPadSpace20x)),
        backgroundColor: kStartUpColor,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChooseImageTypeItemView(
                  onChoose: () async {
                    navigateBack(context);
                    final ImagePicker picker = ImagePicker();
                    final XFile? photo =
                        await picker.pickImage(source: ImageSource.camera);
                    weChatRegisterPageBloc.setImage(File(photo?.path ?? ''));
                  },
                  title: kTakePhotoText,
                ),
                const SizedBox(
                  height: kPadSpace10x,
                ),
                ChooseImageTypeItemView(
                  onChoose: () async {
                    navigateBack(context);
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'gif'],
                    );
                    if (result != null) {
                      weChatRegisterPageBloc
                          .setImage(File(result.paths.single ?? ''));
                    }
                  },
                  title: kChooseFromAlbumText,
                ),
                const SizedBox(
                  height: kPadSpace10x,
                ),
                const Divider(
                  thickness: kPadSpace10x,
                  color: Colors.black38,
                ),
                ChooseImageTypeItemView(
                  onChoose: () {
                    weChatRegisterPageBloc.removePhoto();
                    navigateBack(context);
                  },
                  title: kCancelText,
                ),
              ],
            ),
          );
        });
  }


  void _navigateToRegionPage(BuildContext context,WeChatRegisterPageBloc weChatRegisterPageBloc){
    navigatePush(
        context, const WeChatRegionPage())
        .then((value) {
      if (value != null) {
        weChatRegisterPageBloc.setCountryCode(
            value as CountryCodeVO);
      }
    });
  }

  void _navigateToTermsAndCondition(BuildContext context,WeChatRegisterPageBloc weChatRegisterPageBloc){
    navigatePush(context,  WeChatEmailPage(userVO: weChatRegisterPageBloc.getUserVO()));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatRegisterPageBloc>(
      create: (context) => WeChatRegisterPageBloc(),
      child: Scaffold(
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
          body: Selector<WeChatRegisterPageBloc, CountryCodeVO>(
              shouldRebuild: (pre, next) => pre != next,
              selector: (context, bloc) => bloc.getRegionObject,
              builder: (context, regionObject, child) {
                WeChatRegisterPageBloc weChatRegisterPageBloc =
                    context.read<WeChatRegisterPageBloc>();
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const RegisterTitleItemView(),
                        const SizedBox(
                          height: kPadSpace20x,
                        ),
                        Selector<WeChatRegisterPageBloc, File?>(
                            shouldRebuild: (pre, next) => pre != next,
                            selector: (context, bloc) => bloc.getImage,
                            builder: (context, imageFile, child) {
                              return ChooseImageItemView(
                                file: imageFile ?? File(''),
                                onChoose: () {
                                  _showModelBottomSheetForImagePicker(context,
                                      context.read<WeChatRegisterPageBloc>());
                                },
                              );
                            }),
                        const SizedBox(
                          height: kPadSpace40x,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadSpace20x),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<WeChatRegisterPageBloc, String>(
                                  selector: (context, bloc) => bloc.getUserName,
                                  builder:
                                      (context, userNameController, child) {
                                    WeChatRegisterPageBloc
                                        weChatRegisterPageBloc =
                                        context.read<WeChatRegisterPageBloc>();
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RegisterTextFieldWidget(
                                          onPressedShowPassword: () {},
                                          textInput: TextFieldInputType.text,
                                          onChange: (text) {
                                            weChatRegisterPageBloc.setUserName =
                                                text;
                                            weChatRegisterPageBloc.validation(
                                                text, kFullNameText);
                                          },
                                          hintText: kHintTextForFullName,
                                          preFixText: kFullNameText,
                                        ),
                                        const SizedBox(
                                          height: kPadSpace10x,
                                        ),
                                        Selector<WeChatRegisterPageBloc,
                                            String>(
                                          selector: (context, bloc) =>
                                              bloc.getUserNameErrorText,
                                          builder:
                                              (context, errorText, child) =>
                                                  ErrorTextFieldWidget(
                                                    isError: errorText.startsWith('Error:'),
                                                    errorText: errorText,
                                                  ),
                                        )
                                      ],
                                    );
                                  }),
                              const SizedBox(
                                height: kPadSpace5x,
                              ),
                              ListTile(
                                minLeadingWidth: kPadSpace90x,
                                shape: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black38)),
                                contentPadding: const EdgeInsets.all(0),
                                leading: const Text(
                                  ' $kRegionText',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: kFontSize15x),
                                ),
                                title: Text(
                                  regionObject.name,
                                  style: const TextStyle(color: Colors.white30),
                                ),
                                onTap: () {
                                  _navigateToRegionPage(context,weChatRegisterPageBloc);
                                },
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white30,
                                ),
                              ),
                              const SizedBox(
                                height: kPadSpace5x,
                              ),
                              Selector<WeChatRegisterPageBloc, String>(
                                  selector: (context, bloc) => bloc.getPhone,
                                  builder: (context, phoneController, child) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                     children:[
                                       RegisterTextFieldWidget(
                                         prefixPhoneNo: weChatRegisterPageBloc
                                             .getRegionObject.phNo,
                                         onPressedShowPassword: () {},
                                         textInput: TextFieldInputType.phone,
                                         onChange: (text) {
                                           weChatRegisterPageBloc.setPhone = text;
                                           weChatRegisterPageBloc.validation(
                                               text, kPhoneText);
                                         },
                                         hintText: kHintTextForPhone,
                                         preFixText: kPhoneText,
                                       ),
                                       Selector<WeChatRegisterPageBloc,
                                           String>(
                                         selector: (context, bloc) =>
                                         bloc.getPhoneErrorText,
                                         builder:
                                             (context, errorText, child) =>
                                             ErrorTextFieldWidget(
                                               isError: errorText.startsWith('Error:'),
                                               errorText: errorText,
                                             ),
                                       )
                                     ],

                                    );
                                  }),
                              const SizedBox(
                                height: kPadSpace5x,
                              ),
                              Selector<WeChatRegisterPageBloc, bool>(
                                  selector: (context, bloc) =>
                                      bloc.isShowPassword,
                                  builder: (context, isShowPassword, child) {
                                    WeChatRegisterPageBloc
                                        weChatRegisterPageBloc =
                                        context.read<WeChatRegisterPageBloc>();
                                    return Selector<WeChatRegisterPageBloc,
                                            String>(
                                        selector: (context, bloc) =>
                                            bloc.getPassword,
                                        builder: (context, passwordController,
                                                child) =>
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                RegisterTextFieldWidget(
                                                  isShowPassword: !isShowPassword,
                                                  onPressedShowPassword: () {
                                                    weChatRegisterPageBloc
                                                        .setIsShowPasswordState();
                                                  },
                                                  isShowSuffix: true,
                                                  textInput:
                                                      TextFieldInputType.text,
                                                  onChange: (text) {
                                                    weChatRegisterPageBloc
                                                        .setPassword = text;
                                                    weChatRegisterPageBloc.validation(
                                                        text, kPasswordText);
                                                  },
                                                  hintText: kHintTextForPassword,
                                                  preFixText: kPasswordText,
                                                ),
                                                Selector<WeChatRegisterPageBloc,
                                                    String>(
                                                  selector: (context, bloc) =>
                                                  bloc.getPasswordErrorText,
                                                  builder:
                                                      (context, errorText, child) =>
                                                      ErrorTextFieldWidget(
                                                        isError: errorText.startsWith('Error:'),
                                                        errorText: errorText,
                                                      ),
                                                )
                                              ],
                                            ));
                                  }),
                              const SizedBox(
                                height: kPadSpace90x,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Selector<WeChatRegisterPageBloc, bool>(
                                      selector: (context, bloc) =>
                                          bloc.isRadioButtonSelect,
                                      builder: (context, isSelect, child) {
                                        WeChatRegisterPageBloc
                                            weChatRegisterBloc = context
                                                .read<WeChatRegisterPageBloc>();
                                        return CheckBoxItemView(
                                          isSelect: isSelect,
                                          onTap: () {
                                            weChatRegisterBloc
                                                .setRadioButtonSelectionState();
                                          },
                                        );
                                      }),
                                  const Expanded(
                                    child: TermsAndConditionItemView(),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: kPadSpace40x,
                              ),
                              Selector<WeChatRegisterPageBloc, bool>(
                                selector: (context, bloc) =>
                                    bloc.isRadioButtonSelect,
                                builder: (context, isSelect, child) => Container(
                                  alignment: Alignment.topCenter,
                                  child: MaterialButtonWidget(
                                    miniWidth:
                                    MediaQuery.of(context).size.width * 0.6,
                                    childText: 'Accept and Continue',
                                    textColor: isSelect
                                        ? Colors.white
                                        : Colors.black38,
                                    onPressed: (){
                                      weChatRegisterPageBloc.acceptAndContinue(isSelect).then((value) {
                                        if(value){
                                          _navigateToTermsAndCondition(context,weChatRegisterPageBloc);
                                        }
                                      });
                                    },
                                    color:
                                    isSelect ? kButtonColor : kDisableColor,
                                  ),
                                )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}


