import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  const LoginButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.backgroundColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: icon,
      label: Text(label),
      style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          onPrimary: textColor,
          textStyle: TextStyle(color: Colors.red)),
    );
  }
}
