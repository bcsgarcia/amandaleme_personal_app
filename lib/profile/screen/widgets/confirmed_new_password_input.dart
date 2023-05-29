import 'package:amandaleme_personal_app/profile/cubits/change-password/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/light_theme.dart';

class ConfirmedNewPasswordInput extends StatelessWidget {
  const ConfirmedNewPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Confirme a nova senha',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: blackColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
          ),
        ),
        const SizedBox(height: 3),
        BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          buildWhen: (previous, current) => previous.confirmedNewPass != current.confirmedNewPass || previous.viewConfirmedNewPass != current.viewConfirmedNewPass,
          builder: (context, state) {
            return TextField(
              onChanged: (password) => context.read<ChangePasswordCubit>().confirmedPasswordChanged(password),
              obscureText: state.viewConfirmedNewPass,
              decoration: InputDecoration(
                hintText: 'Digite novamente sua nova senha',
                errorText: state.confirmedNewPass.displayError != null ? 'As senhas não correspondem' : null,
                suffixIcon: IconButton(
                  onPressed: context.read<ChangePasswordCubit>().viewConfirmedNewPass,
                  icon: state.viewConfirmedNewPass ? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.remove_red_eye_rounded),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
