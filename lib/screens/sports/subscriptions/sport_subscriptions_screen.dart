import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/helpers/base64_converter.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/sports/widgets/sport_subscription_widget.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/blocs/sports/sport_bloc.dart';

class SportsSubscriptionsScreen extends StatelessWidget {
  const SportsSubscriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(
      children: [
        AppHeader(title: "Fitnes naročnine"),
        Expanded(child: BlocBuilder<SportBloc, SportState>(
          builder: (context, state) {
            if (state is SportInitial) {
              context.read<SportBloc>().add(SportLoadEvent());
              return LoadingScreen(
                withScaffold: false,
              );
            } else if (state is SportLoadingState) {
              return LoadingScreen(
                withScaffold: false,
              );
            } else if (state is SportLoadedState) {
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  for (var subscription in state.subscriptions)
                    SportSubscriptionWidget(
                      subscription: subscription,
                      onTap: () {
                        context.read<SportBloc>().add(
                            SportLoadSubscriptionDetailEvent(
                                state, subscription));
                        Navigator.of(context)
                            .pushNamed("/sports/subscription-details");
                      },
                    ),
                ],
              );
            } else if (state is SportErrorState) {
              return Text("Napaka");
            } else {
              return Text("Napaka, ne vem kaka");
            }
          },
        )),
      ],
    ));
  }
}
