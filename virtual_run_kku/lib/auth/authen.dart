import 'package:flutter/material.dart';

import '/widgets/auth_button.dart';
import '/widgets/show_logo.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 100),
                  child: const ShowLogo(),
                ),
              ),
              Expanded(
                child: Column(
                  children: const [
                    FacebookButton(),
                    SizedBox(
                      height: 15,
                    ),
                    GoogleButton(),
                    SizedBox(
                      height: 15,
                    ),
                    AdminButton(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
