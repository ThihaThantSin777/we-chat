import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/bloc/we_chat_qr_code_page_bloc.dart';
import 'package:wechat_app/bloc/we_chat_scan_profile_page_bloc.dart';
import 'package:wechat_app/data/vos/user_vo/user_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/widgets/wating_widget.dart';



class ScanProfileUnSuccessItemView extends StatelessWidget {
  const ScanProfileUnSuccessItemView({
    Key? key,
    required this.onPressed
  }) : super(key: key);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Container(
          alignment: Alignment.topLeft,
          child: ScanProfileUnSuccessCancelButtonItemView(
            onPressed: ()=> onPressed(),
          ),
        ),
        const   Icon(Icons.sentiment_dissatisfied_outlined,color: kPrimaryLightColor,size: kPadSpace50x,),
        const   SizedBox(
          height: kPadSpace10x,
        ),
        const  Text('This user is not register in the server',style: TextStyle(
            fontSize: kFontSize23x
        ),),
        const   SizedBox(
          height: kPadSpace10x,
        ),
      ],
    );
  }
}

class ScanProfileUnSuccessCancelButtonItemView extends StatelessWidget {
  const ScanProfileUnSuccessCancelButtonItemView({
    Key? key,
    required this.onPressed
  }) : super(key: key);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ()=>onPressed(),
      icon: const Icon(Icons.cancel,color: Colors.red,size: kPadSpace30x,),
    );
  }
}

class ScanProfileSuccessItemView extends StatelessWidget {
  const ScanProfileSuccessItemView({
    Key? key,
    required this.userVO,
    required this.onCancel,
    required this.onAdd,
    required this.isAlreadyFri
  }) : super(key: key);
  final UserVO ? userVO;
  final Function onCancel;
  final Function onAdd;
  final bool isAlreadyFri;
  @override
  Widget build(BuildContext context) {
    String image=(userVO?.profileImage?.isEmpty??true)?kDefaultImage:userVO?.profileImage??'';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScanProfileImageItemView(
          imageURL: image,
        ),
        const SizedBox(
          height: kPadSpace10x,
        ),
        ScanProfileNameItemView(
          name: userVO?.userName??'None',
        ),
        const SizedBox(
          height: kPadSpace10x,
        ),
        Visibility(
          visible: !isAlreadyFri,
          child: ScanProfileCancelOrAddItemView(
            onAdd: ()=>onAdd(),
            onCancel: (){
             onCancel();
            },
          ),
        ),
        Visibility(
          visible: isAlreadyFri,
          child: Text('${userVO?.userName} is already in your contact. '),
        )
      ],
    );
  }
}

class ScanProfileCancelOrAddItemView extends StatelessWidget {
  const ScanProfileCancelOrAddItemView({
    Key? key,
    required this.onAdd,
    required this.onCancel,
  }) : super(key: key);
  final Function onCancel;
  final Function onAdd;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: ()=>onCancel(), icon: const Icon(Icons.cancel,color: Colors.red,size: kPadSpace40x,)),
        const SizedBox(
          width: kPadSpace40x,
        ),
        IconButton(onPressed: ()=>onAdd(), icon: const Icon(Icons.person_add,color: kPrimaryLightColor,size: kPadSpace40x,)),

      ],
    );
  }
}

class ScanProfileNameItemView extends StatelessWidget {
  const ScanProfileNameItemView({
    Key? key,
    required this.name
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Text(name,style: const TextStyle(
        fontSize: kFontSize23x
    ),);
  }
}

class ScanProfileImageItemView extends StatelessWidget {
  const ScanProfileImageItemView({
    Key? key,
    required this.imageURL
  }) : super(key: key);
  final String imageURL;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:imageURL,
      imageBuilder: (context, imageProvider) => Container(
        width: MediaQuery.of(context).size.width*0.3,
        height: MediaQuery.of(context).size.height*0.2,
        margin: const EdgeInsets.only(left: kPadSpace10x),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider),
        ),
      ),
      placeholder: (context,string)=>const WaitingWidget(),
    );
  }
}