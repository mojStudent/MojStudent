import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/damage-record/damage_record_repo.dart';
import 'package:moj_student/data/failure_records/failures_repo.dart';
import 'package:moj_student/data/internet/admin/iadmin_repo.dart';
import 'package:moj_student/data/internet/internet_help_repo.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/notifications/notification_repo.dart';
import 'package:moj_student/data/sports/sports_repo.dart';
import 'package:moj_student/screens/about_app/about_app_screen.dart';
import 'package:moj_student/screens/damages/damages_screen.dart';
import 'package:moj_student/screens/failures/failure_add_screen.dart';
import 'package:moj_student/screens/failures/failures_screen.dart';
import 'package:moj_student/screens/home/home_screen.dart';
import 'package:moj_student/screens/initial_loading/initial_loading.dart';
import 'package:moj_student/screens/internet/internet_screen.dart';
import 'package:moj_student/screens/internet_admin/iadmin_errors_screen.dart';
import 'package:moj_student/screens/internet_admin/iadmin_nas_screen.dart';
import 'package:moj_student/screens/internet_admin/iadmin_userdet_screen.dart';
import 'package:moj_student/screens/internet_admin/iadmin_users_screen.dart';
import 'package:moj_student/screens/login/login_screen.dart';
import 'package:moj_student/screens/notifications/notification_screen.dart';
import 'package:moj_student/screens/notifications/views/notification_detail_view.dart';
import 'package:moj_student/screens/profile/profile_details.dart/profile_details_screen.dart';
import 'package:moj_student/screens/profile/profile_screen.dart';
import 'package:moj_student/screens/restaurant/restaurant_menu_screen.dart';
import 'package:moj_student/screens/restaurant/restaurant_screen.dart';
import 'package:moj_student/screens/sports/subscriptions/sport_subscriptions_screen.dart';
import 'package:moj_student/screens/sports/subscriptions/sport_subscription_detail_screen.dart';
import 'package:moj_student/screens/sports/sports_screen.dart';
import 'package:moj_student/services/blocs/damage-record/damage_record_bloc.dart';
import 'package:moj_student/services/blocs/failure_record/bloc/failure_record_bloc.dart';
import 'package:moj_student/services/blocs/home/home_bloc.dart';
import 'package:moj_student/services/blocs/home/home_view_panel_bloc/home_view_bloc.dart';
import 'package:moj_student/services/blocs/login/login_bloc.dart';
import 'package:moj_student/services/blocs/notification/notification_bloc.dart';
import 'package:moj_student/services/blocs/profile/profile_bloc.dart';
import 'package:moj_student/services/blocs/sports/sport_bloc.dart';
import 'package:moj_student/services/internet/admin/nas/iadmin_nas_bloc.dart';
import 'package:moj_student/services/internet/admin/users/iadmin_users_bloc.dart';
import 'package:moj_student/services/internet/internet_help/internet_help_bloc.dart';
import 'package:moj_student/services/internet/internet_traffic/internet_traffic_bloc.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
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
        RepositoryProvider(
            create: (context) =>
                InternetHelpRepo(authRepository: AuthRepository())),
        RepositoryProvider(
            create: (context) =>
                SportsRepository(authRepository: AuthRepository())),
        RepositoryProvider(
            create: (context) =>
                InternetAdminRepository(authRepository: AuthRepository())),
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
          BlocProvider(
              create: (context) =>
                  InternetHelpBloc(context.read<InternetHelpRepo>())),
          BlocProvider(
              create: (context) => SportBloc(context.read<SportsRepository>())),
          BlocProvider(
              create: (context) =>
                  ProfileBloc(authRepo: context.read<AuthRepository>())),
          BlocProvider(
              create: (context) =>
                  InternetTrafficBloc(context.read<InternetRepository>())),
          BlocProvider(create: (context) => HomeViewBloc()),
          BlocProvider(
              create: (context) => InternetAdminNasBloc(
                  context.read<InternetAdminRepository>())),
          BlocProvider(
              create: (context) => InternetAdminUsersBloc(
                  context.read<InternetAdminRepository>())),
        ],
        child: MaterialApp(
          title: 'MojŠtudent',
          theme: ThemeData(
              primarySwatch: ThemeColors.primary,
              primaryColor: ThemeColors.primary,
              backgroundColor: ThemeColors.background,
              scaffoldBackgroundColor: ThemeColors.background,
              appBarTheme: AppBarTheme(
                  titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ))),
          routes: {
            '/home': (context) => HomeScreen(),
            '/internet': (context) => InternetScreen(),
            '/notifications': (context) => NotificationScreen(),
            '/notification': (context) => NotificationDetailView(),
            '/failures': (context) => FailuresScreen(),
            '/failures/new': (context) => FailureAddScreen(),
            '/damages': (context) => DamagesScreen(),
            '/profile': (context) => ProfileDetailsScreen(),
            '/profile-settings': (context) => ProfileScreen(),
            '/login': (context) => LoginScreen(),
            '/about': (context) => AboutAppScreen(),
            '/sports': (context) => SportsScreen(),
            '/sports/subscriptions': (context) => SportsSubscriptionsScreen(),
            '/sports/subscription-details': (context) =>
                SportsSubscriptionDetailScreen(),
            '/internet/admin/users': (context) => InternetAdminUsersScreen(),
            '/internet/admin/users/details': (context) =>
                InternetAdminUserDetailScreen(),
            '/internet/admin/errors': (context) => InternetAdminErrorScreen(),
            '/internet/admin/nas': (context) => InternetAdminNasScreen(),
            '/restaurant': (context) => RestaurantScreen(),
          },
          home: InitialLoading(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
