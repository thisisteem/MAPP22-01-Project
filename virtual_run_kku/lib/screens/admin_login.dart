import 'package:flutter_login/flutter_login.dart';
import 'package:flutter/material.dart';
import 'package:virtual_run_kku/utils/constants/colors.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';

import 'admin.dart';

const users = {
  'admin@gmail.com': '1234',
};

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 1000);

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
      title: 'Admin Login',
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
      theme: LoginTheme(
        primaryColor: colorSecondary2,
        titleStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: colorSecondary),
        buttonTheme: LoginButtonTheme(
          splashColor: colorPrimary,
          backgroundColor: colorPrimary,
        ),
      ),
    );
  }
}
