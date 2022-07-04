import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/accordion/cubit/accordion_cubit.dart';

class Accordion extends StatelessWidget {
  final String title;
  final bool expanded;
  final Widget child;

  const Accordion({
    Key? key,
    required this.title,
    this.expanded = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AccordionCubit(
              expanded ? AccordionExpandedState() : AccordionHiddenState(),
            ),
        child: BlocBuilder<AccordionCubit, AccordionState>(
            builder: (context, state) {
          final w = MediaQuery.of(context).size.width;
          final h = MediaQuery.of(context).size.height;

          return Container(
            padding:
                EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.02),
            margin: EdgeInsets.symmetric(
                horizontal: w * 0.06, vertical: h * 0.0075),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => context.read<AccordionCubit>().toggleAccrdion(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: ThemeColors.jet),
                      ),
                      Icon(
                        state is AccordionHiddenState
                            ? FlutterRemix.arrow_drop_down_line
                            : FlutterRemix.arrow_drop_up_line,
                        color: ThemeColors.jet,
                        size: 32,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.02, top: h * 0.005),
                  child: state is AccordionExpandedState ? child : Container(),
                )
              ],
            ),
          );
        }));
  }
}
