import 'package:flutter/material.dart';

import '../../lib.dart';

enum EnumPageSelected { login, meetApp }

class MeetAppAndLogin extends StatefulWidget {
  const MeetAppAndLogin({
    super.key,
    required this.function,
  });

  final Function(EnumPageSelected) function;

  @override
  State<MeetAppAndLogin> createState() => _MeetAppAndLoginState();
}

class _MeetAppAndLoginState extends State<MeetAppAndLogin> {
  EnumPageSelected _pageSelected = EnumPageSelected.meetApp;

  selectedOption(EnumPageSelected pageSelected) {
    _pageSelected = pageSelected;
    widget.function(pageSelected);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: _pageSelected == EnumPageSelected.meetApp ? 0 : (MediaQuery.of(context).size.width / 2) - 12,
                child: Container(
                  height: 50,
                  width: (MediaQuery.of(context).size.width / 2) - 20,
                  decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(10), boxShadow: [
                    defaultBoxShadow(),
                  ]),
                ),
              ),
              Positioned(
                left: 15,
                child: TextButton(
                  onPressed: () => selectedOption(EnumPageSelected.meetApp),
                  child: const Text(
                    textAlign: TextAlign.left,
                    'Conheça o app',
                    style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                right: 55,
                child: TextButton(
                  onPressed: () => selectedOption(EnumPageSelected.login),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
