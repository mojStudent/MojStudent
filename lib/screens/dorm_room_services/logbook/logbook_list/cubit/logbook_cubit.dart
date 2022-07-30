import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/dorm_room_services/logbook/logbook_repo.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_list_model.dart';
import 'package:moj_student/data/exceptions/empty_data_exception.dart';

part 'logbook_state.dart';

class LogbookCubit extends Cubit<LogbookState> {
  final LogbookRepo logbookRepo;

  LogbookCubit(this.logbookRepo) : super(LogbookInitial());

  loadLogbookPage({int page = 1}) async {
    emit(LogbookLoadingState());

    try {
      var model = await logbookRepo.getLogbookRecords(page: page);
      emit(LogbookLoadedState(model));
    } on EmptyDataException {
      emit(LogbookNoDataState());
    } catch (e) {
      emit(LogbookErrorState("Napaka pri pridobivanju podatkov"));
    }
  }
}
