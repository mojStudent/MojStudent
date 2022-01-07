part of 'damage_record_bloc.dart';

@immutable
abstract class DamageRecordState {}

class DamageRecordInitial extends DamageRecordState {}

class DamageRecordLoadingState extends DamageRecordState {}

class DamageRecordLoadedState extends DamageRecordState {
  final SkodniZapisnikPaginationModel model;

  DamageRecordLoadedState(this.model);
}

class DamageRecordEmptyState extends DamageRecordState {
  final EmptyDataException emptyDataException;

  DamageRecordEmptyState(this.emptyDataException);
}

class DamageRecordErrorState extends DamageRecordState {
  final Object error;

  DamageRecordErrorState(this.error);
}
