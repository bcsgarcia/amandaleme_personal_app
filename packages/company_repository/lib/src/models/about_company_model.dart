class AboutCompanyModel {
  String imageUrl;
  String description;
  String videoUrl;
  String secondVideoUrl;

  AboutCompanyModel({
    required this.imageUrl,
    required this.description,
    required this.videoUrl,
    required this.secondVideoUrl,
  });

  factory AboutCompanyModel.fromJson(Map json) => AboutCompanyModel(
        imageUrl: json['imageUrl'],
        description: json['description'],
        videoUrl: json['videoUrl'],
        secondVideoUrl: json['secondVideoUrl'],
      );

  Map toJson() => {
        'imageUrl': imageUrl,
        'description': description,
        'videoUrl': videoUrl,
        'secondVideoUrl': secondVideoUrl,
      };
}
