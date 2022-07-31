part of 'restaurant_cubit.dart';

@immutable
abstract class RestaurantState {}

class RestaurantLoadingState extends RestaurantState {}

class RestaurantLoadedState extends RestaurantState {
  final RestaurantDataModel data;

  RestaurantLoadedState(this.data);
}

class RestaurantErrorState extends RestaurantState {
  final String message;

  RestaurantErrorState(this.message);
}
