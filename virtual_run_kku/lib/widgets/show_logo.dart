import 'package:flutter/material.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';

class ShowLogo extends StatelessWidget {
  const ShowLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Image.asset(
          MyConstant.logo,
          width: size * 0.8,
        ),
        Text(
          'Virtual Run KKU',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: MyConstant.primary,
          ),
        )
      ],
    );
  }
}
