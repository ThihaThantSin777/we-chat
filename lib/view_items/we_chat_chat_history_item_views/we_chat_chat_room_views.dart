import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wechat_app/data/vos/show_more_vo/show_more_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/enums.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

class ShowMoreIconItemView extends StatelessWidget {
  const ShowMoreIconItemView(
      {Key? key, required this.showMoreIcon, required this.onPressed})
      : super(key: key);
  final ShowMoreIconForm showMoreIcon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onPressed(),
        icon: AnimatedCrossFade(
          duration: kDurationIn500milliseconds,
          firstChild: const Icon(Icons.add),
          secondChild: const Icon(Icons.close),
          crossFadeState: (showMoreIcon == ShowMoreIconForm.add)
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ));
  }
}

class TextFieldItemView extends StatelessWidget {
  const TextFieldItemView(
      {Key? key,
      required this.onChange,
      required this.onTap,
      required this.onSubmitted,
      required this.textEditingController})
      : super(key: key);
  final Function(String) onChange;
  final Function onTap;
  final Function(String) onSubmitted;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: TextField(
      controller: textEditingController,
      textInputAction: TextInputAction.send,
      maxLines: null,
      onSubmitted: (text) => onSubmitted(text),
      onTap: () => onTap(),
      onChanged: (string) => onChange(string),
      decoration: InputDecoration(
          hintText: 'Message...',
          suffixIcon: const Icon(Icons.sentiment_satisfied_outlined),
          fillColor: Colors.white60,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kPadSpace10x))),
    ));
  }
}

class MicroPhoneItemView extends StatelessWidget {
  const MicroPhoneItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FaIcon(
      FontAwesomeIcons.microphone,
      size: kMicrophoneIconSize,
      color: Colors.black54,
    );
  }
}

class ShowMoreItemView extends StatelessWidget {
  const ShowMoreItemView({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: kPadSpace10x),
        width: double.infinity,
        color: kShoeMoreColor,
        height: MediaQuery.of(context).size.height * 0.26,
        child: GridView.count(
            crossAxisCount: 4,
            children: showMoreVOList
                .map((data) => GestureDetector(
                      onTap: () => onTap(data.text),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          data.icon,
                          const SizedBox(
                            height: kPadSpace10x,
                          ),
                          Text(data.text)
                        ],
                      ),
                    ))
                .toList()));
  }
}

class ChattingItemView extends StatelessWidget {
  const ChattingItemView(
      {Key? key,
      required this.text,
      required this.isLeft,
      required this.imageLink,
      required this.onImageDetailsPage})
      : super(key: key);
  final String text;
  final bool isLeft;
  final String imageLink;
  final Function(String) onImageDetailsPage;

  @override
  Widget build(BuildContext context) {
    int textLength = text.length;
    return Column(
      crossAxisAlignment:
          (isLeft) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: const EdgeInsets.all(kPadSpace10x),
            alignment: Alignment.center,
            width: textLength < kPadSpace20x
                ? kProfileImageWidthAndHeight
                : kMaterialButtonWidth,
            height: textLength < kPadSpace20x ? kPadSpace50x : null,
            decoration: BoxDecoration(
                color: kBarColor,
                borderRadius: BorderRadius.circular(kPadSpace10x)),
            child: Text(text)),
        const SizedBox(
          height: kPadSpace10x,
        ),
        Visibility(
          visible: imageLink.isNotEmpty,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: kProfileImageWidthAndHeight,
            child: GestureDetector(
              onTap: () => onImageDetailsPage(imageLink),
              child: Hero(
                tag: imageLink,
                child: CachedNetworkImage(
                  imageUrl: imageLink,
                  imageBuilder: (context, imageProvider) => Container(
                    width: kPadSpace50x,
                    height: kPadSpace50x,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kPadSpace10x),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, string) => const WaitingWidget(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CircleAvatarProfileItemView extends StatelessWidget {
  const CircleAvatarProfileItemView(
      {Key? key, required this.isLeft, required this.image})
      : super(key: key);
  final bool isLeft;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isLeft,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(image),
        ));
  }
}
