import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/data/vos/add_post_vo/add_post_vo.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/widgets/video_player_widget.dart';

class PostTextFieldView extends StatelessWidget {
  const PostTextFieldView(
      {Key? key, required this.formState, required this.onChanged,this.preText=''})
      : super(key: key);
  final GlobalKey<FormState> formState;
  final Function(String) onChanged;
  final String preText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kPadSpace10x, vertical: kPadSpace10x),
      child: Form(
          key: formState,
          child: TextFormField(
            controller: TextEditingController(text: preText),
            onChanged: (string) => onChanged(string),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (string) {
              if (string?.isEmpty ?? true) {
                return 'required';
              }
              return null;
            },
            maxLines: null,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: 'What is in your mind?'),
          )),
    );
  }
}

class ProfileItemView extends StatelessWidget {
  const ProfileItemView({Key? key, required this.onPressed}) : super(key: key);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')),
      title: const Text('Thiha Thant Sin'),
      trailing: IconButton(
          onPressed: () => onPressed(), icon: const Icon(Icons.open_with)),
    );
  }
}

class PhotoAndVideosChooseItemView extends StatelessWidget {
  const PhotoAndVideosChooseItemView({Key? key, required this.onTap})
      : super(key: key);
  final Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kPadSpace20x),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: addPostVoList
              .map(
                (data) => Expanded(
                  child: ListTile(
                    onTap: () => onTap(data.name),
                    minLeadingWidth: 0,
                    contentPadding: const EdgeInsets.all(0),
                    leading: data.icon,
                    title: Text(data.name),
                  ),
                ),
              )
              .toList()),
    );
  }
}

class VideoItemView extends StatelessWidget {
  const VideoItemView(
      {Key? key, required this.videoPlayerController, required this.onPressed})
      : super(key: key);
  final VideoPlayerController videoPlayerController;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: VideoPlayer(videoPlayerController)),
      IconButton(
          onPressed: () => onPressed(),
          icon: const Icon(
            Icons.cancel,
            color: Colors.red,
          ))
    ]);
  }
}


class MyBackgroundItemView extends StatelessWidget {
  const MyBackgroundItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yMMMMEEEEd');
    final String formatted = formatter.format(now);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: const[
            BackgroundImageView(),
            Positioned.fill(
              bottom: kPadSpace10x,
              right: kPadSpace10x,
              child:  Align(
                  alignment: Alignment.bottomRight,
                  child:  ProfileNameView()),
            ),
          ],
        ),
        const SizedBox(
          height: kPadSpace20x,
        ),
        Padding(
          padding:  const EdgeInsets.only(right: kPadSpace10x),
          child:  Text(formatted,style: const TextStyle(fontWeight: FontWeight.w700),),
        ),
        const Padding(
          padding:  EdgeInsets.only(right: kPadSpace10x),
          child:  Text('23 new moments',style: TextStyle(fontWeight: FontWeight.w700),),
        )
      ],
    );
  }
}

class ProfileNameView extends StatelessWidget {
  const ProfileNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Thiha Thant Sin',style: TextStyle(color: Colors.white,fontSize: kFontSize17x,fontWeight: FontWeight.bold),);
  }
}

class BackgroundImageView extends StatelessWidget {
  const BackgroundImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.network(
        'https://staticg.sportskeeda.com/editor/2021/11/87584-16359620181400-1920.jpg',fit: BoxFit.cover,),
    );
  }
}




class ImageAndVideoItemView extends StatelessWidget {
  const ImageAndVideoItemView({
    Key? key,
    required this.imageLink,
    required this.videoLink,
    required this.isImage,
    required this.isVideo
  }) : super(key: key);
  final bool isImage;
  final bool isVideo;
  final String imageLink;
  final String videoLink;

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: [
        if(isImage)...[
          ClipRRect(
            borderRadius:
            BorderRadius.circular(kPadSpace10x),
            child: Image.network(
              imageLink,
              fit: BoxFit.cover,
            ),
          ),
        ],
        if(isVideo)...[
          VideoPlayerWidget(url: videoLink)

        ]


      ],
    );
  }

}



class DescriptionItemView extends StatelessWidget {
  const DescriptionItemView({
    Key? key,
    required this.description
  }) : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black54,
      ),
    );
  }
}

class UserNameItemView extends StatelessWidget {
  const UserNameItemView({
    Key? key,
    required this.userName
  }) : super(key: key);
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Text(
      userName,
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: kFontSize19x),
    );
  }
}

class MyProfileItemView extends StatelessWidget {
  const MyProfileItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kProfileImageWidthAndHeight,
      height: kProfileImageWidthAndHeight,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage('https://static.wikia.nocookie.net/naruto/images/d/de/Boruto_Infobox.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(
          color: Colors.black,
        ),
      ),
    );
  }
}

class CommentItemView extends StatelessWidget {
  const CommentItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: kPadSpace50x),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const  Icon(Icons.comment,color: Colors.black,),
            const  SizedBox(
              width: kPadSpace10x,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      maxLines:2,
                      overflow: TextOverflow.ellipsis,
                      text: const TextSpan(
                        text: 'Andy ',
                        style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),
                        children:  <TextSpan>[
                          TextSpan(text: 'I like it very beautiful.',style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ),
                    RichText(
                      maxLines:2,
                      overflow: TextOverflow.ellipsis,
                      text: const TextSpan(
                        text: 'Rickit ',
                        style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),
                        children:  <TextSpan>[
                          TextSpan(text: 'Where did you get theses?',style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    )
                  ],
                )
            )
          ],
        )

    );
  }
}

class LikesItemView extends StatelessWidget {
  const LikesItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: kPadSpace50x),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const[
            Icon(Icons.favorite,color: Colors.black,),
            SizedBox(
              width: kPadSpace10x,
            ),
            Expanded(
              child: SizedBox(
                  child: Text('Thiha Thant Sin, Thomas, Killo, Milopn, Darius, Pillow Willian ',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w700),)),
            )
          ],
        )

    );
  }
}



class DetailsImageAndVideoItemView extends StatelessWidget {
  const DetailsImageAndVideoItemView({
    Key? key,
    required this.postImage,
    required this.postVideo,
  }) : super(key: key);
  final String postImage;
  final String postVideo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBioTextContainerWidth,
      child: PageView(
        children: [
          if(postImage!=kDefaultImage)...[
            ClipRRect(
              borderRadius: BorderRadius.circular(kPadSpace10x),
              child: Image.network(postImage),
            ),
          ],
          if(postVideo!=kDefaultImage)...[
            VideoPlayerWidget(url:postVideo)
          ]

        ],
      ),
    );
  }
}

class DetailsDescriptionItemView extends StatelessWidget {
  const DetailsDescriptionItemView({
    Key? key,
    required this.description
  }) : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    return Text(description,style: const TextStyle(
        color: Colors.white70
    ),);
  }
}

class DetailsProfileNameItemView extends StatelessWidget {
  const DetailsProfileNameItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Thiha Thant Sin',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: kFontSize17x),);
  }
}