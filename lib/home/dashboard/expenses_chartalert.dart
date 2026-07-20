import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';


class ExpensesChart_Alert extends StatefulWidget {
  const ExpensesChart_Alert({Key? key, required this.list, required this.value}) : super(key: key);
  final list;
  final String value;

  @override
  State<ExpensesChart_Alert> createState() => _ExpensesChart_AlertState();
}

class _ExpensesChart_AlertState extends State<ExpensesChart_Alert> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(
          'Material',
          widget.list.materialExpenseAmount.toDouble(),
          Colors.pinkAccent),
      ChartData(
          'SubCont Labour',
          widget.list.nmrLabourExpenseAmount.toDouble(),
          Colors.blueAccent),
      ChartData(
          'SubCont Bill',
          widget.list.subcontractorExpenseAmount.toDouble(),
          Colors.green),
      ChartData(
          'Site Material',
          widget.list.siteMaterialExpenseAmount.toDouble(),
          Colors.purpleAccent),
      ChartData(
          'Miscellaneous',
          widget.list.miscellaneousExpenseAmount.toDouble(),
          Colors.orange),
    ];

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.height * .63,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 7,),
              /// HEADER
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text(
                      "Expenses Overview",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.value == "P"
                          ? widget.list.project.toString()
                          : widget.list.siteName.toString(),
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),

              /// CHART
              SizedBox(
                height: 235,
                child: SfCircularChart(
                  legend: Legend(
                    isVisible: false,
                  ),
                  tooltipBehavior: _tooltipBehavior,
                  annotations: [
                    CircularChartAnnotation(
                      widget: SizedBox(
                        width: 90,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 5,),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                // "1234567890",
                                "₹${BaseUtitiles.amountFormat(widget.list.totalExpenseAmount)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      pointColorMapper: (ChartData data, _) => data.color,
                      innerRadius: '70%',
                    )
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(bottom: 15),
              //   child: Column(
              //     children: [
              //       const Text(
              //         "Total Expense",
              //         style: TextStyle(color: Colors.grey),
              //       ),
              //       Text(
              //         "${RequestConstant.CURRENCY_SYMBOL}${BaseUtitiles.amountFormat(widget.list.totalExpenseAmount)}",
              //         style: TextStyle(
              //           fontSize: 22,
              //           fontWeight: FontWeight.bold,
              //           color: Theme.of(context).primaryColor,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              const Divider(),

              expenseTile(
                Colors.pinkAccent,
                Icons.inventory,
                "Material",
                widget.list.materialExpenseAmount,
              ),

              expenseTile(
                Colors.blueAccent,
                Icons.groups,
                "SubCont Labour",
                widget.list.nmrLabourExpenseAmount,
              ),

              expenseTile(
                Colors.green,
                Icons.receipt_long,
                "SubCont Bill",
                widget.list.subcontractorExpenseAmount,
              ),

              expenseTile(
                Colors.purpleAccent,
                Icons.home_work,
                "Site Material",
                widget.list.siteMaterialExpenseAmount,
              ),

              expenseTile(
                Colors.orange,
                Icons.miscellaneous_services,
                "Miscellaneous",
                widget.list.miscellaneousExpenseAmount,
              ),

              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget expenseTile(
      Color color,
      IconData icon,
      String title,
      double amount,
      ) {
    return ListTile(
      dense: true,
      visualDensity:  VisualDensity(
        vertical: -2,
        horizontal: 0,
      ),
      horizontalTitleGap: 4,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: CircleAvatar(
        radius: 14,
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,fontSize: 15
        ),
      ),
      trailing: Text(
        "${RequestConstant.CURRENCY_SYMBOL}${BaseUtitiles.amountFormat(amount)}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}



class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String? x;
  final double? y;
  final Color? color;
}
