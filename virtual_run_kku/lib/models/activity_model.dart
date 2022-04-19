import 'package:intl/intl.dart';

class ActivityModel {
  final String title;
  final double distance;
  final String bib;
  final int? timeSpendInSeconds;
  final DateTime eventDate;
  final DateTime? sendResultDate;
  // ? Status [checking, approved, rejected]
  final bool isSendResult;
  final bool isArchive;
  final String status;
  final String rejectReason;
  final String? resultImage;
  final String eventImage;

  ActivityModel({
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
  });

  Map<String, dynamic> toJson({
    String? firstTitleChar,
  }) =>
      {
        'title': title,
        'distance': distance,
        'bib': bib,
        'timeSpendInSeconds': timeSpendInSeconds,
        'eventDate': DateFormat('yyyy-MM-dd').format(eventDate),
        'eventImage': eventImage,
        'sendResultDate': sendResultDate,
        'isSendResult': isSendResult,
        'isArchive': isArchive,
        'status': status,
        'rejectReason': rejectReason,
        'resultImage': resultImage,
      };
}
