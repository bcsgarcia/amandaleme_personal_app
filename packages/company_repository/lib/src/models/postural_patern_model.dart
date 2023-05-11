class PosturalPatternModel {
  final String title;
  final String description;
  final String imageUrl;

  PosturalPatternModel({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory PosturalPatternModel.fromJson(Map json) {
    return PosturalPatternModel(
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
