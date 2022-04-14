import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_run_kku/models/activity.dart';
import 'package:virtual_run_kku/screens/send_result.dart';
import 'package:virtual_run_kku/widgets/activity_card.dart';

import '../utils/constants/colors.dart';
import 'main_screen.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final List<ActivityModel> activitiesList = [
    ActivityModel(
      id: 1,
      title:
          '40th RX KKU: 40,000 KM FOR YOU DREAM AT KHON KAEN KHON KAEN KHON KAEN KHON KAEN',
      distance: 15,
      bib: 'Q0001',
      timeSpendInSeconds: 9512,
      eventDate: DateTime.now(),
      sendResultDate: DateTime.now(),
      status: 'checking',
      urlImage:
          'https://p-u.popcdn.net/event_details/posters/000/010/917/medium/4fb06c866283e480c87678ebcc77140e6fc029e7.jpg?1615432226',
    ),
    ActivityModel(
      id: 2,
      title: 'SBPT Virtual Run be For Your Dream at Khon Kaen',
      distance: 11,
      bib: 'Q0032',
      timeSpendInSeconds: 9512,
      eventDate: DateTime.now(),
      sendResultDate: DateTime.now(),
      status: 'approved',
      urlImage:
          'https://img5.localgymsandfitness.com/010/163/1967232840101631.jpg',
    ),
    ActivityModel(
      id: 2,
      title: 'SBPT Virtual Run be For Your Dream at Khon Kaen',
      distance: 11,
      bib: 'Q0032',
      timeSpendInSeconds: 9512,
      eventDate: DateTime.now(),
      sendResultDate: DateTime.now(),
      status: 'rejected',
      urlImage:
          'https://img5.localgymsandfitness.com/010/163/1967232840101631.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ส่งผลการวิ่ง'),
        centerTitle: false,
      ),
      backgroundColor: colorWhite,
      body: ListView(
        children: [
          activitiesList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: activitiesList.length,
                  itemBuilder: (BuildContext context, index) {
                    var event = activitiesList[index];
                    return ActivityCard(activity: event);
                  },
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'ยังไม่มีกิจกรรมที่เข้าร่วม',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'สามารถเข้าร่วมกิจกรรมการวิ่ง\nได้ที่ข่าวสารการวิ่ง',
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: colorPrimary,
                            minimumSize: const Size.fromHeight(40),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const MainScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'ไปที่ข่าวสารการวิ่ง',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: colorWhite,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
