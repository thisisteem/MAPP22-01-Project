import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';

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
          onPressed: () {
            Navigator.pushNamed(context, MyConstant.rountAdminAuthen);
          },
          child: Text(
            'สำหรับผู้ดูแลระบบ',
            style: TextStyle(color: colorSecondary),
          ),
        )
      ],
    );
  }
}
