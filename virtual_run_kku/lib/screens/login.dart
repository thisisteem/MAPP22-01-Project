import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo-removebg.png',
                    width: 300,
                  ),
                  Text(
                    'Virtual Run KKU',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // const LoginButton(
                //   icon: Icon(Icons.facebook),
                //   label: 'เข้าสู่ระบบด้วย Facebook',
                //   backgroundColor: Colors.blue,
                //   textColor: Colors.white,
                // ),
                // const LoginButton(
                //   icon: Icon(),
                //   label: 'เข้าสู่ระบบด้วย Google',
                //   backgroundColor: Colors.white,
                //   textColor: Colors.black,
                // ),
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
                  style: const AuthButtonStyle(
                    width: 280,
                    textStyle: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,
                        color: Colors.black87),
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
    );
  }
}
