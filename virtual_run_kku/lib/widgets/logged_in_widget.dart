import 'package:flutter/material.dart';

class LoggedInWidget extends StatelessWidget {
  const LoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged in'),
        centerTitle: true,
        actions: [
          TextButton(
            child: const Text('Logout'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
