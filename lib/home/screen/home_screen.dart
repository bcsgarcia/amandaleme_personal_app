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
                  : FloatingActionButton.large(
                      backgroundColor: Colors.black.withOpacity(0.8),
                      onPressed: null,
                      child: Stack(
                        children: [
                          const Center(child: CircularProgressIndicator()),
                          Center(
                            child: Icon(
                              Icons.download,
                              size: 80,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          StreamBuilder<double>(
                            stream: context.read<HomeSyncCubit>().syncRepository.downloadProgressStream,
                            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('!!!');
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
              drawer: homeScreenModel == null
                  ? null
                  : HomeDrawerMenu(
                      drawerScreenModel: homeScreenModel.drawerMenu,
                    ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppHeader(notifications: homeScreenModel?.notifications ?? []),
                  if (homeScreenModel == null)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    Flexible(
                      child: RefreshIndicator(
                          onRefresh: () async {
                            context.read<HomeCubit>().getHomePage();
                            if (context.read<HomeSyncCubit>().state.status != SyncStatus.loadInProgress) {
                              context.read<HomeSyncCubit>().shouldSync();
                            }
                          },
                          child: ListView(
                            children: [
                              // const SizedBox(height: 20),
                              const HomeTitle(title: 'Meu programa de treinamento'),
                              MyTrainingPlanWidget(workoutSheets: homeScreenModel.myTrainingPlan),
                              if (showFeedbackWidget == false) const SizedBox(height: 45),
                              if (showFeedbackWidget) HomeFeedbackWidget(workout: homeScreenModel.myTrainingPlan.last),
                              const HomeTitle(title: 'Todos os meus treinos'),
                              const SizedBox(height: 15),
                              AllMyWorkoutSheets(myWorkousheets: homeScreenModel.myWorkousheets),
                              const SizedBox(height: 60),
                            ],
                          )),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
