import 'package:flutter/material.dart';
import 'screens/activity.dart';
import 'screens/login.dart';
import 'screens/setting.dart';
import 'screens/home.dart';
import 'auth/authen.dart';
import 'utils/constants/my_constants.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => const Authen(),
  '/login': (BuildContext context) => const Login(),
  'home': (BuildContext context) => const Home(),
  'activity': (BuildContext context) => const Activity(),
  'setting': (BuildContext context) => const Setting(),
};

String? initialRoute;
void main() {
  initialRoute = MyConstant.routeAuthen;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initialRoute,
      theme: ThemeData(
        fontFamily: 'Kanit',
        primaryColor: const Color(0xFFFF8427),
        hintColor: const Color(0xFF1E212B),
      ),
      // home: const Scaffold(
      //   body: SafeArea(
      //     child: Login(),
      //   ),
      // ),
    );
  }
}
