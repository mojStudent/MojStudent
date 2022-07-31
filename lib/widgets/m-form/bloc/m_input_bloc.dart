import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/widgets/m-form/input_validators/m_input_validator.dart';

part 'm_input_event.dart';
part 'm_input_state.dart';

class MInputBloc<T> extends Bloc<MInputEvent<T>, MInputState<T>> {
  MInputBloc() : super(MInputInitialState()) {
    on<MInputOnValueChangedEvent<T>>(_onValueChange);
  }

  _onValueChange(MInputOnValueChangedEvent<T> event, Emitter<MInputState<T>> emit) {
    var currentState = event.state;
    var value = event.changedValue;

    List<String> errors = [];

    if (currentState.validators != null) {
      for (var validator in currentState.validators!) {
        var e = validator.validate(value);
        if (e != null) {
          errors.add(e);
        }
      }
    }

    emit(MInputValueState(
      value,
      validators: currentState.validators,
      errors: errors,
    ));
  }
}
