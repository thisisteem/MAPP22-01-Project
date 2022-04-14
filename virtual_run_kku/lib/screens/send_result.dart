import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_run_kku/models/event.model.dart';
import 'package:virtual_run_kku/screens/home.dart';
import 'package:virtual_run_kku/screens/main_screen.dart';
import 'package:virtual_run_kku/widgets/send_result_card.dart';
import '../utils/constants/colors.dart';

class SendResult extends StatefulWidget {
  const SendResult({Key? key}) : super(key: key);

  @override
  _SendResultState createState() => _SendResultState();
}

class _SendResultState extends State<SendResult> {
  final List<EventModel> eventsList = [
    EventModel(
      id: 1,
      title:
          '40th RX KKU: 40,000 KM FOR YOU DREAM AT KHON KAEN KHON KAEN KHON KAEN KHON KAEN',
      distance: 15,
      bib: 'Q0001',
      date: DateTime.now(),
      urlImage:
          'https://img5.localgymsandfitness.com/010/163/1967232840101631.jpg',
    ),
    EventModel(
      id: 2,
      title: 'SBPT Virtual Run be For Your Dream at Khon Kaen',
      distance: 11,
      bib: 'Q0032',
      date: DateTime.now(),
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
          eventsList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: eventsList.length,
                  itemBuilder: (BuildContext context, index) {
                    var event = eventsList[index];
                    return SendResultCard(event: event);
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
