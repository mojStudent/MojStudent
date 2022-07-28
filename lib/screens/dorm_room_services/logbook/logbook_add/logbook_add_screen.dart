import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/dorm_room_services/logbook/logbook_repo.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_add_options_model.dart';
import 'package:moj_student/screens/dorm_room_services/logbook/logbook_add/bloc/logbook_add_bloc.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class LogbookAddScreen extends StatelessWidget {
  const LogbookAddScreen({Key? key}) : super(key: key);

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
                  } else if (state is LogbookAddErrorState) {
                    return Center(child: Text("Napaka"));
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
          return FloatingActionButton.extended(
            onPressed: () => null,
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
    return CustomScrollView(
      slivers: [
        CategoryNameSliver(categoryName: "Lokacija"),
        _sublocationInput(state, context),
        RowSliver(
          title: "Soba",
          icon: FlutterRemix.building_line,
          child: TextFormField(
              decoration: InputDecoration(hintText: "Soba"),
              validator: (value) => _notEmptyValidator(value),
              onChanged: (value) {
                state.room = value;
                context
                    .read<LogbookAddBloc>()
                    .add(LogbookAddFormChanged(state));
              }),
        ),
        CategoryNameSliver(categoryName: "Povzročitelj"),
        _vandalInput(state, context),
        RowSliver(
          title: "Opis povzročitelja",
          icon: FlutterRemix.passport_line,
          child: TextFormField(
              decoration: InputDecoration(hintText: "Ime in priimek ali opis"),
              validator: (value) => _notEmptyValidator(value),
              onChanged: (value) {
                state.room = value;
                context
                    .read<LogbookAddBloc>()
                    .add(LogbookAddFormChanged(state));
              }),
        ),
        CategoryNameSliver(categoryName: "Opis dogodka"),
        RowSliver(
          title: "Opis dogodka",
          icon: FlutterRemix.pencil_line,
          child: TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(hintText: "Opis dogodka"),
              validator: (value) => _notEmptyValidator(
                    value,
                    minLength: 4,
                    message:
                        "Opis dogodkga mora biti izpolnjen in daljši od petih znakov",
                  ),
              onChanged: (value) {
                state.room = value;
                context
                    .read<LogbookAddBloc>()
                    .add(LogbookAddFormChanged(state));
              }),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
        items: state.subLocationOptions!
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
        items: state.vandalTypeOptions!
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

  String? _notEmptyValidator(
    String? value, {
    int minLength = 0,
    String message = "Polje je obvezno",
  }) =>
      value != null && value.length > minLength ? null : message;
}
