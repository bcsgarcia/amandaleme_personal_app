import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

class CompanyPresentationWidget extends StatelessWidget {
  const CompanyPresentationWidget({
    super.key,
    required this.aboutCompanyModel,
  });

  final AboutCompanyModel aboutCompanyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 183,
            width: 137,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                aboutCompanyModel.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Image.asset('assets/images/logos/amanda-01.png', fit: BoxFit.cover);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                aboutCompanyModel.description,

                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 14,
                    ),
                // textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }
}
