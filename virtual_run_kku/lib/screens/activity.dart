import 'package:flutter/material.dart';
import 'package:virtual_run_kku/screens/send_result.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          children: [
            // title('กิจกรรมที่กำลังดำเนินการ'),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       buildActivityCard(),
            //       const SizedBox(width: 20),
            //       buildActivityCard(),
            //       const SizedBox(width: 20),
            //       buildActivityCard(),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 10),
            // title('กิจกรรมที่ผ่านมา'),
            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       buildHistoryCard(
            //         '40th RX KKU: 40,000 KM',
            //         12.3,
            //         '15/02/2565',
            //         'assets/images/route1.jpg',
            //       ),
            //       buildHistoryCard(
            //         'HW Virtual Run 2022',
            //         9.5,
            //         '04/02/2565',
            //         'assets/images/route2.jpg',
            //       ),
            //       buildHistoryCard(
            //         '40th RX KKU: 40,000 KM',
            //         12.3,
            //         '15/02/2565',
            //         'assets/images/route1.jpg',
            //       ),
            //     ],
            //   ),
            // )
            Center(
              child: Text('Activity'),
            )
          ],
        ),
      ),
    );
  }

  Widget title(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: MyConstant.h2Style(colorSecondary),
          ),
        ],
      ),
    );
  }

  Widget buildActivityCard() {
    return SizedBox(
      width: 300,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        elevation: 3,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: colorPrimary,
                      width: 60,
                      height: 110,
                    ),
                    Image.asset(
                      MyConstant.runningMan,
                      width: 40,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '40th RX KKU: 40,000 KM...',
                        style: MyConstant.h3StyleBold(colorSecondary),
                      ),
                      Text(
                        'วันนี้',
                        style: MyConstant.h3Style(colorGrey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size(220, 35),
                          primary: colorPrimary,
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SendResult()),
                        ),
                        child: const Text('ส่งผลการวิ่ง'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHistoryCard(
    String title,
    double distance,
    String date,
    String imgPath,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(imgPath),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: MyConstant.h3StyleBold(colorSecondary),
                ),
                Text(
                  '$distance',
                  style: MyConstant.h3StyleBold(colorSecondary),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: MyConstant.h3Style(colorGrey),
                ),
                Text(
                  'KM',
                  style: MyConstant.h3Style(colorGrey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
