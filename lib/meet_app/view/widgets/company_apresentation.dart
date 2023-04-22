import 'package:company_repository/company_repository.dart';
import 'package:flutter/material.dart';

class AmandaApresentation extends StatelessWidget {
  const AmandaApresentation({
    super.key,
    required this.aboutCompanyModel,
  });

  final AboutCompanyModel aboutCompanyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 183,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            height: 183,
            width: 137,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                aboutCompanyModel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  Text(
                    aboutCompanyModel.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
