import 'package:flutter/cupertino.dart';
import 'package:moj_student/widgets/m-form/input_validators/m_input_validator.dart';

abstract class MInputParams<T> {
  final String title;
  final T initialValue;
  final IconData? icon;

  late List<MInputValidator> validators;
  final Function(T) onValueChanged;

  MInputParams(
      {required this.title,
      required this.initialValue,
      this.icon,
      this.validators = const [],
      required this.onValueChanged});
}
