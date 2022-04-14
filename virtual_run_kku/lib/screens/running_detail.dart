import 'package:flutter/material.dart';
import 'package:virtual_run_kku/utils/constants/colors.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';
import 'package:intl/intl.dart';
import 'admin.dart';

class RunningDetail extends StatefulWidget {
  const RunningDetail(
      {Key? key,
      required this.bib,
      required this.imgUrl,
      required this.name,
      required this.distance,
      required this.projectName,
      required this.date})
      : super(key: key);
  final String bib;
  final String imgUrl;
  final String name;
  final double distance;
  final String projectName;
  final String date;

  @override
  State<RunningDetail> createState() => _RunningDetailState();
}

class _RunningDetailState extends State<RunningDetail> {
  Future _showMaxDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Out of Bound problem!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('the maximum value is'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข่าวสารการวิ่ง'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "รูปภาพ",
                style: MyConstant.h2Style(colorSecondary),
              ),
            ),
            _resultPhoto(widget.imgUrl),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "ข้อมูล",
                style: MyConstant.h2Style(colorSecondary),
              ),
            ),
            _detail(widget.name, widget.bib, widget.date, widget.distance,
                widget.projectName),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: SizedBox(
                width: 325,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'คำแนะนำในการปรับปรุงข้อมูล'),
                ),
              ),
            ),
            _buttonChoice(context),
          ],
        ),
      ),
    );
  }
}

Widget _buttonChoice(BuildContext context) {
  double height = 75;
  double width = 75;

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            _showFailedDialog(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            height: height,
            width: width,
            child: const Center(
              child: Icon(
                Icons.close,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _showSuccessDialog(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            height: height,
            width: width,
            child: const Center(
              child: Icon(
                Icons.done,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _resultPhoto(String imgUrl) {
  return Container(
    padding: const EdgeInsets.only(top: 20),
    height: 300,
    width: 500,
    child: Center(
      child: Image(
        image: NetworkImage(imgUrl),
      ),
    ),
  );
}

Widget _detail(
    String name, String bib, String date, double distance, String projectName) {
  final DateFormat formatter = DateFormat('dd MMMM yy');
  DateTime newDate = DateTime.parse(date);
  final String formatted = formatter.format(newDate);
  return Center(
    child: Container(
      width: 350,
      child: Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ชื่อผู้ส่ง: $name",
                style: MyConstant.h3Style(colorSecondary),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "BIB: $bib",
                style: MyConstant.h3Style(colorSecondary),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "ระยะทาง: $distance กิโลเมตร",
                style: MyConstant.h3Style(colorSecondary),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "ชื่อโครงการ: $projectName",
                style: MyConstant.h3Style(colorSecondary),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "ส่งวันที่: $formatted",
                style: MyConstant.h3Style(colorSecondary),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

_showSuccessDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        backgroundColor: Colors.black26,
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Icon(
                Icons.check_circle_outline_outlined,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Success',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: const <Widget>[
          // Center(
          //   child:
          //   ElevatedButton(
          //     style: ElevatedButton.styleFrom(primary: Colors.black12),
          //     child: const Text(
          //       'Success',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 20,
          //       ),
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ),
        ],
      );
    },
  );
}

_showFailedDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        backgroundColor: Colors.black26,
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Icon(
                Icons.close,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Failed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: const <Widget>[
          // Center(
          //   child:
          //   ElevatedButton(
          //     style: ElevatedButton.styleFrom(primary: Colors.black12),
          //     child: const Text(
          //       'Success',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 20,
          //       ),
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ),
        ],
      );
    },
  );
}
