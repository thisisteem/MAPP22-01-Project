import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:virtual_run_kku/screens/history.dart';
import 'package:virtual_run_kku/screens/send_result.dart';
import 'package:virtual_run_kku/widgets/my_app_bar.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';
import '../widgets/bottom_bar_key.dart';
import 'activity.dart';
import 'home.dart';
import 'setting.dart';

class MainScreen extends StatefulWidget with PreferredSizeWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainScreenState extends State<MainScreen> {
  int _activePage = 0;
  final screens = [
    const Home(),
    const SendResult(),
    const Activity(),
    const History(),
    const Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: colorWhite,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorSecondary,
        backgroundColor: Colors.white,
        currentIndex: _activePage,
        onTap: (index) => setState(() {
          _activePage = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'ส่งผลการวิ่ง',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'กิจกรรม',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'ประวัติ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'ตั้งค่า',
          ),
        ],
      ),
      body: IndexedStack(
        index: _activePage,
        children: screens,
      ),
      // body: Text('test'),
    );
  }
}
