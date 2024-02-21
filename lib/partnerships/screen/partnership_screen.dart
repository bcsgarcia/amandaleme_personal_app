import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import '../../app/common_widgets/common_widgets.dart';
import '../widgets/widgets.dart';

class PartnershipScreen extends StatefulWidget {
  const PartnershipScreen({
    super.key,
    required this.partnerships,
  });

  final List<PartnershipModel> partnerships;

  @override
  State<PartnershipScreen> createState() => _PartnershipScreenState();
}

class _PartnershipScreenState extends State<PartnershipScreen> {
  List<PartnershipModel> get _partnerships => widget.partnerships;

  Map<String, List<PartnershipModel>> groupedPartnerships = {};

  @override
  void initState() {
    groupedPartnerships = groupByCategory(_partnerships);
    super.initState();
  }

  Map<String, List<PartnershipModel>> groupByCategory(List<PartnershipModel> partnerships) {
    Map<String, List<PartnershipModel>> groupedPartnerships = {};

    for (var partnership in partnerships) {
      groupedPartnerships.putIfAbsent(partnership.category, () => []).add(partnership);
    }

    return groupedPartnerships;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 180, left: 16, right: 16),
                children: [
                  Text(
                    'Confira aqui as nossas parcerias',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 35),
                  ...groupedPartnerships.entries.map((entry) {
                    final category = entry.key;
                    final categoryPartnerships = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ...categoryPartnerships
                            .map(
                              (partnership) => PartnershipItem(partnership: partnership),
                            )
                            .toList(),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
        AppHeaderWithTitleLeadinAndAction(
          title: 'Parcerias',
          leadingButton: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
