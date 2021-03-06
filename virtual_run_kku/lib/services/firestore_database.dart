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
  final user = FirebaseAuth.instance.currentUser!;
  try {
    var collectionRef = FirebaseFirestore.instance
        .collection('Profile')
        .doc(user.email)
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

Future<bool> createEventUser(NewsModel news) async {
  final user = FirebaseAuth.instance.currentUser!;

  bool docExists = await checkIfUserEventExists(docName: news.title);
  debugPrint('user: ${user.email}');
  if (!docExists) {
    final docUser =
        FirebaseFirestore.instance.collection('Profile').doc(user.email);

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
          (value) => toastSuccess(msg: '???????????????????????????????????????????????????????????????!'),
        )
        .catchError(
      (error) {
        debugPrint("Failed to add user: $error");
        toastError(msg: '??????????????????????????????????????????????????? ?????????????????????????????????????????????');
      },
    );

    // Increase current BIB of Event
    increaseBib(eventTitle: news.title);
    return true;
  } else {
    toastError(msg: '????????????????????????????????????????????????????????????????????????????????????');
    return false;
  }
}

Future<void> increaseBib({
  required String eventTitle,
}) async {
// Get current bib from database
  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('Events')
      .doc(eventTitle)
      .get();

  final json = snapshot.data()!;

  int currentBib = json['currentBib'];

  await FirebaseFirestore.instance.collection('Events').doc(eventTitle).update({
    'currentBib': currentBib + 1,
  });
}

Future<int> getCurrentEventBib({
  required String eventTitle,
}) async {
  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('Events')
      .doc(eventTitle)
      .get();

  final json = snapshot.data()!;

  int currentBib = json['currentBib'];

  return currentBib;
}

Future createEvent(
    {required NewsModel news,
    required BuildContext context,
    required String fileName}) async {
  bool newsExists = await checkIfEventExists(newsTitle: news.title);
  final fileUploadProvider =
      Provider.of<FileUploadProvider>(context, listen: false);
  debugPrint('is event exist: $newsExists');

  if (!newsExists) {
    await storage.uploadNewsImages(
        fileName: fileUploadProvider.fileName,
        filePath: fileUploadProvider.filePath);
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
          (value) => toastSuccess(msg: '??????????????????????????????????????????????????????!'),
        )
        .catchError(
      (error) {
        debugPrint("Failed to add user: $error");
        toastError(msg: '??????????????????????????????????????????????????? ?????????????????????????????????????????????');
      },
    );
  } else {
    toastError(msg: '????????????????????????????????????????????????');
  }

  String path = 'images/news/$fileName';
  updateNewsImage(path: path, eventTitle: news.title);
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
    .orderBy('date', descending: true)
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => NewsModel.fromJson(doc.data())).toList());

// ! Send Result Screen

Stream<List<ActivityModel>> readSendResult() => FirebaseFirestore.instance
    .collection('Profile')
    .doc(FirebaseAuth.instance.currentUser!.email)
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
  final user = FirebaseAuth.instance.currentUser!;

  final docUser =
      FirebaseFirestore.instance.collection('Profile').doc(user.email);
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
    toastSuccess(msg: '??????????????????????????????????????????????????????!');
  }).catchError(
    (error) {
      debugPrint("Failed to add user: $error");
      toastError(msg: '??????????????????????????????????????????????????? ?????????????????????????????????????????????');
    },
  );

  String path = 'images/results/${user.email}/$fileName';
  updateSendResultImage(path: path, eventTitle: activityTitle);

  // Create Checking for admin
  createCheckingForAdmin(activityTitle: activityTitle);
}

Future<void> updateIsSendResult({
  required String eventTitle,
  required bool status,
}) async {
  final user = FirebaseAuth.instance.currentUser!;

  await FirebaseFirestore.instance
      .collection('Profile')
      .doc(user.email)
      .collection('Event')
      .doc(eventTitle)
      .update({
    'isSendResult': status,
  });
}

