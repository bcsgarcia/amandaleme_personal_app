import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app.dart';
import '../cubit/home_cubit/cubit.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.showFeedbackWidget = false,
  });

  final bool showFeedbackWidget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomePageState>(
      builder: (context, state) {
        final homeScreenModel = state.screenModel;

        return BlocBuilder<HomeSyncCubit, HomeSyncState>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: state.status == SyncStatus.loadSuccess
                  ? null
                  : Stack(
                      children: [
                        Positioned(
                          bottom: 30,
                          right: 20,
                          child: Row(
                            children: [
                              const Center(
                                child: Icon(
                                  Icons.download,
                                  size: 25,
                                  color: primaryColor,
                                ),
                              ),
                              StreamBuilder<double>(
                                stream: context.read<HomeSyncCubit>().syncRepository.downloadProgressStream,
                                builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                  if (snapshot.hasError) {
                                    return const SizedBox.shrink();
                                  }

                                  double percentage = 0;
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      percentage = 0;
                                      break;
                                    default:
                                      percentage = snapshot.data ?? 0;
                                      break;
                                  }

                                  return Center(
                                    child: Text(
                                      '${(percentage * 100).toInt()}%',
                                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                            color: Colors.black,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 10),
                              const SizedBox(width: 10, height: 10, child: CircularProgressIndicator()),
                            ],
                          ),
                        ),
                      ],
                    ),
              drawer: homeScreenModel == null
                  ? null
                  : HomeDrawerMenu(
                      drawerScreenModel: homeScreenModel.drawerMenu,
                    ),
              body: Stack(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  if (homeScreenModel == null)
                    const Expanded(
                      child: SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 130),
                        child: RefreshIndicator(
                            onRefresh: () async {
                              context.read<HomeCubit>().getHomePage();
                              if (context.read<HomeSyncCubit>().state.status != SyncStatus.loadInProgress) {
                                context.read<HomeSyncCubit>().shouldSync();
                              }
                            },
                            child: ListView(
                              children: [
                                const HomeTitle(title: 'Meu programa de treinamento'),
                                MyTrainingPlanWidget(workoutSheets: homeScreenModel.myTrainingPlan),
                                if (showFeedbackWidget == false) const SizedBox(height: 45),
                                if (showFeedbackWidget)
                                  HomeFeedbackWidget(workout: homeScreenModel.myTrainingPlan.last),
                                const HomeTitle(title: 'Todos os meus treinos'),
                                const SizedBox(height: 15),
                                AllMyWorkoutSheets(myWorkousheets: homeScreenModel.myWorkousheets),
                                const SizedBox(height: 60),
                              ],
                            )),
                      ),
                    ),
                  AppHeader(notifications: homeScreenModel?.notifications ?? []),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
