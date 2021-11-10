import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/failure_records/failure_record_model.dart';
import 'package:moj_student/data/failure_records/failures_repo.dart';

part 'failure_record_event.dart';
part 'failure_record_state.dart';

class FailureRecordBloc extends Bloc<FailureRecordEvent, FailureRecordState> {
  final FailureRecordRepo repo;

  FailureRecordBloc({required this.repo}) : super(FailureRecordInitial()) {
    on<FailureRecordLoadPageEvent>(_onLoadEvent);
  }

  _onLoadEvent(FailureRecordLoadPageEvent event, Emitter emit) async {
    emit(FailureRecordLoadingState());
    try {
      var data = await repo.getFailureRecords(page: event.page);
      emit(FailureRecordLoadedState(data));
    } catch (e) {
      emit(FailureRecordErrorState(e));
    }
  }
}
