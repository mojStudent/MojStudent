import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_view_event.dart';
part 'home_view_state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  HomeViewBloc() : super(HomeViewHomePanelState()) {
    on<HomeViewChangeViewEvent> (_onViewPanelChange);
  }

  void _onViewPanelChange(
      HomeViewChangeViewEvent event, Emitter<HomeViewState> emit) {
    switch (event.panelIndex) {
      case 0:
        emit(HomeViewHomePanelState());
        break;
      case 1:
        emit(HomeViewProfilePanelState());
        break;
      case 2:
        emit(HomeViewInternetPanelState());
        break;
    }
  }
}
