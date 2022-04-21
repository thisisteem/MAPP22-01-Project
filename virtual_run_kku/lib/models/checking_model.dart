import 'package:intl/intl.dart';

class CheckingModel {
  final String title;
  final dynamic distance;
  final String bib;
  final dynamic timeSpendInSeconds;
  final DateTime eventDate;
  final DateTime? sendResultDate;
  // ? Status [checking, approved, rejected]
  final bool isSendResult;
  final bool isArchive;
  final String status;
  final String rejectReason;
  final String? resultImage;
  final String eventImage;
  final String displayName;
  final String email;

  CheckingModel({
    required this.title,
    required this.distance,
    required this.bib,
    this.timeSpendInSeconds,
    required this.eventDate,
    required this.eventImage,
    this.sendResultDate,
    required this.isSendResult,
    required this.isArchive,
    required this.status,
    required this.rejectReason,
    this.resultImage,
    required this.displayName,
    required this.email,
  });

  Map<String, dynamic> toJson({
    String? firstTitleChar,
  }) =>
      {
        'title': title,
        'distance': distance,
        'bib': bib,
        'timeSpendInSeconds': timeSpendInSeconds ?? 0,
        'eventDate': DateFormat('yyyy-MM-dd').format(eventDate),
        'eventImage': eventImage,
        'sendResultDate': sendResultDate ?? '1000-01-01',
        'isSendResult': isSendResult,
        'isArchive': isArchive,
        'status': status,
        'rejectReason': rejectReason,
        'resultImage': resultImage ?? '',
        'displayName': displayName,
        'email': email,
      };

  static CheckingModel fromJson(Map<String, dynamic> json) => CheckingModel(
        title: json['title'],
        distance: json['distance'],
        bib: json['bib'],
        timeSpendInSeconds: json['timeSpendInSeconds'],
        eventDate: DateTime.parse(json['eventDate']),
        eventImage: json['eventImage'],
        sendResultDate: DateTime.parse(json['sendResultDate']),
        isSendResult: json['isSendResult'],
        isArchive: json['isArchive'],
        status: json['status'],
        rejectReason: json['rejectReason'],
        resultImage: json['resultImage'],
        displayName: json['displayName'],
        email: json['email'],
      );
}
