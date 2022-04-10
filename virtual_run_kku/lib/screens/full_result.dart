import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';
import '../utils/constants/texts.dart';
import '../widgets/running_result_card.dart';

class FullResult extends StatefulWidget {
  const FullResult({Key? key}) : super(key: key);

  @override
  _FullResultState createState() => _FullResultState();
}

class _FullResultState extends State<FullResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              buildTotalCard(),
              buildContentText('ผลการวิ่ง'),
              Column(
                children: [
                  RunningResultCard(
                    status: statusChecking,
                    bib: 'Q0001',
                    date: '15/02/65',
                    distance: 24.2,
                  ),
                  RunningResultCard(
                    status: statusApproved,
                    bib: 'Q0002',
                    date: '10/02/65',
                    distance: 12.1,
                  ),
                  RunningResultCard(
                    status: statusDenied,
                    bib: 'Q0001',
                    date: '25/01/65',
                    distance: 24.2,
                  ),
                  RunningResultCard(
                    status: statusApproved,
                    bib: 'Q0002',
                    date: '10/02/65',
                    distance: 12.1,
                  ),
                  RunningResultCard(
                    status: statusApproved,
                    bib: 'Q0002',
                    date: '10/02/65',
                    distance: 12.1,
                  ),
                  RunningResultCard(
                    status: statusApproved,
                    bib: 'Q0002',
                    date: '10/02/65',
                    distance: 12.1,
                  ),
                  RunningResultCard(
                    status: statusApproved,
                    bib: 'Q0002',
                    date: '10/02/65',
                    distance: 12.1,
                  ),
                  RunningResultCard(
                    status: statusApproved,
                    bib: 'Q0002',
                    date: '10/02/65',
                    distance: 12.1,
                  ),
                  RunningResultCard(
                    status: statusApproved,
                    bib: 'Q0002',
                    date: '10/02/65',
                    distance: 12.1,
                  ),
                  RunningResultCard(
                    status: statusApproved,
                    bib: 'Q0002',
                    date: '10/02/65',
                    distance: 12.1,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Card buildTotalCard() {
    return Card(
      elevation: 3,
      child: Container(
        width: double.infinity,
        height: 140,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ระยะทางที่วิ่งได้ทั้งหมด',
              style: MyConstant.h2Style(colorSecondary),
            ),
            Text(
              '154.9 KM',
              style: TextStyle(
                  color: colorSecondary,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
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
            style: MyConstant.h2Style(colorSecondary),
          ),
        ],
      ),
    );
  }
}
