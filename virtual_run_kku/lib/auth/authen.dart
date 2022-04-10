import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';

import '../third_party/google_third_party.dart';
import '../utils/constants/colors.dart';
import '/widgets/auth_button.dart';
import '/widgets/show_logo.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: Scaffold(
          backgroundColor: colorWhite,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ShowLogo(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: const FacebookButton(),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: const GoogleButton(),
                          ),
                          const AdminButton(),
                          // TextButton(
                          //   onPressed: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const MainScreen()),
                          //   ),
                          //   child: Text(
                          //     'Go to main screen',
                          //     style: MyConstant.h3Style(colorSecondary),
                          //   ),
                          // )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
