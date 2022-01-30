import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/screens/home/home_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/buttons/row_button.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';
import 'package:moj_student/services/blocs/login/login_bloc.dart';
import 'package:moj_student/services/blocs/login/login_event.dart';
import 'package:moj_student/services/blocs/login/login_state.dart';
import 'package:moj_student/services/blocs/submission/form_submission_status.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: h * 0.25,
              padding: EdgeInsets.only(left: w * 0.08, bottom: h * 0.05),
              decoration: BoxDecoration(
                  color: ThemeColors.primary,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(60))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Moj Študent",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: w * 0.03,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/ikona.png',
                        height: 52,
                      ),
                      SizedBox(
                        height: h * 0.015,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: h * 0.05),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _loginFormBox(h, w, context),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: w * 0.02, left: w * 0.1),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(60))),
          height: h * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _tosLink(context),
            ],
          ),
        )
      ],
    );
  }

  Widget _loginFormBox(double h, double w, BuildContext context) {
    return Column(
      children: [
        RowContainer(
          child: _loginForm(context, h, w),
          title: "Prijava",
          icon: FlutterRemix.shield_line,
        ),
        _loginButton(),
        SizedBox(
          height: h * 0.025,
        ),
        RowContainer(
          child: Text(
            "Prijavne podatke ste pridobili ob vselitvi v zavod Študentski domovi Ljubljana.",
            style: TextStyle(fontSize: 10, color: ThemeColors.jet),
          ),
          title: "",
          icon: FlutterRemix.lock_line,
        ),
      ],
    );
  }

  Widget _loginForm(BuildContext context, double h, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * 0.01),
      child: BlocListener<LoginBloc, LoginState>(
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
            _showSnackbar(context, formStatus.exception.error.message);
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: InputDecoration(hintText: "Geslo"),
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
            decoration: InputDecoration(hintText: "E-pošta"),
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
                    child: RowButton(
                      title: "Prijava",
                      icon: FlutterRemix.login_circle_line,
                      onPressed: (() =>
                          _formKey.currentState?.validate() ?? false
                              ? context.read<LoginBloc>().add(
                                  LoginFormStatusChanged(
                                      formState: FormSubmitting()))
                              : null),
                    ),
                  );
          },
        )
      ],
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _tosLink(BuildContext context) {
    const url = "https://mojstudent.marela.team/tos";

    return GestureDetector(
      onTap: () async => await canLaunch(url)
          ? await launch(url)
          : _showSnackbar(context, "Ne morem odpreti povezave"),
      child: Text(
        "Z uporabo klienta se strinjate s splošnimi pogoji uporabe klienta.",
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
