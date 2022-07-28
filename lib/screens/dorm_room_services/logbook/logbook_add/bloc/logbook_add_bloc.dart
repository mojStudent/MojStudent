import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/dorm_room_services/logbook/logbook_repo.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_add_options_model.dart';

part 'logbook_add_event.dart';
part 'logbook_add_state.dart';

class LogbookAddBloc extends Bloc<LogbookAddEvent, LogbookAddState> {
  final LogbookRepo logbookRepo;

  LogbookAddBloc(this.logbookRepo) : super(LogbookAddInitial()) {
    on<LogbookAddLoadOptionsEvent>(_onOptionsLoadEvent);
    on<LogbookAddFormChanged>(_onFormChanged);
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
      emit(LogbookAddErrorState());
    }
  }

  _onFormChanged(LogbookAddFormChanged event, Emitter<LogbookAddState> emit) {
    emit(event.state.copyWith(event.state));
  }
}
