part of 'sport_bloc.dart';

@immutable
abstract class SportState {}

class SportInitial extends SportState {}

abstract class SportLoadingState extends SportState {}

class SportSubscriptionsLoadingState extends SportLoadingState {}

abstract class SportLoadedState extends SportState {}

class SportSubscriptionstLoadedState extends SportLoadedState {
  final List<SportSubscriptionModel> subscriptions;

  SportSubscriptionstLoadedState(this.subscriptions);
}

class SportErrorState extends SportState {}