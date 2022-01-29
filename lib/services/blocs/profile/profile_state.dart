part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserModel user;

  ProfileLoadedState(this.user);
}
