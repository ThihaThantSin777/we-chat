import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_chatting_page_bloc.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_user_vo.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/enums.dart';
import 'package:wechat_app/widgets/leading_widget.dart';

import '../view_items/we_chat_chat_history_item_views/we_chat_chat_room_views.dart';

class WeChatChattingRoomPage extends StatelessWidget {
  const WeChatChattingRoomPage({Key? key, required this.title,required this.friID})
      : super(key: key);
  final String title;
  final String friID;
  void chooseImage(
      String text, WeChatChattingPagesBloc bloc) async {
    if (text == kCameraText) {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      bloc.addImage(File(photo?.path.toString() ?? ''));
    } else if (text == kFileText) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.custom,
            allowedExtensions: ['jpg', 'png', 'gif'],);

      if (result != null) {
        File file = File(result.files.single.path ?? '');
        bloc.addImage(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatChattingPagesBloc>(
      create: (context) => WeChatChattingPagesBloc(friID),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(title),
          leadingWidth: kLeadingWidth,
          leading: const LeadingWidget(text: kWeChatTitle),
          actions: [
            IconButton(
                onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.user))
          ],
        ),
        body: Stack(
            children: [
              Selector<WeChatChattingPagesBloc,List<ChattingUserVO>>(
                selector: (context,bloc)=>bloc.getChattingUserVO,
                builder: (context,chatVOList,child){
                  WeChatChattingPagesBloc weChatChattingPagesBloc=context.read<WeChatChattingPagesBloc>();
                  String loggedInUserID=weChatChattingPagesBloc.getLoggedInUserID;
                  if(chatVOList.isEmpty){
                    return Container();
                  }
                  return  ListView.separated(
                    padding: const EdgeInsets.only(top: kPadSpace10x),
                    itemCount: chatVOList.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: (chatVOList[index].userID==loggedInUserID)
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        CircleAvatarProfileItemView(
                          isLeft: chatVOList[index].userID!=loggedInUserID,
                          image: chatVOList[index].profilePic,
                        ),
                        const SizedBox(
                          width: kPadSpace10x,
                        ),
                        ChattingItemView(
                          text: chatVOList[index].message,
                          isLeft: chatVOList[index].userID!=loggedInUserID,
                        )
                      ],
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      height: kPadSpace20x,
                    ),
                  );

                }


              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Selector<WeChatChattingPagesBloc,File?>(
                      selector: (context,bloc)=>bloc.getFile,
                      builder: (context,getFile,child)=>
                   Visibility(
                        visible: (getFile != null),
                        child: Container(
                          color: kBarColor,
                          height: MediaQuery.of(context).size.height * 0.15,
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadSpace10x, vertical: kPadSpace10x),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [

                              Image.file(
                                getFile ?? File(''),
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    onPressed: () {
                                      WeChatChattingPagesBloc
                                      weChatHomePageBloc = context.read<
                                          WeChatChattingPagesBloc>();
                                      weChatHomePageBloc.removeImage();
                                    },
                                    icon: const Icon(Icons.cancel,color: Colors.red,)),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                    Selector<WeChatChattingPagesBloc,ShowMoreIconForm>(
                      selector: (context,bloc)=>bloc.getShowMoreIcon,
                      builder: (context,isShowMoreIcon,child){
                        WeChatChattingPagesBloc weChatChattingPagesBloc=context.read<WeChatChattingPagesBloc>();
                        return  Container(
                          padding: const EdgeInsets.only(top: kPadSpace10x),
                          alignment: Alignment.topCenter,
                          color: kBarColor,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SizedBox(
                                width: kPadSpace5x,
                              ),
                              const Expanded(flex: 1, child: MicroPhoneItemView()),
                              Expanded(
                                flex: 7,
                                child: TextFieldItemView(
                                  onSubmitted: (text){
                                    weChatChattingPagesBloc.sendMessage();
                                  },
                                  onTap: () {
                                    if (weChatChattingPagesBloc.isShowMoreWidget) {
                                      weChatChattingPagesBloc.setIsShowMoreWidgetState();
                                    }
                                  },
                                  onChange: (string) {
                                    weChatChattingPagesBloc
                                        .setIsShowMoreIconState(string);
                                  },
                                ),
                              ),
                              Expanded(
                                child: ShowMoreIconItemView(
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    weChatChattingPagesBloc.setIsShowMoreWidgetState();
                                  },
                                  showMoreIcon: isShowMoreIcon,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                    ),
                    Selector<WeChatChattingPagesBloc,bool>(
                      selector: (context,bloc)=>bloc.isShowMoreWidget,
                      builder: (context,isShoeMoreWidget,child){
                        WeChatChattingPagesBloc weChatChattingPagesBloc=context.read<WeChatChattingPagesBloc>();
                        return  AnimatedSize(
                          duration: kDurationIn500milliseconds,
                          child: Visibility(
                            visible: isShoeMoreWidget,
                            child: ShowMoreItemView(
                              onTap: (string) => chooseImage(string, weChatChattingPagesBloc),
                            ),
                          ),
                        );
                      }

                    ),
                  ],
                ),
              ),
            ],
          )
      )
    );


  }
}
