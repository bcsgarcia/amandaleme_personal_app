import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import 'screen/screen.dart';

class PartnershipPage extends StatelessWidget {
  const PartnershipPage({
    super.key,
    required this.partnerships,
  });

  final List<PartnershipModel> partnerships;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PartnershipScreen(
        partnerships: partnerships,
      ),
    );
  }
}
