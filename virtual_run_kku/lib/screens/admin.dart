import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_run_kku/screens/list_bug_report.dart';
import 'package:virtual_run_kku/screens/news_create.dart';
import 'package:virtual_run_kku/screens/news_list.dart';
import 'package:virtual_run_kku/screens/result_check.dart';
import 'package:virtual_run_kku/utils/constants/colors.dart';

import '../auth/authen.dart';
import '../utils/constants/my_constants.dart';

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
              _buildNewsLists(),
              _buildNewsCreate(),
              _buildBugReported(),
              const SizedBox(height: 50),
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

  Widget _buildNewsCreate() {
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
                Icons.build,
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

  Widget _buildNewsLists() {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsLists(),
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
                Icons.newspaper,
                size: 40,
                color: colorPrimary,
              ),
              const SizedBox(width: 15),
              Text(
                'ข่าวทั้งหมด',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
