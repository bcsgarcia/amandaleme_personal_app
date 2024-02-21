import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

import 'profile.dart';

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
