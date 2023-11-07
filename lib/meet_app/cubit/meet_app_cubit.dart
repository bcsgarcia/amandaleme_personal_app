import 'package:company_repository/company_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'meet_app_state.dart';

class MeetAppCubit extends Cubit<MeetAppState> {
  MeetAppCubit(this._companyRepository)
      : super(
          const MeetAppState(
            status: MeetAppStatus.initial,
          ),
        );

  final CompanyRepository _companyRepository;

  Future<void> retrieveMeetAppScreen() async {
    try {
      emit(state.copyWith(status: MeetAppStatus.inProgress));
      final meetAppScreen = await _companyRepository.getMeetAppScreen();
      emit(state.copyWith(status: MeetAppStatus.success, screenModel: meetAppScreen));
    } catch (e) {
      emit(state.copyWith(status: MeetAppStatus.failure));
    }
  }
}
