part of 'damage_record_bloc.dart';

@immutable
abstract class DamageRecordEvent {}

class DamageRecordLoadPageEvent extends DamageRecordEvent {
  final int page;

  DamageRecordLoadPageEvent({this.page = 1});
}

class DamageRecordLoadedEvent extends DamageRecordEvent {
  final SkodniZapisnikPaginationModel model;

  DamageRecordLoadedEvent(this.model);
}

class DamageRecordLoadErrorEvent extends DamageRecordEvent {
  final Object error;

  DamageRecordLoadErrorEvent(this.error);
}
