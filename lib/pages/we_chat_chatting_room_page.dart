import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_chatting_and_chat_history_pages_bloc.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/enums.dart';
import 'package:wechat_app/view_items/we_chat_home_item_views/we_chat_chat_item_views.dart';
import 'package:wechat_app/widgets/leading_widget.dart';

class WeChatChattingRoomPage extends StatelessWidget {
  const WeChatChattingRoomPage({Key? key, required this.title})
      : super(key: key);
  final String title;

  void chooseImage(
      String text, WeChatChattingAndChatHistoryPagesBloc bloc) async {
    if (text == kCameraText) {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      bloc.addImage(File(photo?.path.toString() ?? ''));
    } else if (text == kFileText) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.any);

      if (result != null) {
        File file = File(result.files.single.path ?? '');
        bloc.addImage(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatChattingAndChatHistoryPagesBloc>(
      create: (context) => WeChatChattingAndChatHistoryPagesBloc(),
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
        body: Consumer<WeChatChattingAndChatHistoryPagesBloc>(
            builder: (context, bloc, child) {
          ///Declare Object
          WeChatChattingAndChatHistoryPagesBloc weChatHomePageBloc =
              context.read<WeChatChattingAndChatHistoryPagesBloc>();

          ///Local State Variable
          List<ChattingVO> chatVOList = bloc.getChattingVOList;
          File? getFile = bloc.getFile;
          ShowMoreIconForm isShowMoreIcon = bloc.getShowMoreIcon;
          bool isShoeMoreWidget = bloc.isShowMoreWidget;
          return Stack(
            children: [
              ListView.separated(
                padding: const EdgeInsets.only(top: kPadSpace10x),
                itemCount: chatVOList.length,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: (chatVOList[index].isLeft)
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    CircleAvatarProfileItemView(
                      isLeft: chatVOList[index].isLeft,
                    ),
                    const SizedBox(
                      width: kPadSpace10x,
                    ),
                    ChattingItemView(
                      text: chatVOList[index].text,
                      isLeft: chatVOList[index].isLeft,
                    )
                  ],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: kPadSpace20x,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: (getFile != null),
                      child: Container(
                        color: kBarColor,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.15,
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPadSpace10x, vertical: kPadSpace10x),
                        child: Stack(
                          children: [
                            Image.file(
                              getFile ?? File(''),
                              fit: BoxFit.cover,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    WeChatChattingAndChatHistoryPagesBloc
                                        weChatHomePageBloc = context.read<
                                            WeChatChattingAndChatHistoryPagesBloc>();
                                    weChatHomePageBloc.removeImage();
                                  },
                                  icon: const Icon(Icons.close)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
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
                              onTap: () {
                                if (weChatHomePageBloc.isShowMoreWidget) {
                                  weChatHomePageBloc.setIsShowMoreWidgetState();
                                }
                              },
                              onChange: (string) {
                                weChatHomePageBloc
                                    .setIsShowMoreIconState(string);
                              },
                            ),
                          ),
                          Expanded(
                            child: ShowMoreIconItemView(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                bloc.setIsShowMoreWidgetState();
                              },
                              showMoreIcon: isShowMoreIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedSize(
                      duration: kDurationIn500milliseconds,
                      child: Visibility(
                        visible: isShoeMoreWidget,
                        child: ShowMoreItemView(
                          onTap: (string) => chooseImage(string, bloc),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
