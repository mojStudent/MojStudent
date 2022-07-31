import 'package:moj_student/widgets/m-form/m_input_abstract.dart';

class MInputGroup {
  final Map<String, _MInputField> _inputs = {};
  final Function(bool)? validListener;

  MInputGroup(Map<String, MInput> inputMap, {this.validListener}) {
    inputMap.forEach((key, value) {
      _inputs.putIfAbsent(key, () => _MInputField.notValid(value));
    });

    _inputs.forEach((key, value) {
      value.input.validListener = (valid) {
        value.validField = valid;
        if (validListener != null) {
          validListener!(isValid());
        }
      };
    });
  }

  MInput input(String name) => _inputs[name]!.input;

  bool isValid() =>
      !_inputs.entries.map((e) => e.value.validField).any((e) => e == false);
}

class _MInputField<T extends MInput> {
  final MInput input;
  bool validField;

  _MInputField(this.input, this.validField);

  _MInputField.notValid(this.input) : validField = false;
}
