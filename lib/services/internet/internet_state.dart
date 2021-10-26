part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetInitial extends InternetState {}

class InternetDataLoading extends InternetState {}


class InternetTrafficLoaded extends InternetState {}

class InternetLogLoaded extends InternetState {}

class InternetHelpLoaded extends InternetState {}
