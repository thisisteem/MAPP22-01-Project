import 'package:flutter/material.dart';
import 'package:virtual_run_kku/widgets/history_card.dart';

import '../models/activity_model.dart';
import '../utils/constants/colors.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
      urlImage:
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
      urlImage:
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
      urlImage:
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
      urlImage:
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
      urlImage:
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
      urlImage:
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
      urlImage:
          'https://cdn.discordapp.com/attachments/502121669171740673/964971926537785374/unknown.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประวัติการวิ่ง'),
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
                    var activity = activitiesList[index];
                    return activity.isSendResult && activity.isArchive
                        ? HistoryCard(activity: activity)
                        : Container();
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
                          'ยังไม่มีประวัติการวิ่ง',
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
