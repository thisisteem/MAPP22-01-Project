import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/screens/main_screen.dart';
import 'screens/send_result.dart';
import 'third_party/google_third_party.dart';
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
  '/sendResult': (BuildContext context) => const SendResult(),
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Full Screen Mode
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return changeScreen(const MainScreen());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong !'),
            );
          } else {
            return changeScreen(const Authen());
          }
        },
      ),
    );
  }

  MaterialApp changeScreen(Widget screen) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyConstant.appName,
      routes: map,
      home: screen,
      theme: ThemeData(
        fontFamily: 'Kanit',
        primaryColor: const Color(0xFFFF8427),
        hintColor: const Color(0xFF1E212B),
      ),
    );
  }
}
