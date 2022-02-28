part of 'iadmin_nas_bloc.dart';

@immutable
abstract class InternetAdminNasState {}

class InternetAdminNasInitial extends InternetAdminNasState {}

class InternetAdminNasLoadingState extends InternetAdminNasState {}

class InternetAdminNasLoadedState extends InternetAdminNasState {
  final List<InternetAdminNasModel> data;

  InternetAdminNasLoadedState(this.data);
}

class InternetAdminNasErrorState extends InternetAdminNasState {
  final Exception e;

  InternetAdminNasErrorState(this.e);
}

