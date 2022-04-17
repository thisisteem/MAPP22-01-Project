import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';

class ListBugReport extends StatefulWidget {
  const ListBugReport({Key? key}) : super(key: key);

  @override
  State<ListBugReport> createState() => _ListBugReportState();
}

class _ListBugReportState extends State<ListBugReport> {
  List<bugDetails> _bugDetailsList = [
    bugDetails(name: "asdasd", bugDetail: "asdasd", date: "4/10/2565"),
    bugDetails(
        name: "asdasd",
        bugDetail:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        date: "4/10/2565")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การรายงาน'),
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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                'รายการบัคที่ถูกรายงาน',
                style: MyConstant.h2Style(colorSecondary),
              ),
              alignment: Alignment.bottomLeft,
            ),
            ListView.builder(
              itemCount: _bugDetailsList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'จาก ' +
                        _bugDetailsList[index].name +
                        " ณ วันที่ " +
                        _bugDetailsList[index].date,
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(_bugDetailsList[index].bugDetail),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class bugDetails {
  final String name;
  final String bugDetail;
  final String date;

  const bugDetails({
    required this.name,
    required this.bugDetail,
    required this.date,
  });
}
