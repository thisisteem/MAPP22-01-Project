import 'package:flutter_login/flutter_login.dart';
import 'package:flutter/material.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';

import 'admin.dart';

const users = const {
  'admin@gmail.com': '1234',
};

class AdminLoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Admin Zone',
      logo: MyConstant.adminIcon,
      onLogin: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Admin(),
        ));
      },
      onSignup: (LoginData) {},
      onRecoverPassword: (String) {},
      hideSignUpButton: true,
      hideForgotPasswordButton: true,
    );
  }
}
