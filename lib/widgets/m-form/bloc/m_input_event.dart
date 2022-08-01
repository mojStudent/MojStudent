part of 'm_input_bloc.dart';

@immutable
abstract class MInputEvent<T> {}

class MInputOnValueChangedEvent<T> extends MInputEvent<T> {
  final MInputValueState<T> state;
  final T changedValue;

  MInputOnValueChangedEvent(this.state, this.changedValue);

  MInputOnValueChangedEvent<T> copyWith(
          MInputValueState<T>? state, T? changedValue) =>
      MInputOnValueChangedEvent<T>(
        state ?? this.state,
        changedValue ?? this.changedValue,
      );
}
