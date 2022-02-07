part of 'sport_bloc.dart';

@immutable
abstract class SportState {}

class SportInitial extends SportState {}

abstract class SportLoadingState extends SportState {}

class SportDataLoadingState extends SportLoadingState {}

class SportLoadedState extends SportState {
  final List<SportSubscriptionModel> subscriptions;
  final FitnesCardModel? fitnesCard;

  SportLoadedState({required this.subscriptions, this.fitnesCard});
}

class SportSubscriptionDetailState extends SportLoadedState {
  final SportSubscriptionModel subscription;

  SportSubscriptionDetailState({
    required this.subscription,
    required SportLoadedState parent,
  }) : super(
          subscriptions: parent.subscriptions,
          fitnesCard: parent.fitnesCard,
        );
}

class SportErrorState extends SportState {}
