import 'package:amandaleme_personal_app/profile/cubits/change-password/change_password_cubit.dart';
import 'package:amandaleme_personal_app/profile/screen/widgets/old_password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'confirmed_new_password_input.dart';
import 'new_password_input.dart';

class ChangePasswordForm extends StatelessWidget {
  ChangePasswordForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const OldPasswordInput(),
              const SizedBox(height: 10),
              const NewPasswordInput(),
              const SizedBox(height: 10),
              const ConfirmedNewPasswordInput(),
              const SizedBox(height: 36),
              _ChangePasswordButton(_formKey),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChangePasswordButton extends StatelessWidget {
  const _ChangePasswordButton(this.formKey);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: state.oldPass.value.isNotEmpty && state.confirmedNewPass.value.isNotEmpty && state.confirmedNewPass.isValid
                      ? () {
                          context.read<ChangePasswordCubit>().changePassword();
                        }
                      : null,
                  child: const Text('Atualizar senha'),
                ),
              );
      },
    );
  }
}
