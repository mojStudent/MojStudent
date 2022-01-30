
import 'package:charts_flutter/flutter.dart' as charts;
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/models/internet_traffic_model.dart';

class InternetTrafficChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> chartData;
  final bool animate;

  static const int gigabyte = 1000000000;

  const InternetTrafficChart(
      {Key? key, required this.chartData, required this.animate})
      : super(key: key);

  factory InternetTrafficChart.createChart(InternetTrafficModel data) {
    return InternetTrafficChart(
      chartData: _generateData(data),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      chartData,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      vertical: false,
    );
  }

  static List<charts.Series<_TrafficDataChart, String>> _generateData(
      InternetTrafficModel data) {
    var dates = data.days.data.labels;
    var upTraffic = data.days.data.datasets[0].data;
    var downTraffic = data.days.data.datasets[1].data;

    List<_TrafficDataChart> upTrafficChartData = [];
    List<_TrafficDataChart> downTrafficChartData = [];
    for (int i = 0; i < dates.length; i++) {
      upTrafficChartData.add(
          _TrafficDataChart(name: dates[i], value: upTraffic[i] / gigabyte));
      downTrafficChartData.add(
          _TrafficDataChart(name: dates[i], value: downTraffic[i] / gigabyte));
    }

    return [
      charts.Series<_TrafficDataChart, String>(
        id: 'up',
        domainFn: (_TrafficDataChart data, _) => data.name,
        measureFn: (_TrafficDataChart data, _) => data.value,
        data: upTrafficChartData,
        fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
      ),
      charts.Series<_TrafficDataChart, String>(
        id: 'down',
        domainFn: (_TrafficDataChart data, _) => data.name,
        measureFn: (_TrafficDataChart data, _) => data.value,
        data: downTrafficChartData,
        fillColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(ThemeColors.primary),
      )
    ];
  }
}

class _TrafficDataChart {
  final String name;
  final double value;

  _TrafficDataChart({required this.name, required this.value});
}
