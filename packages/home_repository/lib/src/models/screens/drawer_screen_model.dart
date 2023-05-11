import 'package:company_repository/company_repository.dart';
import 'package:user_repository/user_repository.dart';

class DrawerScreenModel {
  final UserModel userModel;
  final List<InformationModel> informations;
  final List<PosturalPatternModel> posturalPatterns;
  final List<PartnershipModel> partnerships;

  DrawerScreenModel({
    required this.userModel,
    required this.informations,
    required this.posturalPatterns,
    required this.partnerships,
  });

  factory DrawerScreenModel.fromJson(Map json) {
    return DrawerScreenModel(
      userModel: UserModel.fromJson(json['clientDto']),
      informations: List<InformationModel>.from(json['companyTipsInformation']
          .map((item) => InformationModel.fromJson(item))),
      posturalPatterns: List<PosturalPatternModel>.from(
          json['companyPosturalPatterns']
              .map((item) => PosturalPatternModel.fromJson(item))),
      partnerships: List<PartnershipModel>.from(json['companyPartnerships']
          .map((item) => PartnershipModel.fromJson(item))),
    );
  }

  Map toMap() {
    return {
      'userModel': userModel.toJson(),
      'informations': informations.map((item) => item.toMap()).toList(),
      'posturalPatterns': posturalPatterns.map((item) => item.toMap()).toList(),
      'partnerships': partnerships.map((item) => item.toMap()).toList(),
    };
  }
}
