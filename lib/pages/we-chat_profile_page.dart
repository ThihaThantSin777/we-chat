import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/animation/tween_animated_opacity_animation.dart';
import 'package:wechat_app/bloc/we_chat_profile_page_bloc.dart';
import 'package:wechat_app/pages/we_chat_file_details_page.dart';
import 'package:wechat_app/pages/we_chat_qr_code_page.dart';
import 'package:wechat_app/pages/we_chat_start_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/view_items/we_chat_profile_item_views/we_chat_profile_item_view.dart';
import 'package:wechat_app/widgets/choose_image_type_widget.dart';
import 'package:wechat_app/widgets/loading_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

class WeChatProfilePage extends StatelessWidget {
  const WeChatProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatProfilePageBloc>(
        create: (context) => WeChatProfilePageBloc(),
        builder: (context, child) {
          WeChatProfilePageBloc weChatProfilePageBloc =
              context.read<WeChatProfilePageBloc>();
          return TweenAnimatedOpacityAnimation(
            child: Stack(
              children: [
                Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: Selector<WeChatProfilePageBloc, String>(
                            selector: (context, bloc) => bloc.getID,
                            builder: (context, id, child) =>
                                Selector<WeChatProfilePageBloc, String>(
                              selector: (context, bloc) => bloc.getName,
                              builder: (context, name, child) => Container(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).viewPadding.top *
                                            1.5),
                                color: kPrimaryLightColor,
                                child: ProfileNameAndQrScanItemView(
                                  id: id,
                                  name: name,
                                  onTap: () => navigatePushRemoveUntil(
                                      context, const WeChatQRCodePage()),
                                ),
                              ),
                            ),
                          )),
                          Selector<WeChatProfilePageBloc, String>(
                            selector: (context, bloc) => bloc.getBioText,
                            builder: (context, bioText, child) => Expanded(
                                flex: 3,
                                child: Container(
                                  color: kBarColor,
                                  child: BioSettingIconLogoutItemView(
                                    onEdit: () {
                                      weChatProfilePageBloc.setShowBioText();
                                    },
                                    bioText: (bioText.isEmpty)
                                        ? kWriteYourBioText
                                        : bioText,
                                    onPressed: () {
                                      showMyDialog(context,
                                              'Are you sure want to logout')
                                          .then((value) {
                                        if (value ?? false) {
                                          weChatProfilePageBloc.logout().then(
                                              (value) =>
                                                  navigatePushRemoveUntil(
                                                      context,
                                                      const WeChatStartPage()));
                                        }
                                      });
                                    },
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Selector<WeChatProfilePageBloc, String>(
                      selector: (context, bloc) => bloc.getProfilePicture,
                      builder: (context, imageURL, child) => (imageURL.isEmpty)
                          ? const WaitingWidget()
                          : Positioned(
                              top: MediaQuery.of(context).viewPadding.top * 3.4,
                              left: MediaQuery.of(context).size.width * 0.33,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(kPadSpace20x),
                                        topRight: Radius.circular(kPadSpace20x),
                                      )),
                                      context: context,
                                      builder: (context) {
                                        return ProfileSelectItemView(
                                          onChooseForAlbum: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: [
                                                'jpg',
                                                'png',
                                                'gif'
                                              ],
                                            );
                                            if (result != null) {
                                              weChatProfilePageBloc
                                                  .uploadProfileImage(File(
                                                      result.paths.single ??
                                                          ''));
                                            }
                                          },
                                          onChooseForCancel: () {
                                            showMyDialog(context,
                                                    'Are you sure want to remove this photo?')
                                                .then((value) {
                                              if (value ?? false) {
                                                weChatProfilePageBloc
                                                    .removeProfileImage();
                                              }
                                            });
                                          },
                                          onChooseForTakePhoto: () async {
                                            final ImagePicker picker =
                                                ImagePicker();
                                            final XFile? photo =
                                                await picker.pickImage(
                                                    source: ImageSource.camera);
                                            if (photo != null) {
                                              weChatProfilePageBloc
                                                  .uploadProfileImage(
                                                      File(photo.path));
                                            }
                                          },
                                        );
                                      });
                                },
                                child: ProfileImageItemView(
                                  imageURL: imageURL,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                Selector<WeChatProfilePageBloc,bool>(
                  selector: (context,bloc)=>bloc.isLoading,
                  builder: (context,isLoading,child)=>
               Visibility(
                      visible: isLoading,
                      child: const LoadingWidget()),
                ),
                Selector<WeChatProfilePageBloc, bool>(
                    selector: (context, bloc) => bloc.isShowBioText,
                    builder: (context, isShow, child) => Visibility(
                        visible: isShow,
                        child: BioTextEnterItemView(
                          onSubmitted: (text) {
                            weChatProfilePageBloc.saveBioText(text);
                          },
                          onChange: (text) {
                            weChatProfilePageBloc.setBioText(text);
                          },
                          onTapForClose: () {
                            weChatProfilePageBloc.setShowBioText();
                          },
                        )))
              ],
            ),
          );
        });
  }
}

class ProfileSelectItemView extends StatelessWidget {
  const ProfileSelectItemView({
    Key? key,
    required this.onChooseForCancel,
    required this.onChooseForTakePhoto,
    required this.onChooseForAlbum,
  }) : super(key: key);
  final Function onChooseForAlbum;
  final Function onChooseForTakePhoto;
  final Function onChooseForCancel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView(
        children: [
          ChooseImageTypeWidget(
            color: Colors.black,
            onChoose: () {
              navigateBack(context);
              onChooseForTakePhoto();
            },
            title: kTakePhotoText,
          ),
          const SizedBox(
            height: kPadSpace10x,
          ),
          ChooseImageTypeWidget(
            color: Colors.black,
            onChoose: () async {
              navigateBack(context);
              onChooseForAlbum();
            },
            title: kChooseFromAlbumText,
          ),
          const SizedBox(
            height: kPadSpace10x,
          ),
          const Divider(
            color: Colors.black,
          ),
          ChooseImageTypeWidget(
            color: Colors.black,
            onChoose: () {
              navigateBack(context);
              onChooseForCancel();
            },
            title: 'Remove',
          ),
        ],
      ),
    );
  }
}
