import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_discover_page_bloc.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/pages/we_chat_add_post_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/view_items/we_chat_discover_item_views/we_chat_discover_item_views.dart';
import 'package:wechat_app/widgets/comments_widget.dart';
import 'package:wechat_app/widgets/leading_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';
import 'package:wechat_app/utils/extension.dart';

class WeChatDiscoverPage extends StatelessWidget {
  const WeChatDiscoverPage({Key? key}) : super(key: key);

  void showDetails(WeChatDiscoverPageBloc weChatDiscoverPageBloc,
      [MomentVO? momentVO]) {
    weChatDiscoverPageBloc.setIsShowDetailsState(momentVO);
  }

  void showCommentTextFieldView(WeChatDiscoverPageBloc weChatDiscoverPageBloc) {
    weChatDiscoverPageBloc.setIsShowCommentTextFieldState();
  }

  void delete(WeChatDiscoverPageBloc weChatDiscoverPageBloc, int id,
      BuildContext context) {
    weChatDiscoverPageBloc
        .deletePost(id)
        .then((_) => showSnackBar(context, '1 Post is deleted'));
  }

  void edit(WeChatDiscoverPageBloc weChatDiscoverPageBloc, int id,
      BuildContext context) {


    navigatePush(
        context,
        WeChatAddPostPage(
          id: id,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatDiscoverPageBloc>(
      create: (context) => WeChatDiscoverPageBloc(),
      child: Scaffold(
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
                icon: const Icon(Icons.photo_camera)),
          ],
        ),
        body: Selector<WeChatDiscoverPageBloc, List<MomentVO>?>(
          shouldRebuild: (pre, next) => pre != next,
          selector: (context, bloc) => bloc.getMomentVO,
          builder: (context, momentListVO, child) => Stack(
            children: [
              ListView(children: [
                Stack(
                  children: [
                    const MyBackgroundItemView(),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.2,
                      left: MediaQuery.of(context).size.width * 0.21,
                      child: const MyProfileItemView(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kPadSpace40x,
                ),
                (momentListVO?.isEmpty ?? true)
                    ? const WaitingWidget(
                        isAddCircularProgressIndicator: false,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: momentListVO
                                ?.map((data) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: kPadSpace20x,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: kPadSpace10x,
                                              bottom: kPadSpace10x),
                                          child: Text(
                                            '3 min ago',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDetails(
                                                context.read<
                                                    WeChatDiscoverPageBloc>(),
                                                data);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 3,
                                                      spreadRadius: 3,
                                                      color: Colors.black12)
                                                ]),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: kPadSpace90x),
                                                    child:
                                                        const UserNameItemView(
                                                      userName:
                                                          'Thiha Thant Sin',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: kPadSpace10x,
                                                  ),

                                                  ///Description View
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: kPadSpace50x),
                                                    child: DescriptionItemView(
                                                      description:
                                                          data.description,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: kPadSpace10x,
                                                  ),

                                                  ///Image and Video View
                                                  Visibility(
                                                    visible: !(data.postImage ==
                                                            kDefaultImage &&
                                                        data.postVideo ==
                                                            kDefaultImage),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showDetails(
                                                            context.read<
                                                                WeChatDiscoverPageBloc>(),
                                                            data);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                        padding: const EdgeInsets
                                                                .symmetric(
                                                            horizontal:
                                                                kPadSpace10x),
                                                        child:
                                                            ImageAndVideoItemView(
                                                          imageLink:
                                                              data.postImage,
                                                          videoLink:
                                                              data.postVideo,
                                                          isImage:
                                                              data.postImage !=
                                                                  kDefaultImage,
                                                          isVideo:
                                                              data.postVideo !=
                                                                  kDefaultImage,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  ///Comment View
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right:
                                                                kPadSpace10x),
                                                    child:
                                                    CommentWidget(
                                                      onPressedLiked: () {
                                                        context
                                                            .read<
                                                                WeChatDiscoverPageBloc>()
                                                            .setIsLikedState(
                                                                data);
                                                      },
                                                      isLiked: data.isLiked,
                                                      commentAction: () {
                                                        context
                                                            .read<
                                                                WeChatDiscoverPageBloc>()
                                                            .setIsShowCommentTextFieldState();
                                                      },
                                                      onDelete: () {
                                                        delete(
                                                            context.read<
                                                                WeChatDiscoverPageBloc>(),
                                                            data.id,
                                                            context);
                                                      },
                                                      onEdit: () {
                                                          edit( context.read<
                                                              WeChatDiscoverPageBloc>(), data.id, context);
                                                      },
                                                    ),
                                                  ),

























                                                  const SizedBox(
                                                    height: kPadSpace10x,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    color: kBarColor,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: const [
                                                        SizedBox(
                                                          height: kPadSpace10x,
                                                        ),
                                                        LikesItemView(),
                                                        SizedBox(
                                                          height: kPadSpace10x,
                                                        ),
                                                        CommentItemView(),
                                                        SizedBox(
                                                          height: kPadSpace30x,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        )
                                      ],
                                    ))
                                .toList() ??
                            [],
                      ),
              ]),
              Selector<WeChatDiscoverPageBloc, bool>(
                selector: (context, bloc) => bloc.isShowDetails,
                builder: (context, isShowDetails, child) => Visibility(
                  visible: isShowDetails,
                  child: Positioned(
                      child: GestureDetector(
                    onTap: () {
                      showDetails(context.read<WeChatDiscoverPageBloc>());
                    },
                    child: Container(
                      color: Colors.black.withOpacity(0.8),
                      child: Center(
                        child: Selector<WeChatDiscoverPageBloc, MomentVO?>(
                          selector: (context, bloc) => bloc.getDetailsMoment,
                          builder: (context, momentVO, child) => Padding(
                            padding: const EdgeInsets.all(kPadSpace10x),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const DetailsProfileNameItemView(),
                                const SizedBox(
                                  height: kPadSpace10x,
                                ),
                                DetailsDescriptionItemView(
                                  description: momentVO?.description ?? '',
                                ),
                                const SizedBox(
                                  height: kPadSpace10x,
                                ),
                                ((momentVO?.postImage.isEmpty ?? true) ||
                                        momentVO?.postImage == kDefaultImage)
                                    ? Container()
                                    : DetailsImageAndVideoItemView(
                                        postImage: momentVO?.postImage ??
                                            kDefaultImage,
                                        postVideo: momentVO?.postVideo ??
                                            kDefaultImage,
                                      ),
                                CommentWidget(
                                  onPressedLiked: () {
                                    // context.read<WeChatDiscoverPageBloc>().setIsLikedState(momentVO!);
                                  },
                                  commentAction: () {
                                    // context.read<WeChatDiscoverPageBloc>().setIsShowCommentTextFieldState();
                                  },
                                  isLiked: momentVO?.isLiked ?? false,
                                  color: Colors.white70,
                                  onDelete: () {},
                                  onEdit: () {
                                    edit( context.read<
                                        WeChatDiscoverPageBloc>(), momentVO!.id, context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                ),
              ),
              Selector<WeChatDiscoverPageBloc, bool>(
                selector: (context, bloc) => bloc.isShowCommentTextField,
                builder: (context, isShowCommentTextField, child) => Visibility(
                  visible: isShowCommentTextField,
                  child: Positioned(
                      child: GestureDetector(
                    onTap: () {
                      showCommentTextFieldView(
                          context.read<WeChatDiscoverPageBloc>());
                    },
                    child: Container(
                      color: Colors.black.withOpacity(0.8),
                      child: Center(
                          child: Row(
                        children: [
                          const SizedBox(
                            width: kPadSpace50x,
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: kPrimaryLightColor))),
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                onSubmitted: (string) {
                                  showCommentTextFieldView(
                                      context.read<WeChatDiscoverPageBloc>());
                                },
                                autofocus: true,
                                decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    suffixIcon: Icon(
                                      Icons.sentiment_satisfied_outlined,
                                      color: Colors.white70,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
