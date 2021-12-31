part of 'internet_help_bloc.dart';

@immutable
abstract class InternetHelpState {}

class InternetHelpInitial extends InternetHelpState {}

class InternetHelpLoadingState extends InternetHelpState {}

class InternetHelpMasterLoadedState extends InternetHelpState {
  final InternetHelpMasterModel masterModel;
    final List<InternetAdministratorModel> administrators;

  InternetHelpMasterLoadedState(this.masterModel, this.administrators);
}

class InternetHelpDetailLoadedState extends InternetHelpState {
  final List<InternetHelpDetailModel> model;

  InternetHelpDetailLoadedState(this.model);
}

class InternetHelpErrorState extends InternetHelpState {
  final Object e;

  InternetHelpErrorState(this.e);
}