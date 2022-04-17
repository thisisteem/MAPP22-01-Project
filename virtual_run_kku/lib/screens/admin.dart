import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/screens/contact_us.dart';
import 'package:virtual_run_kku/screens/list_bug_report.dart';
import 'package:virtual_run_kku/screens/news_create.dart';
import 'package:virtual_run_kku/screens/profile_setting.dart';
import 'package:virtual_run_kku/screens/result_check.dart';
import 'package:virtual_run_kku/utils/constants/colors.dart';

import '../auth/authen.dart';
import '../third_party/google_third_party.dart';
import '../utils/constants/my_constants.dart';
import '../widgets/my_app_bar.dart';
import 'main_screen.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final String version = "0.0.1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        title: const Text('ตรวจสอบผล'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: colorRed,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: const Authen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        children: [
          Column(
            children: [
              _buildResultCheck(),
              _buildContactUsCard(),
              _buildBugReported(),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.all(10),
                child: Text(
                  "เวอร์ชั่น $version",
                  style: MyConstant.h3Style(colorGrey),
                ),
                alignment: Alignment.center,
              ),
              OutlinedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: colorRed,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'ออกจากระบบ',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: colorRed),
                    ),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colorRed),
                ),
              ),
            ],
          ),
        ],
      ),
      // body: Text('test'),
    );
  }

  Widget _buildResultCheck() {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResultCheck(),
          ),
        ),
        child: Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(
                Icons.account_circle,
                size: 40,
                color: colorPrimary,
              ),
              const SizedBox(width: 15),
              Text(
                "ตรวจสอบผลการวิ่ง",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNews(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateNewsPage(),
          ),
        ),
        child: Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(
                Icons.contact_support,
                size: 40,
                color: colorPrimary,
              ),
              const SizedBox(width: 15),
              Text(
                'สร้างข่าว',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactUsCard() {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateNewsPage(),
          ),
        ),
        child: Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(
                Icons.contact_support,
                size: 40,
                color: colorPrimary,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  'สร้างข่าว',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBugReported() {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ListBugReport(),
          ),
        ),
        child: Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(
                Icons.contact_support,
                size: 40,
                color: colorPrimary,
              ),
              const SizedBox(width: 15),
              Text(
                'ตรวจสอบการรายงานบัค',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
