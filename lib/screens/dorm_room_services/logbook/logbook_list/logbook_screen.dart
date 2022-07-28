import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/dorm_room_services/logbook/logbook_list/cubit/logbook_cubit.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class LogbookListScreen extends StatelessWidget {
  const LogbookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/logbook/new"),
        backgroundColor: ThemeColors.jet,
        child: Icon(
          FlutterRemix.add_line,
          color: Colors.white,
        ),
      ),
      body: Column(children: [
        AppHeader(title: "Dežurna knjiga"),
        Expanded(
            child: BlocProvider(
          create: (_) => LogbookCubit(),
          child: BlocBuilder<LogbookCubit, LogbookState>(
            builder: (context, state) {
              return Text("");
            },
          ),
        ))
      ]),
    );
  }
}
