part of 'home_view_bloc.dart';

@immutable
abstract class HomeViewEvent {}

class HomeViewChangeViewEvent extends HomeViewEvent {
  final int panelIndex;
  HomeViewChangeViewEvent(this.panelIndex);
}