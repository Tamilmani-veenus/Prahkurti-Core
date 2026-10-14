import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:prahkurticore/controller/labourDashboard_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../commonpopup/labourAttendanceTable.dart';
import '../../models/labourDashboard_model.dart';
import '../../utilities/baseutitiles.dart';
import 'dashboard.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  final bool isLabour;
  const HomeScreen({
    super.key,
    this.isLabour = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  LabourDashboardController labourDashboardController =
  Get.put(LabourDashboardController());
  late TooltipBehavior _tooltipBehavior;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime currentDate = DateTime.now();
    labourDashboardController.labourEntryFromDate.text =
        currentDate.toString().substring(0, 10);
    labourDashboardController.labourEntryToDate.text =
        currentDate.toString().substring(0, 10);

    _tooltipBehavior = TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        dynamic item;
        if (data is ProjectWiseLabour) {
          item = labourDashboardController.filteredProjects[pointIndex];
        } else {
          item = labourDashboardController
              .subcontractorfilteredProjects[pointIndex];
        }

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await labourDashboardController.getLabourDashboardDetails();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Dashboard_screen(),
          ),
        );
        return false;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            color:Theme.of(context).primaryColor,
            onRefresh: () async {
              await labourDashboardController.getLabourDashboardDetails();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Date -----------

                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: Row(
                      children: [
                        // ================= FROM DATE =================
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              final Frdate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2010),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Theme.of(context).primaryColor,
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (Frdate != null) {
                                labourDashboardController.labourEntryFromDate
                                    .text = Frdate.toString().substring(0, 10);

                                setState(() {});

                                _refreshIndicatorKey.currentState?.show();
                              }
                            },
                            child: Container(
                              height: 62,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xffDDE2E8),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor
                                          .withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    child: Icon(
                                      Icons.calendar_today_outlined,
                                      size: 18,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 9),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "FROM DATE",
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.6,
                                            color: Color(0xff8A919C),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          labourDashboardController
                                              .labourEntryFromDate
                                              .text
                                              .isEmpty
                                              ? "Select date"
                                              : labourDashboardController
                                              .labourEntryFromDate.text,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff20242A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 18,
                                    color: Color(0xff8A919C),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // ================= CENTER ARROW =================
                        Container(
                          width: 28,
                          height: 28,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),

                        // ================= TO DATE =================
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              final Todate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2010),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Theme.of(context).primaryColor,
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (Todate != null) {
                                labourDashboardController.labourEntryToDate
                                    .text = Todate.toString().substring(0, 10);

                                setState(() {});

                                _refreshIndicatorKey.currentState?.show();
                              }
                            },
                            child: Container(
                              height: 62,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xffDDE2E8),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor
                                          .withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    child: Icon(
                                      Icons.event_available_outlined,
                                      size: 18,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 9),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "TO DATE",
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.6,
                                            color: Color(0xff8A919C),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          labourDashboardController
                                              .labourEntryToDate
                                              .text
                                              .isEmpty
                                              ? "Select date"
                                              : labourDashboardController
                                              .labourEntryToDate.text,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff20242A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 18,
                                    color: Color(0xff8A919C),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Obx(() {
                    if (labourDashboardController.isLoading.value) {
                      return _buildDashboardShimmer();
                    }
                    else if (labourDashboardController.dashboardResponse.value==null) {
                      return const DashboardErrorWidget();
                    }
                    else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => GridView.builder(
                            padding: EdgeInsets.only(top: 8),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: labourCards.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 2,
                              mainAxisExtent: 105,
                              // childAspectRatio: 1.45,
                            ),
                            itemBuilder: (_, index) {
                              final item = labourCards[index];

                              return LabourCard(item: item, index: index);
                            },
                          )),

                          SizedBox(
                            height: 12,
                          ),

                          /// Labour category distribution---------

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xffEAECF0),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Category-wise Labour Attendance",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Obx(
                                      () => Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      /// Doughnut
                                      Expanded(
                                        flex: 4,
                                        child: SizedBox(
                                          height: 200,
                                          child: SfCircularChart(
                                            // tooltipBehavior: _tooltipBehavior,
                                            annotations: [
                                              CircularChartAnnotation(
                                                widget: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      BaseUtitiles.formatNumber(
                                                          labourDashboardController
                                                              .totalLabour.toInt()),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                    const Text(
                                                      "TOTAL LABOUR",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                            series: [
                                              DoughnutSeries<LabourCategoryWise,
                                                  String>(
                                                dataSource:
                                                labourDashboardController
                                                    .labourCategoryList,
                                                xValueMapper: (e, _) =>
                                                e.categoryName ?? "",
                                                yValueMapper: (e, _) =>
                                                e.totalNos ?? 0,
                                                pointColorMapper: (e, index) =>
                                                    labourDashboardController
                                                        .getCategoryColor(
                                                        index!),
                                                enableTooltip: true,
                                                innerRadius: "70%",
                                                radius: "130%",
                                                strokeWidth: 2,
                                                strokeColor: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 18),

                                      /// Legend
                                      Expanded(
                                        flex: 5,
                                        child: Obx(() {
                                          final visibleItems =
                                          labourDashboardController
                                              .showAll.value
                                              ? labourDashboardController
                                              .labourCategoryList
                                              : labourDashboardController
                                              .labourCategoryList
                                              .take(4)
                                              .toList();
                                          return AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: Column(
                                              children: [
                                                ...visibleItems
                                                    .asMap()
                                                    .entries
                                                    .map((entry) {
                                                  final index = entry.key;
                                                  final item = entry.value;
                                                  final color =
                                                  labourDashboardController
                                                      .getCategoryColor(
                                                      index);

                                                  final percent =
                                                  labourDashboardController
                                                      .totalLabour ==
                                                      0
                                                      ? 0
                                                      : ((item.totalNos ??
                                                      0) /
                                                      labourDashboardController
                                                          .totalLabour) *
                                                      100;
                                                  return Container(
                                                    margin:
                                                    const EdgeInsets.only(
                                                        bottom: 4),
                                                    padding:
                                                    const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor: color
                                                              .withOpacity(.15),
                                                          child: Icon(
                                                            labourDashboardController
                                                                .getCategoryIcon(
                                                                item.categoryName),
                                                            color: color,
                                                            size: 12,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 12),
                                                        Expanded(
                                                          child: Text(
                                                            item.categoryName ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              10,
                                                              vertical: 5),
                                                          decoration: BoxDecoration(
                                                              color: color
                                                                  .withOpacity(
                                                                  .15),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  25)),
                                                          child: Text(
                                                            "${item.totalNos?.toInt()} (${percent.toStringAsFixed(1)}%)",
                                                            style: TextStyle(
                                                              color: color,
                                                              fontSize: 8,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          );
                                        }),
                                      )
                                    ],
                                  ),
                                ),
                                Obx(() {
                                  if (labourDashboardController
                                      .labourCategoryList.length <=
                                      4) {
                                    return const SizedBox();
                                  }

                                  return InkWell(
                                    onTap: () {
                                      labourDashboardController.showAll
                                          .toggle();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            labourDashboardController
                                                .showAll.value
                                                ? "Show Less"
                                                : "Show More",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Icon(
                                            labourDashboardController
                                                .showAll.value
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),

                          /// ----------- OT ANALYSIS TODAY ------------

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xffEAECF0),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.15),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "Project Wise Labour Summary",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    /// Right Side
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  ProjectWiseLabourDialog(),
                                            );
                                          },
                                          child: Obx(
                                                () => Visibility(
                                              visible: labourDashboardController
                                                  .filteredProjects
                                                  .length > 3,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "View All",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 12,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _legend(
                                                Color(0xFF2563EB), "NMR Work%"),
                                            const SizedBox(width: 15),
                                            _legend(Color(0xFFF97316),
                                                "Rate Work%"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Obx(
                                      () {

                                    final projects =
                                        labourDashboardController.filteredProjects;

                                    if (projects.isEmpty) {
                                      return const SizedBox(
                                        height: 250,
                                        child: Center(
                                          child: Text(
                                            "No Record Found",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff667085),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    final axisValues = getYAxisValues(
                                      labourDashboardController
                                          .filteredProjects,
                                    );
                                    return SizedBox(
                                      height: 250,
                                      child: SfCartesianChart(
                                        tooltipBehavior: _tooltipBehavior,
                                        legend: Legend(isVisible: false),
                                        plotAreaBorderWidth: 0,
                                        primaryXAxis: CategoryAxis(
                                          visibleMinimum: 0,
                                          visibleMaximum: 2,
                                          majorGridLines: const MajorGridLines(width: 0),
                                          majorTickLines: const MajorTickLines(size: 0),
                                          axisLine: const AxisLine(width: 0),
                                          labelStyle: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          labelIntersectAction:
                                          AxisLabelIntersectAction.multipleRows,
                                        ),
                                        primaryYAxis: NumericAxis(
                                          minimum: 0,
                                          maximum: axisValues['maximum'],
                                          interval: axisValues['interval'],
                                          axisLine: const AxisLine(width: 0),
                                          majorGridLines: MajorGridLines(
                                            color: Colors.grey.shade300,
                                          ),
                                          labelStyle: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        series: <CartesianSeries>[
                                          ColumnSeries<ProjectWiseLabour,
                                              String>(
                                            width: 0.85,
                                            spacing: 0.10,
                                            dataSource:
                                            labourDashboardController
                                                .filteredProjects
                                                .take(3)
                                                .toList(),
                                            // Dashboard preview
                                            xValueMapper: (item, _) =>
                                                BaseUtitiles.formatProjectName(
                                                    item.projectName?.trim() ??
                                                        ""),
                                            yValueMapper: (item, _) =>
                                            item.nmrNos ?? 0,
                                            color: const Color(0xFF2563EB),
                                            dataLabelSettings:
                                            const DataLabelSettings(
                                              isVisible: true,
                                              textStyle: TextStyle(
                                                fontSize: 12,
                                                color: Color(
                                                    0xFF2563EB), // Orange label color
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          ColumnSeries<ProjectWiseLabour,
                                              String>(
                                            width: 0.85,
                                            spacing: 0.10,
                                            dataSource:
                                            labourDashboardController
                                                .filteredProjects
                                                .take(3)
                                                .toList(),
                                            xValueMapper: (item, _) =>
                                                BaseUtitiles.formatProjectName(
                                                    item.projectName?.trim() ??
                                                        ""),
                                            yValueMapper: (item, _) =>
                                            item.rateNos ?? 0,
                                            color: const Color(0xFFF97316),
                                            dataLabelSettings:
                                            const DataLabelSettings(
                                              isVisible: true,
                                              textStyle: TextStyle(
                                                fontSize: 12,
                                                color: Color(
                                                    0xFFF97316), // Orange label color
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 12),

                          /// ----------- Subcontractor wise labour summary ------------

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xffEAECF0),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.15),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "Subcontractor Wise Labour Summary",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    /// Right Side
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  SubcontractortWiseLabourSummaryDialog(),
                                            );
                                          },
                                          child: Visibility(
                                            visible: labourDashboardController
                                                .subcontractorfilteredProjects
                                                .length > 3,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "View All",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(width: 4),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 12,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _legend(
                                                Color(0xFF2563EB), "NMR Work%"),
                                            const SizedBox(width: 15),
                                            _legend(Color(0xFFF97316),
                                                "Rate Work%"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Obx(() {
                                  final projects =
                                      labourDashboardController.subcontractorfilteredProjects;

                                  if (projects.isEmpty) {
                                    return const SizedBox(
                                      height: 250,
                                      child: Center(
                                        child: Text(
                                          "No Record Found",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff667085),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final axisValues = getSubcontYAxisValues(
                                    labourDashboardController
                                        .subcontractorfilteredProjects,
                                  );
                                  return SizedBox(
                                    height: 250,
                                    child: SfCartesianChart(
                                      tooltipBehavior: _tooltipBehavior,
                                      legend: Legend(isVisible: false),
                                      plotAreaBorderWidth: 0,
                                      primaryXAxis: CategoryAxis(
                                        majorGridLines:
                                        const MajorGridLines(width: 0),
                                        axisLine: const AxisLine(width: 0),
                                        labelStyle: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        labelIntersectAction:
                                        AxisLabelIntersectAction
                                            .multipleRows,
                                        maximumLabelWidth: 90,
                                      ),
                                      primaryYAxis: NumericAxis(
                                        minimum: 0,
                                        maximum: axisValues['maximum'],
                                        interval: axisValues['interval'],
                                        axisLine: const AxisLine(width: 0),
                                        majorGridLines: MajorGridLines(
                                          color: Colors.grey.shade300,
                                        ),
                                        labelStyle: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      series: <CartesianSeries>[
                                        ColumnSeries<
                                            SubContractorWiseLabourTradeChart,
                                            String>(
                                          width: 0.85,
                                          spacing: 0.10,
                                          dataSource: labourDashboardController
                                              .subcontractorfilteredProjects
                                              .take(3)
                                              .toList(),
                                          // Dashboard preview
                                          xValueMapper: (item, _) =>
                                              BaseUtitiles.formatProjectName(
                                                  item.subcontractName
                                                      ?.trim() ??
                                                      ""),
                                          yValueMapper: (item, _) =>
                                          item.nmrNos ?? 0,
                                          color: const Color(0xFF2563EB),
                                          dataLabelSettings:
                                          const DataLabelSettings(
                                            isVisible: true,
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(
                                                  0xFF2563EB), // Orange label color
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ColumnSeries<
                                            SubContractorWiseLabourTradeChart,
                                            String>(
                                          width: 0.85,
                                          spacing: 0.10,
                                          dataSource: labourDashboardController
                                              .subcontractorfilteredProjects
                                              .take(3)
                                              .toList(),
                                          xValueMapper: (item, _) =>
                                              BaseUtitiles.formatProjectName(
                                                  item.subcontractName
                                                      ?.trim() ??
                                                      ""),
                                          yValueMapper: (item, _) =>
                                          item.rateNos ?? 0,
                                          color: const Color(0xFFF97316),
                                          dataLabelSettings:
                                          const DataLabelSettings(
                                            isVisible: true,
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(
                                                  0xFFF97316), // Orange label color
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),

                          SizedBox(height: 12),

                          /// ---------Pending Approvals Count

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xffEAECF0),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Pending Approvals",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Obx(() {
                                        final visibleItems =
                                            pendingApprovalList;
                                        return AnimatedSize(
                                          duration:
                                          const Duration(milliseconds: 300),
                                          child: Column(
                                            children: [
                                              ...visibleItems
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                final index = entry.key;
                                                final item = entry.value;
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 4),
                                                  padding:
                                                  const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor: item
                                                            .color
                                                            .withOpacity(.15),
                                                        child: Icon(
                                                          item.icon,
                                                          color: item.color,
                                                          size: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Expanded(
                                                        child: Text(
                                                          item.title,
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color: item.color
                                                                .withOpacity(
                                                                .15),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                25)),
                                                        child: Text(
                                                          "${item.count}",
                                                          style: TextStyle(
                                                            color: item.color,
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          // Container(
                          //   padding: const EdgeInsets.all(16),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(16),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey.withOpacity(.15),
                          //         blurRadius: 8,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //
                          //       /// Header
                          //       Row(
                          //         children: [
                          //           const Expanded(
                          //             child: Text(
                          //               "Subcontractor wise labour",
                          //               style: TextStyle(
                          //                 fontSize: 14,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //             ),
                          //           ),
                          //
                          //           InkWell(
                          //             onTap: () {
                          //               Get.dialog(
                          //                 SubcontractorPerformanceDialog(
                          //                   labourList: labourDashboardController.subContractorWiseLabour,
                          //                   totalLabourStrength:
                          //                   labourDashboardController.dashboardResponse.value?.totalLabourStrength ?? 0,
                          //                 ),
                          //               );
                          //             },
                          //             child: Obx(()=>
                          //                Visibility(
                          //                 visible: labourDashboardController.subContractorWiseLabour.isNotEmpty,
                          //                 child: Row(
                          //                   children: [
                          //                     Text(
                          //                       "View All",
                          //                       style: TextStyle(
                          //                         fontSize: 14,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     ),
                          //                     SizedBox(width: 4),
                          //                     Icon(Icons.arrow_forward_ios, size: 12),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       SizedBox(height: 10,),
                          //       Text("Based on work completion",style: TextStyle(fontSize: 13,color: Colors.grey),),
                          //
                          //       const SizedBox(height: 20),
                          //
                          //       /// Horizontal Table
                          //       Obx(() {
                          //
                          //         if (labourDashboardController.subContractorWiseLabour.isEmpty) {
                          //           return const Center(
                          //             child: Text("No Data"),
                          //           );
                          //         }
                          //
                          //         final list = labourDashboardController.subContractorWiseLabour;
                          //
                          //         final displayList = list.take(5).toList();
                          //
                          //         final totalLabourStrength =
                          //             labourDashboardController.dashboardResponse.value?.totalLabourStrength ?? 0;
                          //
                          //         const colors = [
                          //           Colors.green,
                          //           Colors.blue,
                          //           Colors.orange,
                          //           Colors.purple,
                          //         ];
                          //
                          //         return Column(
                          //           children: List.generate(displayList.length, (index) {
                          //
                          //             final item = displayList[index];
                          //             final count = item.labourCount ?? 0;
                          //
                          //             /// Percentage for progress bar (0.0 - 1.0)
                          //             final double percent = totalLabourStrength == 0
                          //                 ? 0.0
                          //                 : (count / totalLabourStrength).clamp(0.0, 1.0);
                          //
                          //             /// Percentage text (0 - 100)
                          //             final double percentageValue = totalLabourStrength == 0
                          //                 ? 0.0
                          //                 : (count / totalLabourStrength) * 100;
                          //
                          //             return Padding(
                          //               padding: const EdgeInsets.only(bottom: 15),
                          //               child: Row(
                          //                 children: [
                          //
                          //                   SizedBox(
                          //                     width: 100,
                          //                     child: Text(
                          //                       item.subcontractName ?? "",
                          //                       maxLines: 1,
                          //                       overflow: TextOverflow.ellipsis,
                          //                       style: const TextStyle(
                          //                         fontWeight: FontWeight.w600,
                          //                         fontSize: 13,
                          //                       ),
                          //                     ),
                          //                   ),
                          //
                          //                   const SizedBox(width: 10),
                          //
                          //                   Expanded(
                          //                     child: LinearPercentIndicator(
                          //                       padding: EdgeInsets.zero,
                          //                       lineHeight: 18,
                          //                       animation: true,
                          //                       animationDuration: 1000,
                          //                       percent: percent,
                          //                       barRadius: const Radius.circular(20),
                          //                       backgroundColor: Colors.grey.shade200,
                          //                       progressColor: colors[index % colors.length],
                          //                     ),
                          //                   ),
                          //
                          //                   const SizedBox(width: 5),
                          //
                          //                   SizedBox(
                          //                     width: 65,
                          //                     child: Column(
                          //                       crossAxisAlignment: CrossAxisAlignment.end,
                          //                       children: [
                          //                         Text(BaseUtitiles.formatNumber(count),
                          //                           style: const TextStyle(
                          //                             fontWeight: FontWeight.bold,
                          //                             fontSize: 13,
                          //                           ),
                          //                         ),
                          //                         Text(
                          //                           "${percentageValue.toStringAsFixed(1)}%",
                          //                           style: TextStyle(
                          //                             fontSize: 11,
                          //                             color: Colors.grey.shade600,
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             );
                          //           }),
                          //         );
                          //       })
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(height: 24,),

                          /// -----------Payment Pending--------
                          // Container(
                          //   padding: const EdgeInsets.all(16),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(16),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey.withOpacity(.15),
                          //         blurRadius: 8,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       /// Header
                          //       Row(
                          //         children: [
                          //           const Expanded(
                          //             child: Text(
                          //               "Payment Pending",
                          //               style: TextStyle(
                          //                 fontSize: 14,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //             ),
                          //           ),
                          //           InkWell(
                          //             onTap: () {
                          //               Get.to(
                          //                     () => PaymentPendingScreen(
                          //                   paymentList: labourDashboardController
                          //                       .dashboardResponse
                          //                       .value
                          //                       ?.subContractPaymentPending ??
                          //                       [],
                          //                 ),
                          //               );
                          //             },
                          //             child:  Obx(() =>
                          //                Visibility(
                          //                 visible: labourDashboardController
                          //                     .dashboardResponse.value?.subContractPaymentPending
                          //                     ?.isNotEmpty ??
                          //                     false,
                          //                 child: Row(
                          //                   children: [
                          //                     Text(
                          //                       "View All",
                          //                       style: TextStyle(
                          //                         fontSize: 14,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     ),
                          //                     SizedBox(width: 4),
                          //                     Icon(Icons.arrow_forward_ios, size: 12),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       SizedBox(height: 10,),
                          //       SizedBox(height: 10,),
                          //       /// Horizontal Table
                          //       Obx(() {
                          //
                          //         final paymentList = labourDashboardController
                          //             .dashboardResponse.value?.subContractPaymentPending ??
                          //             [];
                          //         if (paymentList.isEmpty) {
                          //           return const Center(
                          //             child: Padding(
                          //               padding: EdgeInsets.all(20),
                          //               child: Text("No Payment Pending"),
                          //             ),
                          //           );
                          //         }
                          //         return
                          //           Column(
                          //             children: [
                          //               Container(
                          //                 padding: const EdgeInsets.symmetric(
                          //                   horizontal: 12,
                          //                   vertical: 10,
                          //                 ),
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.grey.shade100,
                          //                   borderRadius: BorderRadius.only(
                          //                     topLeft: Radius.circular(12),
                          //                     topRight: Radius.circular(12),),
                          //                 ),
                          //                 child: const Row(
                          //                   children: [
                          //                     Expanded(
                          //                       child: Text(
                          //                         "Subcontractor",
                          //                         style: TextStyle(
                          //                           fontSize: 12,
                          //                           fontWeight: FontWeight.bold,
                          //                           color: Colors.black87,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     Text(
                          //                       "Amount",
                          //                       style: TextStyle(
                          //                         fontSize: 12,
                          //                         fontWeight: FontWeight.bold,
                          //                         color: Colors.black87,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //               ListView.separated(
                          //                 padding: EdgeInsets.zero,
                          //               shrinkWrap: true,
                          //               physics: const NeverScrollableScrollPhysics(),
                          //               itemCount: paymentList.length > 5 ? 5 : paymentList.length,
                          //               separatorBuilder: (_, __) => const SizedBox(height: 12),
                          //               itemBuilder: (context, index) {
                          //                 final item = paymentList[index];
                          //                 return Container(
                          //                   padding: const EdgeInsets.all(8),
                          //                   decoration: BoxDecoration(
                          //                     color: Colors.white,
                          //                     borderRadius: BorderRadius.only(   bottomLeft: Radius.circular(12),
                          //                       bottomRight: Radius.circular(12),),
                          //                     border: Border.all(color: Colors.grey.shade200),
                          //                     boxShadow: [
                          //                       BoxShadow(
                          //                         color: Colors.grey.withOpacity(.08),
                          //                         blurRadius: 8,
                          //                         offset: const Offset(0, 2),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                   child: Row(
                          //                     children: [
                          //
                          //                       /// Leading Icon
                          //                       Container(
                          //                         height: 38,
                          //                         width: 38,
                          //                         decoration: BoxDecoration(
                          //                           color: item.billType == "WORK BILL" ? BaseUtitiles.primaryColor
                          //                               .withOpacity(.1) : item.billType == "NMR BILL" ? Colors.orange.withOpacity(.2) :
                          //                         item.billType == "RATE BILL" ? Colors.green.withOpacity(.2) : Colors.orange.withOpacity(.2),
                          //                           borderRadius: BorderRadius.circular(10),
                          //                         ),
                          //                         child: Icon(
                          //                           Icons.account_balance_wallet_outlined,
                          //                           color: item.billType == "WORK BILL" ? BaseUtitiles.primaryColor : item.billType == "NMR BILL" ? Colors.orange.shade700 :
                          //                           item.billType == "RATE BILL" ? Colors.green.shade700 : Colors.orange.shade700,
                          //                         ),
                          //                       ),
                          //
                          //                       const SizedBox(width: 12),
                          //
                          //                       /// Left
                          //                       Expanded(
                          //                         child: Column(
                          //                           crossAxisAlignment: CrossAxisAlignment.start,
                          //                           children: [
                          //
                          //                             Text(
                          //                               item.subcontractName ?? "",
                          //                               maxLines: 1,
                          //                               overflow: TextOverflow.ellipsis,
                          //                               style: const TextStyle(
                          //                                 fontSize: 13,
                          //                                 fontWeight: FontWeight.bold,
                          //                               ),
                          //                             ),
                          //
                          //                             const SizedBox(height: 4),
                          //
                          //                             Text(
                          //                               item.projectName ?? "",
                          //                               maxLines: 1,
                          //                               overflow: TextOverflow.ellipsis,
                          //                               style: TextStyle(
                          //                                 fontSize: 12,
                          //                                 color: Colors.grey.shade600,
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //
                          //                       const SizedBox(width: 10),
                          //
                          //                       /// Right
                          //                       Column(
                          //                         crossAxisAlignment: CrossAxisAlignment.end,
                          //                         children: [
                          //
                          //                           Text(
                          //                             " ${'\u20B9'} ${(item.balAmt ?? 0).toStringAsFixed(0)}",
                          //                             style: const TextStyle(
                          //                               fontWeight: FontWeight.bold,
                          //                               fontSize: 14,
                          //                             ),
                          //                           ),
                          //
                          //                           const SizedBox(height: 5),
                          //
                          //                           Container(
                          //                             padding: const EdgeInsets.symmetric(
                          //                               horizontal: 10,
                          //                               vertical: 4,
                          //                             ),
                          //                             decoration: BoxDecoration(
                          //                               color: item.billType == "WORK BILL" ? BaseUtitiles.primaryColor
                          //                                   .withOpacity(.1) : item.billType == "NMR BILL" ? Colors.orange.withOpacity(.2) :
                          //                               item.billType == "RATE BILL" ? Colors.green.withOpacity(.2) : Colors.orange.shade700,
                          //                               borderRadius: BorderRadius.circular(20),
                          //                               border: Border.all(
                          //                                 color: item.billType == "WORK BILL" ? BaseUtitiles.primaryColor
                          //                                     .withOpacity(.4) : item.billType == "NMR BILL" ? Colors.orange.shade700 :
                          //                                 item.billType == "RATE BILL" ? Colors.green.shade700 : Colors.orange.shade700,
                          //                               ),
                          //                             ),
                          //                             child: Text(
                          //                               item.billType ?? "",
                          //                               style: TextStyle(
                          //                                 color: item.billType == "WORK BILL" ? BaseUtitiles.primaryColor :
                          //                                 item.billType == "NMR BILL" ? Colors.orange.shade700 :
                          //                                 item.billType == "RATE BILL" ? Colors.green.shade700 : Colors.orange.shade700,
                          //                                 fontSize: 10,
                          //                                 fontWeight: FontWeight.w600,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 );
                          //               },
                          //               ),
                          //             ],
                          //           );
                          //       })
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(height: 24,),
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xffEAECF0),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Header
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Subcontractor Attendance",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                AttendanceViewAllScreen(
                                                  attendanceList:
                                                  labourDashboardController
                                                      .todayAttendanceList,
                                                ),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: Obx(
                                            () => Visibility(
                                          visible: labourDashboardController
                                              .todayAttendanceList.length > 3,
                                          child: Row(
                                            children: [
                                              const Text(
                                                "View All",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Icon(Icons.arrow_forward_ios,
                                                  size: 12),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                const SizedBox(height: 18),

                                /// Table Container
                                Obx(
                                      () {
                                    final attendanceList =
                                        labourDashboardController
                                            .todayAttendanceList;

                                    if (attendanceList.isEmpty) {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                              "No Subcontractor Attendance"),
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: attendanceList.length > 3
                                          ? 3
                                          : attendanceList.length,
                                      shrinkWrap: true,
                                      separatorBuilder: (_, __) =>
                                      const SizedBox(height: 16),
                                      itemBuilder: (context, index) {
                                        final item = attendanceList[index];

                                        return Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(.12),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              /// Row 1
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      item.labourAttendanceNo ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      item.labourAttendanceDate !=
                                                          null
                                                          ? DateFormat(
                                                          'dd-MM-yyyy')
                                                          .format(
                                                        DateTime.parse(item
                                                            .labourAttendanceDate!),
                                                      )
                                                          : "",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      item.subContractorName ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color:
                                                        Color(0xff1E3A8A),
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
                                                    child: Row(
                                                      children: [
                                                        // const Icon(
                                                        //   Icons.add_chart_rounded,
                                                        //   size: 18,
                                                        //   color: Colors.blue,
                                                        // ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Expanded(
                                                          child: Text(
                                                            item.projectName ??
                                                                "",
                                                            maxLines: 2,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style:
                                                            const TextStyle(
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 3),
                                                    decoration: BoxDecoration(
                                                      color:
                                                      Colors.green.shade50,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          20),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.groups,
                                                          size: 18,
                                                          color: Colors.green,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          (item.totNos ?? 0)
                                                              .toStringAsFixed(
                                                              0),
                                                          style:
                                                          const TextStyle(
                                                            color: Colors.green,
                                                            fontWeight:
                                                            FontWeight.bold,
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
                                                    child: Row(
                                                      children: [
                                                        // const Icon(
                                                        //   Icons.add_card_rounded,
                                                        //   size: 18,
                                                        //   color: Colors.red,
                                                        // ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Expanded(
                                                          child: Text(
                                                            item.siteName ?? "",
                                                            maxLines: 2,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style:
                                                            const TextStyle(
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "${'\u20B9'} ${BaseUtitiles.formatNumber(item.totAmt)}",
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.deepOrange,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Obx(
                                () => Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color(0xffEAECF0),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.06),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "Project Wise Subcontractor",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff101828),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Subcontractor breakdown for selected project",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xff667085),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return SubcontractorWiseLabourDialog(
                                                  subcontractorList:
                                                  labourDashboardController
                                                      .subcontWiseLabourSummaryList,
                                                );
                                              },
                                            );
                                          },
                                          child: Obx(
                                                () => Visibility(
                                              visible: labourDashboardController
                                                  .subcontractorfilteredProjects
                                                  .length > 3,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "View All",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Icon(Icons.arrow_forward_ios,
                                                      size: 12),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 22),
                                    if (labourDashboardController
                                        .subcontractorfilteredProjects.isEmpty)
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 30,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "No Record Found",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff667085),
                                            ),
                                          ),
                                        ),
                                      )
                                    else
                                      ...(() {
                                        final List<
                                            SubContractorWiseLabourTradeChart>
                                        sortedList = List<
                                            SubContractorWiseLabourTradeChart>.from(
                                          labourDashboardController
                                              .subcontractorfilteredProjects,
                                        );

                                        // Alphabetical order
                                        sortedList.sort(
                                              (a, b) => (a.subcontractName ?? '')
                                              .toLowerCase()
                                              .compareTo(
                                            (b.subcontractName ?? '')
                                                .toLowerCase(),
                                          ),
                                        );

                                        // Show only first 4
                                        return sortedList
                                            .take(4)
                                            .map(
                                              (item) => _subcontractorItem(
                                            item: item,
                                          ),
                                        )
                                            .toList();
                                      }()),
                                    const SizedBox(height: 2),
                                    if (labourDashboardController
                                        .subcontractorfilteredProjects
                                        .isNotEmpty)
                                      const Divider(
                                        height: 1,
                                        color: Color(0xffEAECF0),
                                      ),
                                    const SizedBox(height: 10),
                                    if (labourDashboardController
                                        .subcontractorfilteredProjects
                                        .isNotEmpty)
                                      Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: const BoxDecoration(
                                              color: Color(0xff2864F0),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            "NMR Work",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xff667085),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: const BoxDecoration(
                                              color: Color(0xffff7214),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            "Rate Work",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xff667085),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Obx(
                                () => Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color(0xffEAECF0),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.06),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "Subcontractor Wise Project",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff101828),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Project breakdown for selected subcontractor",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xff667085),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ProjectWiseAttendanceDialog(
                                                  projectList:
                                                  labourDashboardController
                                                      .projectWiseAttendanceList,
                                                  attendanceList:
                                                  labourDashboardController
                                                      .allTodayAttendanceList,
                                                );
                                              },
                                            );
                                          },
                                          child: Obx(
                                                () => Visibility(
                                              visible: labourDashboardController
                                                  .projectWiseAttendanceList
                                                  .length > 3,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "View All",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Icon(Icons.arrow_forward_ios,
                                                      size: 12),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 22),
                                    if (labourDashboardController
                                        .projectWiseAttendanceList.isEmpty)
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 30,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "No Record Found",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff667085),
                                            ),
                                          ),
                                        ),
                                      )
                                    else
                                      ...(() {
                                        final List<ProjectWiseAttendance>
                                        sortedList =
                                        List<ProjectWiseAttendance>.from(
                                          labourDashboardController
                                              .projectWiseAttendanceList,
                                        );

                                        // Alphabetical order
                                        sortedList.sort(
                                              (a, b) => (a.projectName ?? '')
                                              .toLowerCase()
                                              .compareTo(
                                            (b.projectName ?? '')
                                                .toLowerCase(),
                                          ),
                                        );

                                        // Show only first 4
                                        return sortedList
                                            .take(4)
                                            .map(
                                              (item) => _projectAttendanceItem(
                                            item: item,
                                          ),
                                        )
                                            .toList();
                                      }()),
                                    const SizedBox(height: 2),
                                    if (labourDashboardController
                                        .projectWiseAttendanceList.isNotEmpty)
                                      const Divider(
                                        height: 1,
                                        color: Color(0xffEAECF0),
                                      ),
                                    const SizedBox(height: 10),
                                    if (labourDashboardController
                                        .projectWiseAttendanceList.isNotEmpty)
                                      Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: const BoxDecoration(
                                              color: Color(0xff2864F0),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            "NMR Work",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xff667085),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: const BoxDecoration(
                                              color: Color(0xffff7214),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            "Rate Work",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xff667085),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      );
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          _buildDashboardShimmerGrid(),

          const SizedBox(height: 15),

          // ───────── SUMMARY CARD ─────────
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(height: 15),

          // ───────── SECOND CARD ─────────
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(height: 20),

          // ───────── SECTION TITLE ─────────
          Container(
            height: 18,
            width: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          const SizedBox(height: 12),

          // ───────── BOTTOM CARD ─────────
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardShimmerGrid() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 6, // number of shimmer placeholders
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 10,
          mainAxisExtent: 105, // same as your LabourCard grid
        ),
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }


  Widget _projectAttendanceItem({
    required ProjectWiseAttendance item,
  }) {
    final double total = item.total.toDouble();

    final int nmrCount = item.nmrCount.toInt();
    final int rateCount = item.rateCount.toInt();

    final int nmrPercentage =
    total > 0 ? ((nmrCount / total) * 100).round() : 0;

    final int ratePercentage =
    total > 0 ? ((rateCount / total) * 100).round() : 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.projectName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff344054),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                item.total.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff101828),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            preferBelow: false,
            verticalOffset: 10,
            waitDuration: Duration.zero,
            showDuration: const Duration(seconds: 5),

            // Tooltip padding
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 9,
            ),

            // Tooltip decoration
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: const Color(0xffD0D5DD),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            richMessage: WidgetSpan(
              child: SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.projectName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff344054),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xff2864F0),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            "NMR",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xff667085),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "$nmrCount "
                              "(${total > 0 ? ((nmrCount / total) * 100).round() : 0}%)",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff344054),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xffff7214),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            "Rate",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xff667085),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "$rateCount "
                              "(${total > 0 ? ((rateCount / total) * 100).round() : 0}%)",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff344054),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xffEAECF0),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff667085),
                            ),
                          ),
                        ),
                        Text(
                          item.total.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff344054),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 12,
                child: Stack(
                  children: [
                    // Background
                    Container(
                      width: double.infinity,
                      color: const Color(0xffEAECF0),
                    ),

                    // NMR + Rate
                    Row(
                      children: [
                        // NMR
                        if (nmrCount > 0)
                          Expanded(
                            flex: nmrCount,
                            child: Container(
                              color: const Color(0xff2864F0),
                            ),
                          ),

                        // Rate
                        if (rateCount > 0)
                          Expanded(
                            flex: rateCount,
                            child: Container(
                              color: const Color(0xffff7214),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subcontractorItem({
    required SubContractorWiseLabourTradeChart item,
  }) {
    final int nmrNos = (item.nmrNos ?? 0).toInt();
    final int rateNos = (item.rateNos ?? 0).toInt();
    final int totalNos = (item.totalNos ?? 0).toInt();

    // Safety check
    final int calculatedTotal = nmrNos + rateNos;

    final int actualTotal = totalNos > 0 ? totalNos : calculatedTotal;

    double nmrFraction = 0.0;
    double rateFraction = 0.0;

    if (actualTotal > 0) {
      nmrFraction = nmrNos / actualTotal;
      rateFraction = rateNos / actualTotal;
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Total
          Row(
            children: [
              Expanded(
                child: Text(
                  item.subcontractName ?? "",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff344054),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                actualTotal.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff101828),
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            preferBelow: false,
            verticalOffset: 10,
            waitDuration: Duration.zero,
            showDuration: const Duration(seconds: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: const Color(0xffD0D5DD),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            richMessage: WidgetSpan(
              child: SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subcontractor Name
                    Text(
                      item.subcontractName ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff344054),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // NMR
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xff2864F0),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "NMR",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff667085),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "$nmrNos "
                              "(${actualTotal > 0 ? ((nmrNos / actualTotal) * 100).round() : 0}%)",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff344054),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Rate
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xffff7214),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "Rate",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff667085),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "$rateNos "
                              "(${actualTotal > 0 ? ((rateNos / actualTotal) * 100).round() : 0}%)",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff344054),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const Divider(
                      height: 1,
                      color: Color(0xffEAECF0),
                    ),

                    const SizedBox(height: 8),

                    // Total
                    Row(
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff667085),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          actualTotal.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff344054),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 12,
                child: Row(
                  children: [
                    if (nmrNos > 0)
                      Expanded(
                        flex: nmrNos,
                        child: Container(
                          color: const Color(0xff2864F0),
                        ),
                      ),
                    if (rateNos > 0)
                      Expanded(
                        flex: rateNos,
                        child: Container(
                          color: const Color(0xffff7214),
                        ),
                      ),
                    if (nmrNos == 0 && rateNos == 0)
                      Expanded(
                        child: Container(
                          color: const Color(0xffEAECF0),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
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

  Map<String, double> getSubcontYAxisValues(
      List<SubContractorWiseLabourTradeChart> list) {
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

  Widget _legend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 10),
        )
      ],
    );
  }

  List<LabourCardModel> get labourCards {
    final data = labourDashboardController.dashboardResponse.value;
    final difference = data?.totalLabourDifference ?? 0;

    return [
      LabourCardModel(
          title: "TOTAL LABOUR",
          value: "${data?.totalLabourStrength ?? 0}",
          subtitle: "vs previous period",
          icon: Icons.groups,
          color: Color(0xFF2563EB),
          difference: difference),
      LabourCardModel(
        title: "NMR WORK",
        value: BaseUtitiles.formatNumber(
            data?.nmrLabourDetails?.isNotEmpty == true
                ? data!.nmrLabourDetails!.first.totalNmrNos
                : 0),
        subtitle:
        "${'\u20B9'} ${data?.nmrLabourDetails?.isNotEmpty == true ? data!.nmrLabourDetails!.first.totalNmrAmount ?? 0.0 : 0.0} Total cost",
        icon: Icons.assignment_turned_in_outlined,
        color: Color(0xFF7C3AED),
      ),
      LabourCardModel(
        title: "RATE WORK",
        value: BaseUtitiles.formatNumber(
            data?.rateWorkDetails?.isNotEmpty == true
                ? data!.rateWorkDetails!.first.totalNosRateWise
                : 0),
        subtitle:
        "${'\u20B9'} ${data?.rateWorkDetails?.isNotEmpty == true ? data!.rateWorkDetails!.first.totalAmountRateWise ?? 0.0 : 0.0} Total cost",
        icon: Icons.view_week_outlined,
        color: Color(0xFFD97706),
      ),
      LabourCardModel(
        title: "No Work",
        value: "${data?.noWorkDetails ?? 0}",
        subtitle: "No work entries today",
        // subtitle: "${'\u20B9'} ${data?.todayLabourCost?.isNotEmpty == true ? data!.todayLabourCost!.first.yesterdayLabourCost ?? 0.0 : 0.0} Yesterday",
        icon: Icons.block,
        color: Color(0xFFE11D48),
      ),
      LabourCardModel(
        title: "TOTAL CONTRACTOR",
        value: "${data?.activeSubContractors ?? 0}",
        subtitle: "Active subcontractors",
        icon: Icons.apartment_outlined,
        color: Color(0xFF0F9D8A),
      ),
      LabourCardModel(
        title: "PENDING APPROVALS",
        value: "${data?.pendingAttendanceApprovals ?? 0}",
        subtitle: "Awaiting sign-off",
        icon: Icons.access_time_outlined,
        color: Color(0xFFEF4444),
      ),
    ];
  }

  List<PendingApprovalModel> get pendingApprovalList {
    final data = labourDashboardController.dashboardResponse.value;

    return [
      PendingApprovalModel(
        title: "DPR APPROVALS",
        count: data?.dprApproval ?? 0,
        color: const Color(0xFF2563EB),
        icon: Icons.description_outlined,
      ),
      PendingApprovalModel(
        title: "ATTENDANCE APPROVALS",
        count: data?.subContAttendanceApprovalPendingCount ?? 0,
        color: const Color(0xFF7C3AED),
        icon: Icons.fact_check_outlined,
      ),
      PendingApprovalModel(
        title: "NMR BILL APPROVALS",
        count: data?.subConNmrBillAppPending ?? 0,
        color: const Color(0xFFF59E0B),
        icon: Icons.receipt_long_outlined,
      ),
      PendingApprovalModel(
        title: "DIRECT BILL",
        count: data?.billAppDirectCount ?? 0,
        color: const Color(0xFF10B981),
        icon: Icons.account_balance_wallet_outlined,
      ),
      PendingApprovalModel(
        title: "BOQ BILL APPROVALS",
        count: data?.boqBillApprovalCount ?? 0,
        color: const Color(0xFFEF4444),
        icon: Icons.request_quote_outlined,
      ),
    ];
  }

  Widget attendanceRow(
      Color color,
      String title,
      String count,
      String percentage,
      ) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "($percentage)",
          style: const TextStyle(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

class ProjectWiseAttendance {
  final String projectName;
  int nmrCount;
  int rateCount;

  ProjectWiseAttendance({
    required this.projectName,
    this.nmrCount = 0,
    this.rateCount = 0,
  });

  int get total => nmrCount + rateCount;
}

class LabourCardModel {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final int? difference;

  LabourCardModel({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.difference = 0,
  });
}

class LabourCard extends StatelessWidget {
  final LabourCardModel item;
  final int index;

  const LabourCard({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        item.title.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 18,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: 0,
                            end: double.tryParse(item.value) ?? 0,
                          ),
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.title == "TOTAL LABOUR") ...[
                    if (item.difference != null && item.difference! < 0) ...[
                      const Icon(
                        Icons.arrow_downward_rounded,
                        size: 13,
                        color: Color(0xffDC2626),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        item.difference!.abs().toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffDC2626),
                        ),
                      ),
                      const SizedBox(width: 4),
                    ] else if (item.difference != null) ...[
                      Text(
                        item.difference.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ],
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class PendingApprovalModel {
  final String title;
  final int count;
  final Color color;
  final IconData icon;

  PendingApprovalModel({
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });
}
