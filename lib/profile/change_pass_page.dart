import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

import '../app/common_widgets/success_dialog_widget.dart';
import 'cubits/change-password/change_password_cubit.dart';
import 'screen/change_pass_screen.dart';

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
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(
              //     builder: (context) => BlocProvider(
              //       create: (_) => HomeCubit(
              //         homeRepository: RepositoryProvider.of<IHomeRepository>(context),
              //         syncRepository: RepositoryProvider.of<SyncRepository>(context),
              //       ),
              //       child: HomePage(),
              //     ),
              //   ),
              //   ModalRoute.withName(RouteNames.home),
              // );

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
