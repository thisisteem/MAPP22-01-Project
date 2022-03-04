import 'package:auth_buttons/auth_buttons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyConstant {
  // General
  static String appName = 'Virtual Run KKU';
  static String titleHome = 'หน้าหลัก';
  static String titleActivity = 'กิจกรรม';
  static String titleSetting = 'ตั้งค่า';
  static String titleFullResult = 'ผลการวิ่ง';

  // Running Status
  static String statusChecking = 'กำลังตรวจสอบ';
  static String statusApproved = 'ผ่าน';
  static String statusDenied = 'ไม่ผ่าน';

  // Route
  static String routeAuthen = '/authen';
  static String routeMainScreen = '/main';
  static String routeHome = '/home';
  static String routeActivity = '/activity';
  static String routeSetting = '/setting';
  static String routeFullResult = '/fullResult';

  // Image
  static String logo = 'assets/images/logo-removebg.png';
  static String womanRunIcon = 'assets/images/woman-run-icon.png';
  static String avatarIcon = 'assets/images/avatar1.png';

  // Color
  static Color primary = const Color(0xFFFF8427);
  static Color secondary = const Color(0xFF1E212B);
  static Color secondary2 = const Color.fromARGB(255, 255, 219, 191);
  static Color secondary3 = const Color.fromARGB(34, 30, 33, 43);
  static Color white = const Color(0xFFFFFFFF);
  static Color grey = const Color(0xFF8A8A8A);
  static Color green = const Color(0xFF34A853);
  static Color yellow = const Color(0xFFFFC800);
  static Color red = const Color(0xFFEB4C4C);

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
      color: MyConstant.white,
    ),
  );
  static AuthButtonStyle authButtonStyleTextDark = AuthButtonStyle(
    width: 280,
    textStyle: TextStyle(
      fontFamily: 'Kanit',
      fontSize: 16,
      color: MyConstant.secondary,
    ),
  );

  // App Bar
  static AppBar appBar(String title, bool showProfileIcon) => AppBar(
        foregroundColor: MyConstant.primary,
        centerTitle: true,
        title: Text(
          title,
          style: MyConstant.h1Style(MyConstant.primary),
        ),
        elevation: 1,
        backgroundColor: MyConstant.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: white,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        actions: [
          showProfileIcon
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    child: Image.asset(avatarIcon),
                  ),
                )
              : Container()
        ],
      );

  // Bottom bar
  static Material bottomBar(int index) => Material(
        elevation: 50,
        child: CurvedNavigationBar(
          items: bottomBarIcons,
          index: index,
          height: 50,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: MyConstant.secondary2,
          buttonBackgroundColor: MyConstant.primary,
        ),
      );

  // Bottom bar Icon
  static List<Widget> bottomBarIcons = [
    const Icon(Icons.bar_chart, size: 30),
    const Icon(Icons.home, size: 30),
    const Icon(Icons.settings, size: 30),
  ];
}
