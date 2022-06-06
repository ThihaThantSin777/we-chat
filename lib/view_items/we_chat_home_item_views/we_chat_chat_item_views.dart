import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wechat_app/bloc/we_chat_home_page_bloc.dart';
import 'package:wechat_app/data/vos/show_more_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';

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
  const TextFieldItemView({Key? key, required this.onChange}) : super(key: key);
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.05,
        child: TextField(
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
  }) : super(key: key);

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
                      onTap: () async {
                        if (data.text == kFileText ||
                            data.text == kCameraText) {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: data.text == kFileText
                                ? FileType.image
                                : FileType.custom,
                          );

                          if (result != null) {
                            File file = File(result.files.single.path ?? '');
                            print(file);
                          } else {
                            // User canceled the picker
                          }
                        }
                      },
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
