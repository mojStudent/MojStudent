import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/sports/models/sport_subcribtion_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/services/blocs/sports/sport_bloc.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Šport"),
          backgroundColor: AppColors.raisinBlack[500],
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: AppColors.green,
        body: BlocBuilder<SportBloc, SportState>(
          builder: (ctx, state) {
            if (state is SportInitial) {
              context.read<SportBloc>().add(SportLoadSubscriptionsEvent());
              return Container();
            } else if (state is SportLoadingState) {
              return LoadingScreen();
            } else if (state is SportSubscriptionstLoadedState) {
              return _availableSubscriptions(context, state.subscriptions);
            } else {
              return Container();
            }
          },
        ));
  }

  Widget _availableSubscriptions(
    BuildContext context,
    List<SportSubscriptionModel> subscriptions,
  ) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<SportBloc>().add(SportLoadSubscriptionsEvent()),
      child: CustomScrollView(
        slivers: [
          for (var subscription in subscriptions)
            SliverToBoxAdapter(
              child: BoxWidget(
                title: subscription.title,
                cardBody: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowBoxWidget(
                      description: "aktivna naročnina",
                      data: subscription.subscribed ? "da" : "ne",
                    ),
                    RowBoxWidget(
                      description: "cena",
                      data: "${subscription.price} €",
                    ),
                    RowBoxWidget(
                      description: "prodanih naročnin",
                      data: "${subscription.sold}",
                    ),
                    RowBoxWidget(
                      description: "zadnja sprememba",
                      data: subscription.updated,
                    ),
                    ElevatedButton(
                        onPressed: () => null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(subscription.subscribed
                                ? Icons.cancel_outlined
                                : Icons.credit_card),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.025,
                            ),
                            Text(subscription.subscribed ? "Odjavi" : "Naroči")
                          ],
                        ))
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
