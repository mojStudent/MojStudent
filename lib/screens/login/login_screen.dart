import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/screens/home/home_screen.dart';
import 'package:moj_student/services/login/login_bloc.dart';
import 'package:moj_student/services/login/login_event.dart';
import 'package:moj_student/services/login/login_state.dart';
import 'package:moj_student/services/submission/form_submission_status.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var loginModelFromSharedPreferences = LoginModelSharedPreferences.getUserFromSharedPreferences();
    if(loginModelFromSharedPreferences != null) {
      
    }



    return Scaffold(
      backgroundColor: AppColors.success,
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: _buildView(context),
      ),
    );
  }

  SafeArea _buildView(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.025),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Text(
                "Moj Študent",
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            _loginFormBox(context)
          ],
        ),
      ),
    );
  }

  Container _loginFormBox(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.025,
              vertical: MediaQuery.of(context).size.height * 0.025),
          child: _loginForm(context)),
    );
  }

  Widget _loginForm(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formSubmissionStatus;
        if (formStatus is SubmissionSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RepositoryProvider(
                      create: (context) => AuthRepository(),
                      child: HomeScreen(),
                    )),
          );
        } else if (formStatus is SubmissionFailed) {
          _showSnackbar(context, formStatus.exception.toString());
          context
              .read<LoginBloc>()
              .add(LoginFormStatusChanged(formState: InitialFormStatus()));
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _usernameField(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            _passwordField(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            _loginButton()
          ],
        ),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration:
              InputDecoration(icon: Icon(Icons.security), hintText: "Geslo"),
          validator: (value) =>
              state.isValidPassword ? null : "Geslo ne sme biti prazno",
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
        );
      },
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
            decoration:
                InputDecoration(icon: Icon(Icons.person), hintText: "E-pošta"),
            validator: (value) =>
                state.isValidEmail ? null : "Podani email ni pravilne oblike",
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginUsernameChanged(username: value)));
      },
    );
  }

  Widget _loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return state.formSubmissionStatus is FormSubmitting
                ? CircularProgressIndicator()
                : Expanded(
                    child: ElevatedButton(
                    onPressed: (() => _formKey.currentState?.validate() ?? false
                        ? context.read<LoginBloc>().add(
                            LoginFormStatusChanged(formState: FormSubmitting()))
                        : null),
                    child: Text("Prijava"),
                  ));
          },
        )
      ],
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
