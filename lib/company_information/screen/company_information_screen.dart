import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import '../widgets/widgets.dart';

class CompanyInformationScreen extends StatelessWidget {
  const CompanyInformationScreen({
    super.key,
    required this.informations,
  });

  final List<InformationModel> informations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 190, bottom: 16),
            itemCount: informations.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
                  child: Text(
                    'Informações importantes a serem consideradas',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                );
              }

              final currentIndex = index - 1;
              return CustomExpandablePanel(
                title: informations[currentIndex].title,
                description: informations[currentIndex].description,
              );
            },
          ),
        ),
      ],
    );
  }
}
