import 'package:company_repository/company_repository.dart';
import 'package:flutter/material.dart';

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
      body: PosturalPatternScreen(
        posturalPatterns: posturalPatterns,
      ),
    );
  }
}
