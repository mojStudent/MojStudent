part of 'm_input_bloc.dart';

@immutable
abstract class MInputState<T> {}

class MInputInitialState<T> extends MInputState<T> {}

@immutable
class MInputValueState<T> extends MInputState<T> {
  final T value;
  final List<MInputValidator>? validators;
  final List<String> errors;

  MInputValueState(
    this.value, {
    this.validators,
    this.errors = const [],
  });
}
