import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/widgets/m-form/bloc/m_input_bloc.dart';
import 'package:moj_student/widgets/m-form/datepicker/m_datepicker_params.dart';
import 'package:moj_student/widgets/m-form/m_input_abstract.dart';
import 'package:intl/intl.dart';

class MDatepicker extends MInput<DateTime, MDatepickerParams> {
  MDatepicker({required super.params, super.key});

  @override
  MInputWithBloc<DateTime, MDatepickerParams> blocChild() => _MInputWithBloc(
        params: super.params,
        validListener: super.validListener,
      );
}

class _MInputWithBloc extends MInputWithBloc<DateTime, MDatepickerParams> {
  _MInputWithBloc({
    super.key,
    required super.params,
    super.validListener,
  });

  @override
  List<Widget> buildBody(
      BuildContext context, MInputValueState<DateTime> state) {
    return [
      Row(
        children: [
          Expanded(
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                hintText: DateFormat("dd. MM. yyyy", "sl").format(state.value),
              ),
            ),
          ),
          IconButton(
              onPressed: () => selectDate(context),
              icon: Icon(
                FlutterRemix.calendar_line,
                color: ThemeColors.jet,
              ))
        ],
      )
    ];
  }

  Future<void> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: params.initialValue,
      firstDate: params.firstDate,
      lastDate: params.lastDate,
    );

    if (pickedDate != null) {
      final state = context.read<MInputBloc<DateTime>>().state
          as MInputValueState<DateTime>;

      context
          .read<MInputBloc<DateTime>>()
          .add(MInputOnValueChangedEvent<DateTime>(state, pickedDate));

      // if (validListener != null) {
      //   validListener!(pickedDate);
      // }
    }
  }
}
