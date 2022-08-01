import 'package:moj_student/data/sports/models/fitnes_card_model.dart';
import 'package:moj_student/widgets/m-form/input_validators/m_input_validator.dart';
import 'package:moj_student/widgets/m-form/m_input_params.dart';

class MDatepickerParams<DateTime> extends MInputParams<DateTime> {
  final DateTime firstDate;
  final DateTime lastDate;
  final String dateFormat;

  MDatepickerParams({
    required super.title,
    required super.initialValue,
    required super.onValueChanged,
    required this.firstDate,
    required this.lastDate,
    super.icon,
    super.validators,
    this.dateFormat = "dd. MM. YYYY",
  });

  MDatepickerParams.required({
    required super.title,
    required super.initialValue,
    required super.onValueChanged,
    required this.firstDate,
    required this.lastDate,
    super.icon,
    List<MInputValidator<DateTime>>? validators,
    this.dateFormat = "dd. MM. YYYY",
  }) {
    super.validators = validators ?? [];
    super.validators.add(NotNullValidator());
  }
}
