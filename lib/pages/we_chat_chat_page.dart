import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_home_page_bloc.dart';
import 'package:wechat_app/data/vos/chatting_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/view_items/we_chat_home_item_views/we_chat_chat_item_views.dart';
import 'package:wechat_app/widgets/leading_widget.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

class WeChatChatPage extends StatelessWidget {
  const WeChatChatPage({Key? key, required this.title}) : super(key: key);
  final String title;
  void chooseImage(String text, WeChatHomePageBloc bloc) async {
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
    return ChangeNotifierProvider<WeChatHomePageBloc>(
      create: (context) => WeChatHomePageBloc(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(title),
          leadingWidth: kLeadingWidth,
          leading: const LeadingWidget(text: 'We chat'),
          actions: [
            IconButton(
                onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.user))
          ],
        ),
        body: Stack(
          children: [
            Selector<WeChatHomePageBloc, List<ChattingVO>>(
                selector: (context, bloc) => bloc.getChattingVOList,
                builder: (context, chatVoList, child) => (chatVoList.isEmpty)
                    ? const WaitingWidget()
                    : ListView.separated(
                        padding: const EdgeInsets.only(top: kPadSpace10x),
                        itemCount: chatVoList.length,
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: (chatVoList[index].isLeft)
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            CircleAvatarProfileItemView(
                              isLeft: chatVoList[index].isLeft,
                            ),
                            const SizedBox(
                              width: kPadSpace10x,
                            ),
                            ChattingItemView(
                              text: chatVoList[index].text,
                              isLeft: chatVoList[index].isLeft,
                            )
                          ],
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: kPadSpace20x,
                        ),
                      )),
            Consumer<WeChatHomePageBloc>(builder: (context, bloc, child) {
              WeChatHomePageBloc weChatHomePageBloc =
                  context.read<WeChatHomePageBloc>();
              return Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Selector<WeChatHomePageBloc, File?>(
                        selector: (context, bloc) => bloc.getFile,
                        builder: (context, file, child) {
                          return Visibility(
                            visible: (file != null),
                            child: Container(
                              color: kBarColor,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.15,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadSpace10x,
                                  vertical: kPadSpace10x),
                              child: Stack(
                                children: [
                                  Image.file(
                                    file ?? File(''),
                                    fit: BoxFit.cover,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          WeChatHomePageBloc
                                              weChatHomePageBloc = context
                                                  .read<WeChatHomePageBloc>();
                                          weChatHomePageBloc.removeImage();
                                        },
                                        icon: const Icon(Icons.close)),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
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
                          // const SizedBox(
                          //   width: kPadSpace10x,
                          // ),
                          Expanded(
                            flex: 7,
                            child: TextFieldItemView(
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
                              showMoreIcon: bloc.getShowMoreIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedSize(
                      duration: kDurationIn500milliseconds,
                      child: Visibility(
                        visible: bloc.isShowMoreWidget,
                        child: ShowMoreItemView(
                          onTap: (string) => chooseImage(string, bloc),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
