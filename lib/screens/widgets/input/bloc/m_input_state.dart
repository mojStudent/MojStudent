part of 'm_input_bloc.dart';

@immutable
abstract class MInputState {}

class MInputInitialState extends MInputState {}

@immutable
class MInputValueState extends MInputState {
  final String value;
  final List<MInputValidator>? validators;
  final List<String> errors;

  MInputValueState(
    this.value, {
    this.validators,
    this.errors = const [],
  });
}
