import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/input/bloc/m_input_bloc.dart';
import 'package:moj_student/screens/widgets/input/m_input_params.dart';

class MInput extends StatelessWidget {
  final MInputParams params;
  Function(bool)? validListener;
  bool valid = false;

  MInput({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MInputBloc(),
      child: BlocBuilder<MInputBloc, MInputState>(
        builder: (context, state) {
          var _bloc = _MInputWithBloc(
            params: params,
            validListener: validListener,
          );

          return _bloc;
        },
      ),
    );
  }
}

class _MInputWithBloc extends StatelessWidget {
  final MInputParams params;
  final Function(bool)? validListener;

  const _MInputWithBloc({
    Key? key,
    required this.params,
    this.validListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<MInputBloc>().state;
    if (validListener != null && state is MInputValueState) {
      validListener!(state.errors.isEmpty);
    }

    return RowSliver(
        title: params.title,
        icon: params.icon,
        child: BlocBuilder<MInputBloc, MInputState>(
          builder: (context, state) {
            if (state is MInputInitialState) {
              context.read<MInputBloc>().add(
                    MInputOnValueChangedEvent(
                        MInputValueState(params.initialValue,
                            validators: params.validators),
                        params.initialValue),
                  );
              return Container();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _inputStack(context, state as MInputValueState),
                  SizedBox(height: 7.5),
                  for (var error in state.errors) _errorMessageWidget(error)
                ],
              );
            }
          },
        ));
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
        context.read<MInputBloc>().add(MInputOnValueChangedEvent(state, value));
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
