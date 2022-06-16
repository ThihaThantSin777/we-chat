import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wechat_app/data/vos/show_more_vo/show_more_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/utils/enums.dart';

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
        icon: AnimatedSwitcher(
            // transitionBuilder: (child,animation){
            //   return ScaleTransition(
            //       scale: animation,
            //     child: child,
            //   );
            // },
            key: UniqueKey(),
            duration: kDurationIn500milliseconds,
            child: (showMoreIcon == ShowMoreIconForm.add)
                ? const Icon(Icons.add)
                : (showMoreIcon == ShowMoreIconForm.close)
                    ? const Icon(Icons.close)
                    : const Icon(Icons.send)));
  }
}

class TextFieldItemView extends StatelessWidget {
  const TextFieldItemView(
      {Key? key, required this.onChange, required this.onTap})
      : super(key: key);
  final Function(String) onChange;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: TextField(
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
  const ChattingItemView({Key? key, required this.text, required this.isLeft})
      : super(key: key);
  final String text;
  final bool isLeft;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 200),
      padding: const EdgeInsets.symmetric(
          horizontal: kPadSpace10x, vertical: kPadSpace10x),
      alignment: (isLeft) ? Alignment.topLeft : Alignment.topRight,
      decoration: BoxDecoration(
          color: kBarColor, borderRadius: BorderRadius.circular(kPadSpace20x)),
      child: Text(text),
    );
  }
}

class CircleAvatarProfileItemView extends StatelessWidget {
  const CircleAvatarProfileItemView({Key? key, required this.isLeft,required this.image})
      : super(key: key);
  final bool isLeft;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isLeft,
        child:  CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
              image),
        ));
  }
}