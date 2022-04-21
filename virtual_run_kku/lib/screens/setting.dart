import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/screens/contact_us.dart';
import 'package:virtual_run_kku/screens/profile_setting.dart';

import '../third_party/google_third_party.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final String version = "1.0.0";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        title: const Text('ตั้งค่า'),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        children: [
          Column(
            children: [
              _buildSettingProfileCard(),
              _buildContactUsCard(context),
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
                onPressed: isLoading
                    ? null
                    : () {
                        setState(() {
                          isLoading = true;
                        });
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogout();
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? Container()
                        : Icon(
                            Icons.exit_to_app,
                            color: colorRed,
                          ),
                    const SizedBox(width: 5),
                    isLoading
                        ? SizedBox(
                            child: CircularProgressIndicator(
                              color: colorRed,
                            ),
                            height: 20.0,
                            width: 20.0,
                          )
                        : Text(
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
    );
  }

  Widget _buildSettingProfileCard() {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileSetting(),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ตั้งค่าโปรไฟล์',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'ชื่อโปรไฟล์, รูป',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: colorGrey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactUsCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContactUs(),
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
                'ติดต่อเรา',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
