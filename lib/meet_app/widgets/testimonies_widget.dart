import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

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
        if (testimonies.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Nenhum depoimento disponível',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          )
        else
          Column(
            children: [
              for (var item in testimonies)
                Testimony(
                  imageUrl: item.imageUrl,
                  title: item.name,
                  text: item.description,
                ),
            ],
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, exception, stackTrace) {
                return Image.asset('assets/images/avatar.png');
              },
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  title,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 9,
                ),
                TextWidget(
                  text,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
