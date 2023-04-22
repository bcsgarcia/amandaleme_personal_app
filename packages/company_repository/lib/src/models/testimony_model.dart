class TestimonyModel {
  String imageUrl;
  String name;
  String description;

  TestimonyModel({
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  factory TestimonyModel.fromJson(Map json) => TestimonyModel(
        imageUrl: json['imageUrl'],
        name: json['name'],
        description: json['description'],
      );

  Map toJson() => {
        'imageUrl': imageUrl,
        'name': name,
        'description': description,
      };
}
