import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

class PartnershipItem extends StatelessWidget {
  final PartnershipModel partnership;

  const PartnershipItem({super.key, required this.partnership});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  partnership.imageUrl,
                  height: 75,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    partnership.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      LauncherAdapter.map(partnership.address);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icons/map-pin.png',
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            partnership.address,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 13),
                  GestureDetector(
                    onTap: () async {
                      await LauncherAdapter.phone(partnership.phone);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icons/phone.png',
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(
                          partnership.phone,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
