part of 'logbook_add_bloc.dart';

@immutable
abstract class LogbookAddEvent {}

class LogbookAddLoadOptionsEvent extends LogbookAddEvent {}

class LogbookAddFormChanged extends LogbookAddEvent {
  final LogbookAddLoadedState state;

  LogbookAddFormChanged(this.state);
}

class LogbookAddOnSubmissionEvent extends LogbookAddEvent {
  final LogbookModel model;

  LogbookAddOnSubmissionEvent(this.model);
}
