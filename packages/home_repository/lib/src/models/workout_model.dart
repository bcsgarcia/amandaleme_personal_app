class WorkoutModel {
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final int order;
  final int breaktime;
  final String serie;
  bool done;

  WorkoutModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.order,
    required this.breaktime,
    required this.serie,
    this.done = false,
  });

  factory WorkoutModel.fromJson(Map json) {
    return WorkoutModel(
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      order: json['order'],
      breaktime: json['breaktime'],
      serie: json['serie'],
    );
  }

  Map toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'order': order,
      'breaktime': breaktime,
      'serie': serie,
    };
  }
}
