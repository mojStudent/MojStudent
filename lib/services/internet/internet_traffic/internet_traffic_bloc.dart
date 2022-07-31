import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/internet/models/internet_admin_model.dart';
import 'package:moj_student/data/internet/models/internet_traffic_model.dart';

part 'internet_traffic_event.dart';
part 'internet_traffic_state.dart';

class InternetTrafficBloc
    extends Bloc<InternetTrafficEvent, InternetTrafficState> {
  final InternetRepository repo;

  InternetTrafficBloc(this.repo) : super(InternetTrafficInitial()) {
    on<InternetTrafficLoad>(_onLoad);
  }

  _onLoad(InternetTrafficLoad event, Emitter emit) async {
    emit(InternetTrafficLoadingState());

    try {
      var model = await repo.getInternetTraffic();
      var administrators = await repo.getInterentAdministrators();
      emit(InternetTrafficLoadedState(model, administrators));
    } catch (e) {
      emit(InternetTrafficErrorState(e));
    }
  }
}
