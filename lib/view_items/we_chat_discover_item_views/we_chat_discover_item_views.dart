import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/add_post_vo.dart';
import 'package:wechat_app/resources/dimension.dart';

class PostTextFieldView extends StatelessWidget {
  const PostTextFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kPadSpace10x, vertical: kPadSpace10x),
      child: Form(
          child: TextFormField(
        maxLines: 10,
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
