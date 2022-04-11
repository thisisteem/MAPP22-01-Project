import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/screens/main_screen.dart';
import 'package:virtual_run_kku/theme.dart';
import 'screens/send_result.dart';
import 'third_party/google_third_party.dart';
import 'screens/activity.dart';
import 'screens/full_result.dart';
import 'screens/setting.dart';
import 'screens/home.dart';
import 'auth/authen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'utils/constants/texts.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Intl.defaultLocale = 'th';
  initializeDateFormatting();

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
            debugPrint('======= Loading Login =======');
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            debugPrint('======= Login Success! =======');
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
      theme: RunKKUTheme.themeData(),
      debugShowCheckedModeBanner: false,
      title: appName,
      routes: map,
      home: screen,
    );
  }
}
