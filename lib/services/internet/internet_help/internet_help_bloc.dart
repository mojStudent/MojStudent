import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/internet/internet_help_repo.dart';
import 'package:moj_student/data/internet/models/help/internet_help_detail_model.dart';
import 'package:moj_student/data/internet/models/help/internet_help_master_model.dart';
import 'package:moj_student/data/internet/models/internet_admin_model.dart';

part 'internet_help_event.dart';
part 'internet_help_state.dart';

class InternetHelpBloc extends Bloc<InternetHelpEvent, InternetHelpState> {
  final InternetHelpRepo repo;

  InternetHelpBloc(this.repo) : super(InternetHelpInitial()) {
    on<InternetHelpLoadMasterEvent>(_onLoadMasterModel);
    on<InternetHelpLoadDetailEvent>(_onLoadDetailModel);
  }

  _onLoadMasterModel(InternetHelpLoadMasterEvent event, Emitter emit) async {
    emit(InternetHelpLoadingState());

    try {
      var model = await repo.loadMasterData();
      var administrators = await repo.getInterentAdministrators();
      emit(InternetHelpMasterLoadedState(model, administrators));
    } catch (e) {
      emit(InternetHelpErrorState(e));
    }
  }

  _onLoadDetailModel(InternetHelpLoadDetailEvent event, Emitter emit) async {
    emit(InternetHelpLoadingState());

    try {
      var model = await repo.loadSteps(event.url);
      emit(InternetHelpDetailLoadedState(model));
    } catch (e) {
      emit(InternetHelpErrorState(e));
    }
  }
}
