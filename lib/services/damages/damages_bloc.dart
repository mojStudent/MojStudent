import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'damages_event.dart';
part 'damages_state.dart';

class DamagesBloc extends Bloc<DamagesEvent, DamagesState> {
  DamagesBloc() : super(DamagesInitial()) {
    on<DamagesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
