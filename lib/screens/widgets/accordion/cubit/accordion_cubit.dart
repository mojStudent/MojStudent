import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'accordion_state.dart';

class AccordionCubit extends Cubit<AccordionState> {
  AccordionCubit(AccordionState state) : super(state);

  toggleAccrdion() {
    if (this.state is AccordionExpandedState) {
      emit(AccordionHiddenState());
    } else if (this.state is AccordionHiddenState) {
      emit(AccordionExpandedState());
    }
  }
}
