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
    this.dateFormat = "dd. MM. YYYY",
  });
}
