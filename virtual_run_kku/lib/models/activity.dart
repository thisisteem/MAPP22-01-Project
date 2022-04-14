class ActivityModel {
  final int id;
  final String title;
  final int distance;
  final String bib;
  final int timeSpendInSeconds;
  final DateTime eventDate;
  final DateTime sendResultDate;
  // ? Status [checking, approved, rejected]
  final String status;
  final String urlImage;

  ActivityModel({
    required this.id,
    required this.title,
    required this.distance,
    required this.bib,
    required this.timeSpendInSeconds,
    required this.eventDate,
    required this.sendResultDate,
    required this.status,
    required this.urlImage,
  });
}
