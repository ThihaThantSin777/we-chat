import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_home_page_bloc.dart';
import 'package:wechat_app/pages/we-chat_profile_page.dart';
import 'package:wechat_app/pages/we_chat_chat_history_page.dart';
import 'package:wechat_app/pages/we_chat_contact_page.dart';
import 'package:wechat_app/pages/we_chat_discover_page.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';

class WeChatHomePage extends StatelessWidget {
  const WeChatHomePage({Key? key,this.pageIndex=0}) : super(key: key);
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatHomePageBloc>(
      create: (context) => WeChatHomePageBloc(pageIndex),
      child: Selector<WeChatHomePageBloc, int>(
          selector: (context, bloc) => bloc.getPageIndex,
          builder: (context, pageIndex, child) {
            ///Declare Object
            WeChatHomePageBloc weChatHomePageBloc =
                context.read<WeChatHomePageBloc>();

            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: (pageIndex == kProfilePageIndex)
                  ? null
                  : _buildAppBar(pageIndex),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: pageIndex,
                onTap: (pageIndex) =>
                    changePageIndex(pageIndex, context, weChatHomePageBloc),
                items: const [
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.commentDots),
                      label: kWeChatAppName),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.addressBook),
                      label: kContactText),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.eye), label: kDiscoverText),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.user), label: kProfileText),
                ],
              ),
              body: _buildBody(pageIndex),
            );
          }),
    );
  }

  void changePageIndex(int pageIndex, BuildContext context,
      WeChatHomePageBloc weChatHomePageBloc) {
    if (pageIndex == kDiscoverPageIndex) {
      navigatePush(context, const WeChatDiscoverPage());
    } else {
      weChatHomePageBloc.pagesChanges(pageIndex);
    }
  }

  Widget _buildBody(int pageIndex) {
    switch (pageIndex) {
      case kChatHistoryPageIndex:
        return const WeChatChatHistoryPage();
      case kContactPageIndex:
        return const WeChatContactPage();
      case kProfilePageIndex:
        return const WeChatProfilePage();
      default:
        return Container();
    }
  }

  AppBar _buildAppBar(int pageIndex) {
    switch (pageIndex) {
      case kChatHistoryPageIndex:
        return AppBar(
          title: const Text(kWeChatAppName),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        );
      default:
        return AppBar(
          title: const Text(kContactTitle),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.person_add))
          ],
        );
    }
  }
}
