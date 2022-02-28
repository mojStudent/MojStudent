part of 'iadmin_users_bloc.dart';

@immutable
abstract class InternetAdminUsersEvent {}

class InternetAdminUsersLoadDataEvent extends InternetAdminUsersEvent {
  final InternetAdminLocationModel? location;
  final int perPage;
  final int page;
  final String? search;

  final List<InternetAdminLocationModel> locations;

  InternetAdminUsersLoadDataEvent(
      {this.location,
      this.page = 1,
      this.perPage = 25,
      this.search,
      required this.locations});

  InternetAdminUsersLoadDataEvent.fromState(
    InternetAdminUsersLoadedState state, {
    InternetAdminLocationModel? location,
    int? perPage,
    int? page,
    String? search,
  }) : this(
          locations: state.locations,
          location: location ?? state.selectedLocation,
          page: page ?? state.page,
          perPage: perPage ?? state.perPage,
          search: search ?? state.searchTerm,
        );
}

class InternetAdminUsersLoadLocationsEvent extends InternetAdminUsersEvent {}
