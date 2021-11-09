part of 'internet_help_bloc.dart';

@immutable
abstract class InternetHelpEvent {}

class InternetHelpLoadMasterEvent extends InternetHelpEvent {}

class InternetHelpLoadDetailEvent extends InternetHelpEvent {
  final String url;
  InternetHelpLoadDetailEvent(this.url);
}
