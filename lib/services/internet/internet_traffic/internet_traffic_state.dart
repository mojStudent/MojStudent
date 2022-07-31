part of 'internet_traffic_bloc.dart';

@immutable
abstract class InternetTrafficState {}

class InternetTrafficInitial extends InternetTrafficState {}

class InternetTrafficLoadingState extends InternetTrafficState {}

class InternetTrafficLoadedState extends InternetTrafficState {
  final InternetTrafficModel traffic;
  final List<InternetAdministratorModel> administrators;

  InternetTrafficLoadedState(this.traffic, this.administrators);
}

class InternetTrafficErrorState extends InternetTrafficState {
  final Object e;

  InternetTrafficErrorState(this.e);
}
