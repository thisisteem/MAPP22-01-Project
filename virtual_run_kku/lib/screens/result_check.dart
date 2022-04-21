import 'package:flutter/material.dart';
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
    super.initState();
    readChecking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ผลการวิ่ง'),
        centerTitle: true,
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: resultCard(e),
                      );
                    })).toList(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 100, horizontal: 20),
                      child: Center(
                        child: Text(
                          'ยังไม่มีผลการวิ่งที่ต้องตรวจสอบ',
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
    return RunningResultCard(activity: checkingModel);
  }
}
