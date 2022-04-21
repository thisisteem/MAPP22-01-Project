class ProfileModel {
  final String name;
  final dynamic distance;
  final dynamic events;
  final dynamic timeInSeconds;
  final String urlImage;

  ProfileModel({
    required this.name,
    required this.distance,
    required this.events,
    required this.timeInSeconds,
    required this.urlImage,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'distance': distance,
        'events': events,
        'timeInSeconds': timeInSeconds,
        'urlImage': urlImage,
      };

  static ProfileModel fromJson(Map<String, dynamic> json) => ProfileModel(
        name: json['name'],
        distance: json['distance'],
        events: json['events'],
        timeInSeconds: json['timeInSeconds'],
        urlImage: json['urlImage'],
      );
}
