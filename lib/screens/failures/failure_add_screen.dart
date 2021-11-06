import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/failure_records/failures_repo.dart';
import 'package:moj_student/data/failure_records/new_failure_model.dart';
import 'package:moj_student/data/failure_records/new_failure_options_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';

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
        appBar: AppBar(
          title: Text("Prijavi novo okvaro"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.raisinBlack[500],
        ),
        backgroundColor: AppColors.green,
        body: options == null ? LoadingScreen() : _buildView());
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
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: CustomScrollView(
        slivers: [
          _card(
            "Lokacija okvare",
            DropdownButton<SubLocationOption>(
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
          _card(
            "Opis okvare",
            TextField(
              onChanged: (value) => description = value,
              maxLines: 3,
              decoration:
                  InputDecoration.collapsed(hintText: "Opišite nastalo okvaro"),
            ),
          ),
          if (error != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text(
                  error!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: !submitting
                  ? ElevatedButton(
                      onPressed: () => _onSubmit(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Oddaj prijavo")
                        ],
                      ))
                  : Center(child: CircularProgressIndicator()),
            ),
          )
        ],
      ),
    );
  }

  Widget _card(String title, Widget body) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Padding(padding: const EdgeInsets.only(top: 10), child: body),
              ],
            ),
          ),
        ),
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
