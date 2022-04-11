import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:virtual_run_kku/models/news_model.dart';
import 'package:virtual_run_kku/models/stats_model.dart';
import '../utils/constants/colors.dart';
import '../utils/functions/seconds_to_time.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _statsSwitcher = 0;

  final statsWeekly = Stats(
    distance: 30.7,
    events: 1,
    timeInSeconds: 100000,
  );

  final statsMonthly = Stats(
    distance: 130.2,
    events: 3,
    timeInSeconds: 500000,
  );

  final List<News> newsList = [
    News(
      title: 'SAT Khon Kaen Virtual Run 2022',
      description:
          'วิ่งสะสมระยะทาง "ที่ไหนก็ได้" ให้ครบตามที่ กำหนดโดยจำลองเส้นทางเสมือนจริงของงานวิ่ง SAT Khon Kaen Virtual 2021 ผ่าน Function MAP  ในแอพพลิเคชั่น Dromos Virtual Club ซึ่งทำงานผ่านการเชื่อมต่อกับเวปไซต์แผนที่นำทางชั้นนำ ที่เชื่อถือได้ที่สุดอย่าง Google Map',
      date: DateTime.now(),
      urlImage:
          'https://img5.localgymsandfitness.com/010/163/1967232840101631.jpg',
    ),
    News(
      title: 'HW Virtual Run 2022',
      description:
          'วิ่งสะสมระยะทาง "ที่ไหนก็ได้" ให้ครบตามที่ กำหนดโดยจำลองเส้นทางเสมือนจริงของงานวิ่ง SAT Khon Kaen Virtual 2021 ผ่าน Function MAP  ในแอพพลิเคชั่น Dromos Virtual Club ซึ่งทำงานผ่านการเชื่อมต่อกับเวปไซต์แผนที่นำทางชั้นนำ ที่เชื่อถือได้ที่สุดอย่าง Google Map',
      date: DateTime.now(),
      urlImage:
          'https://www.realasset.co.th/upload/news/Adjust-size-for-Web-%E0%B9%91%E0%B9%99%E0%B9%90%E0%B9%91%E0%B9%90%E0%B9%94-0001.jpg',
    ),
    News(
      title: 'SAT Khon Kaen Virtual Run 2022',
      description:
          'วิ่งสะสมระยะทาง "ที่ไหนก็ได้" ให้ครบตามที่ กำหนดโดยจำลองเส้นทางเสมือนจริงของงานวิ่ง SAT Khon Kaen Virtual 2021 ผ่าน Function MAP  ในแอพพลิเคชั่น Dromos Virtual Club ซึ่งทำงานผ่านการเชื่อมต่อกับเวปไซต์แผนที่นำทางชั้นนำ ที่เชื่อถือได้ที่สุดอย่าง Google Map',
      date: DateTime.now(),
      urlImage:
          'https://img5.localgymsandfitness.com/010/163/1967232840101631.jpg',
    ),
  ];

  @override
  void initState() {
    var time = intToTimeLeft(statsWeekly.timeInSeconds);
    debugPrint('time: $time');

    super.initState();
  }

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
                backgroundImage: CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1566492031773-4f4e44671857?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ข่าวสารการวิ่ง',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          newsList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (BuildContext context, index) {
                    var news = newsList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            // color: Colors.transparent,
                            child: CachedNetworkImage(
                              imageUrl: news.urlImage,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                Text(
                                  DateFormat('วันที่ dd/MM/yyyy', 'th')
                                      .format(news.date),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: colorGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'ยังไม่มีข่าวสาร',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
        ],
      ),
    );
  }
}
