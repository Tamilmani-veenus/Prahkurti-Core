import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';


class ExpensesChart_Alert extends StatefulWidget {
  const ExpensesChart_Alert({Key? key, required this.list}) : super(key: key);
  final list;

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
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Material Exp', widget.list.mtrExpAmt, Colors.pinkAccent),
     ChartData('CompanyLab Exp', widget.list.nLbrExpAmt.toDouble(), Colors.orangeAccent),
      ChartData('SubContLab Exp', widget.list.gLbrExpAmt, Colors.blueAccent),
      ChartData('SubContBill Exp', widget.list.sbCnExpAmt, Colors.greenAccent),
      ChartData('Site Material Exp', widget.list.siteMatrExpAmt, Colors.purpleAccent),
      ChartData('Miscell Exp', widget.list.miscExpAmt, Colors.lightGreen),

    ];
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: BaseUtitiles.getWidthtofPercentage(context,200),
          child: Card(
            color: Color.fromRGBO(240, 240, 240, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text("Expenses OverView",style: TextStyle(fontWeight: FontWeight.bold)))),
                SfCircularChart(
                  title: ChartTitle(text: widget.list.project.toString(),textStyle: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                       // enableTooltip: true,
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        pointColorMapper:(ChartData data,  _) => data.color,
                       // dataLabelSettings: DataLabelSettings(isVisible: true)
                    ),
                  ],
                ),


                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: BaseUtitiles.getheightofPercentage(context,2),
                      width: BaseUtitiles.getWidthtofPercentage(context, 4),
                      color: Colors.pinkAccent,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text( "Material                  "+ RequestConstant.CURRENCY_SYMBOL+ BaseUtitiles.amountFormat(widget.list.mtrExpAmt),style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 15),
                      height: BaseUtitiles.getheightofPercentage(context,2),
                      width: BaseUtitiles.getWidthtofPercentage(context, 4),
                      color: Colors.orangeAccent,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 10,top: 10),
                      child: Text("CompanyLab         " + RequestConstant.CURRENCY_SYMBOL+widget.list.nLbrExpAmt.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 15),
                      height: BaseUtitiles.getheightofPercentage(context,2),
                      width: BaseUtitiles.getWidthtofPercentage(context, 4),
                      color: Colors.blueAccent,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 10,top: 10),
                      child: Text("SubContLab           "+RequestConstant.CURRENCY_SYMBOL+ BaseUtitiles.amountFormat(widget.list.gLbrExpAmt),style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 15),
                      height: BaseUtitiles.getheightofPercentage(context,2),
                      width: BaseUtitiles.getWidthtofPercentage(context, 4),
                      color: Colors.greenAccent,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 10,top: 10),
                      child: Text("SubContBill            " + RequestConstant.CURRENCY_SYMBOL+ BaseUtitiles.amountFormat(widget.list.sbCnExpAmt),style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                      height: BaseUtitiles.getheightofPercentage(context,2),
                      width: BaseUtitiles.getWidthtofPercentage(context, 4),
                      color: Colors.purpleAccent,
                    ),


                    Container(
                      margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                      child: Text("Site Material          "+RequestConstant.CURRENCY_SYMBOL+ BaseUtitiles.amountFormat(widget.list.siteMatrExpAmt), style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 5,bottom: 10),
                      height: BaseUtitiles.getheightofPercentage(context,2),
                      width: BaseUtitiles.getWidthtofPercentage(context, 4),
                      color: Colors.lightGreen,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 10,top: 5,bottom: 10),
                      child: Text("Miscell                    "  + RequestConstant.CURRENCY_SYMBOL+ BaseUtitiles.amountFormat(widget.list.miscExpAmt),style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
