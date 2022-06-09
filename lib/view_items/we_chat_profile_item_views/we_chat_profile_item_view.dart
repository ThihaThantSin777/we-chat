import 'package:flutter/material.dart';
import 'package:wechat_app/data/vos/show_more_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';


class SettingItemView extends StatelessWidget {
  const SettingItemView({
    Key? key,
    required this.onTap
  }) : super(key: key);
  final Function(String)onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
      EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
      height: kBioTextContainerWidth,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 9/12,

          ),
          itemCount: settingVOList.length,
          itemBuilder: (context,index){
            return Card(
              child: GestureDetector(
                onTap: ()=>onTap(settingVOList[index].text),
                child: Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    settingVOList[index].icon,
                    const SizedBox(
                      height: kPadSpace10x,
                    ),
                    Text(settingVOList[index].text)
                  ],
                ),),
              ),
            );
          }
      ),
    );
  }
}

class BackgroundLayoutItemView extends StatelessWidget {
  const BackgroundLayoutItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            color: kPrimaryLightColor,
          ),
        ),
        Expanded(
          flex: kProfileBodyFlex,
          child: Container(
            padding: const EdgeInsets.only(top: kPadSpace30x),
            color: kBarColor,
          ),
        ),
      ],
    );
  }
}

class LogoutButtonItemView extends StatelessWidget {
  const LogoutButtonItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: () {},
      height: kPadSpace40x,
      minWidth: kLogoutButtonWidth,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kPadSpace40x)),
      color: Colors.white,
      child: const Text(
        'Log Out',
        style: TextStyle(fontSize: kFontSize17x),
      ),
    );
  }
}

class BioTextItemView extends StatelessWidget {
  const BioTextItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: kPadSpace70x),
        alignment: Alignment.center,
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              color: Colors.black54,
            ),
            text:
            'Adding you as my friend doesn’t mean I like you, I did it just to increase.',
            children: [
              TextSpan(
                  text: 'Edit',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                      decoration: TextDecoration.underline)),
            ],
          ),
        ));
  }
}

class QRCodeItemView extends StatelessWidget {
  const QRCodeItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Icon(
          Icons.qr_code,
          color: Colors.white,
        ),
        Icon(
          Icons.chevron_right,
          color: Colors.white,
        )
      ],
    );
  }
}

class ProfileNameAndIdItemView extends StatelessWidget {
  const ProfileNameAndIdItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Thomas Edision',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: kFontSize17x,
                  color: Colors.white),
            ),
            SizedBox(
              height: kPadSpace5x,
            ),
            Text(
              'Thomas20456',
              style: TextStyle(color: Colors.white70),
            )
          ],
        ),
      ],
    );
  }
}

class CircleAvatarProfileItemView extends StatelessWidget {
  const CircleAvatarProfileItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: kFirstBodyCircleRadius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: kSecondBodyCircleRadius,
        backgroundImage: NetworkImage(
            'https://www.diethelmtravel.com/wp-content/uploads/2016/04/bill-gates-wealthiest-person.jpg'),
      ),
    );
  }
}