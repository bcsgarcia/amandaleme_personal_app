import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:amandaleme_personal_app/profile/screen/widgets/change_password_form.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_sharp,
            color: blackColor,
            size: 35,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Alterar senha',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          ListTile(
            title: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Criar nova senha',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            subtitle: Text(
              'Sua nova senha deve ser diferente da senha anteriormente usada.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            ),
          ),
          const SizedBox(height: 38),
          ChangePasswordForm(),
        ],
      ),
    );
  }
}
