part of 'logbook_cubit.dart';

@immutable
abstract class LogbookState {}

class LogbookInitial extends LogbookState {}

class LogbookLoadingState extends LogbookState {}

class LogbookLoadedState extends LogbookState {
  final LogbookListModel model;

  LogbookLoadedState(this.model);
}

class LogbookNoDataState extends LogbookState {}

class LogbookErrorState extends LogbookState {
  final String message;

  LogbookErrorState(this.message);
}
