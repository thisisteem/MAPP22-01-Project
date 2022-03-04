import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../utils/constants/my_constants.dart';
import '../widgets/bottom_bar_key.dart';
import 'activity.dart';
import 'home.dart';
import 'setting.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _activePage = 1;
  final List<Widget> screen = [const Activity(), const Home(), const Setting()];
  List<Widget> bottomBarIcons = [
    const Icon(Icons.bar_chart, size: 30),
    const Icon(Icons.home, size: 30),
    const Icon(Icons.settings, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: MyConstant.white,
      appBar: MyConstant.appBar(MyConstant.titleHome, true),
      bottomNavigationBar: Material(
        elevation: 50,
        child: CurvedNavigationBar(
          key: BottomBarKey.getKey(),
          items: bottomBarIcons,
          index: _activePage,
          height: 50,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: MyConstant.secondary2,
          buttonBackgroundColor: MyConstant.primary,
          onTap: (index) {
            setState(() {
              _activePage = index;
            });
          },
        ),
      ),
      body: screen[_activePage],
      // body: Text('test'),
    );
  }
}
