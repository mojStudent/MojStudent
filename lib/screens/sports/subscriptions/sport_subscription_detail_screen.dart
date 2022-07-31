import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/sports/widgets/subscription_modal.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/buttons/row_button_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/blocs/sports/sport_bloc.dart';

class SportsSubscriptionDetailScreen extends StatelessWidget {
  const SportsSubscriptionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<SportBloc, SportState>(builder: (context, state) {
      if (state is SportSubscriptionDetailState) {
        return Column(
          children: [
            AppHeader(title: state.subscription.title),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  RowSliver(
                    child: Html(data: state.subscription.body),
                  ),
                  TextRowSliver(
                    title: "Cena",
                    icon: FlutterRemix.money_euro_box_line,
                    data: "${state.subscription.price} €",
                  ),
                  RowButtonSliver(
                    title: state.subscription.subscribed ? "Odjavi" : "Naroči",
                    style: state.subscription.subscribed
                        ? ElevatedButton.styleFrom(primary: ThemeColors.danger)
                        : null,
                    icon: state.subscription.subscribed
                        ? FlutterRemix.delete_bin_2_line
                        : FlutterRemix.shopping_cart_line,
                    onPressed: () => SubscriptionModal.showModal(
                        context, true, state.subscription),
                  )
                ],
              ),
            )
          ],
        );
      } else {
        Navigator.pop(context);
        return Text("Napaka");
      }
    }));
  }
}
