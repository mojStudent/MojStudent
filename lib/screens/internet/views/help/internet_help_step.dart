import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/models/help/internet_help_detail_model.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

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
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          AppHeader(title: "Navodila"),
          Expanded(
            child: Center(
              child: PageView(
                controller: controller,
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  for (int i = 0; i < steps.length; i++)
                    _buildStep(context, steps[i], i)
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: "back",
              backgroundColor: ThemeColors.jet[600],
              elevation: 0,
              onPressed: () => controller.animateToPage(
                  controller.page!.toInt() - 1,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn),
              label: Row(
                children: [
                  Icon(Icons.navigate_before, color: Colors.white,),
                  Text("Nazaj", style: TextStyle(color: Colors.white,),),
                ],
              ),
            ),
            FloatingActionButton.extended(
              heroTag: "forward",
              backgroundColor: ThemeColors.jet,
              elevation: 0,
              onPressed: () => controller.animateToPage(
                  controller.page!.toInt() + 1,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn),
              label: Row(
                children: [
                  Text("Naprej", style: TextStyle(color: Colors.white,),),
                  Icon(Icons.navigate_next, color: Colors.white,),
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
        final h = MediaQuery.of(context).size.height;
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
      SliverPadding(
        padding: EdgeInsets.only(top: h * 0.04),
        sliver: RowSliver(
          title: "Korak ${index + 1}/${steps.length}",
          icon: FlutterRemix.information_line,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                Uri.parse(
                  "https://student.sd-lj.si/api/help/data/${step.image}",
                ).toString(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Html(data: step.content ?? ''),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
