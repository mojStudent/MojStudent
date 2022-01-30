import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/failure_records/failures_repo.dart';
import 'package:moj_student/data/failure_records/new_failure_model.dart';
import 'package:moj_student/data/failure_records/new_failure_options_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class FailureAddScreen extends StatefulWidget {
  const FailureAddScreen({Key? key}) : super(key: key);

  @override
  _FailureAddScreenState createState() => _FailureAddScreenState();
}

class _FailureAddScreenState extends State<FailureAddScreen> {
  SubLocationOption? _chosenValue;
  List<SubLocationOption>? options;
  String? description;
  String? error;

  bool submitting = false;

  @override
  void initState() {
    _getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            AppHeader(
              title: "Prijava okvare",
            ),
            options == null ? LoadingScreen(withScaffold: false, expanded: true,) : Expanded(child: _buildView())
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ThemeColors.jet,
          elevation: 0,
          onPressed: () => _onSubmit(context),
          label: Row(
            children: [
              Text("Oddaj", style: TextStyle(color: Colors.white),),
              SizedBox(
                width: 10,
              ),
              Icon(FlutterRemix.send_plane_2_line, color: Colors.white,),
            ],
          ),
        ));
  }

  void _getOptions() {
    final repo = FailureRecordRepo();
    repo.getFailureOptions().then(
          (value) => setState(() {
            options = value.subLocation;
            _chosenValue = options![0];
          }),
        );
  }

  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: CustomScrollView(
        slivers: [
          if (error != null)
            RowSliver(
              child: Row(
                children: [
                  Text(
                    error!,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              title: "Napaka oddaje",
              icon: FlutterRemix.error_warning_line,
            ),
          RowSliver(
            title: "Lokacija okvare",
            icon: FlutterRemix.home_2_line,
            child: DropdownButton<SubLocationOption>(
              focusColor: Colors.white,
              isExpanded: true,
              value: _chosenValue,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              items: options!.map<DropdownMenuItem<SubLocationOption>>(
                  (SubLocationOption value) {
                return DropdownMenuItem<SubLocationOption>(
                  value: value,
                  child: Text(
                    value.label,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              hint: Text(
                "Lokacija okvare",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (SubLocationOption? value) {
                setState(() {
                  _chosenValue = value;
                });
              },
            ),
          ),
          RowSliver(
            child: TextField(
              onChanged: (value) => description = value,
              maxLines: 3,
              decoration:
                  InputDecoration.collapsed(hintText: "Opišite nastalo okvaro"),
            ),
            title: "Opis okvare",
            icon: FlutterRemix.file_2_fill,
          ),
        ],
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    setState(() => error = null);

    if (_chosenValue == null ||
        description == null ||
        description!.length < 3) {
      setState(() => error = "Forma ni pravilno izpolnjena");
    } else {
      setState(() => submitting = true);
      final repo = FailureRecordRepo();
      repo
          .postNewFailure(NewFailureModel(
              subLocation: _chosenValue!, description: description!))
          .then(
        (value) {
          if (value) {
            Navigator.of(context).pop();
            final snackBar =
                SnackBar(content: Text("Okvara je bila prijavljena"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            setState(() {
              submitting = false;
              error = "Prišlo je do napaka";
            });
          }
        },
      );
    }
  }
}
