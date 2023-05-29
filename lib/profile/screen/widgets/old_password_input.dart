import 'package:amandaleme_personal_app/profile/cubits/change-password/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../app/theme/light_theme.dart';

class OldPasswordInput extends StatelessWidget {
  const OldPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Senha atual',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: blackColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
          ),
        ),
        const SizedBox(height: 3),
        BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          buildWhen: (previous, current) => previous.oldPass != current.oldPass || previous.viewOldPass != current.viewOldPass || current.status == FormzSubmissionStatus.failure,
          builder: (context, state) {
            return TextField(
              onChanged: (password) => context.read<ChangePasswordCubit>().oldPassChanged(password),
              obscureText: state.viewOldPass,
              decoration: InputDecoration(
                hintText: 'Inisra sua senha atual',
                errorText: state.status == FormzSubmissionStatus.failure ? "Senha atual inválida" : null,
                suffixIcon: IconButton(
                  onPressed: context.read<ChangePasswordCubit>().viewOldPass,
                  icon: state.viewOldPass ? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.remove_red_eye_rounded),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
