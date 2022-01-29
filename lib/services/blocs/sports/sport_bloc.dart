import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/sports/models/sport_subcribtion_model.dart';
import 'package:moj_student/data/sports/sport_services.dart';

part 'sport_event.dart';
part 'sport_state.dart';

class SportBloc extends Bloc<SportEvent, SportState> {
  SportsRepository sportsRepo;

  SportBloc(this.sportsRepo) : super(SportInitial()) {
    on<SportLoadSubscriptionsEvent>(_onLoadSubscriptions);
  }

  Future<void> _onLoadSubscriptions(
      SportLoadSubscriptionsEvent event, Emitter emit) async {
    emit(SportSubscriptionsLoadingState());
    try {
      final subscriptions = await sportsRepo.getSubscriptions();
      emit(SportSubscriptionstLoadedState(subscriptions));
    } catch (e) {
      emit(SportErrorState());
    }
  }
}
