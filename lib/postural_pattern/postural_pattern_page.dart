import 'package:amandaleme_personal_app/postural_pattern/screen/postural_pattern_screen.dart';
import 'package:company_repository/company_repository.dart';
import 'package:flutter/material.dart';

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
