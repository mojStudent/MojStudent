import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/services/internet/internet_tab.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetBloc() : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
