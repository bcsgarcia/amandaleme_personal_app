import 'package:amandaleme_personal_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import 'profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Perfil',
      ),
      body: ProfileScreen(userModel: userModel),
    );
  }
}
