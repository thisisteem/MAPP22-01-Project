import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

import '../utils/constants/my_constants.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FacebookAuthButton(
      onPressed: () {},
      text: 'เข้าสู่ระบบด้วย Facebook',
      style: const AuthButtonStyle(
        width: 280,
        textStyle: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 16,
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleAuthButton(
      onPressed: () {},
      darkMode: false,
      text: 'เข้าสู่ระบบด้วย Google',
      style: AuthButtonStyle(
        width: 280,
        textStyle: TextStyle(
            fontFamily: 'Kanit', fontSize: 16, color: MyConstant.light),
      ),
    );
  }
}

class AdminButton extends StatelessWidget {
  const AdminButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock,
          color: MyConstant.light,
        ),
        const SizedBox(
          width: 8,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'สำหรับผู้ดูแลระบบ',
            style: TextStyle(color: MyConstant.light),
          ),
        )
      ],
    );
  }
}
