import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/sports/models/fitnes_card_model.dart';
import 'package:moj_student/data/sports/models/sport_subcribtion_model.dart';
import 'package:moj_student/data/sports/sports_repo.dart';

part 'sport_event.dart';
part 'sport_state.dart';

class SportBloc extends Bloc<SportEvent, SportState> {
  SportsRepository sportsRepo;

  SportBloc(this.sportsRepo) : super(SportInitial()) {
    on<SportLoadEvent>(_onLoad);
    on<SportLoadSubscriptionDetailEvent>(_onSubScriptionDetailLoad);
    on<SportCancelSubscriptionEvent>(_onCancelSubscriptionEvent);
    on<SportSubscribeSubscriptionEvent>(_onSubscribeSubscriptionEvent);
  }

  Future<void> _onLoad(SportLoadEvent event, Emitter emit) async {
    emit(SportDataLoadingState());

    FitnesCardModel? fintessCard;

    try {
      fintessCard = await sportsRepo.getFitnesCard();
    } catch (e) {}

    try {
      final subscriptions = await sportsRepo.getSubscriptions();
      emit(SportLoadedState(
          subscriptions: subscriptions, fitnesCard: fintessCard));
    } catch (e) {
      emit(SportErrorState());
    }
  }

  void _onSubScriptionDetailLoad(
      SportLoadSubscriptionDetailEvent event, Emitter emit) {
    emit(SportSubscriptionDetailState(
      subscription: event.detailModel,
      parent: event.state,
    ));
  }

  Future<void> _onCancelSubscriptionEvent(
      SportCancelSubscriptionEvent event, Emitter emit) async {
    emit(SportDataLoadingState());

    try {
      sportsRepo.cancelSubscription(event.subscriptionId);
      emit(SportInitial());
    } catch (e) {
      emit(SportErrorState());
    }
  }

  Future<void> _onSubscribeSubscriptionEvent(
      SportSubscribeSubscriptionEvent event, Emitter emit) async {
    emit(SportDataLoadingState());

    try {
      sportsRepo.subscribeSubscription(event.subscriptionId);
      emit(SportInitial());
    } catch (e) {
      emit(SportErrorState());
    }
  }
}
