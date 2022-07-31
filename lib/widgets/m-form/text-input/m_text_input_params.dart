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
    required String title,
    String initialValue = "",
    this.placeholder,
    IconData? icon,
    List<MInputValidator> validators = const [],
    required Function(String) onValueChanged,
    this.obscuredText = false,
    this.keyboardType = TextInputType.text,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
  }) : super(
            title: title,
            initialValue: initialValue,
            onValueChanged: onValueChanged,
            icon: icon,
            validators: validators);

  MTextInputParams.password({
    required String title,
    String initialValue = "",
    this.placeholder,
    IconData? icon,
    List<MInputValidator> validators = const [],
    required Function(String) onValueChanged,
    this.keyboardType = TextInputType.text,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.obscuredText = true,
  }) : super(
            title: title,
            initialValue: initialValue,
            onValueChanged: onValueChanged,
            icon: icon,
            validators: validators);

  MTextInputParams.multiline({
    required String title,
    String initialValue = "",
    IconData? icon,
    List<MInputValidator> validators = const [],
    required Function(String) onValueChanged,
    this.placeholder,
    this.obscuredText = false,
    this.keyboardType = TextInputType.multiline,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines,
    this.minLines,
  }) : super(
            title: title,
            initialValue: initialValue,
            onValueChanged: onValueChanged,
            icon: icon,
            validators: validators);

  MTextInputParams.required({
    required String title,
    String initialValue = "",
    IconData? icon,
    List<MInputValidator> validators = const [],
    required Function(String) onValueChanged,
    this.placeholder,
    this.obscuredText = false,
    this.keyboardType = TextInputType.text,
    this.textInputFormatters = const [],
    this.maxLength,
    this.maxLines,
    this.minLines,
  }) : super(
            title: title,
            initialValue: initialValue,
            onValueChanged: onValueChanged,
            icon: icon,
            validators: validators) {
    this.validators = validators ?? [];
    this.validators.add(NotNullValidator());
  }
}
