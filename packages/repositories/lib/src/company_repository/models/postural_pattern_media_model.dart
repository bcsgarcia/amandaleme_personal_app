class PosturalPatternMediaModel {
  final String id;
  final String url;

  PosturalPatternMediaModel({
    required this.id,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
    };
  }

  factory PosturalPatternMediaModel.fromMap(Map<String, dynamic> map) {
    return PosturalPatternMediaModel(
      id: map['id'] as String,
      url: map['url'] as String,
    );
  }
}
