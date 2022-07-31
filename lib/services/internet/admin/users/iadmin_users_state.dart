part of 'iadmin_users_bloc.dart';

@immutable
abstract class InternetAdminUsersState {}

class InternetAdminUsersInitial extends InternetAdminUsersState {}

class InternetAdminUsersLoadingState extends InternetAdminUsersState {}

class InternetAdminUsersLocationsLoadedState extends InternetAdminUsersState {
  final List<InternetAdminLocationModel> locations;

  InternetAdminUsersLocationsLoadedState(this.locations);
}

class InternetAdminUsersLoadedState
    extends InternetAdminUsersLocationsLoadedState {
  final InternetAdminUsersPaginationModel? data;

  final InternetAdminLocationModel? selectedLocation;
  final String? searchTerm;
  final int perPage;
  final int page;

  InternetAdminUsersLoadedState(
      {this.data,
      required locations,
      this.selectedLocation,
      this.searchTerm,
      this.perPage = 20,
      required this.page})
      : super(locations);

  InternetAdminUsersLoadedState copyWith({
    InternetAdminUsersPaginationModel? data,
    List<InternetAdminLocationModel>? locations,
    InternetAdminLocationModel? selectedLocation,
    String? searchTerm,
    int? perPage,
    int? page,
  }) {
    return InternetAdminUsersLoadedState(
      data: data ?? this.data,
      locations: locations ?? this.locations,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      searchTerm: searchTerm ?? this.searchTerm,
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }
}

class InternetAdminUsersErrorState extends InternetAdminUsersState {
  final Exception e;

  InternetAdminUsersErrorState(this.e);
}
