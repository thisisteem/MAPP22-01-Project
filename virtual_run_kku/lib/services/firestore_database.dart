import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_run_kku/models/activity_model.dart';
import 'package:virtual_run_kku/models/news_model.dart';
import 'package:virtual_run_kku/models/profile.dart';
import 'package:virtual_run_kku/screens/activity.dart';
import 'package:virtual_run_kku/widgets/toast.dart';

import '../utils/functions/bib_converter.dart';

final user = FirebaseAuth.instance.currentUser!;

// ! General

Future<bool> checkIfProfileExists(String docName) async {
  try {
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection('Profile');
    var doc = await collectionRef.doc(docName).get();
    return doc.exists;
  } catch (e) {
    rethrow;
  }
}

Future<bool> checkIfUserEventExists({
  required String docName,
}) async {
  try {
    var collectionRef = FirebaseFirestore.instance
        .collection('Profile')
        .doc(user.displayName)
        .collection('Event');
    var doc = await collectionRef.doc(docName).get();
    return doc.exists;
  } catch (e) {
    rethrow;
  }
}

Future<bool> checkIfEventExists({
  required String newsTitle,
}) async {
  try {
    var collectionRef = FirebaseFirestore.instance.collection('Events');
    var doc = await collectionRef.doc(newsTitle).get();
    return doc.exists;
  } catch (e) {
    rethrow;
  }
}

// ! Home Screen
Future joinEvent(NewsModel news) async {
  bool docExists = await checkIfUserEventExists(docName: news.title);
  print('is event exist: $docExists');

  if (!docExists) {
    final docUser =
        FirebaseFirestore.instance.collection('Profile').doc(user.displayName);

    final activity = ActivityModel(
      bib: nextBib(firstChar: news.title[0], number: news.currentBib),
      distance: news.distance,
      eventDate: DateTime.parse(news.date),
      eventImage: news.urlImage,
      isArchive: false,
      isSendResult: false,
      rejectReason: '',
      resultImage: '',
      title: news.title,
      status: '',
    );

    final json = activity.toJson();

    await docUser
        .collection('Event')
        .doc(news.title)
        .set(json)
        .then(
          (value) => toastSuccess(msg: 'เข้าร่วมกิจกรรมสำเร็จ!'),
        )
        .catchError(
      (error) {
        debugPrint("Failed to add user: $error");
        toastError(msg: 'มีบางอย่างผิดพลาด โปรดลองอีกครั้ง');
      },
    );
  } else {
    toastError(msg: 'คุณได้เข้าร่วมกิจกรรมนี้แล้ว');
  }
}

Future createEvent(NewsModel news) async {
  bool newsExists = await checkIfEventExists(newsTitle: news.title);
  print('is event exist: $newsExists');

  if (!newsExists) {
    final docNews = FirebaseFirestore.instance.collection('Events');

    final newsDetails = NewsModel(
      currentBib: 0,
      date: news.date,
      description: news.description,
      distance: news.distance,
      title: news.title,
      urlImage: news.urlImage,
    );

    final json = newsDetails.toJson();

    await docNews
        .doc(news.title)
        .set(json)
        .then(
          (value) => toastSuccess(msg: 'สร้างกิจกรรมสำเร็จ!'),
        )
        .catchError(
      (error) {
        debugPrint("Failed to add user: $error");
        toastError(msg: 'มีบางอย่างผิดพลาด โปรดลองอีกครั้ง');
      },
    );
  } else {
    toastError(msg: 'กิจกรรมนี้มีแล้ว');
  }
}

Future createProfile(
    {required String collectionName, required ProfileModel profileData}) async {
  final docProfile = FirebaseFirestore.instance.collection('Profile');

  final profile = ProfileModel(
    name: profileData.name,
    distance: profileData.distance,
    events: profileData.events,
    timeInSeconds: profileData.timeInSeconds,
    urlImage: profileData.urlImage,
  );

  final json = profile.toJson();

  docProfile.doc(collectionName).set(json);
}

Future<ProfileModel?> readProfile(String docId) async {
  debugPrint('reading profile');
  final docUser = FirebaseFirestore.instance.collection('Profile').doc(docId);
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    return ProfileModel.fromJson(snapshot.data()!);
  }
  return null;
}

Stream<List<NewsModel>> readNews() => FirebaseFirestore.instance
    .collection('Events')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => NewsModel.fromJson(doc.data())).toList());

// ! Send Result Screen

Stream<List<ActivityModel>> readSendResult() => FirebaseFirestore.instance
    .collection('Profile')
    .doc(user.displayName)
    .collection('Event')
    .where('isSendResult', isEqualTo: false)
    // .orderBy('eventDate')
    .snapshots()
    .map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => ActivityModel.fromJson(
              doc.data(),
            ),
          )
          .toList(),
    );

Future sendResult({
  required String activityTitle,
  required int timeSpendInSeconds,
  required double distance,
}) async {
  final docUser =
      FirebaseFirestore.instance.collection('Profile').doc(user.displayName);

  // TODO ส่งรูป

  await docUser
      .collection('Event')
      .doc('HW Virtual Run 2022')
      .update({
        'isSendResult': true,
        'status': 'checking',
        'sendResultDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'timeSpendInSeconds': timeSpendInSeconds,
        'distance': distance,
      })
      .then(
        (value) => toastSuccess(msg: 'ส่งผลการวิ่งสำเร็จ!'),
      )
      .catchError(
        (error) {
          debugPrint("Failed to add user: $error");
          toastError(msg: 'มีบางอย่างผิดพลาด โปรดลองอีกครั้ง');
        },
      );
}

// ! Activity Screen

Stream<List<ActivityModel>> readActivity() => FirebaseFirestore.instance
    .collection('Profile')
    .doc(user.displayName)
    .collection('Event')
    .snapshots()
    .map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => ActivityModel.fromJson(
              doc.data(),
            ),
          )
          .toList(),
    );

void archive(String eventTitle) => FirebaseFirestore.instance
    .collection('Profile')
    .doc(user.displayName)
    .collection('Event')
    .doc(eventTitle)
    .update({
      'isArchive': true,
    })
    .then(
      (value) => toastSuccess(msg: 'กิจกรรมได้ถูกจัดเก็บไปที่ประวัติแล้ว!'),
    )
    .catchError((error) {
      debugPrint("Failed to add user: $error");
      toastError(msg: 'มีบางอย่างผิดพลาด โปรดลองอีกครั้ง');
    });

// ! History Screen

Stream<List<ActivityModel>> readActivityHistory() => FirebaseFirestore.instance
    .collection('Profile')
    .doc(user.displayName)
    .collection('Event')
    .where('isArchive', isEqualTo: true)
    // .orderBy('eventDate', descending: true)
    .snapshots()
    .map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => ActivityModel.fromJson(
              doc.data(),
            ),
          )
          .toList(),
    );
