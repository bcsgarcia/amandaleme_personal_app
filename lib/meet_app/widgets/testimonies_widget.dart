import 'package:company_repository/company_repository.dart';
import 'package:flutter/material.dart';

import '../../app/theme/light_theme.dart';

class TestimoniesWidget extends StatelessWidget {
  const TestimoniesWidget({
    super.key,
    required this.testimonies,
  });

  final List<TestimonyModel> testimonies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Text(
            'O que diz quem treina comigo?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 23,
                  color: blackColor,
                ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 125.0 * testimonies.length,
          width: double.infinity,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: testimonies.length,
            itemBuilder: (context, index) {
              var item = testimonies[index];

              return Testimony(imageUrl: item.imageUrl, title: item.name, text: item.description);
            },
          ),
        ),
      ],
    );
  }
}

class Testimony extends StatelessWidget {
  const Testimony({
    super.key,
    required this.title,
    required this.text,
    required this.imageUrl,
  });

  final String imageUrl;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: SizedBox(
        height: 104,
        child: Row(
          children: [
            SizedBox(
              height: 104,
              width: 104,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  height: 104,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
