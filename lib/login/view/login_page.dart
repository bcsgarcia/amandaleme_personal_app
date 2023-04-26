import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:amandaleme_personal_app/login/view/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../meet_app/view/meet_app_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Widget _bodyLogin = const LoginBody();
  final Widget _bodyMeetApp = const MeetAppScreen();

  late Widget _bodyPage;

  @override
  void initState() {
    super.initState();
    _bodyPage = _bodyMeetApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _bodyPage,
            SizedBox(
              height: 94,
              child: MeetAppAndLogin(
                function: (page) {
                  if (page == EnumPageSelected.login) {
                    _bodyPage = _bodyLogin;
                  } else {
                    _bodyPage = _bodyMeetApp;
                  }
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
