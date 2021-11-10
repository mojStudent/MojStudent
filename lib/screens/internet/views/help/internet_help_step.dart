import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/models/help/internet_help_detail_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/services/home/home_state.dart';
import 'package:moj_student/services/internet/internet_help/internet_help_bloc.dart';

class InternetHelpDetailView extends StatefulWidget {
  final List<InternetHelpDetailModel> steps;
  const InternetHelpDetailView({Key? key, required this.steps})
      : super(key: key);

  @override
  _InternetHelpDetailViewState createState() => _InternetHelpDetailViewState();
}

class _InternetHelpDetailViewState extends State<InternetHelpDetailView> {
  late final List<InternetHelpDetailModel> steps;

  final controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    steps = widget.steps;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      appBar: AppBar(
        title: Text("Navodila"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.raisinBlack[500],
      ),
      body: Center(
        child: PageView(
          controller: controller,
          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            for (int i = 0; i < steps.length; i++)
              _buildStep(context, steps[i], i)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton.extended(
              backgroundColor: AppColors.raisinBlack[600],
              onPressed: () => controller.animateToPage(
                  controller.page!.toInt() - 1,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn),
              label: Row(
                children: [
                  Icon(Icons.navigate_before),
                  Text("Nazaj"),
                ],
              ),
            ),
            FloatingActionButton.extended(
              backgroundColor: AppColors.raisinBlack,
              onPressed: () => controller.animateToPage(
                  controller.page!.toInt() + 1,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn),
              label: Row(
                children: [
                  Text("Naprej"),
                  Icon(Icons.navigate_next),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStep(
      BuildContext context, InternetHelpDetailModel step, int index) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: BoxWidget(
          title: "Korak ${index + 1}/${steps.length}",
          cardBody: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                Uri.parse(
                  "https://student.sd-lj.si/api/help/data/${step.image}",
                ).toString(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Html(data: step.content ?? ''),
                ),
              )
            ],
          ),
        ),
      )
    ]);
  }
}
