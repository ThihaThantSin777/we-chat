

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_file_details_page_bloc.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/widgets/wating_widget.dart';

import '../widgets/flick_manager_video.dart';

class WeChatFileDetailsPage extends StatelessWidget {
  const WeChatFileDetailsPage({Key? key,required this.imageLink,this.isFile=true}) : super(key: key);
  final String imageLink;
  final bool isFile;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatFileDetailsPageBloc>(
      create: (context)=>WeChatFileDetailsPageBloc(imageLink),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: ()=>navigateBack(context),
            icon: const Icon(Icons.chevron_left,color: Colors.white,),
          ),
        ),
        body: Selector<WeChatFileDetailsPageBloc,String>(
          selector: (context,bloc)=>bloc.getImageLink,
          builder: (context,link,child)=>
         Center(
            child: Hero(
              tag: link.toString(),
              child: isFile?CachedNetworkImage(
                imageUrl: link,
                placeholder: (context,string)=>const WaitingWidget(),
              ):FlickManagerVideoWidget(
                filePath: '',
                url: link,
              )
            ),
          ),
        ),
      ),
    );
  }
}
