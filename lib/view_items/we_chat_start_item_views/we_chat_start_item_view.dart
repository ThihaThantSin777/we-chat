import 'package:flutter/material.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/widgets/material_button_widget.dart';




class LoginSignUpButtonItemView extends StatelessWidget {
  const LoginSignUpButtonItemView({
    Key? key,
    required this.onPressedLogin,
    required this.onPressedSignup
  }) : super(key: key);
  final Function onPressedLogin;
  final Function onPressedSignup;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: kPadSpace50x, left: kPadSpace20x, right: kPadSpace20x),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            Expanded(
                child: MaterialButtonWidget(
                  onPressed: ()=>onPressedLogin(),
                  textColor:kButtonColor,
                  color: Colors.white,
                  childText: 'Log in',
                ),
            ),

            const SizedBox(
              width: kPadSpace20x,
            ),
            Expanded(
                child: MaterialButtonWidget(
                  onPressed: ()=>onPressedSignup(),
                  textColor:Colors.white,
                  color: kButtonColor,
                  childText: 'Sign up',
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageItemView extends StatelessWidget {
  const LanguageItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kPadSpace20x, vertical: kPadSpace40x),
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          'English',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

class BackgroundImageItemView extends StatelessWidget {
  const BackgroundImageItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        'images/login.jpeg',
        fit: BoxFit.cover,
      ),
    );
  }
}

class SignupWithMobileItemView extends StatelessWidget {
  const SignupWithMobileItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const[
        Icon(Icons.rectangle_rounded,color: Colors.white),
        SizedBox(
          width: kPadSpace5x,
        ),
        Text(kSignupWithMobile,style: TextStyle(
            color: Colors.white,
            fontSize: kFontSize16x
        ),),
      ],
    );
  }
}

class TitleView extends StatelessWidget {
  const TitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: (){
          navigateBack(context);
        }, icon: const Icon(Icons.close,color: Colors.white60,)),
        const Text('Select Sign Up Method',style: TextStyle(
          color: Colors.white60,
          fontWeight: FontWeight.w600,
        ),),
        const SizedBox(
          width: kPadSpace50x,
        ),
      ],
    );
  }
}

class SignInBottomSheetItemView extends StatelessWidget {
  const SignInBottomSheetItemView({
    Key? key,
    required this.onPressedForMobileNumber
  }) : super(key: key);
  final Function onPressedForMobileNumber;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TitleView(),
          const SizedBox(
            height: kPadSpace30x,
          ),
          GestureDetector(
            onTap: ()=>onPressedForMobileNumber(),
            child: Container(
              width: MediaQuery.of(context).size.height*0.3,
              height: kPadSpace45x,
              decoration: BoxDecoration(
                color: kButtonColor,
                borderRadius: BorderRadius.circular(kPadSpace5x),
              ),
              child:    const SignupWithMobileItemView(),
            ),
          ),
          const SizedBox(
            height: kPadSpace20x,
          ),
          const Text('━━━━━━━━━Or━━━━━━━━━',style: TextStyle(
              color: Colors.white70
          ),),
          const SizedBox(
            height: kPadSpace20x,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kPadSpace10x),
            width: MediaQuery.of(context).size.height*0.3,
            height: kPadSpace45x,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kPadSpace5x),
                border: Border.all(color: Colors.white70)
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.apple,color: Colors.white,),
                Text('Sign up with Apple',style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.w600,
                    fontSize: kFontSize16x
                ),),
                SizedBox(
                  width: kPadSpace20x,
                ),

              ],
            ),
          ),
          const SizedBox(
            height: kPadSpace20x,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kPadSpace10x),
            width: MediaQuery.of(context).size.height*0.3,
            height: kPadSpace45x,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kPadSpace5x),
                border: Border.all(color: Colors.white70)
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.facebook,color: Colors.white,),
                Text('Sign up with Facebook',style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.w600,
                    fontSize: kFontSize16x
                ),),
                SizedBox(
                  width:kPadSpace10x,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}