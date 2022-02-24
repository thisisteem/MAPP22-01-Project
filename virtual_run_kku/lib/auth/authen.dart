import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';
import '/widgets/show_logo.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.only(top: 100),
                  child: const ShowLogo(),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    FacebookAuthButton(
                      onPressed: () {},
                      darkMode: false,
                      text: 'เข้าสู่ระบบด้วย Facebook',
                      style: const AuthButtonStyle(
                        width: 280,
                        textStyle: TextStyle(
                          fontFamily: 'Kanit',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GoogleAuthButton(
                      onPressed: () {},
                      darkMode: false,
                      text: 'เข้าสู่ระบบด้วย Google',
                      style: AuthButtonStyle(
                        width: 280,
                        textStyle: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 16,
                            color: MyConstant.light),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        debugPrint('admin button');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock,
                              color: Theme.of(context).hintColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'สำหรับผู้ดูแลระบบ',
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
