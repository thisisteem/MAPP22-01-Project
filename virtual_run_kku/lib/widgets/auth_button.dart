import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../utils/constants/my_constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FacebookAuthButton(
      onPressed: () => Navigator.pushNamed(context, MyConstant.routeMainScreen),
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
          color: MyConstant.secondary,
        ),
        const SizedBox(
          width: 8,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'สำหรับผู้ดูแลระบบ',
            style: TextStyle(color: MyConstant.secondary),
          ),
        )
      ],
    );
  }
}
