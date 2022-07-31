// ignore_for_file: constant_identifier_names

import 'package:moj_student/data/auth/models/auth/user_model.dart';

abstract class HomeState {
  const HomeState();
}

class InitialState extends HomeState {}

class LoadingData extends HomeState {}

class LoadedData extends HomeState {
  UserModel user;
  LoadedDataTab showTab;

  LoadedData({required this.user, this.showTab = LoadedDataTab.MENU});

  LoadedData changeTab(LoadedDataTab showTab) {
    return LoadedData(user: user, showTab: showTab);
  }
}

class LoadingDataError extends HomeState {
  Exception e;

  LoadingDataError({required this.e});
}

enum LoadedDataTab { MENU, PROFILE }
