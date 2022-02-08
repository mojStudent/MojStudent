part of 'sport_bloc.dart';

@immutable
abstract class SportEvent {}

class SportLoadEvent extends SportEvent {}

class SportLoadSubscriptionDetailEvent extends SportEvent {
  final SportLoadedState state;
  final SportSubscriptionModel detailModel;

  SportLoadSubscriptionDetailEvent(this.state, this.detailModel);
}

class SportCancelSubscriptionEvent extends SportEvent {
  final int subscriptionId;

  SportCancelSubscriptionEvent(this.subscriptionId);
}

class SportSubscribeSubscriptionEvent extends SportEvent {
  final int subscriptionId;

  SportSubscribeSubscriptionEvent(this.subscriptionId);
}
