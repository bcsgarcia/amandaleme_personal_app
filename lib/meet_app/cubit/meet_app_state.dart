part of 'meet_app_cubit.dart';

enum MeetAppStatus {
  initial,
  inProgress,
  success,
  failure,
}

class MeetAppState extends Equatable {
  const MeetAppState({
    required this.status,
    this.screenModel,
  });

  final MeetAppStatus status;
  final MeetAppScreenModel? screenModel;

  MeetAppState copyWith({
    MeetAppStatus? status,
    MeetAppScreenModel? screenModel,
  }) {
    return MeetAppState(
      status: status ?? this.status,
      screenModel: screenModel ?? this.screenModel,
    );
  }

  @override
  List<Object?> get props => [status, screenModel];
}
