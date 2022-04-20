import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_run_kku/models/activity_model.dart';
import 'package:virtual_run_kku/services/firestore_database.dart';
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
      title:
          '40th RX KKU: 40,000 KM FOR YOU DREAM AT KHON KAEN KHON KAEN KHON KAEN KHON KAEN',
      distance: 15,
      bib: 'Q0001',
      eventDate: DateTime.now(),
      isSendResult: false,
      isArchive: false,
      status: '',
      rejectReason: '',
      eventImage:
          'https://img5.localgymsandfitness.com/010/163/1967232840101631.jpg',
    ),
    ActivityModel(
      title: 'SBPT Virtual Run be For Your Dream at Khon Kaen',
      distance: 11,
      bib: 'Q0032',
      eventDate: DateTime.now(),
      isSendResult: false,
      isArchive: false,
      status: '',
      rejectReason: '',
      eventImage:
          'https://img5.localgymsandfitness.com/010/163/1967232840101631.jpg',
    ),
    ActivityModel(
      title:
          '40th RX KKU: 40,000 KM FOR YOU DREAM AT KHON KAEN KHON KAEN KHON KAEN KHON KAEN',
      distance: 15,
      bib: 'Q0001',
      timeSpendInSeconds: 9512,
      eventDate: DateTime.now(),
      sendResultDate: DateTime.now(),
      isSendResult: true,
      isArchive: false,
      status: 'checking',
      rejectReason: '',
      eventImage:
          'https://p-u.popcdn.net/event_details/posters/000/010/917/medium/4fb06c866283e480c87678ebcc77140e6fc029e7.jpg?1615432226',
    ),
    ActivityModel(
      title: 'SBPT Virtual Run be For Your Dream at Khon Kaen',
      distance: 11,
      bib: 'Q0032',
      timeSpendInSeconds: 9512,
      eventDate: DateTime.now(),
      sendResultDate: DateTime.now(),
      isSendResult: true,
      isArchive: false,
      status: 'approved',
      rejectReason: '',
      eventImage:
          'https://img5.localgymsandfitness.com/010/163/1967232840101631.jpg',
    ),
    ActivityModel(
      title: 'SBPT Virtual Run be For Your Dream at Khon Kaen',
      distance: 11,
      bib: 'Q0032',
      timeSpendInSeconds: 9512,
      eventDate: DateTime.now(),
      sendResultDate: DateTime.now(),
      isSendResult: true,
      isArchive: false,
      status: 'rejected',
      rejectReason: 'รูปภาพไม่ชัด กรุณาส่งผลการวิ่งอีกครั้งด้วยค่ะ',
      eventImage:
          'https://img5.localgymsandfitness.com/010/163/1967232840101631.jpg',
    ),
    ActivityModel(
      title: 'SBPT Virtual Run be For Your Dream at Khon Kaen',
      distance: 11,
      bib: 'Q0032',
      timeSpendInSeconds: 9512,
      eventDate: DateTime.now(),
      sendResultDate: DateTime.now(),
      isSendResult: true,
      isArchive: true,
      status: 'approved',
      rejectReason: '',
      eventImage:
          'https://cdn.discordapp.com/attachments/502121669171740673/964971869449101332/unknown.png',
    ),
    ActivityModel(
      title: 'KKU RUNNING AROUND THE WORLD',
      distance: 150,
      bib: 'Q0001',
      timeSpendInSeconds: 9512,
      eventDate: DateTime.now(),
      sendResultDate: DateTime.now(),
      isSendResult: true,
      isArchive: true,
      status: 'approved',
      rejectReason: '',
      eventImage:
          'https://cdn.discordapp.com/attachments/502121669171740673/964971926537785374/unknown.png',
    ),
  ];

  late bool isActivityEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('กิจกรรมการวิ่ง'),
        centerTitle: false,
      ),
      backgroundColor: colorWhite,
      body: StreamBuilder<List<ActivityModel>>(
        stream: readActivity(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('มีบางอย่างผิดพลาด ${snapshot.error}');
          } else if (snapshot.hasData) {
            final activity = snapshot.data!;
            isActivityEmpty = !activity.isNotEmpty;
            bool isNoSendResult = true;

            return activity.isNotEmpty
                ? ListView(
                    children: activity.map<Widget>(((e) {
                      if (e.isSendResult && !e.isArchive) {
                        isNoSendResult = false;
                        return ActivityCard(activity: e);
                      } else {
                        if (activity.indexOf(e) == activity.length - 1) {
                          if (isNoSendResult) return emptyList();
                        }
                        return Container();
                      }
                    })).toList(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 100, horizontal: 20),
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
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget emptyList() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ยังไม่มีกิจกรรมที่ส่งผลวิ่ง\nสามารถส่งผลวิ่งได้ที่',
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
                      child: const MainScreen(
                        gotoPage: 1,
                      ),
                    ),
                  );
                },
                child: Text(
                  'ส่งผลการวิ่ง',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: colorWhite,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
