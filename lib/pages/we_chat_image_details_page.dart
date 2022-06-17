

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_image_details_page_bloc.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

class WeChatImageDetailsPage extends StatelessWidget {
  const WeChatImageDetailsPage({Key? key,required this.imageLink}) : super(key: key);
  final String imageLink;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatImageDetailsPageBloc>(
      create: (context)=>WeChatImageDetailsPageBloc(imageLink),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: ()=>navigateBack(context),
            icon: const Icon(Icons.chevron_left,color: Colors.white,),
          ),
        ),
        body: Selector<WeChatImageDetailsPageBloc,String>(
          selector: (context,bloc)=>bloc.getImageLink,
          builder: (context,imageLink,child)=>
         Center(
            child: Hero(
              tag: imageLink,
              child: CachedNetworkImage(
                imageUrl: imageLink,
                placeholder: (context,string)=>const WaitingWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
