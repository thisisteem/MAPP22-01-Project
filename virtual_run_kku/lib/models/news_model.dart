class NewsModel {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final String urlImage;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.urlImage,
  });
}