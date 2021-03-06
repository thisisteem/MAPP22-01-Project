import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:virtual_run_kku/utils/constants/colors.dart';
import 'package:intl/intl.dart';

import '../models/checking_model.dart';
import '../services/firestore_database.dart';

class RunningDetail extends StatefulWidget {
  final CheckingModel activity;
  const RunningDetail({Key? key, required this.activity}) : super(key: key);

  @override
  _RunningDetailState createState() => _RunningDetailState();
}

class _RunningDetailState extends State<RunningDetail> {
  final TextEditingController _rejectReasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text('ตรวจสอบผลการวิ่ง'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            _resultPhoto(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "ข้อมูล",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            _detail(),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 325,
                child: TextField(
                  minLines:
                      2, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  controller: _rejectReasonController,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 24.0,
                  ),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'เหตุผล',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colorGrey)),
                ),
              ),
            ),
            _buttonChoice(),
          ],
        ),
      ),
    );
  }

  Widget _buttonChoice() {
    double height = 75;
    double width = 75;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.confirm,
                title: '',
                confirmBtnText: 'ใช่',
                cancelBtnText: 'ยกเลิก',
                confirmBtnColor: colorRed,
                confirmBtnTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: colorWhite),
                widget: Center(
                  child: Column(
                    children: [
                      Text(
                        'คุณแน่ใจหรือไม่ ที่จะไม่ให้ผ่าน',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'เหตุผล ${_rejectReasonController.text != '' ? _rejectReasonController.text : '-'}',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                onConfirmBtnTap: () async {
                  Navigator.pop(context);
                  _showFailedDialog();
                  await changeStatusAdmin(
                    eventTitle: widget.activity.title,
                    status: 'rejected',
                    email: widget.activity.email,
                    rejectReason: _rejectReasonController.text,
                  );
                  await deleteChecking(
                    eventTitle: widget.activity.title,
                    email: widget.activity.email,
                    bib: widget.activity.bib,
                  );
                },
              );
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
              CoolAlert.show(
                context: context,
                type: CoolAlertType.confirm,
                title: '',
                confirmBtnText: 'ใช่',
                cancelBtnText: 'ยกเลิก',
                confirmBtnColor: colorGreen,
                confirmBtnTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: colorWhite),
                widget: Text(
                  'คุณแน่ใจหรือไม่ ที่จะให้ผ่าน',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                onConfirmBtnTap: () async {
                  Navigator.pop(context);
                  _showSuccessDialog();
                  await changeStatusAdmin(
                    eventTitle: widget.activity.title,
                    status: 'approved',
                    email: widget.activity.email,
                    rejectReason: _rejectReasonController.text,
                  );
                  await deleteChecking(
                    eventTitle: widget.activity.title,
                    email: widget.activity.email,
                    bib: widget.activity.bib,
                  );
                },
              );
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

  Widget _resultPhoto() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Image(
          image: FirebaseImage(
            'gs://virtualrunkku-c67d1.appspot.com/${widget.activity.resultImage}',
            maxSizeBytes: 10000 * 1000,
          ),
        ),
      ),
    );
  }

  Widget _detail() {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'ชื่อผู้ส่ง: ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: colorGrey),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.activity.displayName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            RichText(
              text: TextSpan(
                text: 'BIB: ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: colorGrey),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.activity.bib,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            RichText(
              text: TextSpan(
                text: 'ระยะทาง: ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: colorGrey),
                children: <TextSpan>[
                  TextSpan(
                    text: '${widget.activity.distance} กม.',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            RichText(
              text: TextSpan(
                text: 'กิจกรรม: ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: colorGrey),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.activity.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            RichText(
              text: TextSpan(
                text: 'วันที่ส่ง: ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: colorGrey),
                children: <TextSpan>[
                  TextSpan(
                    text: DateFormat('dd MMMM yyyy', 'th')
                        .format(widget.activity.sendResultDate!),
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showSuccessDialog() {
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
                    'ผ่าน',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) => Navigator.of(context).pop());
  }

  _showFailedDialog() {
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
                    'ไม่ผ่าน',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) => Navigator.of(context).pop());
  }
}
