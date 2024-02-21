import 'models.dart';

class MeetAppScreenModel {
  AboutCompanyModel aboutCompany;
  List<TestimonyModel> testemonies;
  List<String> photosBeforeAndAfter;

  MeetAppScreenModel({
    required this.aboutCompany,
    required this.testemonies,
    required this.photosBeforeAndAfter,
  });

  factory MeetAppScreenModel.fromJson(Map json) => MeetAppScreenModel(
        aboutCompany: AboutCompanyModel.fromJson(json['aboutCompany']),
        testemonies: List<TestimonyModel>.from(json['testemonies'].map((x) => TestimonyModel.fromJson(x))),
        photosBeforeAndAfter: List<String>.from(json['photosBeforeAndAfter'].map((x) => x['imageUrl'] ?? '')),
      );

  Map toJson() => {
        'aboutCompany': aboutCompany.toJson(),
        'testemonies': List<dynamic>.from(testemonies.map((x) => x.toJson())),
        'photosBeforeAndAfter': List<dynamic>.from(photosBeforeAndAfter.map((x) => x)),
      };
}
