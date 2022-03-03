part of 'iadmin_errors_bloc.dart';

@immutable
abstract class InternetAdminErrorsEvent {}

class InternetAdminErrorsLoadEvent extends InternetAdminErrorsEvent {
  final int perPage;
  final int page;
  final String? searchUsername;
  final String? searchDescription;

  InternetAdminErrorsLoadEvent({
    this.perPage = 20,
    this.page = 1,
    this.searchDescription,
    this.searchUsername,
  });
}
