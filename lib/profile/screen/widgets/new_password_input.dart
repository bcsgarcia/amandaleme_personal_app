import 'package:amandaleme_personal_app/profile/cubits/change-password/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/light_theme.dart';

class NewPasswordInput extends StatelessWidget {
  const NewPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Nova senha',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: blackColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
          ),
        ),
        const SizedBox(height: 3),
        BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          buildWhen: (previous, current) => previous.newPass != current.newPass || previous.viewNewPass != current.viewNewPass,
          builder: (context, state) {
            return TextField(
              onChanged: (password) => context.read<ChangePasswordCubit>().newPassChanged(password),
              obscureText: state.viewNewPass,
              decoration: InputDecoration(
                hintText: 'Insira sua nova senha',
                suffixIcon: IconButton(
                  onPressed: context.read<ChangePasswordCubit>().viewNewPass,
                  icon: Image.asset(state.viewNewPass ? 'assets/images/icons/eye.png' : 'assets/images/icons/eye-off.png', height: 22),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
