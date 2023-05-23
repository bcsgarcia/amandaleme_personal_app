class WorkoutMedia {
  final String id;
  final String title;
  final String format;
  final String type;
  final String url;

  WorkoutMedia({
    required this.id,
    required this.title,
    required this.format,
    required this.type,
    required this.url,
  });

  factory WorkoutMedia.fromJson(Map json) => WorkoutMedia(
        id: json['id'],
        title: json['title'],
        format: json['format'],
        type: json['type'],
        url: json['url'],
      );

  Map toJson() => {
        'id': id,
        'title': title,
        'format': format,
        'type': type,
        'url': url,
      };
}
