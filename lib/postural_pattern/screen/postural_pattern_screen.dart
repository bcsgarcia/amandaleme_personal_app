import 'package:amandaleme_personal_app/app/common_widgets/common_widgets.dart';
import 'package:company_repository/company_repository.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class PosturalPatternScreen extends StatelessWidget {
  const PosturalPatternScreen({
    super.key,
    required this.posturalPatterns,
  });

  final List<PosturalPatternModel> posturalPatterns;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 150),
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Fotos bem feitas são de extrema importância na avaliação correta do padrão postural global',
                      textAlign: TextAlign.justify,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const HowToTakeAPictureWidget(),
                  const SizedBox(height: 30),
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: List.generate(
                        posturalPatterns.length,
                        (index) => PosturalPatternItemWidget(
                          imageSide: index % 2 != 0
                              ? EnumImageSide.rigth
                              : EnumImageSide.left,
                          index: index,
                          posturalPattern: posturalPatterns[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        AppHeaderWithTitleLeadinAndAction(
          title: 'Padrões posturais',
          leadingButton: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
