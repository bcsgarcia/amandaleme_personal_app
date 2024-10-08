import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import '../../lib.dart';

enum EnumImageSide { rigth, left }

class PosturalPatternItemWidget extends StatelessWidget {
  const PosturalPatternItemWidget({
    super.key,
    required this.imageSide,
    required this.index,
    required this.posturalPattern,
  });

  final int index;
  final EnumImageSide imageSide;
  final PosturalPatternModel posturalPattern;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "${index + 1}. ${posturalPattern.title}",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 164,
            child: Row(
              children: [
                if (imageSide == EnumImageSide.left)
                  SizedBox(
                    height: 164,
                    width: 137,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        posturalPattern.media?.url ??
                            'https://dev-personal-media.bcsgarcia.com.br/images/no-image.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: imageSide == EnumImageSide.left ? 14 : 0.0,
                        right: imageSide == EnumImageSide.rigth ? 14 : 0.0),
                    child: LayoutBuilder(builder: (context, constraints) {
                      double descriptionHeight = calculateHeight(
                        posturalPattern.description,
                        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16, height: 1.5),
                        constraints.maxWidth,
                      );

                      return ListView(
                        padding: EdgeInsets.zero,
                        physics: descriptionHeight > 200 ? null : const NeverScrollableScrollPhysics(),
                        children: [
                          Text(
                            posturalPattern.description,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16, height: 1.5),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                if (imageSide == EnumImageSide.rigth)
                  SizedBox(
                    height: 183,
                    width: 137,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        posturalPattern.media?.url ??
                            'https://dev-personal-media.bcsgarcia.com.br/images/no-image.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
