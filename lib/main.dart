import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/damage-record/damage_record_repo.dart';
import 'package:moj_student/data/failure_records/failures_repo.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/notifications/notification_repo.dart';
import 'package:moj_student/screens/damages/damages_screen.dart';
import 'package:moj_student/screens/failures/failure_add_screen.dart';
import 'package:moj_student/screens/failures/failures_screen.dart';
import 'package:moj_student/screens/home/home_screen.dart';
import 'package:moj_student/screens/initial_loading/initial_loading.dart';
import 'package:moj_student/screens/internet/internet_screen.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/login/login_screen.dart';
import 'package:moj_student/screens/notifications/notification_screen.dart';
import 'package:moj_student/screens/notifications/views/notification_detail_view.dart';
import 'package:moj_student/screens/profile/profile_screen.dart';
import 'package:moj_student/services/damage-record/damage_record_bloc.dart';
import 'package:moj_student/services/failure_record/bloc/failure_record_bloc.dart';
import 'package:moj_student/services/home/home_bloc.dart';
import 'package:moj_student/services/login/login_bloc.dart';
import 'package:moj_student/services/notification/notification_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => NotificationRepo()),
        RepositoryProvider(create: (context) => DamageRecordRepo()),
        RepositoryProvider(create: (context) => FailureRecordRepo()),
        RepositoryProvider(
            create: (context) =>
                InternetRepository(authRepository: AuthRepository())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  LoginBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider(
              create: (context) =>
                  HomeBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider(
              create: (context) => NotificationBloc(
                  notificationRepo: context.read<NotificationRepo>())),
          BlocProvider(
              create: (context) =>
                  DamageRecordBloc(repo: context.read<DamageRecordRepo>())),
          BlocProvider(
              create: (context) =>
                  FailureRecordBloc(repo: context.read<FailureRecordRepo>())),
        ],
        child: MaterialApp(
          title: 'Moj študent',
          theme: ThemeData(
            primarySwatch: AppColors.blue,
          ),
          routes: {
            '/home': (context) => HomeScreen(),
            '/internet': (context) => InternetScreen(),
            '/notifications': (context) => NotificationScreen(),
            '/notification': (context) => NotificationDetailView(),
            '/failures': (context) => FailuresScreen(),
            '/failures/new': (context) => FailureAddScreen(),
            '/damages': (context) => DamagesScreen(),
            '/profile': (context) => ProfileScreen(),
            '/login': (context) => LoginScreen(),
          },
          home: InitialLoading(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
