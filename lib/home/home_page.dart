import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import '../lib.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.isShowFeedback = false,
  });

  static Page<void> page() => MaterialPage<void>(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeCubit(
                homeRepository: RepositoryProvider.of<IHomeRepository>(context),
              ),
            ),
          ],
          child: const HomePage(),
        ),
      );

  final bool isShowFeedback;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeCubit>().getHomePage();
    context.read<HomeSyncCubit>().shouldSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: BlocListener<HomeCubit, HomePageState>(
          listener: (context, state) {
            if (state.status == HomePageStatus.failure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    buttonPressed: () {
                      Navigator.of(context).pop();
                      context.read<HomeCubit>().getHomePage();
                    },
                  );
                },
              );
            }
          },
          child: BlocBuilder<HomeCubit, HomePageState>(
            builder: (context, state) {
              return BlocProvider(
                create: (_) => FeedbackCubit(
                  context.read<WorkoutsheetRepository>(),
                ),
                child: HomeScreen(
                  showFeedbackWidget: widget.isShowFeedback,
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
