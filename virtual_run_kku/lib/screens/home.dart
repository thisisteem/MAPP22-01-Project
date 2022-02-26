import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';
import '../widgets/running_result_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.bar_chart, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.settings, size: 30),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: MyConstant.white,
      appBar: MyConstant.appBar(MyConstant.titleHome),
      bottomNavigationBar: Material(
        elevation: 50,
        child: CurvedNavigationBar(
          items: items,
          index: 1,
          height: 50,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: MyConstant.secondary2,
          buttonBackgroundColor: MyConstant.primary,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            buildGreetingText(),
            buildStatsCard(),
            buildContentText('ผลการวิ่ง'),
            RunningResultCard(
              status: MyConstant.statusChecking,
              bib: 'Q0001',
              date: '15/02/65',
              distance: 24.2,
            ),
            RunningResultCard(
              status: MyConstant.statusApproved,
              bib: 'Q0002',
              date: '10/02/65',
              distance: 12.1,
            ),
            RunningResultCard(
              status: MyConstant.statusDenied,
              bib: 'Q0001',
              date: '25/01/65',
              distance: 24.2,
            ),
            buildContentText('ข่าวสารการวิ่ง'),
          ],
        ),
      ),
    );
  }
}

Container buildGreetingText() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    child: Row(
      children: [
        Text(
          'สวัสดี! ',
          style: MyConstant.h3Style(MyConstant.primary),
        ),
        Text(
          'คุณสมชาย ไกรทอง',
          style: MyConstant.h3Style(MyConstant.secondary),
        ),
      ],
    ),
  );
}

Card buildStatsCard() {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 5),
    elevation: 3,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                MyConstant.womanRunIcon,
                width: 40,
              ),
              const SizedBox(width: 10),
              Text(
                'ระยะทางที่วิ่งได้',
                style: MyConstant.h3Style(MyConstant.secondary),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.topRight,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '154.9',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'km',
                  style: TextStyle(fontSize: 16, color: MyConstant.grey),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Container buildContentText(String title) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: MyConstant.h2Style(MyConstant.secondary),
        ),
        Text(
          'ดูทั้งหมด',
          style: MyConstant.h3Style(MyConstant.grey),
        ),
      ],
    ),
  );
}
