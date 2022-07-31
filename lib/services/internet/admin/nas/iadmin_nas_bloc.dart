import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/admin/exceptions/iadmin_norole_exception.dart';
import 'package:moj_student/data/internet/admin/iadmin_repo.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_nas_model.dart';

part 'iadmin_nas_event.dart';
part 'iadmin_nas_state.dart';

class InternetAdminNasBloc
    extends Bloc<InternetAdminNasEvent, InternetAdminNasState> {
  final InternetAdminRepository iAdminRepo;

  InternetAdminNasBloc(this.iAdminRepo) : super(InternetAdminNasInitial()) {
    on<InternetAdminNasLoadEvent>(_onDataLoadedEvent);
  }

  Future<void> _onDataLoadedEvent(InternetAdminNasLoadEvent event,
      Emitter<InternetAdminNasState> emit) async {
    if (AuthRepository.isNetAdmin()) {
      emit(InternetAdminNasLoadingState());
      try {
        var data = await iAdminRepo.getNasStatus();
        emit(InternetAdminNasLoadedState(data));
      } catch (e) {
        emit(InternetAdminNasErrorState(e as Exception));
      }
    } else {
      emit(InternetAdminNasErrorState(InternetAdminNoRoleException(
          "Uporabnik nima pravic za dostop do podatkov")));
    }
  }
}
