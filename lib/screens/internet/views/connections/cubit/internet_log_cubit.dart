import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/internet/models/internet_log_model.dart';

part 'internet_log_state.dart';

class InternetLogCubit extends Cubit<InternetLogState> {
  InternetLogCubit() : super(InternetLogInitial());

  void initialize(List<InternetConnectionLogModel> connections) {
    emit(InternetLogLoadedState(connections, false));
  }

  void filterActive(
          List<InternetConnectionLogModel> connections, bool showOnlyActive) =>
      emit(InternetLogLoadedState(connections, showOnlyActive));
}
