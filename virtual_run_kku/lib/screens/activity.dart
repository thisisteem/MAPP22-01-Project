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
            debugPrint(snapshot.error.toString());
            return Text('มีบางอย่างผิดพลาด ${snapshot.error}');
          } else if (snapshot.hasData) {
            final activity = snapshot.data!;
            isActivityEmpty = !activity.isNotEmpty;
            bool isNoSendResult = true;

            return activity.isNotEmpty
                ? ListView(
                    children: activity.map<Widget>(((e) {
                      if ((e.isSendResult && !e.isArchive) ||
                          e.status == 'rejected') {
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
