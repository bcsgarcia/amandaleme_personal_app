import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import '../lib.dart';

class SyncMediasPage extends StatelessWidget {
  const SyncMediasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SyncMediaPageCubit(context.read<SyncRepository>()),
      child: BlocListener<SyncMediaPageCubit, SyncMadiaPageState>(
        listener: (context, state) {
          if (state.status == SyncPageStatus.loadFailure) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                  buttonPressed: () {
                    Navigator.of(context).pop();
                    context.read<SyncMediaPageCubit>().sync();
                  },
                );
              },
            );
          }

          if (state.status == SyncPageStatus.unautorized) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                  title: 'Autenticação necessária',
                  description: 'Sua sessão expirou, por favor, faça login novamente',
                  buttonPressed: () {
                    context.read<AppBloc>().add(const AppLogoutRequested());
                  },
                );
              },
            );
          }

          if (state.status == SyncPageStatus.loadSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Sincronização concluída'),
                  backgroundColor: successColor,
                ),
              );
          }
        },
        child: const SyncMediaScreen(),
      ),
    );
  }
}
