import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/content_constant.dart';
import '../widgets/running_result_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _statsSwitcher = 0;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าหลัก'),
      ),
      backgroundColor: colorBackground,
      body: SafeArea(
        child: ListView(
          // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          children: [
            buildStats(),
            // const SizedBox(height: 30),
            buildNews(),
          ],
        ),
      ),
    );
  }

  Widget buildStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      color: colorWhite,
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1566492031773-4f4e44671857?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 18),
              Text(
                'Eleanor Pena',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                'สถิติการวิ่งล่าสุด',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(),
              ToggleSwitch(
                initialLabelIndex: _statsSwitcher,
                totalSwitches: 2,
                // radiusStyle: true,
                animate: true,
                animationDuration: 100,
                labels: const ['สัปดาห์', 'เดือน'],
                cornerRadius: 50.0,
                activeBgColor: [colorPrimary],
                activeFgColor: Colors.black,
                inactiveBgColor: colorSecondary3,
                inactiveFgColor: Colors.black,
                customTextStyles: [
                  Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: colorWhite),
                  Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: colorWhite),
                ],
                onToggle: (index) {
                  debugPrint('index: $index');

                  setState(() {
                    _statsSwitcher = index!;
                  });
                  debugPrint('_statsSwitcher: $_statsSwitcher');
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '30.4',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 60,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'กิโลเมตร',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: colorGrey,
                      height: 0.2,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    'กิจกรรม',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: colorGrey,
                          height: 1,
                        ),
                  ),
                ],
              ),
              const SizedBox(width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3:26:07',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    'เวลาที่ใช้',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: colorGrey,
                          height: 1,
                        ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildNews() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      color: colorWhite,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'ข่าวสารการวิ่ง',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
