import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class MyConstant {
  // Route
  static String routeAuthen = '/authen';
  static String routeMainScreen = '/main';
  static String routeHome = '/home';
  static String routeActivity = '/activity';
  static String routeSetting = '/setting';
  static String routeFullResult = '/fullResult';
  static String routeSendResult = '/sendResult';
  static String routeAdmin = '/admin';
  static String rountAdminAuthen = '/adminLogin';

  // Image
  static String logo = 'assets/images/logo-removebg.png';
  static String womanRunIcon = 'assets/images/woman-run-icon.png';
  static String avatarIcon = 'assets/images/avatar1.png';
  static String instaIcon = 'assets/images/insta-icon.png';
  static String runningMan = 'assets/images/running-man.png';
  static String adminIcon = 'assets/images/admin-icon.jpg';

  // Text Style
  static TextStyle h1Style(Color color) => TextStyle(
        letterSpacing: 1,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: color,
      );
  static TextStyle h2Style(Color color) => TextStyle(
        letterSpacing: 1,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      );
  static TextStyle h3Style(Color color) => TextStyle(
        letterSpacing: 1,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle h3StyleBold(Color color) => TextStyle(
        letterSpacing: 1,
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: color,
      );

  // Button Style
  static AuthButtonStyle authButtonStyleTextWhite = AuthButtonStyle(
    width: 280,
    textStyle: TextStyle(
      fontFamily: 'Kanit',
      fontSize: 16,
      color: colorWhite,
    ),
  );
  static AuthButtonStyle authButtonStyleTextDark = AuthButtonStyle(
    width: 280,
    textStyle: TextStyle(
      fontFamily: 'Kanit',
      fontSize: 16,
      color: colorSecondary,
    ),
  );
}
