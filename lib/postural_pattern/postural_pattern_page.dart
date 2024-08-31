import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import '../lib.dart';

class PosturalPatternPage extends StatelessWidget {
  const PosturalPatternPage({
    super.key,
    required this.posturalPatterns,
  });

  final List<PosturalPatternModel> posturalPatterns;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        title: 'Padrões posturais',
      ),
      body: PosturalPatternScreen(
        posturalPatterns: posturalPatterns,
      ),
    );
  }
}
