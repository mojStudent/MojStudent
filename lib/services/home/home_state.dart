import 'package:moj_student/data/auth/models/auth/user_model.dart';

abstract class HomeState {
  const HomeState();
}

class InitialState extends HomeState {}

class LoadingData extends HomeState {}

class LoadedData extends HomeState {
  UserModel user;

  LoadedData({required this.user});
}

class LoadingDataError extends HomeState{
  Exception e;

  LoadingDataError({required this.e});
}