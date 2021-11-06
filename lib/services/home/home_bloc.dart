import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/services/home/home_event.dart';
import 'package:moj_student/services/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository authRepository;

  HomeBloc({required this.authRepository}) : super(InitialState()) {
    on<InitialEvent>(_onDataLoadedEvent);
    on<DataLoaded>(_onDataLoadedEvent);
    on<DataError>((event, emit) => emit(LoadingDataError(e: event.e)));
    on<RefreshData>(_onDataLoadingEvent);
    on<ChangeTabEvent>(
        (event, emit) => emit(event.state.changeTab(event.newTab)));
  }

  void _onDataLoadedEvent(HomeEvent event, Emitter<HomeState> emit) {
    if (authRepository.loggedInUser != null) {
      emit(LoadedData(user: authRepository.loggedInUser!));
    } else {
      emit(LoadingDataError(e: Exception("Napaka pri pridobivanju podatkov")));
    }
  }

  Future<void> _onDataLoadingEvent(
      HomeEvent event, Emitter<HomeState> emit) async {
    emit(LoadingData());

    try {
      final user = await authRepository.login(null);
      emit(LoadedData(user: user));
    } catch (e) {
      emit(LoadingDataError(e: e as Exception));
    }
  }
}
