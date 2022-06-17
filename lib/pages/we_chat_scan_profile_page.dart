import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_scan_profile_page_bloc.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/pages/we_chat_home_page.dart';
import 'package:wechat_app/pages/we_chat_qr_code_page.dart';
import 'package:wechat_app/utils/enums.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/view_items/we_chat_qr_code_item_views/we_chat_qr_codeitem_view.dart';
import 'package:wechat_app/widgets/loading_widget.dart';

import '../widgets/wating_widget.dart';

class WeChatScanProfilePage extends StatelessWidget {
  const WeChatScanProfilePage({Key? key,required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatScanProfilePageBloc>(
        create: (context)=>WeChatScanProfilePageBloc(id),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Selector<WeChatScanProfilePageBloc,UserVO?>(
            selector: (context,bloc)=>bloc.getUserVO,
            builder: (context,userVO,child){
              WeChatScanProfilePageBloc weChatScanProfilePageBloc=context.read<WeChatScanProfilePageBloc>();
              return  Center(
                child:(userVO==null)?const WaitingWidget():
                Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                            color: Colors.white,
                            child: (userVO.id!=null)?
                            Selector<WeChatScanProfilePageBloc,bool>(
                              selector: (context,bloc)=>bloc.isAlreadyFri,
                              builder: (context,isAlreadyFri,child)=>
                              ScanProfileSuccessItemView(
                                isAlreadyFri: isAlreadyFri,
                                userVO: userVO,
                                onCancel: (){
                                  navigatePushRemoveUntil(context,const WeChatQRCodePage());
                                },
                                onAdd: (){
                                  weChatScanProfilePageBloc.addFriend().then((value) {
                                    navigatePushReplacement(context,  WeChatHomePage(
                                      pageIndex: WeChatPages.contactPage.index,
                                    ));
                                  });
                                },
                              ),
                            ):ScanProfileUnSuccessItemView(
                                onPressed: ()=> navigatePushReplacement(context,const WeChatQRCodePage())
                            )

                        ),
                      ],
                    ),
                    Selector<WeChatScanProfilePageBloc,bool>(
                      selector: (context,bloc)=>bloc.isLoading,
                      builder: (context,loading,child)=>
                     Visibility(
                          visible: loading,
                       child: const LoadingWidget(),
                      ),
                    )
                  ],
                ),
              );
            }

          )
          ),

    );
  }
}
