import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/resources/dimension.dart';

class SubMessageItemView extends StatelessWidget {
  const SubMessageItemView({Key? key, required this.subMessage})
      : super(key: key);
  final String subMessage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: kSubMessageShowHeight,
        child: Text(
          subMessage,
          maxLines: kMaxLines,
          style: const TextStyle(color: Colors.black38),
          overflow: TextOverflow.ellipsis,
        ));
  }
}

class ReceiveTimeItemView extends StatelessWidget {
  const ReceiveTimeItemView({Key? key, required this.time}) : super(key: key);
  final String time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kPadSpace10x),
      child: Text(
        time,
        style: const TextStyle(color: Colors.black38),
      ),
    );
  }
}

class UserNameItemView extends StatelessWidget {
  const UserNameItemView({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: kFontSize17x),
    );
  }
}

class ProfileItemView extends StatelessWidget {
  const ProfileItemView({Key? key, required this.imageURL}) : super(key: key);
  final String imageURL;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      imageBuilder: (context, imageProvider) => Container(
        width: kPadSpace50x,
        height: kPadSpace50x,
        margin: const EdgeInsets.only(left: kPadSpace10x),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
