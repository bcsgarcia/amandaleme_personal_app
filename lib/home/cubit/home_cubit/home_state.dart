part of 'home_cubit.dart';

enum HomePageStatus {
  initial,
  loadInProgress,
  loadSuccess,
  failure,
  sync,
  unautorized,
}

class HomePageState extends Equatable {
  const HomePageState({
    required this.status,
    this.isShowFeedback = false,
    this.screenModel,
  });

  final HomePageStatus status;
  final bool isShowFeedback;
  final HomeScreenModel? screenModel;

  HomePageState copyWith({
    HomePageStatus? status,
    HomeScreenModel? screenModel,
    bool? isShowFeedback,
  }) {
    return HomePageState(
      status: status ?? this.status,
      screenModel: screenModel ?? this.screenModel,
      isShowFeedback: isShowFeedback ?? this.isShowFeedback,
    );
  }

  @override
  List<Object?> get props => [status, screenModel];
}
