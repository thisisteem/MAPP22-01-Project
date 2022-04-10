import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../third_party/google_third_party.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FacebookAuthButton(
      // onPressed: () => Navigator.pushNamed(context, MyConstant.routeMainScreen),
      onPressed: () => {},
      text: 'เข้าสู่ระบบด้วย Facebook',
      style: MyConstant.authButtonStyleTextWhite,
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleAuthButton(
      onPressed: () {
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

class AdminButton extends StatelessWidget {
  const AdminButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock,
          color: colorSecondary,
        ),
        const SizedBox(
          width: 8,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'สำหรับผู้ดูแลระบบ',
            style: TextStyle(color: colorSecondary),
          ),
        )
      ],
    );
  }
}
