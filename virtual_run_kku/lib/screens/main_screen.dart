import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:virtual_run_kku/widgets/myAppBar.dart';

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
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: MyAppBar(
          title: MyConstant.titleHome,
          showProfileIcon: true,
        ),
      ),
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
