import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants/my_constants.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: MyConstant.white,
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
                style: MyConstant.h1Style(MyConstant.secondary),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Image.asset(MyConstant.instaIcon),
                maxRadius: 20,
              ),
              title: Text(
                'Teem Chakphet',
                style: MyConstant.h1Style(MyConstant.secondary),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.contact_phone,
                size: 40,
                color: MyConstant.primary,
              ),
              title: Text(
                '084-798-8456',
                style: MyConstant.h1Style(MyConstant.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar subAppBar(String title) => AppBar(
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
    );
