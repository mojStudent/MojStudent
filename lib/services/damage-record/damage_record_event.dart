part of 'damage_record_bloc.dart';

@immutable
abstract class DamageRecordEvent {}

class DamageRecordLoadPageEvent {
  int page;

  DamageRecordLoadPageEvent({this.page = 1});
}

class DamageRecordLoadedEvent {
  SkodniZapisnikPaginationModel model;

  DamageRecordLoadedEvent(this.model);
}

class DamageRecordLoadErrorEvent {
  Object error;

  DamageRecordLoadErrorEvent(this.error);
}