import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_discover_page_bloc.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/pages/we_chat_add_post_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/view_items/we_chat_discover_item_views/we_chat_discover_item_views.dart';
import 'package:wechat_app/widgets/leading_widget.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/widgets/loading_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';
import '../widgets/small_profile_widget.dart';

class WeChatDiscoverPage extends StatelessWidget {
  const WeChatDiscoverPage({Key? key}) : super(key: key);

  void postDelete(WeChatDiscoverPageBloc weChatDiscoverPageBloc, String id,
      BuildContext context) {
    weChatDiscoverPageBloc.deletePost(id).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryLightColor,
          content: Text(
            '1 post delete',
            style: TextStyle(color: Colors.white),
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatDiscoverPageBloc>(
      create: (context) => WeChatDiscoverPageBloc(),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: kBarColor,
            appBar: AppBar(
              title: const Text(kMomentsText),
              automaticallyImplyLeading: false,
              leadingWidth: kLeadingWidth,
              leading: const LeadingWidget(text: kDiscoverText),
              actions: [
                IconButton(
                    onPressed: () {
                      navigatePush(context, WeChatAddPostPage());
                    },
                    icon: const Icon(Icons.add_a_photo)),
              ],
            ),
            body: Stack(
              children: [
                Selector<WeChatDiscoverPageBloc, List<MomentVO>?>(
                    shouldRebuild: (pre, next) => pre != next,
                    selector: (context, bloc) => bloc.getMomentVO,
                    builder: (context, momentLisVO, child) {
                      WeChatDiscoverPageBloc weChatDiscoverPageBloc =
                          context.read<WeChatDiscoverPageBloc>();
                      return ListView(
                        children: [
                          Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Selector<WeChatDiscoverPageBloc, String>(
                                      selector: (context, bloc) =>
                                          bloc.getBackgroundImage,
                                      builder:
                                          (context, backgroundImage, child) =>
                                              (backgroundImage.isEmpty)
                                                  ? const WaitingWidget()
                                                  : BackgroundImageItemView(
                                                      backgroundImage:
                                                          backgroundImage,
                                                      onTapForBgImage: () {
                                                        showModalBottomSheet(
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      kPadSpace20x),
                                                              topRight: Radius
                                                                  .circular(
                                                                      kPadSpace20x),
                                                            )
                                                                ),
                                                            context: context,
                                                            builder: (context) {
                                                              return BackgroundChooseImageItemView(
                                                                onChooseForAlbum:
                                                                    () async {
                                                                  FilePickerResult?
                                                                      result =
                                                                      await FilePicker
                                                                          .platform
                                                                          .pickFiles(
                                                                    type: FileType
                                                                        .custom,
                                                                    allowedExtensions: [
                                                                      'jpg',
                                                                      'png',
                                                                      'gif'
                                                                    ],
                                                                  );
                                                                  if (result !=
                                                                      null) {
                                                                    weChatDiscoverPageBloc.uploadBackgroundImage(File(result
                                                                            .paths
                                                                            .single ??
                                                                        ''));
                                                                  }
                                                                },
                                                                onChooseForTakePhoto:
                                                                    () async {
                                                                  final ImagePicker
                                                                      picker =
                                                                      ImagePicker();
                                                                  final XFile?
                                                                      photo =
                                                                      await picker.pickImage(
                                                                          source:
                                                                              ImageSource.camera);
                                                                  if (photo !=
                                                                      null) {
                                                                    weChatDiscoverPageBloc
                                                                        .uploadBackgroundImage(
                                                                            File(photo.path));
                                                                  }
                                                                },
                                                                onChooseForCancel:
                                                                    () {
                                                                  showMyDialog(
                                                                          context,
                                                                          'Are you sure want to remove this photo?')
                                                                      .then(
                                                                          (value) {
                                                                    if (value ??
                                                                        false) {
                                                                      weChatDiscoverPageBloc
                                                                          .removeBackgroundImage();
                                                                    }
                                                                  });
                                                                },
                                                              );
                                                            });
                                                      },
                                                    )),
                                  const DateTimeItemView(),
                                  NewMomentsItemView(
                                    moments: (momentLisVO?.isEmpty ?? true)
                                        ? 0
                                        : momentLisVO?.length ?? 0,
                                  ),
                                ],
                              ),
                              Positioned(
                                  top: MediaQuery.of(context).size.width * 0.55,
                                  right: kPadSpace10x,
                                  child:
                                      Selector<WeChatDiscoverPageBloc, String>(
                                          selector: (context, bloc) =>
                                              bloc.getProfileName,
                                          builder:
                                              (context, profileName, child) =>
                                                  ProfileNameItemView(
                                                    profileName: profileName,
                                                  ))),
                              Selector<WeChatDiscoverPageBloc, String>(
                                selector: (context, bloc) =>
                                    bloc.getProfileImage,
                                builder: (context, image, child) => (image
                                        .isEmpty)
                                    ? const WaitingWidget()
                                    : Positioned(
                                        top: MediaQuery.of(context).size.width *
                                            0.5,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.23,
                                        child: SmallProfileImageItemView(
                                          image: image,
                                        ),
                                      ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: kPadSpace20x,
                          ),
                          (momentLisVO?.isEmpty ?? true)
                              ? const WaitingWidget(
                                  isAddCircularProgressIndicator: false,
                                  text: 'No Moment available',
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: momentLisVO?.length,
                                  itemBuilder: (context, index) => Stack(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: kPadSpace10x),
                                            child: TimeAgoItemView(
                                              dateTime: momentLisVO?[index]
                                                      .timeStamp ??
                                                  DateTime.now(),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: kPadSpace10x,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<
                                                      WeChatDiscoverPageBloc>()
                                                  .setIsShowDetailsState(
                                                      momentLisVO![index]);
                                            },
                                            child: Card(
                                              margin: const EdgeInsets.all(0),
                                              elevation: 2,
                                              shadowColor: kShoeMoreColor,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: kPadSpace20x,
                                                  ),
                                                  MomentUploaderNameItemView(
                                                    name: momentLisVO?[index]
                                                            .userName ??
                                                        'None',
                                                  ),
                                                  const SizedBox(
                                                    height: kPadSpace10x,
                                                  ),
                                                  MomentDescriptionItemView(
                                                    description:
                                                        momentLisVO?[index]
                                                                .description ??
                                                            'None',
                                                  ),
                                                  Visibility(
                                                    visible: ((momentLisVO?[
                                                                    index]
                                                                .postImage
                                                                .isNotEmpty ??
                                                            false) ||
                                                        (momentLisVO?[index]
                                                                .postVideo
                                                                .isNotEmpty ??
                                                            false)),
                                                    child: ImageAndVideoView(
                                                      isImage:
                                                          momentLisVO?[index]
                                                                  .postImage
                                                                  .isNotEmpty ??
                                                              false,
                                                      imageURL:
                                                          momentLisVO?[index]
                                                                  .postImage ??
                                                              kDefaultImage,
                                                      isVideo:
                                                          momentLisVO?[index]
                                                                  .postVideo
                                                                  .isNotEmpty ??
                                                              false,
                                                      videoURL:
                                                          momentLisVO?[index]
                                                                  .postVideo ??
                                                              kDefaultVideoLink,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: kPadSpace10x,
                                                  ),
                                                  FavoriteCommentIconItemView(
                                                    onPressedForFavorite: () =>
                                                        weChatDiscoverPageBloc
                                                            .setIsLikedState(
                                                                momentLisVO![
                                                                    index]),
                                                    onPressedForComment: () {
                                                      context
                                                          .read<
                                                              WeChatDiscoverPageBloc>()
                                                          .setIsShowCommentTextFieldState();
                                                    },
                                                    onEdit: () {
                                                      navigatePush(
                                                          context,
                                                          WeChatAddPostPage(
                                                            id: momentLisVO?[
                                                                        index]
                                                                    .id ??
                                                                '',
                                                          ));
                                                    },
                                                    onDelete: () {
                                                      showMyDialog(context,
                                                              'Are you sure want to delete this moment?')
                                                          .then((value) {
                                                        if (value ?? false) {
                                                          postDelete(
                                                              context.read<
                                                                  WeChatDiscoverPageBloc>(),
                                                              momentLisVO?[
                                                                          index]
                                                                      .id ??
                                                                  '',
                                                              context);
                                                        }
                                                      });
                                                    },
                                                    isFavorite:
                                                        momentLisVO?[index]
                                                                .isLiked ??
                                                            false,
                                                    isOriginalUploader:
                                                        momentLisVO?[index]
                                                                .isOriginalUploader ??
                                                            false,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: kPadSpace10x,
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              WhoLikesItemView(),
                                              SizedBox(
                                                height: kPadSpace20x,
                                              ),
                                              WhoCommentItemView()
                                            ],
                                          ),
                                          const SizedBox(
                                            height: kPadSpace30x,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: kPadSpace20x),
                                        child: SmallProfileWidget(
                                          width: 60,
                                          height: 60,
                                          imageURL: (momentLisVO?[index]
                                                      .profilePicture
                                                      .isEmpty ??
                                                  true)
                                              ? kDefaultImage
                                              : momentLisVO?[index]
                                                      .profilePicture ??
                                                  '',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      );
                    }),
                Selector<WeChatDiscoverPageBloc, bool>(
                  selector: (context, bloc) => bloc.isShowCommentTextField,
                  builder: (context, isShowCommentTextField, child) =>
                      GestureDetector(
                    onTap: () {
                      context
                          .read<WeChatDiscoverPageBloc>()
                          .setIsShowCommentTextFieldState();
                    },
                    child: Visibility(
                        visible: isShowCommentTextField,
                        child: CommentItemView(
                          onSubmitted: () {
                            context
                                .read<WeChatDiscoverPageBloc>()
                                .setIsShowCommentTextFieldState();
                          },
                          prefixText: 'Thiha Thant Sin  ',
                        )),
                  ),
                ),
                Selector<WeChatDiscoverPageBloc, MomentVO?>(
                    selector: (context, bloc) => bloc.getDetailsMoment,
                    builder: (context, detailsMomentVO, child) =>
                        GestureDetector(
                          onTap: () => context
                              .read<WeChatDiscoverPageBloc>()
                              .setIsShowDetailsState(),
                          child: Visibility(
                              visible: detailsMomentVO != null,
                              child: DetailsItemView(
                                isOriginalUploader:
                                    detailsMomentVO?.isOriginalUploader ??
                                        false,
                                momentVO: detailsMomentVO,
                              )),
                        ))
              ],
            ),
          ),
          Selector<WeChatDiscoverPageBloc, bool>(
              selector: (context, bloc) => bloc.isLoading,
              builder: (context, isLoading, child) => Visibility(
                    visible: isLoading,
                    child: const LoadingWidget(),
                  ))
        ],
      ),
    );
  }
}
