class ActivityModel {
  final String title;
  final int distance;
  final String bib;
  final int? timeSpendInSeconds;
  final DateTime eventDate;
  final DateTime? sendResultDate;
  // ? Status [checking, approved, rejected]
  final bool isSendResult;
  final bool isArchive;
  final String status;
  final String rejectReason;
  final String urlImage;

  ActivityModel({
    required this.title,
    required this.distance,
    required this.bib,
    this.timeSpendInSeconds,
    required this.eventDate,
    this.sendResultDate,
    required this.isSendResult,
    required this.isArchive,
    required this.status,
    required this.rejectReason,
    required this.urlImage,
  });
}
