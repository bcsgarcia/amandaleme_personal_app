import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../profile.dart';

class ConfirmedNewPasswordInputWidget extends StatelessWidget {
  const ConfirmedNewPasswordInputWidget({super.key});

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
          buildWhen: (previous, current) =>
              previous.confirmedNewPass != current.confirmedNewPass ||
              previous.viewConfirmedNewPass != current.viewConfirmedNewPass,
          builder: (context, state) {
            return TextField(
              onChanged: (password) => context.read<ChangePasswordCubit>().confirmedPasswordChanged(password),
              obscureText: state.viewConfirmedNewPass,
              decoration: InputDecoration(
                hintText: 'Digite novamente sua nova senha',
                errorText: state.confirmedNewPass.displayError != null ? 'As senhas não correspondem' : null,
                suffixIcon: IconButton(
                  onPressed: context.read<ChangePasswordCubit>().viewConfirmedNewPass,
                  icon: Image.asset(
                      state.viewConfirmedNewPass ? 'assets/images/icons/eye.png' : 'assets/images/icons/eye-off.png',
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
