part of 'failure_record_bloc.dart';

@immutable
abstract class FailureRecordState {}

class FailureRecordInitial extends FailureRecordState {}

class FailureRecordLoadingState extends FailureRecordState {}

class FailureRecordLoadedState extends FailureRecordState {
  final FailurePaginationModel model;

  FailureRecordLoadedState(this.model);
}

class FailureEmptyDataState extends FailureRecordState {
  final EmptyDataException emptyDataException;

  FailureEmptyDataState(this.emptyDataException);
}

class FailureRecordErrorState extends FailureRecordState {
  final Object error;

  FailureRecordErrorState(this.error);
}
