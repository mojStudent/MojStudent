import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/dorm_room_services/logbook/logbook_repo.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_model.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_sublocation_model.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_vandal_type.dart';
import 'package:moj_student/screens/dorm_room_services/logbook/logbook_add/bloc/logbook_add_bloc.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/input/input_validators/m_input_validator.dart';
import 'package:moj_student/screens/widgets/input/m_input.dart';
import 'package:moj_student/screens/widgets/input/m_input_group.dart';
import 'package:moj_student/screens/widgets/input/m_input_params.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class LogbookAddScreen extends StatelessWidget {
  bool inputFormValid = false;

  LogbookAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LogbookAddBloc(LogbookRepo()),
        child: Scaffold(
          floatingActionButton: _fab(context),
          body: Column(children: [
            AppHeader(title: "Nov vpis"),
            Expanded(
              child: BlocBuilder<LogbookAddBloc, LogbookAddState>(
                builder: (context, state) {
                  if (state is LogbookAddInitial) {
                    context
                        .read<LogbookAddBloc>()
                        .add(LogbookAddLoadOptionsEvent());
                    return LoadingScreen(
                      withScaffold: false,
                    );
                  } else if (state is LogbookAddLoadingState) {
                    return LoadingScreen(
                      withScaffold: false,
                    );
                  } else if (state is LogbookAddLoadedState) {
                    return _buildForm(context);
                  } else if (state is LogbookAddSumittedState) {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.pop(context);
                      _showScaffoldMessage(
                        context,
                        "Vpis je bil uspešno shranjen",
                      );
                    });
                    return Container();
                  } else if (state is LogbookAddErrorState ||
                      state is LogbookAddOnSubmitErrorState) {
                    return Center(
                      child: Text(
                        (state as LogbookAddErrorState).message,
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Center(child: Text("Napaka, še sam ne vem kakšna"));
                  }
                },
              ),
            ),
          ]),
        ));
  }

  Widget _fab(BuildContext context) {
    return BlocBuilder<LogbookAddBloc, LogbookAddState>(
      builder: (context, state) {
        if (state is LogbookAddLoadedState) {
          var model = LogbookModel(
            subLocation: state.selectedSubLocation!,
            vandalType: state.selectedVandalType!,
            description: state.description,
            room: state.room,
            vandal: state.vandalDescription,
          );

          return FloatingActionButton.extended(
            onPressed: () => context
                .read<LogbookAddBloc>()
                .add(LogbookAddOnSubmissionEvent(model)),
            backgroundColor: ThemeColors.jet,
            label: Row(
              children: [
                Text(
                  "Oddaj",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  FlutterRemix.send_plane_2_line,
                  color: Colors.white,
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    var state = context.read<LogbookAddBloc>().state as LogbookAddLoadedState;

    var inputGroup = MInputGroup(
      {
        "soba": MInput(
          params: MInputParams.required(
              title: "Soba",
              icon: FlutterRemix.building_line,
              placeholder: "Soba",
              onValueChanged: (value) {
                state.room = value;
                context
                    .read<LogbookAddBloc>()
                    .add(LogbookAddFormChanged(state));
              }),
        ),
        "povzrocitelj": MInput(
          params: MInputParams.required(
            title: "Opis povzročitelja",
            icon: FlutterRemix.passport_line,
            placeholder: "Ime in priimek ali opis",
            onValueChanged: (value) {
              state.vandalDescription = value;
              context.read<LogbookAddBloc>().add(LogbookAddFormChanged(state));
            },
          ),
        ),
        "opis": MInput(
          params: MInputParams.multiline(
            title: "Opis dogodka",
            icon: FlutterRemix.pencil_line,
            placeholder: "Opis dogodka",
            validators: [
              MinLengthValidator.withCustomMessage(
                minLength: 4,
                errorMessage:
                    "Opis dogodkga mora biti izpolnjen in daljši od petih znakov",
              )
            ],
            onValueChanged: (value) {
              state.description = value;
              context.read<LogbookAddBloc>().add(LogbookAddFormChanged(state));
            },
          ),
        ),
      },
      validListener: (value) => inputFormValid = value,
    );

    return CustomScrollView(
      slivers: [
        CategoryNameSliver(categoryName: "Lokacija"),
        _sublocationInput(state, context),
        inputGroup.input('soba'),
        CategoryNameSliver(categoryName: "Povzročitelj"),
        _vandalInput(state, context),
        inputGroup.input('povzrocitelj'),
        CategoryNameSliver(categoryName: "Opis dogodka"),
        inputGroup.input('opis'),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        )
      ],
    );
  }

  RowSliver _sublocationInput(
      LogbookAddLoadedState state, BuildContext context) {
    return RowSliver(
      icon: FlutterRemix.compass_line,
      title: "Pod-lokacija",
      child: DropdownButton<LogbookSubLocation>(
        focusColor: Colors.white,
        isExpanded: true,
        value: state.selectedSubLocation,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        items: state.subLocationOptions
            .map<DropdownMenuItem<LogbookSubLocation>>(
                (LogbookSubLocation value) {
          return DropdownMenuItem<LogbookSubLocation>(
            value: value,
            child: Text(
              value.label,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        hint: Text(
          "Lokacija dogodka",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        onChanged: (LogbookSubLocation? value) {
          state.selectedSubLocation = value;
          context.read<LogbookAddBloc>().add(LogbookAddFormChanged(state));
        },
      ),
    );
  }

  RowSliver _vandalInput(LogbookAddLoadedState state, BuildContext context) {
    return RowSliver(
      icon: FlutterRemix.criminal_line,
      title: "Tip povzročitelja",
      child: DropdownButton<VandalType>(
        focusColor: Colors.white,
        isExpanded: true,
        value: state.selectedVandalType,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        items: state.vandalTypeOptions
            .map<DropdownMenuItem<VandalType>>((VandalType value) {
          return DropdownMenuItem<VandalType>(
            value: value,
            child: Text(
              value.label,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        hint: Text(
          "Tip povzročitelja",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        onChanged: (VandalType? value) {
          state.selectedVandalType = value;
          context.read<LogbookAddBloc>().add(LogbookAddFormChanged(state));
        },
      ),
    );
  }

  void _showScaffoldMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
