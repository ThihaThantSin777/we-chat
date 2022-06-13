import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/widgets/flick_manager_video.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

//
//
// class MyBackgroundItemView extends StatelessWidget {
//   const MyBackgroundItemView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final DateTime now = DateTime.now();
//     final DateFormat formatter = DateFormat('yMMMMEEEEd');
//     final String formatted = formatter.format(now);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Stack(
//           children: const[
//             BackgroundImageView(),
//             Positioned.fill(
//               bottom: kPadSpace10x,
//               right: kPadSpace10x,
//               child:  Align(
//                   alignment: Alignment.bottomRight,
//                   child:  ProfileNameView()),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: kPadSpace20x,
//         ),
//         Padding(
//           padding:  const EdgeInsets.only(right: kPadSpace10x),
//           child:  Text(formatted,style: const TextStyle(fontWeight: FontWeight.w700),),
//         ),
//         const Padding(
//           padding:  EdgeInsets.only(right: kPadSpace10x),
//           child:  Text('23 new moments',style: TextStyle(fontWeight: FontWeight.w700),),
//         )
//       ],
//     );
//   }
// }
//
// class ProfileNameView extends StatelessWidget {
//   const ProfileNameView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Text('Thiha Thant Sin',style: TextStyle(color: Colors.white,fontSize: kFontSize17x,fontWeight: FontWeight.bold),);
//   }
// }
//
// class BackgroundImageView extends StatelessWidget {
//   const BackgroundImageView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Image.network(
//         'https://staticg.sportskeeda.com/editor/2021/11/87584-16359620181400-1920.jpg',fit: BoxFit.cover,),
//     );
//   }
// }
//
//
//
//
// class ImageAndVideoItemView extends StatelessWidget {
//   const ImageAndVideoItemView({
//     Key? key,
//     required this.imageLink,
//     required this.videoLink,
//     required this.isImage,
//     required this.isVideo
//   }) : super(key: key);
//   final bool isImage;
//   final bool isVideo;
//   final String imageLink;
//   final String videoLink;
//
//   @override
//   Widget build(BuildContext context) {
//     return PageView(
//       scrollDirection: Axis.horizontal,
//       children: [
//         if(isImage)...[
//           ClipRRect(
//             borderRadius:
//             BorderRadius.circular(kPadSpace10x),
//             child: Image.network(
//               imageLink,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ],
//         if(isVideo)...[
//           FlickManagerVideoWidget(url: videoLink)
//         ]
//
//
//       ],
//     );
//   }
//
// }
//
//
//
// class DescriptionItemView extends StatelessWidget {
//   const DescriptionItemView({
//     Key? key,
//     required this.description
//   }) : super(key: key);
//   final String description;
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       description,
//       maxLines: 6,
//       overflow: TextOverflow.ellipsis,
//       style: const TextStyle(
//         color: Colors.black54,
//       ),
//     );
//   }
// }
//
// class UserNameItemView extends StatelessWidget {
//   const UserNameItemView({
//     Key? key,
//     required this.userName
//   }) : super(key: key);
//   final String userName;
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       userName,
//       style: const TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.w700,
//           fontSize: kFontSize19x),
//     );
//   }
// }
//
// class MyProfileItemView extends StatelessWidget {
//   const MyProfileItemView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: kProfileImageWidthAndHeight,
//       height: kProfileImageWidthAndHeight,
//       decoration: BoxDecoration(
//         image: const DecorationImage(
//           image: NetworkImage('https://static.wikia.nocookie.net/naruto/images/d/de/Boruto_Infobox.png'),
//           fit: BoxFit.cover,
//         ),
//         borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//         border: Border.all(
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }
//
// class CommentItemView extends StatelessWidget {
//   const CommentItemView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.only(left: kPadSpace50x),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const  Icon(Icons.comment,color: Colors.black,),
//             const  SizedBox(
//               width: kPadSpace10x,
//             ),
//             Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     RichText(
//                       maxLines:2,
//                       overflow: TextOverflow.ellipsis,
//                       text: const TextSpan(
//                         text: 'Andy ',
//                         style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),
//                         children:  <TextSpan>[
//                           TextSpan(text: 'I like it very beautiful.',style: TextStyle(color: Colors.black54)),
//                         ],
//                       ),
//                     ),
//                     RichText(
//                       maxLines:2,
//                       overflow: TextOverflow.ellipsis,
//                       text: const TextSpan(
//                         text: 'Rickit ',
//                         style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),
//                         children:  <TextSpan>[
//                           TextSpan(text: 'Where did you get theses?',style: TextStyle(color: Colors.black54)),
//                         ],
//                       ),
//                     )
//                   ],
//                 )
//             )
//           ],
//         )
//
//     );
//   }
// }
//
// class LikesItemView extends StatelessWidget {
//   const LikesItemView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.only(left: kPadSpace50x),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const[
//             Icon(Icons.favorite,color: Colors.black,),
//             SizedBox(
//               width: kPadSpace10x,
//             ),
//             Expanded(
//               child: SizedBox(
//                   child: Text('Thiha Thant Sin, Thomas, Killo, Milopn, Darius, Pillow Willian ',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w700),)),
//             )
//           ],
//         )
//
//     );
//   }
// }
//
//
//
// class DetailsImageAndVideoItemView extends StatelessWidget {
//   const DetailsImageAndVideoItemView({
//     Key? key,
//     required this.postImage,
//     required this.postVideo,
//   }) : super(key: key);
//   final String postImage;
//   final String postVideo;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: kBioTextContainerWidth,
//       child: PageView(
//         children: [
//           if(postImage!=kDefaultImage)...[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(kPadSpace10x),
//               child: Image.network(postImage),
//             ),
//           ],
//           if(postVideo!=kDefaultImage)...[
//             FlickManagerVideoWidget(url:postVideo)
//           ]
//
//         ],
//       ),
//     );
//   }
// }
//
// class DetailsDescriptionItemView extends StatelessWidget {
//   const DetailsDescriptionItemView({
//     Key? key,
//     required this.description
//   }) : super(key: key);
//   final String description;
//   @override
//   Widget build(BuildContext context) {
//     return Text(description,style: const TextStyle(
//         color: Colors.white70
//     ),);
//   }
// }
//
// class DetailsProfileNameItemView extends StatelessWidget {
//   const DetailsProfileNameItemView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Text('Thiha Thant Sin',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: kFontSize17x),);
//   }
// }

