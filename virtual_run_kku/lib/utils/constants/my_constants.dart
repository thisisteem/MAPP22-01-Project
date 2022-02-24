import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyConstant {
  // General
  static String appName = 'Virtual Run KKU';
  static String titleHome = 'หน้าหลัก';
  static String titleActivity = 'กิจกรรม';
  static String titleSetting = 'ตั้งค่า';

  // Route
  static String routeAuthen = '/authen';
  static String routeHome = '/home';
  static String routeActivity = '/activity';
  static String routeSetting = '/setting';

  // Image
  static String logo = 'assets/images/logo-removebg.png';
  static String womanRunIcon = 'assets/images/woman-run-icon.png';

  // Color
  static Color primary = const Color(0xFFFF8427);
  static Color dark = const Color(0xFFFFFFFF);
  static Color light = const Color(0xFF1E212B);
  static Color grey = const Color(0xFF8A8A8A);

  // Text Style
  static TextStyle h1Style(Color color) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: color,
      );
  static TextStyle h2Style(Color color) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      );
  static TextStyle h3Style(Color color) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      );

  // Button Style
  static AuthButtonStyle authButtonStyleTextWhite = AuthButtonStyle(
    width: 280,
    textStyle: TextStyle(
      fontFamily: 'Kanit',
      fontSize: 16,
      color: MyConstant.dark,
    ),
  );
  static AuthButtonStyle authButtonStyleTextDark = AuthButtonStyle(
    width: 280,
    textStyle: TextStyle(
      fontFamily: 'Kanit',
      fontSize: 16,
      color: MyConstant.light,
    ),
  );

  // App Bar
  static AppBar appBar = AppBar(
    foregroundColor: MyConstant.primary,
    centerTitle: true,
    title: Text(
      MyConstant.titleHome,
      style: MyConstant.h1Style(MyConstant.primary),
    ),
    elevation: 1,
    backgroundColor: MyConstant.dark,
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: dark,

      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
  );
}
