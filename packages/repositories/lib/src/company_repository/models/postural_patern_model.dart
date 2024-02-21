import 'models.dart';

class PosturalPatternModel {
  final String title;
  final String description;
  final PosturalPatternMediaModel? media;

  PosturalPatternModel({
    required this.title,
    required this.description,
    required this.media,
  });

  factory PosturalPatternModel.fromJson(Map json) {
    return PosturalPatternModel(
      title: json['title'] as String,
      description: json['description'] as String,
      media:json['media'] != null ? PosturalPatternMediaModel.fromMap(json['media']) : null,
    );
  }

  Map toMap() {
    return {
      'title': title,
      'description': description,
      'media': media,
    };
  }
}
