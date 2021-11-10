import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/login_model.dart';
import 'package:moj_student/services/blocs/login/login_event.dart';
import 'package:moj_student/services/blocs/login/login_state.dart';
import 'package:moj_student/services/blocs/submission/form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginState()) {
    on<LoginUsernameChanged>(
        (event, emit) => emit(state.copyWith(username: event.username)));
    on<LoginPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<LoginFormStatusChanged>(_loginSubmit);
  }

  void _loginSubmit(
      LoginFormStatusChanged event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formSubmissionStatus: event.formState));

    if (event.formState is FormSubmitting) {
      try {
        await authRepository.login(
            LoginModel(username: state.username, password: state.password));
        emit(state.copyWith(formSubmissionStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(
            formSubmissionStatus: SubmissionFailed(e as Exception)));
      }
    }
  }
}
