import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_run_kku/screens/main_screen.dart';
import 'screens/activity.dart';
import 'screens/full_result.dart';
import 'screens/setting.dart';
import 'screens/home.dart';
import 'auth/authen.dart';
import 'utils/constants/my_constants.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => const Authen(),
  '/main': (BuildContext context) => const MainScreen(),
  '/home': (BuildContext context) => const Home(),
  '/activity': (BuildContext context) => const Activity(),
  '/setting': (BuildContext context) => const Setting(),
  '/fullResult': (BuildContext context) => const FullResult(),
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
    // Disable rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Full Screen Mode
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyConstant.appName,
      routes: map,
      initialRoute: initialRoute,
      theme: ThemeData(
        fontFamily: 'Kanit',
        primaryColor: const Color(0xFFFF8427),
        hintColor: const Color(0xFF1E212B),
      ),
    );
  }
}
