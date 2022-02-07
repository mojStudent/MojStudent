import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/sports/models/sport_subcribtion_model.dart';
import 'package:moj_student/screens/sports/widgets/subscription_modal.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/modal.dart';

class SportSubscriptionWidget extends StatelessWidget {
  final SportSubscriptionModel subscription;
  final Function? onTap;

  const SportSubscriptionWidget(
      {Key? key, required this.subscription, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowSliver(
      title: subscription.title,
      child: GestureDetector(
        onTap: onTap != null ? () => onTap!() : () {},
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FlutterRemix.bank_line,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Naročnina",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${subscription.price}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "€",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FlutterRemix.ticket_2_line,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Prodanih",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${subscription.sold}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FlutterRemix.close_circle_line,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Razprodano",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription.soldOut ? "da" : "ne",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            !subscription.subscribed
                ? TextButton(
                    onPressed: () => SubscriptionModal.showModal(context, true),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Naroči"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(FlutterRemix.shopping_cart_line),
                      ],
                    ),
                  )
                : TextButton(
                    onPressed: () => SubscriptionModal.showModal(context, true),
                    style: TextButton.styleFrom(
                      primary: ThemeColors.danger,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Odjavi"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(FlutterRemix.delete_bin_2_line),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
