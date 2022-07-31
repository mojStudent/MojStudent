import 'package:moj_student/services/blocs/submission/form_submission_status.dart';

class LoginState {
  final String username;
  final String password;
  final FormSubmissionStatus formSubmissionStatus;

  LoginState(
      {this.username = '',
      this.password = '',
      this.formSubmissionStatus = const InitialFormStatus()});

  LoginState copyWith(
      {String? username,
      String? password,
      FormSubmissionStatus? formSubmissionStatus}) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }

  bool get isValidEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
      .hasMatch(username);

  bool get isValidPassword => password.length > 3;
}
