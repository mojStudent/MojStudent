import 'package:moj_student/services/blocs/home/home_state.dart';

abstract class HomeEvent {}

class InitialEvent extends HomeEvent {}

class RefreshData extends HomeEvent {}

class DataLoaded extends HomeEvent {}

class ChangeTabEvent extends HomeEvent {
  LoadedData state;
  LoadedDataTab newTab;

  ChangeTabEvent(this.state, this.newTab);
}

class DataError extends HomeEvent {
  Exception e;

  DataError({required this.e});
}
