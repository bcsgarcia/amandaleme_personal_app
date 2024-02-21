import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../lib.dart';

class ChangePasswordFormWidget extends StatelessWidget {
  ChangePasswordFormWidget({super.key});

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
              const OldPasswordInputWidget(),
              const SizedBox(height: 10),
              const NewPasswordInputWidget(),
              const SizedBox(height: 10),
              const ConfirmedNewPasswordInputWidget(),
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
                  onPressed: state.oldPass.value.isNotEmpty &&
                          state.confirmedNewPass.value.isNotEmpty &&
                          state.confirmedNewPass.isValid
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
