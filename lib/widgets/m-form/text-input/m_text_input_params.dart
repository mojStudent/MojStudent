import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moj_student/widgets/m-form/input_validators/m_input_validator.dart';
import 'package:moj_student/widgets/m-form/m_input_params.dart';

class MTextInputParams extends MInputParams<String> {
  final String? placeholder;

  final bool obscuredText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> textInputFormatters;

  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  MTextInputParams({
    required super.title,
    super.initialValue = "",
    this.placeholder,
    super.icon,
    super.validators = const [],
    required super.onValueChanged,
    this.obscuredText = false,
    this.keyboardType = TextInputType.text,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
  });

  MTextInputParams.password({
    required super.title,
    super.initialValue = "",
    this.placeholder,
    super.icon,
    super.validators = const [],
    required super.onValueChanged,
    this.keyboardType = TextInputType.text,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.obscuredText = true,
  });

  MTextInputParams.multiline({
    required super.title,
    super.initialValue = "",
    super.icon,
    super.validators = const [],
    required super.onValueChanged,
    this.placeholder,
    this.obscuredText = false,
    this.keyboardType = TextInputType.multiline,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines,
    this.minLines,
  });

  MTextInputParams.required({
    required super.title,
    super.initialValue = "",
    super.icon,
    List<MInputValidator<String>>? validators,
    required super.onValueChanged,
    this.placeholder,
    this.obscuredText = false,
    this.keyboardType = TextInputType.text,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines,
    this.minLines,
  }) {
    super.validators = validators ?? [];
    super.validators.add(NotEmptyValidator());
  }
}
