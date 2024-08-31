// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:repositories/repositories.dart';

part 'meet_app_state.dart';

class MeetAppCubit extends Cubit<MeetAppState> {
  MeetAppCubit(this._companyRepository)
      : super(
          const MeetAppState(
            status: MeetAppStatus.initial,
          ),
        ) {
    _getAppVersion();
  }

  String? appVersion;

  final CompanyRepository _companyRepository;

  void _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    appVersion = "$version ($buildNumber)"; // Formato: versão+build
  }

  Future<void> retrieveMeetAppScreen() async {
    try {
      emit(state.copyWith(status: MeetAppStatus.inProgress));

      final meetAppScreen = await _companyRepository.getMeetAppScreen();
      emit(state.copyWith(status: MeetAppStatus.success, screenModel: meetAppScreen));
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
      emit(state.copyWith(status: MeetAppStatus.failure));
    }
  }
}
