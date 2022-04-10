import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: colorWhite,
      appBar: subAppBar("ติดต่อเรา"),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(
                Icons.facebook,
                color: Colors.blue,
                size: 40,
              ),
              title: Text(
                'Teem Chakphet',
                style: MyConstant.h1Style(colorSecondary),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Image.asset(MyConstant.instaIcon),
                maxRadius: 20,
              ),
              title: Text(
                'Teem Chakphet',
                style: MyConstant.h1Style(colorSecondary),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.contact_phone,
                size: 40,
                color: colorPrimary,
              ),
              title: Text(
                '084-798-8456',
                style: MyConstant.h1Style(colorSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar subAppBar(String title) => AppBar(
      foregroundColor: colorPrimary,
      centerTitle: true,
      title: Text(
        title,
        style: MyConstant.h1Style(colorPrimary),
      ),
      elevation: 1,
      backgroundColor: colorWhite,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: colorWhite,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    );
