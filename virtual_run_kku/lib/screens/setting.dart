import 'package:flutter/material.dart';
import 'package:virtual_run_kku/screens/contact_us.dart';

import '../utils/constants/my_constants.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final String version = "0.0.1";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          _buildSettingProfileCard(),
          _buildContactUsCard(context),
          const SizedBox(
            height: 5,
          ),
          Container(
            child: Text(
              "เวอร์ชั่น ${version}",
              style: MyConstant.h3Style(MyConstant.grey),
            ),
            alignment: Alignment.topLeft,
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: MyConstant.white,
              maximumSize: const Size(200, 100),
            ),
            onPressed: () {},
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

  InkWell _buildSettingProfileCard() {
    return InkWell(
      onTap: () {
        print("Click event on Container");
      },
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ตั้งค่าโปรไฟล์',
                          style: MyConstant.h2Style(MyConstant.secondary),
                        ),
                        Text(
                          'ชื่อโปรไฟล์, รูป',
                          style: MyConstant.h3Style(MyConstant.grey),
                        ),
                      ],
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

  InkWell _buildContactUsCard(BuildContext context) {
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
                          Text(
                            'ติดต่อเรา',
                            style: MyConstant.h2Style(MyConstant.secondary),
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
