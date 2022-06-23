import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/show_more_vo/show_more_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';

class ProfileNameAndQrScanItemView extends StatelessWidget {
  const ProfileNameAndQrScanItemView({
    Key? key,
    required this.onTap,
    required this.id,
    required this.name
  }) : super(key: key);
  final Function onTap;
  final String name;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Container(
          padding: const EdgeInsets.only(left: kPadSpace45x),
          child:  ProfileNameView(
            id: id,
            name: name,
          ),
        ),
         QRCodeScanIconView(
           onTap: ()=>onTap(),
         )
      ],
    );
  }
}

class QRCodeScanIconView extends StatelessWidget {
  const QRCodeScanIconView({
    Key? key,
    required this.onTap
  }) : super(key: key);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const[
          Icon(Icons.qr_code,size: kPadSpace25x,color: Colors.white,),
          Icon(Icons.chevron_right,size: kPadSpace25x,color: Colors.white,)
        ],
      ),
    );
  }
}

class ProfileNameView extends StatelessWidget {
  const ProfileNameView({
    Key? key,
    required this.name,
    required this.id
  }) : super(key: key);
  final String name;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name,style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: kFontSize19x
        ),),
        const SizedBox(
          height: kPadSpace5x,
        ),
        Text(id,style: const TextStyle(
            color: Colors.white70
        ),)
      ],
    );
  }
}


class BioSettingIconLogoutItemView extends StatelessWidget {
  const BioSettingIconLogoutItemView({
    Key? key,
    required this.onPressed,
    required this.onEdit,
    required this.bioText
  }) : super(key: key);
  final Function onPressed;
  final Function onEdit;
  final String bioText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:  [
          Expanded(child:  BioView(
          onEdit: ()=>onEdit(),
           bioText: bioText,
        )),
        const  Expanded(
            flex: 2,
            child: SettingIconView()
        ),
        Expanded(
            child: LogoutButtonView(
              onPressed: ()=>onPressed(),
            )
        ),
      ],
    );
  }
}

class LogoutButtonView extends StatelessWidget {
  const LogoutButtonView({
    Key? key,
    required this.onPressed
  }) : super(key: key);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: MaterialButton(
        elevation: 0,
        minWidth: 200,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kPadSpace20x)
        ),
        color: Colors.white,
        onPressed: ()=>onPressed(),
        child: const Text('Log out',style: TextStyle(
            fontSize: kFontSize17x
        ),),
      ),
    );
  }
}

class SettingIconView extends StatelessWidget {
  const SettingIconView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(left: kPadSpace5x,right: kPadSpace5x),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 4/4.3
      ),
      itemCount: settingVOList.length,
      itemBuilder: (_,index)=> Card(
        margin: const EdgeInsets.all(1),
        elevation: 0,
        child:Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              settingVOList[index].icon,
              Text(settingVOList[index].text)
            ],
          ),
        ),

      ),

    );
  }
}

class BioView extends StatelessWidget {
  const BioView({
    Key? key,
    required this.onEdit,
    required this.bioText,
  }) : super(key: key);
  final Function onEdit;
  final String bioText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kPadSpace20x,vertical: kPadSpace20x),
      alignment: Alignment.bottomCenter,
      child: RichText(
        maxLines: 2,
        textAlign: TextAlign.center,
        text:  TextSpan(
            style: const TextStyle(
                color: Colors.black38,
                fontSize: kFontSize12x,
                overflow: TextOverflow.ellipsis
            ),
            text: bioText,
            children: [
              const TextSpan(
                  text: '  '
              ),
              TextSpan(
                  recognizer:  TapGestureRecognizer()..onTap = () =>onEdit(),
                  style:  const TextStyle(
                      color: Colors.cyan,
                      decoration: TextDecoration.underline
                  ),
                  text: bioText==kWriteYourBioText?'Write':'Edit'
              )
            ]
        ),

      ),
    );
  }
}


class ProfileImageItemView extends StatelessWidget {
  const ProfileImageItemView({
    Key? key,
    required this.imageURL
  }) : super(key: key);
  final String imageURL;
  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      radius: kFirstBodyCircleRadius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: kSecondBodyCircleRadius,
        backgroundImage: NetworkImage(imageURL),
      ),
    );
  }
}


class BioTextEnterItemView extends StatelessWidget {
  const BioTextEnterItemView({
    Key? key,
    required this.onTapForClose,
    required this.onChange,
    required this.onSubmitted
  }) : super(key: key);
  final Function onTapForClose;
  final Function(String) onChange;
  final Function(String) onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => onTapForClose(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPadSpace10x,
                  vertical: kPadSpace10x),
              margin: const EdgeInsets.symmetric(
                  horizontal: kPadSpace20x),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(kPadSpace10x),
                color: Colors.white,
              ),
              width: double.infinity,
              height: null,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Bio Text',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: kFontSize19x),
                    ),
                    TextField(
                      autofocus: true,
                      onChanged: (text)=>onChange(text),
                      onSubmitted: (text)=>onSubmitted(text),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}