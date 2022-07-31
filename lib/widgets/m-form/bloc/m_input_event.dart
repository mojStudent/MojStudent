part of 'm_input_bloc.dart';

@immutable
abstract class MInputEvent<T> {}

class MInputOnValueChangedEvent<T> extends MInputEvent<T> {
  final MInputValueState state;
  final T changedValue;

  MInputOnValueChangedEvent(this.state, this.changedValue);

  MInputOnValueChangedEvent<T> copyWith(
          MInputValueState? state, T? changedValue) =>
      MInputOnValueChangedEvent<T>(
        state ?? this.state,
        changedValue ?? this.changedValue,
      );
}
