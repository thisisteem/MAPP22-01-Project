class NewsModel {
  final String title;
  final dynamic distance;
  final String description;
  final String date;
  final String urlImage;
  final dynamic currentBib;

  NewsModel({
    required this.title,
    required this.distance,
    required this.description,
    required this.date,
    required this.urlImage,
    required this.currentBib,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'distance': distance,
        'description': description,
        'date': date,
        'urlImage': urlImage,
        'currentBib': currentBib
      };

  static NewsModel fromJson(Map<String, dynamic> json) => NewsModel(
        title: json['title'],
        distance: json['distance'],
        description: json['description'],
        date: json['date'],
        urlImage: json['urlImage'],
        currentBib: json['currentBib'],
      );
}
