import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

class SmallProfileWidget extends StatelessWidget {
  const SmallProfileWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.imageURL
  }) : super(key: key);
  final double width;
  final double height;
  final String imageURL;
  @override
  Widget build(BuildContext context) {
    return
      CachedNetworkImage(
      imageUrl: imageURL,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
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
