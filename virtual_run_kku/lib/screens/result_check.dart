import 'dart:ffi';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:virtual_run_kku/screens/running_detail.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';
import 'package:virtual_run_kku/widgets/running_result_card.dart';
import 'package:virtual_run_kku/screens/admin.dart';

class ResultCheck extends StatefulWidget {
  const ResultCheck({Key? key}) : super(key: key);

  @override
  State<ResultCheck> createState() => _ResultCheckState();
}

class _ResultCheckState extends State<ResultCheck> {
  List<RunningResult> _runningResultList = [];

  void getData() async {
    var url = Uri.parse(
        "https://api.json-generator.com/templates/qnqJFFDD5A16/data?access_token=303cetegl6kljis2b7y0flojifv882vgy0d7pbqs");
    http.Response response = await http.get(url);
    setState(() {
      _runningResultList =
          RunningResultList.fromJson(jsonDecode(response.body)).runningResult;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        child: AppBarTest(),
        preferredSize: Size.fromHeight(55),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                'ผลการวิ่งที่ต้องการการตรวจสอบ',
                style: MyConstant.h2Style(MyConstant.secondary),
              ),
              alignment: Alignment.bottomLeft,
            ),
            ListView.builder(
              itemCount: _runningResultList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RunningDetail(
                        bib: _runningResultList[index].bib,
                        imgUrl: _runningResultList[index].imgUrl,
                        name: _runningResultList[index].name,
                        date: _runningResultList[index].date,
                        projectName: _runningResultList[index].projectName,
                        distance: _runningResultList[index].distance,
                      ),
                    ),
                  ),
                  child: RunningResultCard(
                    status: _runningResultList[index].status,
                    bib: _runningResultList[index].bib,
                    distance: _runningResultList[index].distance,
                    date: _runningResultList[index].date,
                  ),
                );
              },
            ),
          ],
        ),
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
