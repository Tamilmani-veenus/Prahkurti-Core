import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class AttendanceChart extends StatefulWidget {
  final List<ChartData> chartData;
  final int totalCount;

  const AttendanceChart({
    Key? key,
    required this.chartData,
    required this.totalCount,
  }) : super(key: key);

  @override
  State<AttendanceChart> createState() => _AttendanceChartState();
}

class _AttendanceChartState extends State<AttendanceChart> {
  late SelectionBehavior _selectionBehavior;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();

    _selectionBehavior = SelectionBehavior(
      enable: true,
      selectedBorderWidth: 3,
      selectedBorderColor: Colors.black,
      toggleSelection: true,
      unselectedOpacity: 0.5,
    );
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      margin: EdgeInsets.zero,

      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${widget.totalCount}",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Total",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataSource: widget.chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color,
          // selectionBehavior: _selectionBehavior,

          radius: "95%",
          innerRadius: "70%",

          strokeWidth: 2,
          strokeColor: Colors.white,

          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
          ),
        ),
      ],
    );
  }
}


class ChartData {
  final String x;
  final double y;
  final Color color;


  ChartData(
      this.x,
      this.y,
      this.color,
      );
}


class LabourCategoryChartData {
  final String category;
  final double value;
  final Color color;
  final IconData? icon;

  LabourCategoryChartData({
    required this.category,
    required this.value,
    required this.color,
    this.icon,
  });
}



