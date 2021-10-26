import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/services/home/home_bloc.dart';
import 'package:moj_student/services/home/home_event.dart';

class InitialLoading extends StatefulWidget {
  InitialLoading({Key? key}) : super(key: key);

  @override
  _InitialLoadingState createState() => _InitialLoadingState();
}

class _InitialLoadingState extends State<InitialLoading> {
  Future<void> isUserInSharedPreferences(BuildContext context) async {
    var authRepository = context.read<AuthRepository>();
    var model =
        await LoginModelSharedPreferences.getUserFromSharedPreferences();
    if (model == null) {
      Navigator.of(context).pushReplacementNamed("/login");
    } else {
      var userModel = await authRepository.login(model);
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(authRepository: context.read<AuthRepository>()),
      child: _letsFuckingBuiltIt(context)
    );
  }

  Widget _letsFuckingBuiltIt(BuildContext context) {
    isUserInSharedPreferences(context);
    return Scaffold(body: Center(child: CircularProgressIndicator(),),);
  }


}
