import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/models/activity_model.dart';
import 'package:virtual_run_kku/models/news_model.dart';
import 'package:virtual_run_kku/models/profile.dart';
import 'package:virtual_run_kku/widgets/toast.dart';

import '../models/checking_model.dart';
import '../providers/file_upload_provider.dart';
import '../utils/functions/bib_converter.dart';
import '../utils/functions/checking_document_id_converter.dart';
import 'firestore_storage.dart';

final user = FirebaseAuth.instance.currentUser!;
final FirebaseStorage storage = FirebaseStorage();

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

// ! Home Screen

Future createEvent(NewsModel news) async {
  bool docExists = await checkIfUserEventExists(docName: news.title);

  if (!docExists) {
    final docUser =
        FirebaseFirestore.instance.collection('Profile').doc(user.displayName);

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
  } else {
    toastError(msg: 'คุณได้เข้าร่วมกิจกรรมนี้แล้ว');
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
    .orderBy('eventDate')
    .orderBy('title')
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
  String? fileName,
  required BuildContext context,
}) async {
  final docUser =
      FirebaseFirestore.instance.collection('Profile').doc(user.displayName);
  final fileUploadProvider =
      Provider.of<FileUploadProvider>(context, listen: false);

  await storage.uploadFile(
      fileName: fileUploadProvider.fileName,
      filePath: fileUploadProvider.filePath);

  await docUser.collection('Event').doc(activityTitle).update({
    'isSendResult': true,
    'status': 'checking',
    'sendResultDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'timeSpendInSeconds': timeSpendInSeconds,
    'distance': distance,
  }).then((value) {
    toastSuccess(msg: 'ส่งผลการวิ่งสำเร็จ!');
  }).catchError(
    (error) {
      debugPrint("Failed to add user: $error");
      toastError(msg: 'มีบางอย่างผิดพลาด โปรดลองอีกครั้ง');
    },
  );

  String path = 'images/results/${user.email}/$fileName';
  updateSendResultImage(path: path, eventTitle: activityTitle);

  // Create Checking for admin
  createCheckingForAdmin(activityTitle: activityTitle);
}

void updateIsSendResult({
  required String eventTitle,
  required bool status,
}) =>
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(user.displayName)
        .collection('Event')
        .doc(eventTitle)
        .update({
      'isSendResult': status,
    });

Future<void> changeStatus({
  required String eventTitle,
  required String status,
}) =>
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(user.displayName)
        .collection('Event')
        .doc(eventTitle)
        .update({
      'status': status,
    });

void updateSendResultImage({
  required String eventTitle,
  required String path,
}) =>
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(user.displayName)
        .collection('Event')
        .doc(eventTitle)
        .update({
      'resultImage': path,
    });

// ! Activity Screen

Stream<List<ActivityModel>> readActivity() => FirebaseFirestore.instance
    .collection('Profile')
    .doc(user.displayName)
    .collection('Event')
    .orderBy('status', descending: false)
    .orderBy('title')
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
    .orderBy('eventDate', descending: true)
    .orderBy('title', descending: false)
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

Stream<List<CheckingModel>> readChecking() =>
    FirebaseFirestore.instance.collection('Checking').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => CheckingModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
// ! Admin

void createCheckingForAdmin({required String activityTitle}) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
      .collection('Profile')
      .doc(user.displayName)
      .collection('Event')
      .doc(activityTitle)
      .get();

  final json = snapshot.data()!;

  final newJson = {
    'displayName': user.displayName,
    'title': json['title'],
    'distance': json['distance'],
    'bib': json['bib'],
    'timeSpendInSeconds': json['timeSpendInSeconds'],
    'eventDate': json['eventDate'],
    'eventImage': json['eventImage'],
    'sendResultDate': json['sendResultDate'],
    'isSendResult': json['isSendResult'],
    'isArchive': json['isArchive'],
    'status': json['status'],
    'rejectReason': json['rejectReason'],
    'resultImage': json['resultImage'],
  };
  String docName = checkingDocumentIdConverter(
    displayName: user.displayName!,
    eventTitle: activityTitle,
    bib: json['bib'],
  );
  await _firestore.collection('Checking').doc(docName).set(newJson);
}

Future<void> changeStatusAdmin({
  required String eventTitle,
  required String status,
  required String displayName,
}) =>
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(displayName)
        .collection('Event')
        .doc(eventTitle)
        .update({
      'status': status,
    });
