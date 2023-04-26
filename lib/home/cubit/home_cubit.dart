import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomePageState> {
  HomeCubit(this.workoutSheetRepository)
      : super(const HomePageState(status: HomePageStatus.initial));

  final IWorkoutSheetRepository workoutSheetRepository;

  Future<void> getHomePage() async {
    try {
      emit(state.copyWith(status: HomePageStatus.loadInProgress));
      final getHomeScreen = await workoutSheetRepository.getHomeScreen();
      print(getHomeScreen);
      emit(state.copyWith(
        status: HomePageStatus.loadSuccess,
        screenModel: getHomeScreen,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomePageStatus.failure));
    }
  }
}
