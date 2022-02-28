import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/internet/admin/exceptions/iadmin_norole_exception.dart';
import 'package:moj_student/data/internet/admin/iadmin_repo.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_users_model.dart';
import 'package:moj_student/data/internet/models/internet_traffic_model.dart';
import 'package:moj_student/services/internet/admin/users/iadmin_users_bloc.dart';

part 'iadmin_userdet_event.dart';
part 'iadmin_userdet_state.dart';

class InternetAdminUserDetBloc
    extends Bloc<InternetAdminUserDetEvent, InternetAdminUserDetState> {
  final InternetAdminRepository iAdminRepo;

  InternetAdminUserDetBloc(this.iAdminRepo)
      : super(InternetAdminUserDetInitial()) {
    on<InternetAdminUserDetLoadEvent>(_onDataLoadingEvent);
  }

  Future<void> _onDataLoadingEvent(InternetAdminUserDetLoadEvent event,
      Emitter<InternetAdminUserDetState> emit) async {
    emit(InternetAdminUserDetLoadingState());

    if (AuthRepository.isNetAdmin()) {
      try {
        var user = await iAdminRepo.getUserDetails(event.userId);
        var traffic = await iAdminRepo.getInternetTrafficForUser(event.userId);
        emit(InternetAdminUserDetLoadedState(user: user, traffic: traffic));
      } catch (e) {
        emit(InternetAdminUserDetErrorState(e as Exception));
      }
    } else {
      emit(InternetAdminUserDetErrorState(InternetAdminNoRoleException(
          "Uporabnik nima pravic za dostop do podatkov")));
    }
  }
}
