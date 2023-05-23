class MediaSyncModel {
  final String id;
  final String url;
  final String type;

  MediaSyncModel({
    required this.id,
    required this.url,
    required this.type,
  });

  factory MediaSyncModel.fromJson(Map json) {
    return MediaSyncModel(id: json['id'], url: json['url'], type: json['type']);
  }
}
