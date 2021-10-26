import 'package:flutter/cupertino.dart';
import 'package:moj_student/services/submission/form_submission_status.dart';

abstract class LoginEvent {}


class LoginUsernameChanged extends LoginEvent {
  final String username;

  LoginUsernameChanged({required this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginFormStatusChanged extends LoginEvent {
  final FormSubmissionStatus formState;

  LoginFormStatusChanged({required this.formState});
}
