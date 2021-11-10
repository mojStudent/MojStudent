import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/damage-record/damage_record_model.dart';
import 'package:moj_student/data/damage-record/damage_record_repo.dart';

part 'damage_record_event.dart';
part 'damage_record_state.dart';

class DamageRecordBloc extends Bloc<DamageRecordEvent, DamageRecordState> {
  final DamageRecordRepo repo;

  DamageRecordBloc({required this.repo}) : super(DamageRecordInitial()) {
    on<DamageRecordLoadPageEvent>(_onLoadEvent);
  }

  _onLoadEvent(DamageRecordLoadPageEvent event, Emitter emit) async {
    emit(DamageRecordLoadingState());
    try {
      var data = await repo.getDamageRecords(page: event.page);
      emit(DamageRecordLoadedState(data));
    } catch (e) {
      emit(DamageRecordErrorState(e));
    }
  }
}
