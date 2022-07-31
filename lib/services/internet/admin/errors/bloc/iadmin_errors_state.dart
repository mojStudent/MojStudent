part of 'iadmin_errors_bloc.dart';

@immutable
abstract class InternetAdminErrorsState {}

class InternetAdminErrorsInitial extends InternetAdminErrorsState {}

class InternetAdminErrorsLoadingState extends InternetAdminErrorsState {}

class InternetAdminErrorsLoadedState extends InternetAdminErrorsState {
  final IAdminErrorsPaginationModel errors;
  final int perPage;
  final int page;
  final String? searchUsername;
  final String? searchDescription;

  InternetAdminErrorsLoadedState(
      {required this.errors,
      this.page = 1,
      this.perPage = 20,
      this.searchDescription,
      this.searchUsername});

  InternetAdminErrorsLoadedState copyWith({
    IAdminErrorsPaginationModel? errors,
    int? perPage,
    int? page,
    String? searchUsername,
    String? searchDescription,
  }) =>
      InternetAdminErrorsLoadedState(
        errors: errors ?? this.errors,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        searchDescription: searchDescription ?? this.searchDescription,
        searchUsername: searchUsername ?? this.searchUsername,
      );
}

class InternetAdminErrorsErrorState extends InternetAdminErrorsState {
  final Exception e;

  InternetAdminErrorsErrorState(this.e);
}
