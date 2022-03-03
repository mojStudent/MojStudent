import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/admin/exceptions/iadmin_norole_exception.dart';
import 'package:moj_student/data/internet/admin/iadmin_repo.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_errors_model.dart';

part 'iadmin_errors_event.dart';
part 'iadmin_errors_state.dart';

class InternetAdminErrorsBloc
    extends Bloc<InternetAdminErrorsEvent, InternetAdminErrorsState> {
  final InternetAdminRepository iAdminRepo;

  InternetAdminErrorsBloc(this.iAdminRepo)
      : super(InternetAdminErrorsInitial()) {
    on<InternetAdminErrorsLoadEvent>(_onDataLoadingEvent);
  }

  Future<void> _onDataLoadingEvent(InternetAdminErrorsLoadEvent event,
      Emitter<InternetAdminErrorsState> emit) async {
    emit(InternetAdminErrorsLoadingState());

    if (AuthRepository.isNetAdmin()) {
      try {
        var data = await iAdminRepo.getErrors(
          description: event.searchDescription,
          page: event.page,
          perPage: event.perPage,
          username: event.searchUsername,
        );

        emit(InternetAdminErrorsLoadedState(
          errors: data,
          page: event.page,
          perPage: event.perPage,
          searchDescription: event.searchDescription,
          searchUsername: event.searchUsername,
        ));
      } catch (e) {
        emit(InternetAdminErrorsErrorState(e as Exception));
      }
    } else {
      emit(InternetAdminErrorsErrorState(InternetAdminNoRoleException(
          "Uporabnik nima pravic za dostop do podatkov")));
    }
  }
}
