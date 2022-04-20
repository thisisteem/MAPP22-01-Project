import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_run_kku/screens/running_detail.dart';
import 'package:virtual_run_kku/widgets/running_result_card.dart';

import '../models/checking_model.dart';
import '../services/firestore_database.dart';

class ResultCheck extends StatefulWidget {
  const ResultCheck({Key? key}) : super(key: key);

  @override
  State<ResultCheck> createState() => _ResultCheckState();
}

class _ResultCheckState extends State<ResultCheck> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readChecking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ผลการวิ่ง'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipOval(
              child: Image.network(
                  "https://icons.veryicon.com/png/o/miscellaneous/yuanql/icon-admin.png"),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<CheckingModel>>(
        stream: readChecking(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return Text('มีบางอย่างผิดพลาด ${snapshot.error}');
          } else if (snapshot.hasData) {
            final activity = snapshot.data!;

            return activity.isNotEmpty
                ? ListView(
                    children: activity.map<Widget>(((e) {
                      return resultCard(e);
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

  Widget resultCard(CheckingModel checkingModel) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RunningDetail(
            bib: checkingModel.bib,
            imgUrl: checkingModel.eventImage,
            name: checkingModel.displayName,
            date: DateFormat('yyyy-MM-dd').format(checkingModel.eventDate),
            distance: checkingModel.distance,
            eventName: checkingModel.title,
          ),
        ),
      ),
      child: RunningResultCard(
        status: checkingModel.status,
        bib: checkingModel.bib,
        distance: checkingModel.distance,
        date: DateFormat('yyyy-MM-dd').format(checkingModel.eventDate),
      ),
    );
  }
}

class RunningResult {
  String bib;
  String date;
  String status;
  double distance;
  String imgUrl;
  String name;
  String projectName;

  RunningResult.fromJson(Map<String, dynamic> runningResultJson)
      : bib = runningResultJson['bib'],
        date = runningResultJson['date'],
        status = runningResultJson['status'],
        distance = runningResultJson['distance'],
        imgUrl = runningResultJson['img'],
        projectName = runningResultJson['project'],
        name = runningResultJson['name'];
}

class RunningResultList {
  List<RunningResult> runningResult;

  RunningResultList({
    required this.runningResult,
  });

  RunningResultList.fromJson(List<dynamic> runningResultJson)
      : runningResult = List.from(runningResultJson)
            .map((runningResult) => RunningResult.fromJson(runningResult))
            .toList();
}
