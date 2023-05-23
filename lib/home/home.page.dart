import 'package:amandaleme_personal_app/home/cubit/home_cubit.dart';
import 'package:amandaleme_personal_app/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';
import 'package:sync_repository/sync_repository.dart';

import '../app/common_widgets/common_widgets.dart';
import 'screen/sync_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  static Page<void> page() => MaterialPage<void>(
        child: BlocProvider(
          create: (context) => HomeCubit(
            homeRepository: RepositoryProvider.of<IHomeRepository>(context),
            syncRepository: RepositoryProvider.of<SyncRepository>(context),
          ),
          child: HomePage(),
        ),
      );

  late HomeCubit _homeCubit;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      _homeCubit = context.read<HomeCubit>();
      context.read<HomeCubit>().getHomePage();

      return Scaffold(
        body: BlocListener<HomeCubit, HomePageState>(
          listener: (context, state) {
            if (state.status == HomePageStatus.failure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    title: 'Error Title',
                    description: 'Error description.',
                    button1Label: 'Cancel',
                    button1OnPressed: () {
                      Navigator.of(context).pop();
                    },
                    button2Label: 'Retry',
                    button2OnPressed: () {
                      Navigator.of(context).pop();
                      _homeCubit.getHomePage();
                    },
                  );
                },
              );
            }
          },
          child: BlocBuilder<HomeCubit, HomePageState>(
            builder: (context, state) {
              if (state.status == HomePageStatus.loadSuccess) {
                return HomeScreen(homeScreenModel: state.screenModel!);
              }

              if (state.status == HomePageStatus.sync) {
                return BlocProvider(
                  create: (_) => context.read<HomeCubit>(),
                  child: const DownloadProgressPage(),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );
    });
  }
}
