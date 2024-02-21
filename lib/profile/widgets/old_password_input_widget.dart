import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../app/app.dart';
import '../profile.dart';

class OldPasswordInputWidget extends StatelessWidget {
  const OldPasswordInputWidget({super.key});

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
          buildWhen: (previous, current) =>
              previous.oldPass != current.oldPass ||
              previous.viewOldPass != current.viewOldPass ||
              current.status == FormzSubmissionStatus.failure,
          builder: (context, state) {
            return TextField(
              onChanged: (password) => context.read<ChangePasswordCubit>().oldPassChanged(password),
              obscureText: state.viewOldPass,
              decoration: InputDecoration(
                hintText: 'Insira sua senha atual',
                errorText: state.status == FormzSubmissionStatus.failure ? "Senha atual inválida" : null,
                suffixIcon: IconButton(
                  onPressed: context.read<ChangePasswordCubit>().viewOldPass,
                  icon: Image.asset(
                      state.viewOldPass ? 'assets/images/icons/eye.png' : 'assets/images/icons/eye-off.png',
                      height: 22),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
