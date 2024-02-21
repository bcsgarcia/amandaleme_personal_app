import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:repositories/repositories.dart';

import '../app/app.dart';
import 'profile.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    showSuccessDialog() async {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SuccessDialogWidget(
            title: 'Senha alterada',
            description: 'Sua senha foi alterada com sucesso.',
            buttonLabel: 'Voltar à página inicial',
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          );
        },
      );
    }

    return BlocProvider(
      create: (_) => ChangePasswordCubit(context.read<UserRepository>()),
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) async {
          if (state.status == FormzSubmissionStatus.success) {
            await showSuccessDialog();
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        },
        child: const ChangePasswordScreen(),
      ),
    );
  }
}
