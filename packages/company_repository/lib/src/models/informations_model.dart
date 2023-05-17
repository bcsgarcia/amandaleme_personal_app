class InformationModel {
  final String title;
  final String description;
  bool isExpanded;

  InformationModel({
    required this.title,
    required this.description,
    this.isExpanded = false,
  });

  factory InformationModel.fromJson(Map json) {
    return InformationModel(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  Map toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
