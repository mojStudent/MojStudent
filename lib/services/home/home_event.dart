abstract class HomeEvent {}

class InitialEvent extends HomeEvent {}

class RefreshData extends HomeEvent {}

class DataLoaded extends HomeEvent {}

class DataError extends HomeEvent {
  Exception e;

  DataError({required this.e});
}