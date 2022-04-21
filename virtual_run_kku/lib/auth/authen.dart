import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';

import '../screens/admin.dart';
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
  bool isLoading = false;

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                          ? SizedBox(
                              child: CircularProgressIndicator(
                                color: colorPrimary,
                              ),
                              height: 40.0,
                              width: 40.0,
                            )
                          : Container(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          // Container(
                          //   margin: const EdgeInsets.symmetric(vertical: 8),
                          //   child: const FacebookButton(),
                          // ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: googleButton(),
                          ),
                          Row(
                            children: [
                              const AdminButton(),
                              bypassAdmin(),
                              const Text('<-- bypass')
                            ],
                          ),
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

  Widget bypassAdmin() {
    return IconButton(
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Admin(),
        ));
      },
      icon: const Icon(Icons.person),
    );
  }

  Widget googleButton() {
    return GoogleAuthButton(
      onPressed: isLoading
          ? null
          : () {
              setState(() {
                isLoading = true;
              });
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
            },

      // onPressed: () => Navigator.pushNamed(context, MyConstant.routeMainScreen),

      darkMode: false,
      text: 'เข้าสู่ระบบด้วย Google',
      style: MyConstant.authButtonStyleTextDark,
    );
  }
}
