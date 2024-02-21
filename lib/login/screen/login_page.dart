import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../lib.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  EnumPageSelected _selectedPage = EnumPageSelected.meetApp;

  @override
  void initState() {
    super.initState();

    context.read<MeetAppCubit>().retrieveMeetAppScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            _selectedPage == EnumPageSelected.login ? const LoginBody() : const MeetAppScreen(),
            // _bodyPage,
            const LoginHeader(),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                height: 94,
                child: MeetAppAndLogin(
                  function: (page) => setState(() => _selectedPage = page),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
