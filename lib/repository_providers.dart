import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/damage-record/damage_record_repo.dart';
import 'package:moj_student/data/failure_records/failures_repo.dart';
import 'package:moj_student/data/internet/admin/iadmin_repo.dart';
import 'package:moj_student/data/internet/internet_help_repo.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/notifications/notification_repo.dart';
import 'package:moj_student/data/sports/sports_repo.dart';

var appProviders = [
  RepositoryProvider(create: (context) => AuthRepository()),
  RepositoryProvider(create: (context) => NotificationRepo()),
  RepositoryProvider(create: (context) => DamageRecordRepo()),
  RepositoryProvider(create: (context) => FailureRecordRepo()),
  RepositoryProvider(
      create: (context) =>
          InternetRepository(authRepository: AuthRepository())),
  RepositoryProvider(
      create: (context) => InternetHelpRepo(authRepository: AuthRepository())),
  RepositoryProvider(
      create: (context) => SportsRepository(authRepository: AuthRepository())),
  RepositoryProvider(
      create: (context) =>
          InternetAdminRepository(authRepository: AuthRepository())),
];
