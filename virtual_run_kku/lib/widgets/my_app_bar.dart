import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants/my_constants.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final bool showProfileIcon;
  final user = FirebaseAuth.instance.currentUser!;
  MyAppBar({Key? key, required this.title, required this.showProfileIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: MyConstant.primary,
      centerTitle: true,
      title: Text(
        title,
        style: MyConstant.h1Style(MyConstant.primary),
      ),
      elevation: 1,
      backgroundColor: MyConstant.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: MyConstant.white,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      actions: [
        showProfileIcon
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  child: Image.network(user.photoURL!),
                ),
              )
            : Container()
      ],
    );
  }
}
