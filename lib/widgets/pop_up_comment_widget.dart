import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_discover_page_bloc.dart';
import 'package:wechat_app/pages/we_chat_add_post_page.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/utils/extension.dart';

class PopUpCommentWidget extends StatelessWidget {
  const PopUpCommentWidget(
      {Key? key,
        this.color = Colors.black54,
        this.id = '-1'})
      : super(key: key);
  final Color color;
  final String id;

  void delete(WeChatDiscoverPageBloc weChatDiscoverPageBloc, String id,
      BuildContext context) {
    weChatDiscoverPageBloc
        .deletePost(id)
        .then((_) => showSnackBar(context, '1 Post is deleted'));
  }

  void edit(WeChatDiscoverPageBloc weChatDiscoverPageBloc, String id,
      BuildContext context) {
    navigateBack(context);

    navigatePush(
        context,
        WeChatAddPostPage(
          id: id,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeChatDiscoverPageBloc>(
      builder: (context,bloc,child)=>
     PopupMenuButton(
              icon: Icon(
                Icons.more_horiz,
                size: kPadSpace40x,
                color: color,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () => edit(context.read<WeChatDiscoverPageBloc>(), id, context),
                  child: const Text('Edit'),
                ),
                PopupMenuItem(
                  child: const Text('Delete'),
                  onTap: () => delete(context.read<WeChatDiscoverPageBloc>(), id, context),
                ),
              ]
      ),
    );


  }
}
