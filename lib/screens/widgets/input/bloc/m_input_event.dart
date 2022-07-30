part of 'm_input_bloc.dart';

@immutable
abstract class MInputEvent {}

class MInputOnValueChangedEvent extends MInputEvent {
  final MInputValueState state;
  final String changedValue;

  MInputOnValueChangedEvent(this.state, this.changedValue);

  MInputOnValueChangedEvent copyWith(
          MInputValueState? state, String? changedValue) =>
      MInputOnValueChangedEvent(
        state ?? this.state,
        changedValue ?? this.changedValue,
      );
}
