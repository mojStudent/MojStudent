import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:moj_student/screens/widgets/input/input_validators/m_input_validator.dart';

class MInputParams {
  final String title;
  final String initialValue;
  final String? placeholder;
  final IconData? icon;
  late List<MInputValidator> validators;
  final Function(String) onValueChanged;

  final bool obscuredText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> textInputFormatters;

  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  MInputParams({
    required this.title,
    this.initialValue = "",
    this.placeholder,
    this.icon,
    this.validators = const [],
    required this.onValueChanged,
    this.obscuredText = false,
    this.keyboardType = TextInputType.text,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
  });

  MInputParams.password({
    required this.title,
    this.initialValue = "",
    this.placeholder,
    this.icon,
    this.validators = const [],
    required this.onValueChanged,
    this.obscuredText = true,
    this.keyboardType = TextInputType.text,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
  });

  MInputParams.multiline({
    required this.title,
    this.initialValue = "",
    this.placeholder,
    this.icon,
    this.validators = const [],
    required this.onValueChanged,
    this.obscuredText = false,
    this.keyboardType = TextInputType.multiline,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines,
    this.minLines,
  });

  MInputParams.required({
    required this.title,
    this.initialValue = "",
    this.placeholder,
    this.icon,
    List<MInputValidator>? validators,
    required this.onValueChanged,
    this.obscuredText = false,
    this.keyboardType = TextInputType.text,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines,
    this.minLines,
  }) {
    this.validators = validators ?? [];
    this.validators.add(NotNullValidator());
  }
}
