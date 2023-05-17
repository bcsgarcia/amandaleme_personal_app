import 'package:amandaleme_personal_app/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileScreen(userModel: userModel),
    );
  }
}
