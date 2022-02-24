import 'package:flutter/material.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.dark,
      appBar: MyConstant.appBar,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            buildGreetingText(),
            buildStatsCard(),
            buildContentText('ผลการวิ่ง'),
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
          style: MyConstant.h3Style(MyConstant.light),
        ),
      ],
    ),
  );
}

Card buildStatsCard() {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 10),
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
                style: MyConstant.h3Style(MyConstant.light),
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
          style: MyConstant.h2Style(MyConstant.light),
        ),
        Text(
          'ดูทั้งหมด',
          style: MyConstant.h3Style(MyConstant.grey),
        ),
      ],
    ),
  );
}
