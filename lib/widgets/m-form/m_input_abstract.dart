import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/widgets/m-form/bloc/m_input_bloc.dart';
import 'package:moj_student/widgets/m-form/m_input_params.dart';

class MInput<T, P extends MInputParams> extends StatelessWidget {
  final P params;
  Function(bool)? validListener;

  MInput({Key? key, this.validListener, required this.params})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MInputBloc<T>(), child: blocChild());
  }

  MInputWithBloc<T, P> blocChild() => MInputWithBloc<T, P>(
        params: params,
        validListener: validListener,
      );
}

class MInputWithBloc<T, P extends MInputParams> extends StatelessWidget {
  final P params;
  Function(bool)? validListener;

  MInputWithBloc({super.key, required this.params, this.validListener});

  @override
  Widget build(BuildContext context) {
    var state = context.read<MInputBloc<T>>().state;
    if (validListener != null && state is MInputValueState<T>) {
      validListener!(state.errors.isEmpty);
    }

    return RowSliver(
        title: params.title,
        icon: params.icon,
        child: BlocBuilder<MInputBloc<T>, MInputState<T>>(
          builder: (context, state) {
            if (state is MInputInitialState<T>) {
              context.read<MInputBloc<T>>().add(
                    MInputOnValueChangedEvent<T>(
                        MInputValueState<T>(params.initialValue,
                            validators: params.validators),
                        params.initialValue),
                  );
              return Container();
            } else if (state is MInputValueState<T>) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var e in buildBody(context, state)) e,
                  SizedBox(height: 7.5),
                  for (var error in state.errors) _errorMessageWidget(error)
                ],
              );
            } else {
              return Container();
            }
          },
        ));
  }

  List<Widget> buildBody(BuildContext context, MInputValueState<T> state) {
    return [Container()];
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
