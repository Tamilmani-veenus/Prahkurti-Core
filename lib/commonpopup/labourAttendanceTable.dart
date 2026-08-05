import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:prahkurticore/controller/labourDashboard_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/labourDashboard_model.dart';
import '../newhome/maindashboard/labourDashboard.dart';
import 'dart:math' as math;
import '../utilities/baseutitiles.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// class AttendanceListScreen extends StatefulWidget {
//   const AttendanceListScreen({super.key});
//
//   @override
//   State<AttendanceListScreen> createState() =>
//       _AttendanceListScreenState();
// }
//
// class _AttendanceListScreenState
//     extends State<AttendanceListScreen> {
//
//   LabourDashboardController labourDashboardController = Get.put(LabourDashboardController());
//
//   final TextEditingController searchController=
//   TextEditingController();
//
//   String filterValue = "All";
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//
//         backgroundColor: Color(0xffF5F7FB),
//
//         appBar: AppBar(
//           elevation: 0,
//           title: const Text("Subcontractor Attendance"),
//           backgroundColor: Theme.of(context).primaryColor,
//         ),
//
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//
//           child: Column(
//             children: [
//
//               Row(
//                 children: [
//
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                       children: [
//
//                         Text(
//                           "All Records",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold),
//                         ),
//
//                         SizedBox(height: 5),
//
//                         Text(
//                           "Attendance History",
//                           style: TextStyle(
//                               color: Colors.grey),
//                         ),
//
//                       ],
//                     ),
//                   ),
//
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 10),
//                     decoration: BoxDecoration(
//                       color:  Theme.of(context).primaryColor,
//                       borderRadius:
//                       BorderRadius.circular(10),
//                     ),
//                     child: Obx(() => Text(
//                       "Total ${labourDashboardController.todayAttendanceList.length}",
//                       style: const TextStyle(color: Colors.white),
//                     ))
//                   )
//
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//
//               Row(
//                 children: [
//
//                   Expanded(
//                     child: SizedBox(
//                       height: 42,
//                       child: TextField(
//                         controller: searchController,
//
//                         decoration: InputDecoration(
//                           isDense: true,
//                           hintText: "Search",
//                           prefixIcon:
//                           const Icon(Icons.search),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 10,
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(
//                               color: Colors.grey,
//                               width: 1,
//                             ),
//                           ),
//
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(
//                               color: Color(0xFF7C3AED), // Purple when focused
//                               width: 2,
//                             ),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                           onChanged: (value) {
//                             labourDashboardController.filterAttendance(value);
//                           }
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(width: 15),
//
//                   Obx(() =>
//                      SizedBox(
//                       width: 180,
//                       height: 42,
//                       child: DropdownButtonFormField<String>(
//                         value: filterValue,
//                         menuMaxHeight: 220,
//                         decoration: InputDecoration(
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 8,
//                           ),
//                           filled: true,
//                           isDense: true,
//                           fillColor: Colors.white,
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(
//                               color: Colors.grey,
//                               width: 1,
//                             ),
//                           ),
//
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(
//                               color: Color(0xFF7C3AED), // Purple when focused
//                               width: 2,
//                             ),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                             BorderRadius.circular(12),
//                           ),
//                         ),
//                         items: labourDashboardController.projectList
//                             .map(
//                               (project) => DropdownMenuItem<String>(
//                             value: project,
//                             child: SizedBox(
//                               width: 120,
//                               child: Text(project,maxLines: 1,style: TextStyle(fontSize: 12),
//                                   overflow: TextOverflow.ellipsis),
//                             ),
//                           ),
//                         )
//                             .toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             filterValue = value!;
//                           });
//                           labourDashboardController.filterByProject(filterValue);
//                         },
//
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius:
//                     BorderRadius.circular(15),
//                   ),
//
//                   child: Column(
//                     children: [
//                       /// Header
//                       Expanded(
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: SizedBox(
//                             width: 1010,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 /// Header
//                                 Table(
//                                   border: TableBorder.all(color: Colors.grey.shade300),
//                                   columnWidths: const {
//                                     0: FixedColumnWidth(135),
//                                     1: FixedColumnWidth(90),
//                                     2: FixedColumnWidth(180),
//                                     3: FixedColumnWidth(180),
//                                     4: FixedColumnWidth(150),
//                                     5: FixedColumnWidth(70),
//                                     6: FixedColumnWidth(90),
//                                     7: FixedColumnWidth(120),
//                                   },
//                                   children: [
//                                     TableRow(
//                                       decoration: BoxDecoration(
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                       children: const [
//                                         HeaderCell("Attendance\nNo"),
//                                         HeaderCell("Date"),
//                                         HeaderCell("Project"),
//                                         HeaderCell("Site"),
//                                         HeaderCell("Subcontractor"),
//                                         HeaderCell("Labour"),
//                                         HeaderCell("Amount"),
//                                         HeaderCell("Prepared By"),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//
//                                 Expanded(
//                                   child: Obx(() =>
//                                      ListView.builder(
//                                       itemCount: labourDashboardController.todayAttendanceList.length,
//                                       itemBuilder: (context, index) {
//
//                                         final item = labourDashboardController.todayAttendanceList[index];
//
//                                         return Table(
//                                           border: TableBorder.all(
//                                             color: Colors.grey.shade300,
//                                           ),
//                                           columnWidths: const {
//                                             0: FixedColumnWidth(135),
//                                             1: FixedColumnWidth(90),
//                                             2: FixedColumnWidth(180),
//                                             3: FixedColumnWidth(180),
//                                             4: FixedColumnWidth(150),
//                                             5: FixedColumnWidth(70),
//                                             6: FixedColumnWidth(90),
//                                             7: FixedColumnWidth(120),
//                                           },
//                                           children: [
//
//                                             TableRow(
//                                               decoration: BoxDecoration(
//                                                 color: index.isEven
//                                                     ? Colors.white
//                                                     : Colors.grey.shade50,
//                                               ),
//                                               children: [
//
//                                                 TableCellWidget(item.labourAttendanceNo ?? ""),
//
//                                                 TableCellWidget(item.labourAttendanceDate != null
//                                                     ? DateFormat('yyyy-MM-dd').format(
//                                                   DateTime.parse(item.labourAttendanceDate!),
//                                                 )
//                                                     : "",),
//
//                                                 TableCellWidget(item.projectName ?? ""),
//
//                                                 TableCellWidget(item.siteName ?? ""),
//
//                                                 TableCellWidget(item.subContractorName ?? ""),
//
//                                                 TableCellWidget(
//                                                   item.totNos?.toStringAsFixed(0) ?? "0",),
//
//                                                 TableCellWidget(
//                                                   "₹${item.totAmt?.toStringAsFixed(2) ?? "0.00"}",
//                                                   color: Colors.green,
//                                                   isBold: true,
//                                                 ),
//
//                                                 TableCellWidget(item.employeeName ?? ""),
//                                               ],
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//
//                     ],
//                   ),
//                 ),
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HeaderCell extends StatelessWidget {
//   final String text;
//
//   const HeaderCell(this.text, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(14),
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 13,
//           color: Colors.white
//         ),
//       ),
//     );
//   }
// }

// class TableCellWidget extends StatelessWidget {
//   final String text;
//   final Color? color;
//   final bool isBold;
//
//   const TableCellWidget(
//       this.text, {
//         super.key,
//         this.color,
//         this.isBold = false,
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Text(
//         text,
//         softWrap: true,
//         style: TextStyle(
//           color: color ?? Colors.black,
//           fontWeight:
//           isBold ? FontWeight.bold : FontWeight.normal,fontSize: 13
//         ),
//       ),
//     );
//   }
// }


class ProjectWiseLabourDialog extends StatefulWidget {
  const ProjectWiseLabourDialog({super.key});

  @override
  State<ProjectWiseLabourDialog> createState() => _ProjectWiseLabourDialogState();
}

class _ProjectWiseLabourDialogState extends State<ProjectWiseLabourDialog> {

  LabourDashboardController labourDashboardController = Get.put(LabourDashboardController());
  final TextEditingController searchController = TextEditingController();
  String filterValue = "All Status";

  final List<String> filterItems = [
    "All Status",
    "Under",
    "Over",
    "On Track",
  ];

  late TooltipBehavior _tooltipBehavior;

  late ZoomPanBehavior _zoomPanBehavior;

  final ScrollController _horizontalScrollController = ScrollController();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      labourDashboardController.filteredProjects.assignAll(
        labourDashboardController.projectWiseLabourList,
      );
    });


    _tooltipBehavior = TooltipBehavior(
      enable: true,
      builder: (dynamic data,
          dynamic point,
          dynamic series,
          int pointIndex,
          int seriesIndex) {

        final item = labourDashboardController.filteredProjects[pointIndex];

        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 6),

              if (seriesIndex == 0)
                Text(
                  "NMR Nos : ${item.nmrNos?.toStringAsFixed(0) ?? "0"}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),

              if (seriesIndex == 1)
                Text(
                  "Rate Nos : ${item.rateNos?.toStringAsFixed(0) ?? "0"}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
            ],
          ),
        );
      },
    );

    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,        // allows horizontal drag/scroll
      enablePinching: true,       // pinch to zoom (optional)
      zoomMode: ZoomMode.x,       // restrict zoom/pan to X-axis only
      enableMouseWheelZooming: true,
      enableDoubleTapZooming: false,
      enableSelectionZooming: false,// desktop/web mouse-wheel support
    );


  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        labourDashboardController.filteredProjects.assignAll(labourDashboardController.projectWiseLabourList);
        searchController.clear();
        filterValue = "All";

        return true;
      },
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 30,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .85,
          height: 430,
          child: Column(
            children: [

              /// Header
              Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [

                    // Container(
                    //   height: 36,
                    //   width: 36,
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue.shade50,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: Icon(
                    //     Icons.bar_chart_rounded,
                    //     color: Colors.blue.shade700,
                    //   ),
                    // ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Project Wise Labour Summary",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            "All Projects",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        labourDashboardController.filteredProjects.assignAll(labourDashboardController.projectWiseLabourList);
                        Navigator.pop(context);
                        },
                      icon: const Icon(Icons.close,size: 20,),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              /// Search & Filter
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: TextField(
                            controller: searchController,

                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Search",
                              prefixIcon:
                              const Icon(Icons.search),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:  BorderSide(
                                  color: Colors.grey, // Purple when focused
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              searchProjects(value);
                            }
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    SizedBox(
                      width: 140,
                      height: 36,
                      child: DropdownButtonFormField<String>(
                        value: filterValue,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey, // Purple when focused
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                        ),
                        items: filterItems
                            .map(
                              (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e,style: TextStyle(fontSize: 14),),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            filterProjects(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _legend(Color(0xFF2563eb), "NMR Work %"),
                    const SizedBox(width: 16),
                    _legend(Color(0xFFf97316), "Rate Work %"),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 5,
                    right: 5,
                    bottom: 10,
                  ),
                  child: Obx(() {
                    final axisValues = getYAxisValues(
                      labourDashboardController.filteredProjects,
                    );
                    print("Max Value: ${axisValues['maximum']}");
                    print("Interval : ${axisValues['interval']}");
                    return SizedBox(

                      width: math.max(
                        MediaQuery.of(context).size.width,
                        labourDashboardController.filteredProjects.length * 160.0,
                      ),
                      child:
                      SfCartesianChart(
                        enableAxisAnimation: true,
                        tooltipBehavior: _tooltipBehavior,
                        zoomPanBehavior: _zoomPanBehavior,
                        legend:  Legend(
                          isVisible: false,
                          position: LegendPosition.top,
                        ),
                        plotAreaBorderWidth: 0,
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          axisLine: const AxisLine(width: 0),
                          labelStyle: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,),
                          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                          labelPlacement: LabelPlacement.betweenTicks,

                          maximumLabelWidth: 90,
                          labelRotation: 0,
                          autoScrollingDelta:3,
                          autoScrollingMode: AutoScrollingMode.start,
                          interval: 1,
                        ),
                        primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: axisValues['maximum'],
                          interval: axisValues['interval'],
                          axisLine: const AxisLine(width: 0),
                          majorGridLines: MajorGridLines(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        series: <CartesianSeries>[

                          ColumnSeries<ProjectWiseLabour, String>(
                            // animationDuration: 2000,
                            width: 0.55,
                            spacing: 0.35,
                            name: "NMR Work %",
                            dataSource: labourDashboardController.filteredProjects,
                            xValueMapper: (ProjectWiseLabour e, _) =>
                                BaseUtitiles.formatProjectName(e.projectName?.trim() ?? ""),
                            yValueMapper: (ProjectWiseLabour e, _) => e.nmrNos ?? 0,
                            color: Color(0xFF2563eb),
                            // borderRadius:
                            // BorderRadius.circular(5),
                            dataLabelSettings:
                            const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                color: Color(0xFF2563EB), // Orange label color
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          ColumnSeries<ProjectWiseLabour, String>(
                            // animationDuration: 2000,
                            animationDelay: 0,
                            width: 0.55,
                            spacing: 0.35,
                            name: "Rate Work %",
                            dataSource: labourDashboardController.filteredProjects,
                            xValueMapper: (ProjectWiseLabour e, _) =>
                                BaseUtitiles.formatProjectName(e.projectName?.trim() ?? ""),
                            yValueMapper: (ProjectWiseLabour e, _) => e.rateNos ?? 0,
                            color: Color(0xFFf97316),
                            // borderRadius:
                            // BorderRadius.circular(5),
                            dataLabelSettings:
                            const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                color: Color(0xFFF97316), // Orange label color
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                    );
                  }

                  ),
                ),
              ),
              /// Chart
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.only(
              //       left: 5,
              //       right: 5,
              //       bottom: 10,
              //     ),
              //     child: Obx(() {
              //       final data = labourDashboardController.filteredProjects;
              //       final axisValues = getYAxisValues(data);
              //
              //       return Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //
              //           /// Fixed Y-Axis
              //           SizedBox(
              //             width: 5,
              //             height: 257,
              //             child: SfCartesianChart(
              //               plotAreaBorderWidth: 0,
              //               primaryXAxis: CategoryAxis(
              //                 isVisible: true, // <-- keep it "on" so it reserves space
              //                 labelStyle: const TextStyle(
              //                   fontSize: 10,
              //                   color: Colors.transparent, // invisible text, same height reserved
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //                 axisLine: const AxisLine(width: 0),
              //                 majorTickLines: const MajorTickLines(size: 0),
              //                 majorGridLines: const MajorGridLines(width: 0),
              //                 labelIntersectAction: AxisLabelIntersectAction.multipleRows, // match scrollable chart
              //                 maximumLabelWidth: 90, // match scrollable chart
              //               ),
              //               primaryYAxis: NumericAxis(
              //                 minimum: 0,
              //                 maximum: axisValues['maximum'],
              //                 interval: axisValues['interval'],
              //                 axisLine: const AxisLine(width: 0),
              //                 majorGridLines: const MajorGridLines(width: 0), // <-- turned off here
              //               ),
              //               series: const <CartesianSeries>[],
              //             ),
              //           ),
              //
              //           /// Scrollable Chart
              //           Expanded(
              //             child: Scrollbar(
              //               thumbVisibility: true,
              //               child: SingleChildScrollView(
              //                 scrollDirection: Axis.horizontal,
              //                 controller: _horizontalScrollController,
              //                 child: SizedBox(
              //                   width: math.max(
              //                     MediaQuery.of(context).size.width,
              //                     data.length * 120,
              //                   ),
              //                   child: SfCartesianChart(
              //                     enableAxisAnimation: true,
              //                     tooltipBehavior: _tooltipBehavior,
              //                     legend:  Legend(
              //                       isVisible: false,
              //                     ),
              //                     plotAreaBorderWidth: 0,
              //
              //                     primaryXAxis: CategoryAxis(
              //                       majorGridLines: const MajorGridLines(width: 0),
              //                       axisLine: const AxisLine(width: 0),
              //                       labelStyle: const TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                       labelIntersectAction:
              //                       AxisLabelIntersectAction.multipleRows,
              //                       maximumLabelWidth: 90,
              //                       interval: 1,
              //                     ),
              //
              //                     primaryYAxis: NumericAxis(
              //                       minimum: 0,
              //                       maximum: axisValues['maximum'],
              //                       interval: axisValues['interval'],
              //                       axisLine: const AxisLine(width: 0),
              //                       majorTickLines: const MajorTickLines(size: 0),
              //                       labelStyle: const TextStyle(color: Colors.transparent), // hide numbers, keep axis active
              //                       majorGridLines: MajorGridLines(
              //                         width: 1,
              //                         color: Colors.grey.shade300, // <-- horizontal gridlines now render
              //                       ),
              //                     ),
              //
              //                     series: <CartesianSeries>[
              //
              //                       ColumnSeries<ProjectWiseLabour, String>(
              //                         animationDuration: 2000,
              //                         width: 0.75,
              //                         spacing: 0.35,
              //                         dataSource: data,
              //                         xValueMapper: (e, _) => BaseUtitiles
              //                             .formatProjectName(e.projectName ?? ""),
              //                         yValueMapper: (e, _) => e.nmrNos ?? 0,
              //                         color: const Color(0xFF2563EB),
              //                         dataLabelSettings: const DataLabelSettings(
              //                           isVisible: true,
              //                         ),
              //                       ),
              //
              //                       ColumnSeries<ProjectWiseLabour, String>(
              //                         animationDuration: 2000,
              //                         width: 0.75,
              //                         spacing: 0.35,
              //                         dataSource: data,
              //                         xValueMapper: (e, _) => BaseUtitiles
              //                             .formatProjectName(e.projectName ?? ""),
              //                         yValueMapper: (e, _) => e.rateNos ?? 0,
              //                         color: const Color(0xFFF97316),
              //                         dataLabelSettings: const DataLabelSettings(
              //                           isVisible: true,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       );
              //     }),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Map<String, double> getYAxisValues(List<ProjectWiseLabour> list) {
    double maxValue = 0;

    for (final item in list) {
      maxValue = math.max(
        maxValue,
        math.max(item.nmrNos ?? 0, item.rateNos ?? 0),
      );
    }

    print("Chart Max Data: $maxValue");

    double maximum;
    double interval;

    if (maxValue <= 50) {
      maximum = 50;
      interval = 10;
    } else if (maxValue <= 100) {
      maximum = 100;
      interval = 20;
    } else if (maxValue <= 500) {
      maximum = 500;
      interval = 100;
    } else if (maxValue <= 1000) {
      maximum = 1000;
      interval = 200;
    } else if (maxValue <= 5000) {
      maximum = 5000;
      interval = 1000;
    } else if (maxValue <= 10000) {
      maximum = 10000;
      interval = 2000;
    } else {
      // Round up to next multiple of 5000
      maximum = (maxValue / 5000).ceil() * 5000;
      interval = maximum / 5;
    }

    return {
      'maximum': maximum,
      'interval': interval,
    };
  }

  /// ---------- Search based on projects ----------
  void searchProjects(String query) {
    final search = query.trim().toLowerCase();

    final sourceList = labourDashboardController.projectWiseLabourList;


      if (search.isEmpty) {
        filterProjects(filterValue); // Retain the selected dropdown filter
        return;
      }

      labourDashboardController.filteredProjects.assignAll(
        sourceList.where((item) {
          return (item.projectName ?? "")
              .trim()
              .toLowerCase()
              .contains(search);
        }).toList(),
      );

      // Apply the selected dropdown filter on the searched results
      switch (filterValue) {
        case "Under":
          labourDashboardController.filteredProjects.assignAll(
            labourDashboardController.filteredProjects.where(
                  (e) => (e.nmrNos ?? 0) > (e.rateNos ?? 0),
            ).toList(),
          );
          break;

        case "Over":
          labourDashboardController.filteredProjects.assignAll(
            labourDashboardController.filteredProjects.where(
                  (e) => (e.rateNos ?? 0) > (e.nmrNos ?? 0),
            ).toList(),
          );
          break;

        case "On Track":
          labourDashboardController.filteredProjects.assignAll(
            labourDashboardController.filteredProjects.where(
                  (e) => ((e.nmrNos ?? 0) - (e.rateNos ?? 0)).abs() < 0.01,
            ).toList(),
          );
          break;
      }

  }


  /// Dropdown Allstatus, under, Over ---------
  void filterProjects(String value) {
    final list = labourDashboardController.projectWiseLabourList;

    filterValue = value;

    switch (value) {
      case "All Status":
        labourDashboardController.filteredProjects.assignAll(list);
        break;

      case "Under":
        labourDashboardController.filteredProjects.assignAll(
          list.where(
                (e) => (e.nmrNos ?? 0) > (e.rateNos ?? 0),
          ),
        );
        break;

      case "Over":
        labourDashboardController.filteredProjects.assignAll(
          list.where(
                (e) => (e.rateNos ?? 0) > (e.nmrNos ?? 0),
          ),
        );
        break;

      case "On Track":
        labourDashboardController.filteredProjects.assignAll(
          list.where(
                (e) => ((e.nmrNos ?? 0) - (e.rateNos ?? 0)).abs() < 0.01,
          ),
        );
        break;
    }

  }


  Widget _legend(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class SubcontractortWiseLabourSummaryDialog extends StatefulWidget {
  const SubcontractortWiseLabourSummaryDialog({super.key});

  @override
  State<SubcontractortWiseLabourSummaryDialog> createState() => _SubcontractortWiseLabourSummaryDialogState();
}

class _SubcontractortWiseLabourSummaryDialogState extends State<SubcontractortWiseLabourSummaryDialog> {

  LabourDashboardController labourDashboardController = Get.put(LabourDashboardController());
  final TextEditingController searchController = TextEditingController();
  String filterValue = "All Status";

  final List<String> filterItems = [
    "All Status",
    "Under",
    "Over",
    "On Track",
  ];

  late TooltipBehavior _tooltipBehavior;

  late ZoomPanBehavior _zoomPanBehavior;

  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      labourDashboardController.subcontractorfilteredProjects.assignAll(
        labourDashboardController.subcontWiseLabourSummaryList,
      );
    });


    _tooltipBehavior = TooltipBehavior(
      enable: true,
      builder: (dynamic data,
          dynamic point,
          dynamic series,
          int pointIndex,
          int seriesIndex) {

        final item = labourDashboardController.subcontractorfilteredProjects[pointIndex];;

        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 6),

              if (seriesIndex == 0)
                Text(
                  "NMR Nos : ${item.nmrNos?.toStringAsFixed(0) ?? "0"}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),

              if (seriesIndex == 1)
                Text(
                  "Rate Nos : ${item.rateNos?.toStringAsFixed(0) ?? "0"}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
            ],
          ),
        );
      },
    );

    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,        // allows horizontal drag/scroll
      enablePinching: true,       // pinch to zoom (optional)
      zoomMode: ZoomMode.x,       // restrict zoom/pan to X-axis only
      enableMouseWheelZooming: true, // desktop/web mouse-wheel support
    );
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        labourDashboardController.subcontractorfilteredProjects.assignAll(labourDashboardController.subcontWiseLabourSummaryList);

        searchController.clear();
        filterValue = "All";

        return true;
      },
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 30,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .85,
          height: 430,
          child: Column(
            children: [

              /// Header
              Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [

                    // Container(
                    //   height: 36,
                    //   width: 36,
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue.shade50,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: Icon(
                    //     Icons.bar_chart_rounded,
                    //     color: Colors.blue.shade700,
                    //   ),
                    // ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Subcontractor Wise Labour Summary",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            "All Projects",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        labourDashboardController.subcontractorfilteredProjects.assignAll(labourDashboardController.subcontWiseLabourSummaryList);
                       Navigator.pop(context);
                       },
                      icon: const Icon(Icons.close,size: 20,),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              /// Search & Filter
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: TextField(
                            controller: searchController,

                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Search",
                              prefixIcon:
                              const Icon(Icons.search),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:  BorderSide(
                                  color: Colors.grey, // Purple when focused
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              searchProjects(value);
                            }
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    SizedBox(
                      width: 140,
                      height: 36,
                      child: DropdownButtonFormField<String>(
                        value: filterValue,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey, // Purple when focused
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                        ),
                        items: filterItems
                            .map(
                              (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e,style: TextStyle(fontSize: 14),),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            filterProjects(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _legend(Color(0xFF2563eb), "NMR Work %"),
                    const SizedBox(width: 16),
                    _legend(Color(0xFFf97316), "Rate Work %"),
                  ],
                ),
              ),

              /// Chart
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 5,
                    right: 5,
                    bottom: 10,
                  ),
                  child: Obx(() {
                    final axisValues = getYAxisValues(
                      labourDashboardController.subcontractorfilteredProjects,
                    );
                    return SizedBox(

                      width: math.max(
                        MediaQuery.of(context).size.width,
                        labourDashboardController.subcontractorfilteredProjects.length * 160.0,
                      ),
                      child:
                      SfCartesianChart(
                        enableAxisAnimation: true,
                        tooltipBehavior: _tooltipBehavior,
                        zoomPanBehavior: _zoomPanBehavior,
                        legend:  Legend(
                          isVisible: false,
                          position: LegendPosition.top,
                        ),
                        plotAreaBorderWidth: 0,
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          axisLine: const AxisLine(width: 0),
                          labelStyle: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,),
                          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                          labelPlacement: LabelPlacement.betweenTicks,

                          maximumLabelWidth: 90,
                          labelRotation: 0,
                          autoScrollingDelta:3,
                          autoScrollingMode: AutoScrollingMode.start,
                          interval: 1,
                        ),
                        primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: axisValues['maximum'],
                          interval: axisValues['interval'],
                          axisLine: const AxisLine(width: 0),
                          majorGridLines: MajorGridLines(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        series: <CartesianSeries>[

                          ColumnSeries<SubContractorWiseLabourTradeChart, String>(
                            // animationDuration: 2000,
                            width: 0.55,
                            spacing: 0.35,
                            name: "NMR Work %",
                            dataSource: labourDashboardController.subcontractorfilteredProjects,
                            xValueMapper: (SubContractorWiseLabourTradeChart e, _) =>
                                BaseUtitiles.formatProjectName(e.subcontractName?.trim() ?? ""),
                            yValueMapper: (SubContractorWiseLabourTradeChart e, _) => e.nmrNos ?? 0,
                            color: Color(0xFF2563eb),
                            // borderRadius:
                            // BorderRadius.circular(5),
                            dataLabelSettings:
                            const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                color: Color(0xFF2563EB), // Orange label color
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          ColumnSeries<SubContractorWiseLabourTradeChart, String>(
                            // animationDuration: 2000,
                            animationDelay: 0,
                            width: 0.55,
                            spacing: 0.35,
                            name: "Rate Work %",
                            dataSource: labourDashboardController.subcontractorfilteredProjects,
                            xValueMapper: (SubContractorWiseLabourTradeChart e, _) =>
                                BaseUtitiles.formatProjectName(e.subcontractName?.trim() ?? ""),
                            yValueMapper: (SubContractorWiseLabourTradeChart e, _) => e.rateNos ?? 0,
                            color: Color(0xFFf97316),
                            // borderRadius:
                            // BorderRadius.circular(5),
                            dataLabelSettings:
                            const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                color: Color(0xFFF97316), // Orange label color
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                    );
                  }

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, double> getYAxisValues(List<SubContractorWiseLabourTradeChart> list) {
    double maxValue = 0;

    for (final item in list) {
      maxValue = math.max(
        maxValue,
        math.max(item.nmrNos ?? 0, item.rateNos ?? 0),
      );
    }

    double maximum;
    double interval;

    if (maxValue <= 50) {
      maximum = 50;
      interval = 10;
    } else if (maxValue <= 100) {
      maximum = 100;
      interval = 20;
    }else if (maxValue <= 500) {
      maximum = 500;
      interval = 100;
    } else if (maxValue <= 1000) {
      maximum = 1000;
      interval = 200;
    } else if (maxValue <= 5000) {
      maximum = 5000;
      interval = 1000;
    } else if (maxValue <= 10000) {
      maximum = 10000;
      interval = 2000;
    } else {
      // Round up to next multiple of 5000
      maximum = (maxValue / 5000).ceil() * 5000;
      interval = maximum / 5;
    }

    return {
      'maximum': maximum,
      'interval': interval,
    };
  }

  /// ---------- Search based on projects ----------
  void searchProjects(String query) {
    final search = query.trim().toLowerCase();

    final sourceList = labourDashboardController.subcontractorfilteredProjects;


    if (search.isEmpty) {
      filterProjects(filterValue); // Retain the selected dropdown filter
      return;
    }

    labourDashboardController.subcontractorfilteredProjects.assignAll(
      sourceList.where((item) {
        return (item.subcontractName ?? "")
            .trim()
            .toLowerCase()
            .contains(search);
      }).toList(),
    );

    // Apply the selected dropdown filter on the searched results
    switch (filterValue) {
      case "Under":
        labourDashboardController.subcontractorfilteredProjects.assignAll(
          labourDashboardController.subcontractorfilteredProjects.where(
                (e) => (e.nmrPercent ?? 0) > (e.ratePercent ?? 0),
          ).toList(),
        );
        break;

      case "Over":
        labourDashboardController.subcontractorfilteredProjects.assignAll(
          labourDashboardController.subcontractorfilteredProjects.where(
                (e) => (e.ratePercent ?? 0) > (e.nmrPercent ?? 0),
          ).toList(),
        );
        break;

      case "On Track":
        labourDashboardController.subcontractorfilteredProjects.assignAll(
          labourDashboardController.subcontractorfilteredProjects.where(
                (e) => ((e.nmrPercent ?? 0) - (e.ratePercent ?? 0)).abs() < 0.01,
          ).toList(),
        );
        break;
    }

  }

  /// Dropdown Allstatus, under, Over ---------
  void filterProjects(String value) {
    final list = labourDashboardController.subcontWiseLabourSummaryList;

    filterValue = value;

    switch (value) {
      case "All Status":
        labourDashboardController.subcontractorfilteredProjects.assignAll(list);
        break;

      case "Under":
        labourDashboardController.subcontractorfilteredProjects.assignAll(
          list.where(
                (e) => (e.nmrNos ?? 0) > (e.rateNos ?? 0),
          ),
        );
        break;

      case "Over":
        labourDashboardController.subcontractorfilteredProjects.assignAll(
          list.where(
                (e) => (e.rateNos ?? 0) > (e.nmrNos ?? 0),
          ),
        );
        break;

      case "On Track":
        labourDashboardController.subcontractorfilteredProjects.assignAll(
          list.where(
                (e) => ((e.nmrNos ?? 0) - (e.rateNos ?? 0)).abs() < 0.01,
          ),
        );
        break;
    }
  }


  Widget _legend(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class SubcontractorPerformanceDialog extends StatelessWidget {
  final List<SubContractorWiseLabour> labourList;
  final int totalLabourStrength;

  const SubcontractorPerformanceDialog({
    Key? key,
    required this.labourList,
    required this.totalLabourStrength,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: SizedBox(
        width: 560,
        height: MediaQuery.of(context).size.height * .42,
        child: Column(
          children: [

            /// HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 5, 18, 8),
              child: Row(
                children: [

                  const Expanded(
                    child: Text(
                      "Subcontractor Performance",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(
              height: 1,
              color: Colors.grey.shade300,
            ),

            /// LIST
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.separated(
                  padding: const EdgeInsets.all(22),
                  itemCount: labourList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 18),
                  itemBuilder: (context, index) {
                    final item = labourList[index];

                    final count = item.labourCount ?? 0;

                    final double percent = totalLabourStrength == 0
                        ? 0.0
                        : (count / totalLabourStrength).clamp(0.0, 1.0);

                    final double percentageValue = totalLabourStrength == 0
                        ? 0.0
                        : (count / totalLabourStrength) * 100;

                    const colors = [
                      Colors.green,
                      Colors.blue,
                      Colors.orange,
                      Colors.purple,
                      Colors.red,
                      Colors.teal,
                      Colors.indigo,
                      Colors.amber,
                    ];

                    return Row(
                      children: [

                        SizedBox(
                          width: 90,
                          child: Text(
                            item.subcontractName ?? "",
                            maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: LinearPercentIndicator(
                            padding: EdgeInsets.zero,
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 16,
                            percent: percent,
                            barRadius: const Radius.circular(30),
                            backgroundColor: Colors.grey.shade200,
                            progressColor: colors[index % colors.length],
                          ),
                        ),

                        const SizedBox(width: 15),

                        SizedBox(
                          width: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                BaseUtitiles.formatNumber(count),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "${percentageValue.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPendingScreen extends StatefulWidget {
  final List<SubContractPaymentPending> paymentList;

  const PaymentPendingScreen({
    Key? key,
    required this.paymentList,
  }) : super(key: key);

  @override
  State<PaymentPendingScreen> createState() => _PaymentPendingScreenState();
}

class _PaymentPendingScreenState extends State<PaymentPendingScreen> {

  LabourDashboardController labourDashboardController = Get.put(LabourDashboardController());
  final TextEditingController searchController = TextEditingController();
  String filterValue = "All";
  List<String> projectList = ["All"];
  late List<SubContractPaymentPending> allPaymentList;
  List<SubContractPaymentPending> filteredPaymentList = [];

  @override
  void initState() {
    super.initState();

    allPaymentList = List.from(widget.paymentList);
    filteredPaymentList = List.from(widget.paymentList);

    projectList = [
      "All",
      ...allPaymentList
          .map((e) => e.projectName ?? "")
          .where((e) => e.isNotEmpty)
          .toSet()
          .toList(),
    ];

    print(projectList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payment Pending",style: TextStyle(color: Colors.black,fontSize: 18),),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ))
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Expanded(
                    child: SizedBox(
                      height: 42,
                      width: 150,
                      child: TextField(
                          controller: searchController,
                          cursorColor: Colors.black87,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Search",
                            hintStyle: TextStyle(fontSize: 14),
                            prefixIcon:
                            const Icon(Icons.search,color: Colors.grey,),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.grey, // Purple when focused
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {
                            filterPayment(value);
                          }
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),


                  SizedBox(
                    width: 180,
                    height: 42,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        alignment: Alignment.centerLeft,

                        hint: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "All",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        value: filterValue,

                        items: projectList
                            .map(
                              (project) => DropdownMenuItem<String>(
                            value: project,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                project,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        )
                            .toList(),

                        onChanged: (value) {
                          if (value != null) {
                            filterByProject(value);
                          }
                        },

                        buttonStyleData: ButtonStyleData(
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),

                        iconStyleData: const IconStyleData(
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 22,
                          iconEnabledColor: Colors.grey,
                        ),

                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 220,
                          offset: const Offset(0, 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),

                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20,),
            /// Header
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      "Subcontractor",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /// List
            Expanded(
              child: ListView.separated(
                itemCount: filteredPaymentList.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = filteredPaymentList[index];

                  return Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(   bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [

                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.subcontractName ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.projectName ?? "",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${'\u20B9'} ${(item.balAmt ?? 0).toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius:
                                BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.orange.shade200,
                                ),
                              ),
                              child: Text(
                                item.billType ?? "",
                                style: TextStyle(
                                  color: Colors.orange.shade700,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void filterPayment(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        filteredPaymentList = List.from(allPaymentList);
      });
      return;
    }

    query = query.toLowerCase();

    setState(() {
      filteredPaymentList = allPaymentList.where((item) {
        return (item.subcontractName ?? "")
            .toLowerCase()
            .contains(query) ||
            (item.projectName ?? "")
                .toLowerCase()
                .contains(query) ||
            (item.siteName ?? "")
                .toLowerCase()
                .contains(query) ||
            (item.billType ?? "")
                .toLowerCase()
                .contains(query) ||
            (item.balAmt?.toString() ?? "")
                .contains(query);
      }).toList();
    });
  }

  void filterByProject(String project) {
    setState(() {
      filterValue = project;

      if (project == "All") {
        filteredPaymentList = List.from(allPaymentList);
      } else {
        filteredPaymentList = allPaymentList
            .where((e) => e.projectName == project)
            .toList();
      }
    });
  }
}

class AttendanceViewAllScreen extends StatefulWidget {
  final List<TodayAttendance> attendanceList;

  const AttendanceViewAllScreen({
    Key? key,
    required this.attendanceList,
  }) : super(key: key);

  @override
  State<AttendanceViewAllScreen> createState() => _AttendanceViewAllScreenState();
}

class _AttendanceViewAllScreenState extends State<AttendanceViewAllScreen> {

  LabourDashboardController labourDashboardController = Get.put(LabourDashboardController());
  final TextEditingController searchController = TextEditingController();
  String filterValue = "All";

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        labourDashboardController.todayAttendanceList
            .assignAll(labourDashboardController.allTodayAttendanceList);

        searchController.clear();
        filterValue = "All";

        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Subcontractor Attendance",style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false, // Hide left back button
            actions: [
              TextButton(
                  onPressed: () {
                    labourDashboardController.todayAttendanceList.assignAll(labourDashboardController.allTodayAttendanceList);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ))
            ],
          ),
          body: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
      
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        width: 150,
                        child: TextField(
                            controller: searchController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Search",
                              hintStyle: TextStyle(fontSize: 14),
                              prefixIcon:
                              const Icon(Icons.search,color: Colors.grey,),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
      
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey, // Purple when focused
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              labourDashboardController.filterAttendance(value);
                            }
                        ),
                      ),
                    ),
      
                    const SizedBox(width: 15),

                    Obx(() =>
                        SizedBox(
                          width: 180,
                          height: 42,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              alignment: Alignment.centerLeft,

                              hint: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "All",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              items: labourDashboardController.projectList
                                  .map((project) => DropdownMenuItem<String>(
                                value: project,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    project,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ))
                                  .toList(),

                              value: filterValue,

                              onChanged: (value) {
                                setState(() {
                                  filterValue = value!;
                                });
                                labourDashboardController.filterByProject(filterValue);
                              },

                              buttonStyleData: ButtonStyleData(
                                height: 42,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),

                              iconStyleData: const IconStyleData(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 22,
                                iconEnabledColor: Colors.grey,
                              ),

                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 220,
                                offset: const Offset(0, 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),

                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ),
                          // DropdownButtonFormField<String>(
                          //
                          //   value: filterValue,
                          //   menuMaxHeight: 220,
                          //   decoration: InputDecoration(
                          //     contentPadding: const EdgeInsets.symmetric(
                          //       horizontal: 12,
                          //       vertical: 8,
                          //     ),
                          //     filled: true,
                          //     isDense: true,
                          //     fillColor: Colors.white,
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(12),
                          //       borderSide: const BorderSide(
                          //         color: Colors.grey,
                          //         width: 1,
                          //       ),
                          //     ),
                          //
                          //     focusedBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(12),
                          //       borderSide: const BorderSide(
                          //         color: Color(0xFF7C3AED), // Purple when focused
                          //         width: 2,
                          //       ),
                          //     ),
                          //     border: OutlineInputBorder(
                          //       borderRadius:
                          //       BorderRadius.circular(12),
                          //     ),
                          //   ),
                          //   items: labourDashboardController.projectList
                          //       .map(
                          //         (project) => DropdownMenuItem<String>(
                          //       value: project,
                          //       child: SizedBox(
                          //         width: 120,
                          //         child: Text(project,maxLines: 1,style: TextStyle(fontSize: 12),
                          //             overflow: TextOverflow.ellipsis),
                          //       ),
                          //     ),
                          //   )
                          //       .toList(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       filterValue = value!;
                          //     });
                          //     labourDashboardController.filterByProject(filterValue);
                          //   },
                          //
                          // ),
                        ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(()=>
                   ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: labourDashboardController.todayAttendanceList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = labourDashboardController.todayAttendanceList[index];
      
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.12),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
      
                            /// Row 1
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    item.labourAttendanceNo ?? "",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item.labourAttendanceDate != null
                                        ? DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(item.labourAttendanceDate!))
                                        : "",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    item.subContractorName ?? "",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff1E3A8A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
      
                            const Divider(height: 15),
      
                            /// Row 2
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.projectName ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.groups,
                                          size: 18, color: Colors.green),
                                      const SizedBox(width: 4),
                                      Text(
                                        (item.totNos ?? 0).toStringAsFixed(0),
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
      
                            const SizedBox(height: 5),
      
                            /// Row 3
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.siteName ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                Text(
                                  "${'\u20B9'} ${(item.totAmt ?? 0).toStringAsFixed(0)}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


