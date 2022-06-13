import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/show_more_vo/show_more_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';

class ProfileNameAndQrScanItemView extends StatelessWidget {
  const ProfileNameAndQrScanItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Container(
          padding: const EdgeInsets.only(left: kPadSpace45x),
          child: const ProfileNameView(),
        ),
        const QRCodeScanIconView()
      ],
    );
  }
}

class QRCodeScanIconView extends StatelessWidget {
  const QRCodeScanIconView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const[
        Icon(Icons.qr_code,size: kPadSpace25x,color: Colors.white,),
        Icon(Icons.chevron_right,size: kPadSpace25x,color: Colors.white,)
      ],
    );
  }
}

class ProfileNameView extends StatelessWidget {
  const ProfileNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const[
        Text('Thiha Thant Sin',style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: kFontSize19x
        ),),
        SizedBox(
          height: kPadSpace5x,
        ),
        Text('thiha277#45',style: TextStyle(
            color: Colors.white70
        ),)
      ],
    );
  }
}


class BioSettingIconLogoutItemView extends StatelessWidget {
  const BioSettingIconLogoutItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Expanded(child:  BioView()),
        Expanded(
            flex: 2,
            child: SettingIconView()
        ),
        Expanded(
            child: LogoutButtonView()
        ),
      ],
    );
  }
}

class LogoutButtonView extends StatelessWidget {
  const LogoutButtonView({
    Key? key,
  }) : super(key: key);

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
        onPressed: (){

        },
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kPadSpace20x,vertical: kPadSpace20x),
      alignment: Alignment.bottomCenter,
      child: RichText(
        maxLines: 2,
        textAlign: TextAlign.center,
        text: const TextSpan(
            style: TextStyle(
                color: Colors.black38,
                fontSize: kFontSize12x,
                overflow: TextOverflow.ellipsis
            ),
            text: 'No Pain No Gain. Success is the only way to become success. become success.',
            children: [
              TextSpan(
                  text: '  '
              ),
              TextSpan(
                  style:  TextStyle(
                      color: Colors.cyan,
                      decoration: TextDecoration.underline
                  ),
                  text: 'EDIT'
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: kFirstBodyCircleRadius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: kSecondBodyCircleRadius,
        backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
      ),
    );
  }
}