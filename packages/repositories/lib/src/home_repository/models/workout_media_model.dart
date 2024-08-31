class WorkoutMedia {
  final String id;
  final String title;
  final String format;
  final String type;
  final String? thumbnailUrl;
  final String url;
  final int mediaOrder;

  WorkoutMedia({
    required this.id,
    required this.title,
    required this.format,
    required this.type,
    required this.url,
    required this.mediaOrder,
    this.thumbnailUrl,
  });

  factory WorkoutMedia.fromJson(Map json) => WorkoutMedia(
        id: json['id'],
        title: json['title'],
        format: json['format'],
        type: json['type'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl'],
        mediaOrder: json['mediaOrder'],
      );

  Map toJson() => {
        'id': id,
        'title': title,
        'format': format,
        'type': type,
        'url': url,
        'thumbnailUrl': thumbnailUrl,
        'mediaOrder': mediaOrder,
      };
}
