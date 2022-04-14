import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/screens/contact_us.dart';
import 'package:virtual_run_kku/screens/profile_setting.dart';
import 'package:virtual_run_kku/screens/result_check.dart';

import '../third_party/google_third_party.dart';
import '../utils/constants/my_constants.dart';
import '../widgets/my_app_bar.dart';
import 'main_screen.dart';

class AppBarTest extends StatelessWidget {
  const AppBarTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: MyConstant.primary,
      centerTitle: true,
      title: Text(
        "Admin",
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipOval(
            child: Image.network(
                "https://icons.veryicon.com/png/o/miscellaneous/yuanql/icon-admin.png"),
          ),
        ),
      ],
    );
  }
}

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final String version = "0.0.1";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: false,
        backgroundColor: MyConstant.white,
        appBar: const PreferredSize(
          child: AppBarTest(),
          preferredSize: Size.fromHeight(55),
        ),
        body: adminOption(context),
        // body: Text('test'),
      ),
    );
  }

  Widget adminOption(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          _buildResultCheck(context),
          _buildNewsModify(context),
          const SizedBox(
            height: 5,
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(10),
            child: Text(
              "เวอร์ชั่น $version",
              style: MyConstant.h3Style(MyConstant.grey),
            ),
            alignment: Alignment.bottomLeft,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: MyConstant.white,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              // final provider =
              //     Provider.of<GoogleSignInProvider>(context, listen: false);
              // provider.googleLogout();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app,
                  size: 40,
                  color: MyConstant.red,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('ออกจากระบบ', style: MyConstant.h3Style(MyConstant.red)),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  InkWell _buildResultCheck(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResultCheck(),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        elevation: 3,
        child: Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(
                    Icons.account_circle,
                    size: 40,
                    color: MyConstant.primary,
                  ),
                  const SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.all(5.5),
                    child: Center(
                        child: Text(
                      "ตรวจสอบผลการวิ่ง",
                      style: MyConstant.h2Style(MyConstant.secondary),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _buildNewsModify(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ContactUs(),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        elevation: 3,
        child: Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(
                    Icons.contact_support,
                    size: 40,
                    color: MyConstant.primary,
                  ),
                  const SizedBox(width: 15),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: Text(
                              'ตรวจสอบการรายงานแอปพลิเคชัน',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: MyConstant.h3Style(MyConstant.secondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
