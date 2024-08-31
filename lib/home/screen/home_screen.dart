import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import '../../lib.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.showFeedbackWidget = false,
  });

  final bool showFeedbackWidget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomePageState>(
      builder: (context, homeCubitState) {
        final homeScreenModel = homeCubitState.screenModel;
        final notifications = homeScreenModel?.notifications ?? [];
        final hasNotificationUnread = verifyNotificationUnread(notifications);

        return BlocBuilder<HomeSyncCubit, HomeSyncState>(
          builder: (context, homeSyncCubitState) {
            return Scaffold(
              appBar: _buildAppBar(
                context,
                notifications,
                hasNotificationUnread,
              ),
              drawer: homeScreenModel == null
                  ? null
                  : HomeDrawerMenu(
                      drawerScreenModel: homeScreenModel.drawerMenu,
                    ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      if (homeScreenModel == null)
                        const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              context.read<HomeCubit>().getHomePage();
                              if (context.read<HomeSyncCubit>().state.status != SyncStatus.loadInProgress) {
                                context.read<HomeSyncCubit>().shouldSync();
                              }
                            },
                            child: ListView(
                              padding: const EdgeInsets.only(top: 45),
                              children: [
                                const HomeTitle(title: 'Meu programa de treinamento'),
                                MyTrainingPlanWidget(workoutSheets: homeScreenModel.myTrainingPlan),
                                if (!showFeedbackWidget) const SizedBox(height: 45),
                                if (showFeedbackWidget)
                                  HomeFeedbackWidget(workout: homeScreenModel.myTrainingPlan.last),
                                const HomeTitle(title: 'Todos os meus treinos'),
                                const SizedBox(height: 15),
                                AllMyWorkoutSheets(myWorkousheets: homeScreenModel.myWorkousheets),
                                const SizedBox(height: 60),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  // AppHeader(
                  //     notifications: homeScreenModel?.notifications ?? []),
                  if (homeSyncCubitState.status != SyncStatus.loadSuccess)
                    const Positioned(
                      bottom: 30,
                      right: 20,
                      child: Center(
                        child: DownloadLoadingWidget(),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    List<NotificationModel> notifications,
    bool hasNotificationUnread,
  ) {
    return CustomAppBar(
      actions: [
        IconButton(
          onPressed: () => _goToNotificationPage(
            context,
            notifications,
          ),
          icon: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              children: [
                const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 24,
                ),
                if (hasNotificationUnread)
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 13,
                      width: 13,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _goToNotificationPage(
    BuildContext context,
    List<NotificationModel> notifications,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => NotificationCubit(context.read<NotificationRepository>()),
          child: NotificationsPage(
            notifications: notifications,
          ),
        ),
      ),
    );

    context.read<HomeCubit>().getHomePage();
  }

  bool verifyNotificationUnread(List<NotificationModel> notifications) {
    return notifications.any((notification) => notification.readDate == null);
  }
}

class DownloadLoadingWidget extends StatelessWidget {
  const DownloadLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      // Ajuste o raio conforme necessário
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        // Intensidade do desfoque
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            // Preto translúcido
            borderRadius: BorderRadius.circular(15.0),
            // Raio das bordas
            border: Border.all(
              color: Colors.black.withOpacity(0.8),
              // Borda branca translúcida
              width: 1.5,
            ),
          ),
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
      ),
    );
  }
}
