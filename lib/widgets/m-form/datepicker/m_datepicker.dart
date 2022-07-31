import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/widgets/m-form/bloc/m_input_bloc.dart';
import 'package:moj_student/widgets/m-form/datepicker/m_datepicker_params.dart';
import 'package:moj_student/widgets/m-form/m_input_abstract.dart';

class MDatepicker extends MInput<MDatepickerParams> {
  MDatepicker({required super.params});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MInputBloc<DateTime>(),
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
  final MDatepickerParams params;
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
                ],
              );
            }
          },
        ));
  }
}
