import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/sports/models/sport_subcribtion_model.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/services/blocs/sports/sport_bloc.dart';

class SubscriptionModal {
  static void showModal(
      BuildContext context, bool cancel, SportSubscriptionModel subscription) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    BottomModal.showCustomModal(context,
        body: Padding(
          padding: EdgeInsets.only(
              top: h * 0.05, bottom: h * 0.03, left: w * 0.04, right: w * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FlutterRemix.question_mark,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Text(
                    cancel
                        ? "Tega dejanja ne morete preklicati.\nŽelite nadaljevati?"
                        : "Ste prepričani, da se želite prijaviti?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Text(
                    cancel
                        ? ""
                        : "Izvedela se bo samodejna bremenitev v višini 15 EUR\nSamodejna obnova vsakega 1. v mesecu.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              cancel ? ThemeColors.danger : ThemeColors.primary,
                        ),
                        onPressed: () =>
                            onActionConfirmed(context, subscription, cancel),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: h * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                cancel
                                    ? FlutterRemix.delete_bin_2_line
                                    : FlutterRemix.shopping_cart_line,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                cancel
                                    ? "Nadaljuj in odjavi"
                                    : "Potrdi naročilo",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: h * 0.01),
                            child: Text(
                              "Prekliči",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  static void onActionConfirmed(
      BuildContext context, SportSubscriptionModel subscription, bool cancel) {
    if (cancel) {
      context
          .read<SportBloc>()
          .add(SportCancelSubscriptionEvent(subscription.id));
    } else {
      context
          .read<SportBloc>()
          .add(SportSubscribeSubscriptionEvent(subscription.id));
    }

    Navigator.pop(context);
  }
}
