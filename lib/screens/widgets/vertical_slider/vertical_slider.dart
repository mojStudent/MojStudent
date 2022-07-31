import 'package:flutter/material.dart';
import 'package:moj_student/screens/widgets/vertical_slider/vertical_slider_card.dart';

class VerticalSlider extends StatelessWidget {
  final double? height;
  final List<VerticalSLiderCard> cards;

  const VerticalSlider({Key? key, required this.cards, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    List<Widget> children = [
      SizedBox(
        width: w * 0.05,
      ),
    ];

    children.addAll(cards);

    return SliverPadding(
      padding: EdgeInsets.only(top: h * 0.01),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: height ?? h * 0.16),
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
