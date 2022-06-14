
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/utils/methods.dart';
import 'package:wechat_app/view_items/we_chat_discover_item_views/we_chat_add_post_item_views.dart';
import 'package:wechat_app/widgets/loading_widget.dart';
import '../bloc/we_chat_add_post_page_bloc.dart';

class WeChatAddPostPage extends StatelessWidget {
  WeChatAddPostPage({Key? key, this.id = -1}) : super(key: key);
  final int id;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatAddPostPageBloc>(
      create: (context) => WeChatAddPostPageBloc((id == -1)?null:id),
      child: Consumer<WeChatAddPostPageBloc>(
          builder: (context, bloc, child) {
            return    Scaffold(
              appBar: AppBar(
                title: Text((id == -1) ? 'Add Post' : 'Edit Post'),
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
                actions: [
                  GestureDetector(
                      onTap: () => post(bloc, id, context, formKey),
                      child: Center(child: Text((id == -1) ? 'POST' : 'EDIT'))),

                  const SizedBox(
                    width: kPadSpace10x,
                  ),
                ],
              ),
              body:  Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: kPadSpace10x),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ProfileItemView(
                              onPressed: () {
                                openBottomSheet(context, bloc);
                              },
                            ),
                            PostTextFieldView(
                                formState: formKey,
                                onChanged: (string) => changeDescription(
                                    string,
                                    context.read<WeChatAddPostPageBloc>()),
                                controller: bloc.getController??TextEditingController()),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadSpace20x,
                                    vertical: kPadSpace20x),
                                child: ListView(
                                  children: [
                                    addOrEditVideo(bloc),
                                    const SizedBox(
                                      height: kPadSpace20x,
                                    ),
                                    addOrEditImage(bloc),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        )),
                  ),
                  Visibility(visible: bloc.isLoading, child: const LoadingWidget()),
                ],
              ),

            );
          }

      ),
    );
  }
}