Future<void> changeStatus({
  required String eventTitle,
  required String status,
}) async {
  final user = FirebaseAuth.instance.currentUser!;

  await FirebaseFirestore.instance
      .collection('Profile')
      .doc(user.email)
      .collection('Event')
      .doc(eventTitle)
      .update({
    'status': status,
  });
}

Future<void> updateSendResultImage({
  required String eventTitle,
  required String path,
}) async {
  final user = FirebaseAuth.instance.currentUser!;

  await FirebaseFirestore.instance
      .collection('Profile')
      .doc(user.email)
      .collection('Event')
      .doc(eventTitle)
      .update({
    'resultImage': path,
  });
}

Future<void> updateNewsImage({
  required String eventTitle,
  required String path,
}) async {
  await FirebaseFirestore.instance.collection('Events').doc(eventTitle).update({
    'urlImage': path,
  });
}

// ! Activity Screen

Stream<List<ActivityModel>> readActivity() => FirebaseFirestore.instance
    .collection('Profile')
    .doc(FirebaseAuth.instance.currentUser!.email)
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

Future<void> archive(ActivityModel activity) async {
  final user = FirebaseAuth.instance.currentUser!;

  await FirebaseFirestore.instance
      .collection('Profile')
      .doc(user.email)
      .collection('Event')
      .doc(activity.title)
      .update({
    'isArchive': true,
  }).then(
    (value) {
      toastSuccess(msg: '????????????????????????????????????????????????????????????????????????????????????????????????????????????!');
      updateProfileStats(activity: activity);
    },
  ).catchError((error) {
    debugPrint("Failed to add user: $error");
    toastError(msg: '??????????????????????????????????????????????????? ?????????????????????????????????????????????');
  });
}

Future<void> updateProfileStats({
  required ActivityModel activity,
}) async {
  final user = FirebaseAuth.instance.currentUser!;

// Get current bib from database
  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('Profile')
      .doc(user.email)
      .get();

  final json = snapshot.data()!;

  dynamic oldDistance = json['distance'];
  int oldEvents = json['events'];
  int oldTimeInSeconds = json['timeInSeconds'];

  debugPrint('new: ${json['distance']}');
  debugPrint('new: ${json['events']}');
  debugPrint('new: ${json['timeInSeconds']}');

  await FirebaseFirestore.instance
      .collection('Profile')
      .doc(user.email)
      .update({
    'distance': oldDistance + activity.distance,
    'events': oldEvents + 1,
    'timeInSeconds': oldTimeInSeconds + activity.timeSpendInSeconds,
  });
}

// ! History Screen

Stream<List<ActivityModel>> readActivityHistory() => FirebaseFirestore.instance
    .collection('Profile')
    .doc(FirebaseAuth.instance.currentUser!.email)
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

Future<void> createCheckingForAdmin({
  required String activityTitle,
}) async {
  final user = FirebaseAuth.instance.currentUser!;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
      .collection('Profile')
      .doc(user.email)
      .collection('Event')
      .doc(activityTitle)
      .get();

  final json = snapshot.data()!;

  final newJson = {
    'displayName': user.displayName,
    'email': user.email,
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
    email: user.email!,
    eventTitle: activityTitle,
    bib: json['bib'],
  );
  await _firestore.collection('Checking').doc(docName).set(newJson);
}

Future<void> changeStatusAdmin({
  required String eventTitle,
  required String status,
  required String email,
  String? rejectReason,
}) =>
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(email)
        .collection('Event')
        .doc(eventTitle)
        .update({
      'status': status,
      'rejectReason': rejectReason ?? '',
    });

Future<void> deleteChecking({
  required String eventTitle,
  required String email,
  required String bib,
}) async {
  String docName = checkingDocumentIdConverter(
    email: email,
    eventTitle: eventTitle,
    bib: bib,
  );

  FirebaseFirestore.instance.collection('Checking').doc(docName).delete();
}
