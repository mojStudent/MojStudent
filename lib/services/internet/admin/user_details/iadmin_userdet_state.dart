part of 'iadmin_userdet_bloc.dart';

@immutable
abstract class InternetAdminUserDetState {}

class InternetAdminUserDetInitial extends InternetAdminUserDetState {}

class InternetAdminUserDetLoadingState extends InternetAdminUserDetState {}

class InternetAdminUserDetLoadedState extends InternetAdminUserDetState {
  final InternetAdminUserModel user;
  final InternetTrafficModel traffic;
  InternetAdminUserDetLoadedState({
    required this.user,
    required this.traffic,
  });
}

class InternetAdminUserDetErrorState extends InternetAdminUserDetState {
  final Exception e;
  InternetAdminUserDetErrorState(this.e);
}
