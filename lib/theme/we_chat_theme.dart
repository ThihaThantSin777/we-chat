import 'package:flutter/material.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';

class WeChatTheme {
  static ThemeData weChatLightTheme = lightTheme;
  static ThemeData weChatDarkTheme = darkTheme;
}

final lightTheme = ThemeData(
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kBarColor,
      selectedItemColor: kPrimaryLightColor,
      unselectedItemColor: Colors.black38,
      showUnselectedLabels: true,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleSpacing: 0,
      backgroundColor: kPrimaryLightColor,
      elevation: 0,
      actionsIconTheme: IconThemeData(
        size: kAppbarActionIconSize,
        color: kShoeMoreColor,
      ),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: kFontSize17x,
        color: Colors.white,
      ),
      centerTitle: true,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black38,
    ));

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: kPrimaryDarkColor,
    selectedItemColor: kPrimaryLightColor,
    unselectedItemColor: Colors.black38,
    showUnselectedLabels: true,
  ),
  scaffoldBackgroundColor: kPrimaryDarkColor,
  iconTheme: const IconThemeData(
    color: Colors.white70,
  ),
  appBarTheme: const AppBarTheme(
    titleSpacing: 0,
    backgroundColor: kPrimaryDarkColor,
    elevation: 0,
    actionsIconTheme: IconThemeData(
      size: kAppbarActionIconSize,
      color: kShoeMoreColor,
    ),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: kFontSize17x,
      color: Colors.white,
    ),
    centerTitle: true,
  ),
);
