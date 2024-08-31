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
      appBar: const CustomAppBar(),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: _selectedPage == EnumPageSelected.login
                  ? const LoginBody()
                  : const Padding(
                      padding: EdgeInsets.only(top: 190.0),
                      child: MeetAppScreen(),
                    ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.white,
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
