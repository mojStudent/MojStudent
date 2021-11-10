part of 'failure_record_bloc.dart';

@immutable
abstract class FailureRecordEvent {}

class FailureRecordLoadPageEvent extends FailureRecordEvent {
  final int page;

  FailureRecordLoadPageEvent({this.page = 1});
}

class FailureRecordLoadedEvent extends FailureRecordEvent {
  final FailurePaginationModel model;

  FailureRecordLoadedEvent(this.model);
}

class FailureRecordLoadErrorEvent extends FailureRecordEvent {
  final Object error;

  FailureRecordLoadErrorEvent(this.error);
}
