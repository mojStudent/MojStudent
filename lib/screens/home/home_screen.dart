import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/home/views/home_panel_view.dart';
import 'package:moj_student/screens/home/views/internet_panel_view.dart';
import 'package:moj_student/screens/home/views/profile_panel_view.dart';
import 'package:moj_student/services/blocs/home/home_view_panel_bloc/home_view_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeViewBloc, HomeViewState>(
      builder: (context, state) {
        return Scaffold(
            body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [_buildPanel(state), _bottomNavbar(h, w, state, context)],
        ));
      },
    );
  }

  Padding _bottomNavbar(
      double h, double w, HomeViewState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: h * 0.005, horizontal: w * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: ThemeColors.jet.withOpacity(0.25),
                blurRadius: 10,
                offset: Offset(5, 5))
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: state.panelIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FlutterRemix.home_3_line), label: "Bivanje"),
            BottomNavigationBarItem(
                icon: Icon(FlutterRemix.user_line), label: "Profil"),
            // if (AuthRepository.isNetAdmin())
              BottomNavigationBarItem(
                  icon: Icon(FlutterRemix.database_line), label: "Internet"),
          ],
          onTap: (index) =>
              context.read<HomeViewBloc>().add(HomeViewChangeViewEvent(index)),
        ),
      ),
    );
  }

  Widget _buildPanel(HomeViewState state) {
    if (state is HomeViewHomePanelState) {
      return HomePanelView();
    } else if (state is HomeViewProfilePanelState) {
      return ProfilePanelView();
    } else if (state is HomeViewInternetPanelState) {
      return InternetAdminPanelView();
    } else {
      return HomePanelView();
    }
  }
}
