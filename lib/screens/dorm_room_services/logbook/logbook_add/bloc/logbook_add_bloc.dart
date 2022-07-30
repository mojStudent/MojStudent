import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/dorm_room_services/logbook/logbook_repo.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_add_options_model.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_model.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_sublocation_model.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_vandal_type.dart';

part 'logbook_add_event.dart';
part 'logbook_add_state.dart';

class LogbookAddBloc extends Bloc<LogbookAddEvent, LogbookAddState> {
  final LogbookRepo logbookRepo;

  LogbookAddBloc(this.logbookRepo) : super(LogbookAddInitial()) {
    on<LogbookAddLoadOptionsEvent>(_onOptionsLoadEvent);
    on<LogbookAddFormChanged>(_onFormChanged);
    on<LogbookAddOnSubmissionEvent>(_onFormSubmit);
  }

  _onOptionsLoadEvent(
    LogbookAddLoadOptionsEvent event,
    Emitter<LogbookAddState> emit,
  ) async {
    emit(LogbookAddLoadingState());

    try {
      var data = await logbookRepo.getOptions();

      emit(
        LogbookAddLoadedState(
          data.subLocation,
          data.vandalType,
          selectedSubLocation: data.subLocation[0],
          selectedVandalType: data.vandalType[0],
        ),
      );
    } catch (e) {
      emit(LogbookAddErrorState("Napaka pri pridobivanju podatkpov"));
    }
  }

  _onFormChanged(LogbookAddFormChanged event, Emitter<LogbookAddState> emit) {
    emit(event.state.copyWith(event.state));
  }

  _onFormSubmit(
    LogbookAddOnSubmissionEvent event,
    Emitter<LogbookAddState> emit,
  ) async {
    emit(LogbookAddLoadingState());

    try {
      var success = await logbookRepo.postLog(event.model);
      if (success) {
        emit(LogbookAddSumittedState());
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(LogbookAddOnSubmitErrorState(
          "Napaka pri pošiljanju podatkov, poskusite ponovno nekoliko kasneje"));
    }
  }
}
