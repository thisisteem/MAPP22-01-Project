import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtual_run_kku/models/activity_model.dart';
import 'package:virtual_run_kku/models/news_model.dart';
import 'package:virtual_run_kku/models/profile.dart';
import 'package:virtual_run_kku/widgets/toast.dart';

import '../utils/functions/bib_converter.dart';

final user = FirebaseAuth.instance.currentUser!;

Future joinEvent(NewsModel news) async {
  final docUser =
      FirebaseFirestore.instance.collection('Profile').doc(user.displayName);

  String titleFirstChar = news.title[0];

  final activity = ActivityModel(
    bib: nextBib(firstChar: news.title[0], number: news.currentBib),
    distance: news.distance,
    eventDate: news.date,
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
}

Stream<List<NewsModel>> readNews() =>
    FirebaseFirestore.instance.collection('Events').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => NewsModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );

/// Check If Document Exists
Future<bool> checkIfDocExists(String docName) async {
  try {
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection('Profile');
    var doc = await collectionRef.doc(docName).get();
    return doc.exists;
  } catch (e) {
    rethrow;
  }
}
