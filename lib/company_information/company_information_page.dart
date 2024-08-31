import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import '../lib.dart';

class CompanyInformationPage extends StatelessWidget {
  const CompanyInformationPage({
    super.key,
    required this.informations,
  });

  final List<InformationModel> informations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        title: 'Informações',
      ),
      body: CompanyInformationScreen(informations: informations),
    );
  }
}
