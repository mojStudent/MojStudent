import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/widgets/m-form/bloc/m_input_bloc.dart';
import 'package:moj_student/widgets/m-form/m_input_abstract.dart';
import 'package:moj_student/widgets/m-form/text-input/m_text_input_params.dart';

class MTextInput extends MInput<MTextInputParams> {
  bool valid = false;

  MTextInput({
    Key? key,
    required super.params,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MInputBloc<String>(),
        child: _MInputWithBloc(
          params: params,
          validListener: super.validListener,
        ));
  }
}

class _MInputWithBloc extends MInputWithBloc<String, MTextInputParams> {
  _MInputWithBloc({
    Key? key,
    required super.params,
    super.validListener,
  }) : super(key: key);

  @override
  List<Widget> buildBody(BuildContext context, MInputValueState<String> state) {
    return [_inputStack(context, state)];
  }

  Widget _inputStack(BuildContext context, MInputValueState state) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        _inputWidget(context, state),
        state.errors.isNotEmpty
            ? Icon(
                FlutterRemix.error_warning_line,
                color: ThemeColors.danger,
                size: 20,
              )
            : Container(),
      ],
    );
  }

  TextFormField _inputWidget(BuildContext context, MInputValueState state) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: params.placeholder,
      ),
      onChanged: (value) {
        context
            .read<MInputBloc<String>>()
            .add(MInputOnValueChangedEvent<String>(state, value));
        params.onValueChanged(value);
      },
      obscureText: params.obscuredText,
      keyboardType: params.keyboardType,
      inputFormatters: params.textInputFormatters,
      minLines: params.minLines,
      maxLines: params.maxLines,
      maxLength: params.maxLength,
    );
  }

  Text _errorMessageWidget(String error) {
    return Text(
      error,
      style: TextStyle(
        color: ThemeColors.danger,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
