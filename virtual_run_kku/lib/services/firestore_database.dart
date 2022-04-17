import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_run_kku/models/activity_model.dart';
import 'package:virtual_run_kku/models/news_model.dart';
import 'package:virtual_run_kku/widgets/toast.dart';

Future joinEvent(NewsModel news) async {
  final docUser = FirebaseFirestore.instance.collection('Profile');

  // final activity = ActivityModel(
  //   title: news.title,
  //   distance: distance,
  //   bib: bib,
  //   eventDate: eventDate,
  //   isSendResult: isSendResult,
  //   isArchive: isArchive,
  //   status: status,
  //   rejectReason: rejectReason,
  //   urlImage: urlImage,
  // );

  // await docUser
  //     .doc('teem')
  //     .set(activity)
  //     .then(
  //       (value) => toastSuccess(msg: 'เข้าร่วมกิจกรรมสำเร็จ!'),
  //     )
  //     .catchError(
  //   (error) {
  //     print("Failed to add user: $error");
  //     toastError(msg: 'มีบางอย่างผิดพลาด โปรดลองอีกครั้ง');
  //   },
  // );
}
