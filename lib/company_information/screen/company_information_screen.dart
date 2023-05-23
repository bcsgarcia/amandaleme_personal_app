import 'package:company_repository/company_repository.dart';
import 'package:flutter/material.dart';

import '../../app/common_widgets/common_widgets.dart';
import 'widgets/widgets.dart';

class CompanyInformationScreen extends StatefulWidget {
  const CompanyInformationScreen({
    super.key,
    required this.informations,
  });

  final List<InformationModel> informations;

  @override
  State<CompanyInformationScreen> createState() => _CompanyInformationScreenState();
}

class _CompanyInformationScreenState extends State<CompanyInformationScreen> {
  List<InformationModel> get _informations => widget.informations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeaderWithTitleLeadinAndAction(
          title: 'Informações',
          leadingButton: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        const SizedBox(height: 35),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Informações importantes a serem consideradas',
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _informations.length,
            itemBuilder: (context, index) {
              final currentIndex = index;
              return CustomExpandablePanel(
                title: _informations[currentIndex].title,
                description: _informations[currentIndex].description,
              );
            },
          ),
        ),
      ],
    );
  }
}
