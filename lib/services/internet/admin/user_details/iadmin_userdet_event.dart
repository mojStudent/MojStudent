part of 'iadmin_userdet_bloc.dart';

@immutable
abstract class InternetAdminUserDetEvent {}

class InternetAdminUserDetLoadEvent extends InternetAdminUserDetEvent {
  final int userId;

  InternetAdminUserDetLoadEvent(this.userId);
}
