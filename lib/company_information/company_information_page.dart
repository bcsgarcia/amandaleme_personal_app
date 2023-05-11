import 'package:amandaleme_personal_app/company_information/screen/company_information_screen.dart';
import 'package:company_repository/company_repository.dart';
import 'package:flutter/material.dart';

class CompanyInformationPage extends StatelessWidget {
  const CompanyInformationPage({
    super.key,
    required this.informations,
  });

  final List<InformationModel> informations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CompanyInformationScreen(informations: informations),
    );
  }
}