class NewMomentsItemView extends StatelessWidget {
  const NewMomentsItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: kPadSpace10x, top: kPadSpace10x),
      child: const Text(
        '23 new moments',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}

class DateTimeItemView extends StatelessWidget {
  const DateTimeItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: kPadSpace10x, top: kPadSpace10x),
      child: Text(
        DateFormat('yMMMMEEEEd').format(DateTime.now()),
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}

class BackgroundImageItemView extends StatelessWidget {
  const BackgroundImageItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Image.network(
        'https://m.media-amazon.com/images/M/MV5BMDFjYTc1ODgtNjRlNi00ZDllLTg3ZGYtMjJlYTA0NjBkYWZlXkEyXkFqcGdeQXRyYW5zY29kZS13b3JrZmxvdw@@._V1_.jpg',
        fit: BoxFit.cover,
        loadingBuilder: (_, child, chuck) {
          if (chuck == null) {
            return child;
          }
          return const WaitingWidget();
        },
      ),
    );
  }
}

class SmallProfileImageItemView extends StatelessWidget {
  const SmallProfileImageItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(
      imageUrl: 'https://static.wikia.nocookie.net/naruto/images/d/de/Boruto_Infobox.png',
      imageBuilder: (context, imageProvider) => Container(
        width: kProfileImageCircleShapeWidth,
        height: kProfileImageCircleShapeWidth,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) =>  const WaitingWidget(),
    );

  }
}

class ProfileNameItemView extends StatelessWidget {
  const ProfileNameItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Uzumaki Boruto',
      style: TextStyle(color: Colors.white, fontSize: kFontSize23x),
    );
  }
}

class MomentDescriptionItemView extends StatelessWidget {
  const MomentDescriptionItemView({
    Key? key,
    required this.description
  }) : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
         Expanded(
          flex: 5,
          child: Text(
            description,
            maxLines: 3,
            style: const TextStyle(
                color: Colors.black38,
                fontSize: kFontSize15x,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }
}

class MomentUploaderNameItemView extends StatelessWidget {
  const MomentUploaderNameItemView({
    Key? key,
    required this.name
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
        ),
         Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: kFontSize21x),
        ),
      ],
    );
  }
}

class FavoriteCommentIconItemView extends StatelessWidget {
  const FavoriteCommentIconItemView({
    Key? key,
    required this.onPressedForFavorite,
    required this.onPressedForComment,
    required this.onEdit,
    required this.onDelete,
    required this.isFavorite,
    this.color=Colors.black38
  }) : super(key: key);
  final Function onPressedForFavorite;
  final Function onPressedForComment;
  final Function onEdit;
  final Function onDelete;
  final bool isFavorite;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () =>onPressedForFavorite(),
            icon:  Icon(
             isFavorite?Icons.favorite: Icons.favorite_border_outlined,
              size: kContactIconSize,
              color: isFavorite?Colors.red:color,
            )),
        const SizedBox(
          width: kPadSpace5x,
        ),
        IconButton(
            onPressed: () =>onPressedForComment(),
            icon:  Icon(
              Icons.comment_outlined,
              size: kContactIconSize,
              color: color,
            )),
        const SizedBox(
          width: kPadSpace5x,
        ),
        PopupMenuButton(
            onSelected: (value){
              if(value==kEditText){
                onEdit();
              }
              if(value==kDeleteText){
                onDelete();
              }
            },
            icon: Icon(Icons.more_horiz,color: color,),
            itemBuilder: (context){
          return [
           const PopupMenuItem(
              value: kEditText,
                child: Text(kEditText)),
           const PopupMenuItem(
                value: kDeleteText,
                child: Text(kDeleteText)),
          ];
        }),

      ],
    );
  }
}

