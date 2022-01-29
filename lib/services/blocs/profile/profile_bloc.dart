import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/services/blocs/notification/notification_states.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthRepository authRepo;

  ProfileBloc({required this.authRepo}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter emit) async {
    emit(ProfileLoadingState());

    try {
      final user = authRepo.loggedInUser as UserModel;
      emit(ProfileLoadedState(user));
    } catch (e) {
      emit(DataLoadingError(e: e));
    }
  }
}
