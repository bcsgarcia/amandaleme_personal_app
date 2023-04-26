part of 'home_cubit.dart';

enum HomePageStatus {
  initial,
  loadInProgress,
  loadSuccess,
  failure,
}

class HomePageState extends Equatable {
  const HomePageState({
    required this.status,
    this.screenModel,
  });

  final HomePageStatus status;
  final HomeScreenModel? screenModel;

  HomePageState copyWith({
    HomePageStatus? status,
    HomeScreenModel? screenModel,
  }) {
    return HomePageState(
      status: status ?? this.status,
      screenModel: screenModel ?? this.screenModel,
    );
  }

  @override
  List<Object?> get props => [status, screenModel];
}
