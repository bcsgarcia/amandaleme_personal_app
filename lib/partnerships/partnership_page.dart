import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import '../lib.dart';

class PartnershipPage extends StatelessWidget {
  const PartnershipPage({
    super.key,
    required this.partnerships,
  });

  final List<PartnershipModel> partnerships;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        title: 'Parcerias',
      ),
      body: PartnershipScreen(
        partnerships: partnerships,
      ),
    );
  }
}
