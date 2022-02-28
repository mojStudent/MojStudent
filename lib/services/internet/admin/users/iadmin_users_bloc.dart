import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/admin/exceptions/iadmin_norole_exception.dart';
import 'package:moj_student/data/internet/admin/iadmin_repo.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_location_model.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_users_model.dart';
import 'package:moj_student/services/internet/admin/nas/iadmin_nas_bloc.dart';

part 'iadmin_users_event.dart';
part 'iadmin_users_state.dart';

class InternetAdminUsersBloc
    extends Bloc<InternetAdminUsersEvent, InternetAdminUsersState> {
  final InternetAdminRepository iAdminRepo;

  InternetAdminUsersBloc(this.iAdminRepo) : super(InternetAdminUsersInitial()) {
    on<InternetAdminUsersLoadDataEvent>(_onDataLoadingEvent);
    on<InternetAdminUsersLoadLocationsEvent>(_onLocationsLoadingEvent);
  }

  Future<void> _onDataLoadingEvent(InternetAdminUsersLoadDataEvent event,
      Emitter<InternetAdminUsersState> emit) async {
    emit(InternetAdminUsersLoadingState());

    if (AuthRepository.isNetAdmin()) {
      try {
        var data = await iAdminRepo.getUsers(
          perPage: event.perPage,
          page: event.page,
          location: event.location?.id,
          search: event.search,
        );

        emit(InternetAdminUsersLoadedState(
          data: data,
          locations: event.locations,
          selectedLocation: event.location,
          page: event.page,
          searchTerm: event.search,
        ));
      } catch (e) {
        emit(InternetAdminUsersErrorState(e as Exception));
      }
    } else {
      emit(InternetAdminUsersErrorState(InternetAdminNoRoleException(
          "Uporabnik nima pravic za dostop do podatkov")));
    }
  }

  Future<void> _onLocationsLoadingEvent(
      InternetAdminUsersLoadLocationsEvent event,
      Emitter<InternetAdminUsersState> emit) async {
    emit(InternetAdminUsersLoadingState());

    if (AuthRepository.isNetAdmin()) {
      try {
        var data = await iAdminRepo.getLocations();

        emit(InternetAdminUsersLocationsLoadedState(data));
      } catch (e) {
        emit(InternetAdminUsersErrorState(e as Exception));
      }
    } else {
      emit(InternetAdminUsersErrorState(InternetAdminNoRoleException(
          "Uporabnik nima pravic za dostop do podatkov")));
    }
  }
}
