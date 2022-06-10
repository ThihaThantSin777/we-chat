import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/bloc/we_chat_discover_page_bloc.dart';
import 'package:wechat_app/pages/we_chat_add_post_page.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/view_items/we_chat_discover_item_views/we_chat_discover_item_views.dart';
import 'package:wechat_app/widgets/leading_widget.dart';

class WeChatDiscoverPage extends StatefulWidget {
  const WeChatDiscoverPage({Key? key}) : super(key: key);

  @override
  State<WeChatDiscoverPage> createState() => _WeChatDiscoverPageState();
}

class _WeChatDiscoverPageState extends State<WeChatDiscoverPage> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network('https://www.youtube.com/watch?v=cNwEVYkx2Kk')
      ..addListener(() {})
      ..setLooping(true)
      ..initialize().then((value) => videoPlayerController?.play());
  }

  @override
  void dispose(){
    super.dispose();
    videoPlayerController?.dispose();
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
                  //navigatePush(context, WeChatAddPostPage());
                },
                icon: const Icon(Icons.photo_camera)),
          ],
        ),
        body: ListView(
          children: [
            Stack(
              children: [
                AspectRatio(
                    aspectRatio: videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(
                    videoPlayerController!
                  ),
                ),
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
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          right: kPadSpace10x, bottom: kPadSpace10x),
                      child: Text(
                        '3 min ago',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: kPadSpace90x),
                            child: const UserNameItemView(
                              userName: 'Thiha Thant Sin',
                            ),
                          ),
                          const SizedBox(
                            height: kPadSpace10x,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: kPadSpace50x),
                            child: const DescriptionItemView(
                              description:
                                  'Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin ',
                            ),
                          ),
                          const SizedBox(
                            height: kPadSpace10x,
                          ),
                          Visibility(
                            visible: true,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadSpace10x),
                              child: const ImageAndVideoItemView(
                                imageLink:
                                    'https://img.freepik.com/free-vector/hand-painted-background-violet-orange-colours_23-2148427578.jpg',
                                videoLink:
                                    'https://img.freepik.com/free-vector/hand-painted-background-violet-orange-colours_23-2148427578.jpg',
                                isImage: true,
                                isVideo: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: kPadSpace10x),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      size: kPadSpace40x,
                                    )),
                                const SizedBox(
                                  width: kPadSpace10x,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.comment,
                                      size: kPadSpace40x,
                                    )),
                                const SizedBox(
                                  width: kPadSpace10x,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.horizontal_rule,
                                      size: kPadSpace40x,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kPadSpace10x,
                    ),
                    Container(
                      width: double.infinity,
                      color: kBarColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                  ],
                ),
                const Positioned(
                  top: 0,
                  left: kPadSpace20x,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://media.comicbook.com/2021/03/boruto-naruto-kawaki-anime-1261354.jpeg'),
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          right: kPadSpace10x, bottom: kPadSpace10x),
                      child: Text(
                        '3 min ago',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: kPadSpace90x),
                            child: const UserNameItemView(
                              userName: 'Thiha Thant Sin',
                            ),
                          ),
                          const SizedBox(
                            height: kPadSpace10x,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: kPadSpace50x),
                            child: const DescriptionItemView(
                              description:
                                  'Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin ',
                            ),
                          ),
                          const SizedBox(
                            height: kPadSpace10x,
                          ),
                          Visibility(
                            visible: true,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadSpace10x),
                              child: const ImageAndVideoItemView(
                                imageLink:
                                    'https://img.freepik.com/free-vector/hand-painted-background-violet-orange-colours_23-2148427578.jpg',
                                videoLink:
                                    'https://img.freepik.com/free-vector/hand-painted-background-violet-orange-colours_23-2148427578.jpg',
                                isImage: true,
                                isVideo: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: kPadSpace10x),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      size: kPadSpace40x,
                                    )),
                                const SizedBox(
                                  width: kPadSpace10x,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.comment,
                                      size: kPadSpace40x,
                                    )),
                                const SizedBox(
                                  width: kPadSpace10x,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.horizontal_rule,
                                      size: kPadSpace40x,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kPadSpace10x,
                    ),
                    Container(
                      width: double.infinity,
                      color: kBarColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                  ],
                ),
                const Positioned(
                  top: 0,
                  left: kPadSpace20x,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://media.comicbook.com/2021/03/boruto-naruto-kawaki-anime-1261354.jpeg'),
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          right: kPadSpace10x, bottom: kPadSpace10x),
                      child: Text(
                        '3 min ago',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: kPadSpace90x),
                            child: const UserNameItemView(
                              userName: 'Thiha Thant Sin',
                            ),
                          ),
                          const SizedBox(
                            height: kPadSpace10x,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: kPadSpace50x),
                            child: const DescriptionItemView(
                              description:
                                  'Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin Thiha Thant Sin ',
                            ),
                          ),
                          const SizedBox(
                            height: kPadSpace10x,
                          ),
                          Visibility(
                            visible: true,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadSpace10x),
                              child: const ImageAndVideoItemView(
                                imageLink:
                                    'https://img.freepik.com/free-vector/hand-painted-background-violet-orange-colours_23-2148427578.jpg',
                                videoLink:
                                    'https://img.freepik.com/free-vector/hand-painted-background-violet-orange-colours_23-2148427578.jpg',
                                isImage: true,
                                isVideo: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: kPadSpace10x),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      size: kPadSpace40x,
                                    )),
                                const SizedBox(
                                  width: kPadSpace10x,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.comment,
                                      size: kPadSpace40x,
                                    )),
                                const SizedBox(
                                  width: kPadSpace10x,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.horizontal_rule,
                                      size: kPadSpace40x,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kPadSpace10x,
                    ),
                    Container(
                      width: double.infinity,
                      color: kBarColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                  ],
                ),
                const Positioned(
                  top: 0,
                  left: kPadSpace20x,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://media.comicbook.com/2021/03/boruto-naruto-kawaki-anime-1261354.jpeg'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
