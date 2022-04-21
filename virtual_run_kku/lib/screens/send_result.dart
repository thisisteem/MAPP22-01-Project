import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_run_kku/screens/main_screen.dart';
import 'package:virtual_run_kku/widgets/send_result_card.dart';
import '../models/activity_model.dart';
import '../services/firestore_database.dart';
import '../utils/constants/colors.dart';

class SendResult extends StatefulWidget {
  const SendResult({Key? key}) : super(key: key);

  @override
  _SendResultState createState() => _SendResultState();
}

class _SendResultState extends State<SendResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ส่งผลการวิ่ง'),
          centerTitle: false,
        ),
        backgroundColor: colorWhite,
        body: StreamBuilder<List<ActivityModel>>(
          stream: readSendResult(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return Text('มีบางอย่างผิดพลาด ${snapshot.error}');
            } else if (snapshot.hasData) {
              final activity = snapshot.data!;

              return activity.isNotEmpty
                  ? ListView(
                      children: activity.map<Widget>(((e) {
                        return SendResultCard(activity: e);
                      })).toList(),
                    )
                  : emptyResult();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget emptyResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Center(
        child: Column(
          children: [
            Text(
              'ยังไม่มีกิจกรรมที่ต้องส่งผล',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 30),
            Text(
              'สามารถเข้าร่วมกิจกรรมอื่นๆ\nได้ที่ข่าวสารการวิ่ง',
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
                'ข่าวสารการวิ่ง',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: colorWhite,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
