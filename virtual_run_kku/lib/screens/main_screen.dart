import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

import 'home.dart';
import 'send_result.dart';
import 'activity.dart';
import 'history.dart';
import 'setting.dart';

class MainScreen extends StatefulWidget with PreferredSizeWidget {
  final int? gotoPage;
  const MainScreen({Key? key, this.gotoPage}) : super(key: key);

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
  void initState() {
    _activePage = widget.gotoPage ?? 0;
    super.initState();
  }

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
