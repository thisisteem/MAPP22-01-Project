import 'package:flutter/material.dart';
import 'package:virtual_run_kku/widgets/history_card.dart';

import '../models/activity_model.dart';
import '../services/firestore_database.dart';
import '../utils/constants/colors.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประวัติการวิ่ง'),
        centerTitle: false,
      ),
      backgroundColor: colorWhite,
      body: StreamBuilder<List<ActivityModel>>(
        stream: readActivityHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return Text('มีบางอย่างผิดพลาด ${snapshot.error}');
          } else if (snapshot.hasData) {
            final activity = snapshot.data!;

            return activity.isNotEmpty
                ? ListView(
                    children: activity.map<Widget>(((e) {
                      return HistoryCard(activity: e);
                    })).toList(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 100, horizontal: 20),
                      child: Center(
                        child: Text(
                          'ยังไม่มีประวัติกิจกรรม',
                          style: Theme.of(context).textTheme.displaySmall,
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
}
