import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/widgets/choose_image_type_widget.dart';
import 'package:wechat_app/widgets/flick_manager_video.dart';
import 'package:wechat_app/widgets/wating_widget.dart';
import 'package:timeago/timeago.dart' as timeago;


class NewMomentsItemView extends StatelessWidget {
  const NewMomentsItemView({
    Key? key,
    required this.moments
  }) : super(key: key);
  final int moments;
  @override
  Widget build(BuildContext context) {
    String textMoments=(moments<=1)?'$moments moment':'$moments moments';
    return Container(
      padding: const EdgeInsets.only(right: kPadSpace10x, top: kPadSpace10x),
      child:  Text(
        textMoments,
        style: const TextStyle(fontWeight: FontWeight.w500),
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
    required this.backgroundImage,
    required this.onTapForBgImage
  }) : super(key: key);
  final String backgroundImage;
  final Function onTapForBgImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTapForBgImage(),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        child: CachedNetworkImage(
          imageUrl: backgroundImage,
          placeholder: (context,string)=>const WaitingWidget(),
          fit: BoxFit.cover,
        )
      ),
    );
  }
}

class SmallProfileImageItemView extends StatelessWidget {
  const SmallProfileImageItemView({
    Key? key,
    required this.image
  }) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(
      imageUrl: image,
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
    required this.profileName
  }) : super(key: key);
  final String profileName;
  @override
  Widget build(BuildContext context) {
    return  Text(
      profileName,
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
    required this.isOriginalUploader,
    this.color=Colors.black38
  }) : super(key: key);
  final Function onPressedForFavorite;
  final Function onPressedForComment;
  final Function onEdit;
  final Function onDelete;
  final bool isFavorite;
  final Color color;
  final bool isOriginalUploader;
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
        Visibility(
          visible: isOriginalUploader,
          child: PopupMenuButton(
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
        ),

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
  const DetailsItemView({Key? key, required this.momentVO,required this.isOriginalUploader}) : super(key: key);
  final MomentVO? momentVO;
  final bool isOriginalUploader;

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


class TimeAgoItemView extends StatelessWidget {
  const TimeAgoItemView({Key? key, required this.dateTime}) : super(key: key);
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    final ago = DateTime.now().subtract(Duration(minutes: dateTime.minute));
    return Text(
      timeago.format(ago, locale: 'en'),
      style: const TextStyle(color: Colors.black38),
    );
  }
}



class BackgroundChooseImageItemView extends StatelessWidget {
  const BackgroundChooseImageItemView({
    Key? key,
    required this.onChooseForTakePhoto,
    required this.onChooseForAlbum,
    required this.onChooseForCancel
  }) : super(key: key);
  final Function onChooseForTakePhoto;
  final Function onChooseForAlbum;
  final Function onChooseForCancel;
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChooseImageTypeWidget(
            color: Colors.black,
            onChoose: ()  {
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