import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_run_kku/screens/main_screen.dart';
import 'screens/activity.dart';
import 'screens/full_result.dart';
import 'screens/setting.dart';
import 'screens/home.dart';
import 'auth/authen.dart';
import 'utils/constants/my_constants.dart';
import 'package:firebase_core/firebase_core.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => const Authen(),
  '/main': (BuildContext context) => const MainScreen(),
  '/home': (BuildContext context) => const Home(),
  '/activity': (BuildContext context) => const Activity(),
  '/setting': (BuildContext context) => const Setting(),
  '/fullResult': (BuildContext context) => const FullResult(),
};

String? initialRoute;
Future<void> main() async {
  initialRoute = MyConstant.routeAuthen;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Disable rotation
    child:
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Full Screen Mode
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: MyConstant.appName,
              routes: map,
              initialRoute: MyConstant.routeHome,
              theme: ThemeData(
                fontFamily: 'Kanit',
                primaryColor: const Color(0xFFFF8427),
                hintColor: const Color(0xFF1E212B),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong !'),
            );
          } else {
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
        });
  }
}
