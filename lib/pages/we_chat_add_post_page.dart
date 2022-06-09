import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_add_post_page_bloc.dart';
import 'package:wechat_app/resources/dimension.dart';

class WeChatAddPostPage extends StatelessWidget {
  const WeChatAddPostPage({Key? key, this.id = -1}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatAddPostPageBloc>(
      create: (context) => WeChatAddPostPageBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: Text((id == -1) ? 'Add Post' : 'Edit Post'),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
            actions: [
              GestureDetector(
                  onTap: () {},
                  child: Center(child: Text((id == -1) ? 'POST' : 'EDIT'))),
              const SizedBox(
                width: kPadSpace10x,
              ),
            ],
          ),
          body: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: kPadSpace10x),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ProfileItemView(),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Selector<WeChatAddPostPageBloc, bool>(
                    selector: (context, bloc) => bloc.isShowBottomSheet,
                    builder: (context, isShowMoreButtonSheet, child) =>
                        Visibility(
                            visible: isShowMoreButtonSheet,
                            child: const PhotoAndVideosChooseItemView()),
                  )),

            ],
          )),
    );
  }
}

class ProfileItemView extends StatelessWidget {
  const ProfileItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeChatAddPostPageBloc weChatAddPostPageBloc =
        context.read<WeChatAddPostPageBloc>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ListTile(
          leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')),
          title: Text('Thiha Thant Sin'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kPadSpace10x, vertical: kPadSpace10x),
          child: Form(
              child: TextFormField(
            onFieldSubmitted: (string) {
              weChatAddPostPageBloc.setShowBottomSheetState(true);
            },
            onTap: () {
              weChatAddPostPageBloc.setShowBottomSheetState(false);
            },
            decoration:
                const InputDecoration(hintText: 'What is in your mind?'),
          )),
        ),
        Expanded(
          child: ListView(
            children: [
              Container(
                height: 200,
                color: Colors.red,
              )
            ],
          )
        )
      ],
    );
  }
}

class PhotoAndVideosChooseItemView extends StatelessWidget {
  const PhotoAndVideosChooseItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.42,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              spreadRadius: 3,
              offset: Offset(0, -1),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () async{
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                File file = File(result.files.single.path??'');
                print(file);
              } else {
                print('None');
              }
            },
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.all(0),
            leading: const Icon(
              Icons.photo,
              color: Colors.green,
            ),
            title: const Text('Photos'),
          ),
          ListTile(
            onTap: () {},
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.all(0),
            leading: const Icon(
              Icons.video_call,
              color: Colors.orange,
            ),
            title: const Text('Vidos'),
          ),
          ListTile(
            onTap: () {},
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.all(0),
            leading: const FaIcon(
              FontAwesomeIcons.userTag,
              color: Colors.blue,
              size: 20,
            ),
            title: const Text('Tag Peoples'),
          ),
          ListTile(
            onTap: () {},
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.all(0),
            leading: const Icon(
              Icons.sentiment_satisfied_outlined,
              color: Colors.amber,
            ),
            title: const Text('Feelings/Activity'),
          ),
          ListTile(
            onTap: () {},
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.all(0),
            leading: const Icon(
              Icons.location_on,
              color: Colors.red,
            ),
            title: const Text('Check in'),
          ),
          ListTile(
            onTap: () {},
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.all(0),
            leading: const Icon(
              Icons.videocam,
              color: Colors.red,
            ),
            title: const Text('Live videos'),
          ),
        ],
      ),
    );
  }
}
