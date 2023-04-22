class AboutCompanyModel {
  String imageUrl;
  String description;
  String videoUrl;

  AboutCompanyModel({
    required this.imageUrl,
    required this.description,
    required this.videoUrl,
  });

  factory AboutCompanyModel.fromJson(Map json) => AboutCompanyModel(
        imageUrl: json['imageUrl'],
        description: json['description'],
        videoUrl: json['videoUrl'],
      );

  Map toJson() => {
        'imageUrl': imageUrl,
        'description': description,
        'videoUrl': videoUrl,
      };
}