class ImageAndVideoView extends StatelessWidget {
  const ImageAndVideoView({
    Key? key,
    required this.isImage,
    required this.imageURL,
    required this.isVideo,
    required this.videoURL,
  }) : super(key: key);
  final bool isImage;
  final bool isVideo;
  final String imageURL;
  final String videoURL;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kPadSpace10x),
      padding: const EdgeInsets.symmetric(horizontal: kPadSpace10x),
      height: MediaQuery.of(context).size.height * 0.3,
      child: PageView(
        children: [
          if(isImage)...[
            CachedNetworkImage(
              imageUrl: imageURL,
              fit: BoxFit.cover,
              placeholder: (context,placeHolder)=>const WaitingWidget(),
            ),
          ],
          if(isVideo)...[
            FlickManagerVideoWidget(url: videoURL,filePath: '',)
          ]
         
        ],
      ),
    );
  }
}

class WhoLikesItemView extends StatelessWidget {
  const WhoLikesItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        const Expanded(
          flex: 5,
          child: WhoLikesView(),
        ),
      ],
    );
  }
}

class WhoLikesView extends StatelessWidget {
  const WhoLikesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Icon(Icons.favorite),
        SizedBox(
          width: kPadSpace5x,
        ),
        Expanded(
          child: Text(
            'Thiha Thiha Thiha Thiha Thiha Thiha Thiha Thiha Thiha Thiha Thiha Thiha Thiha Thiha Thiha',
            maxLines: 2,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: kFontSize15x,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }
}

class WhoCommentItemView extends StatelessWidget {
  const WhoCommentItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        Expanded(
            flex: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.comment_outlined),
                SizedBox(
                  width: kPadSpace5x,
                ),
                WhoCommentView(),
              ],
            )),
      ],
    );
  }
}

class WhoCommentView extends StatelessWidget {
  const WhoCommentView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: const TextSpan(
              text: 'Align  ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: kFontSize15x,
              ),
              children: [
                TextSpan(
                  text: 'It is really beautiful',
                  style: TextStyle(
                    fontSize: kFontSize13x,
                    color: Colors.black38,
                  ),
                ),
              ]),
        ),
        const SizedBox(
          height: kPadSpace5x,
        ),
        RichText(
          text: const TextSpan(
              text: 'Malivin  ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: kFontSize15x,
              ),
              children: [
                TextSpan(
                  text: 'It is really beautiful. How can i get these?',
                  style: TextStyle(
                    fontSize: kFontSize13x,
                    color: Colors.black38,
                  ),
                ),
              ]),
        )
      ],
    ));
  }
}


class DetailsItemView extends StatelessWidget {
  const DetailsItemView({Key? key, required this.momentVO}) : super(key: key);
  final MomentVO? momentVO;

  @override
  Widget build(BuildContext context) {
    String postImage = momentVO?.postImage ?? '';
    String postVideo = momentVO?.postVideo ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kPadSpace10x),
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DetailsUserNameView(momentVO: momentVO!),
            const SizedBox(
              height: kPadSpace20x,
            ),
            DetailsDescriptionView(momentVO: momentVO!),
            Visibility(
              visible: (postImage.isNotEmpty || postVideo.isNotEmpty),
              child: ImageAndVideoView(
                isImage: postImage.isNotEmpty,
                imageURL: postImage,
                isVideo: postVideo.isNotEmpty,
                videoURL: postVideo,
              ),
            ),
            FavoriteCommentIconItemView(
              onPressedForFavorite: () {},
              onPressedForComment: () {},
              onEdit: () {},
              onDelete: () {},
              isFavorite: momentVO?.isLiked ?? false,
              color: Colors.white70,
            )
          ],
        ),
      ),
    );
  }
}

class DetailsDescriptionView extends StatelessWidget {
  const DetailsDescriptionView({
    Key? key,
    required this.momentVO,
  }) : super(key: key);

  final MomentVO momentVO;

  @override
  Widget build(BuildContext context) {
    return Text(
      momentVO.description,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: kFontSize15x,
      ),
    );
  }
}

class DetailsUserNameView extends StatelessWidget {
  const DetailsUserNameView({
    Key? key,
    required this.momentVO,
  }) : super(key: key);

  final MomentVO momentVO;

  @override
  Widget build(BuildContext context) {
    return Text(
      momentVO.userName,
      style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: kFontSize19x,
          color: Colors.white),
    );
  }
}

class CommentItemView extends StatelessWidget {
  const CommentItemView(
      {Key? key, required this.onSubmitted, required this.prefixText})
      : super(key: key);
  final Function onSubmitted;
  final String prefixText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: kPadSpace50x),
      alignment: Alignment.bottomCenter,
      color: Colors.black.withOpacity(0.8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.chevron_right,
            color: kPrimaryLightColor,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: kPrimaryLightColor))),
              child: TextField(
                style: const TextStyle(color: Colors.white60),
                onSubmitted: (string) => onSubmitted(),
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixText: prefixText,
                    prefixStyle: const TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}