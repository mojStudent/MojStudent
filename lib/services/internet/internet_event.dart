part of 'internet_bloc.dart';

@immutable
abstract class InternetEvent {}

class InternetLoadData extends InternetEvent {
  final InternetTab tab;

  InternetLoadData({required this.tab});
}

class InternetDataLoaded extends InternetEvent {
  final InternetTab tab;

  InternetDataLoaded({required this.tab});
}