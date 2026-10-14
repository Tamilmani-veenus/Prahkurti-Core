import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:prahkurticore/controller/hrDashboard_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../commonpopup/hrDashboardViewAllScreen.dart';
import '../../controller/logincontroller.dart';
import '../../models/hrDashboardCardsRes.dart';
import '../../models/hr_Dashboard_Response.dart';
import '../../models/planningCalendarRes_model.dart';
import '../../utilities/apiconstant.dart';
import '../../utilities/baseutitiles.dart';
import 'dashboard.dart';
import 'labourDashboard.dart';

class HrDashboard extends StatefulWidget {
  const HrDashboard({super.key});

  @override
  State<HrDashboard> createState() => _HrDashboardState();
}

class _HrDashboardState extends State<HrDashboard> with SingleTickerProviderStateMixin {

  HrDashboardController hrDashboardController = Get.put(HrDashboardController());
  LoginController loginController = Get.put(LoginController());
  late AnimationController _dotAnimationController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime currentDate = DateTime.now();
    hrDashboardController.entryFromDate.text =
        currentDate.toString().substring(0, 10);
    hrDashboardController.entryToDate.text =
        currentDate.toString().substring(0, 10);
    hrDashboardController.getHrDashboardDetails();
    hrDashboardController.getHrCardsList();
    _calendarMonth = DateTime.now();

    _updateCalendarDateRange();
    if (AppClient.isAnusamm){
      hrDashboardController.getPendingLeaveRequest();
      hrDashboardController.getPlanningCalendar_List();
    }

    _dotAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _dotAnimationController.dispose();
    super.dispose();
  }

  final TooltipBehavior _tooltipBehavior = TooltipBehavior(
    enable: true,
    header: '',
    canShowMarker: false,
    builder: (
        dynamic data,
        dynamic point,
        dynamic series,
        int pointIndex,
        int seriesIndex,
        ) {
      final item = data as _LeaveChartData;

      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 5),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 6),

                Text(
                  "${item.value} Days",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
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
              color: Theme.of(context).primaryColor,
              onRefresh: () async {
                await hrDashboardController.getHrDashboardDetails();
                await hrDashboardController.getHrCardsList();
                if (AppClient.isAnusamm) {
                  await hrDashboardController.getPendingLeaveRequest();
                  await hrDashboardController.getPlanningCalendar_List();
                }
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Greetings and Date

                    Card(
                      elevation: 3,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SizedBox(
                        height: 125,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            // Header content
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                top: 10,
                                right: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "HR Analytics & Operations",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${BaseUtitiles().getGreeting()}, ${loginController.UserName()}!  👋",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Date filter - Bottom Right
                            Positioned(
                              bottom: 8,
                              right: 10,
                              child: SizedBox(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _compactDateField(
                                      title: "From",
                                      controller: hrDashboardController.entryFromDate,
                                      onTap: () async {
                                        final date = await showDatePicker(
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
                                                    onSurface: Colors.black, // body text color
                                                  ),
                                                  textButtonTheme: TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      primary: Colors
                                                          .black, // button text color
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            });
                                        if (date != null) {
                                          setState(() {
                                            hrDashboardController.entryFromDate.text =
                                                date.toString().substring(0, 10);
                                          });
                                          _refreshIndicatorKey.currentState?.show();
                                        }
                                      },
                                    ),

                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: 16,
                                        color: Color(0xff667085),
                                      ),
                                    ),

                                    _compactDateField(
                                      title: "To",
                                      controller: hrDashboardController.entryToDate,
                                      onTap: () async {
                                        final date = await showDatePicker(
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
                                                    onSurface: Colors.black, // body text color
                                                  ),
                                                  textButtonTheme: TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      primary: Colors.black, // button text color
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            });
                                        if (date != null) {
                                          setState(() {
                                            hrDashboardController.entryToDate.text =
                                                date.toString().substring(0, 10);
                                          });
                                          _refreshIndicatorKey.currentState?.show();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Cards

                    Obx(()=>
                        GridView.builder(
                          padding: EdgeInsets.only(top: 8),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: hrCards.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 2,
                            mainAxisExtent: 105,
                            // childAspectRatio: 1.45,
                          ),
                          itemBuilder: (_, index) {
                            final item = hrCards[index];

                            return InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: AppClient.isAnusamm
                                  ? () {
                                _showEmployeeListDialog(
                                  context,
                                  title: item.title,
                                  employees: hrDashboardController.getEmployeesForCard(item.title),
                                  icon: item.icon,
                                  color: item.color,
                                );
                              }
                                  : null,
                              child: LabourCard(
                                item: item,
                                index: index,
                              ),
                            );
                          },
                        ),
                    ),

                    /// Staff attendance

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
                      child: Obx(() {
                        final data = hrDashboardController.hrCategoryList.value;
                        final chart = hrDashboardController.hrStaffAttendanceList.value;

                        final int present = int.tryParse(
                          data?.totalPresentEmployee.toString() ?? "0",
                        ) ??
                            0;

                        final int absent = int.tryParse(
                          data?.absentEmployee.toString() ?? "0",
                        ) ??
                            0;

                        final int onLeave = int.tryParse(
                          data?.onLeaveEmployee.toString() ?? "0",
                        ) ??
                            0;

                        final int total = present + absent + onLeave;

                        return Column(
                          children: [

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          getAttendanceTitle("Staff Attendance"),
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff172B4D),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Workforce attendance breakdown",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xff98A2B3),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            const Divider(
                              height: 1,
                              color: Color(0xffEAECF0),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 170,
                                height: 170,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [

                                    // Inner dotted circle
                                    SizedBox(
                                      width: 112,
                                      height: 112,
                                      child: CustomPaint(
                                        painter: DottedCirclePainter(animation: _dotAnimationController,),
                                      ),
                                    ),

                                    // Outer attendance doughnut
                                    CustomPaint(
                                      size: const Size(180, 180),
                                      painter: AttendanceDonutPainter(
                                        presentPercentage:
                                        chart?.presentPercentage ?? 0.0,
                                        absentPercentage:
                                        chart?.absentPercentage ?? 0.0,
                                        onLeavePercentage:
                                        chart?.onLeavePercentage ?? 0.0,
                                      ),
                                    ),

                                    // Center content
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "TOTAL",
                                          style: TextStyle(
                                            fontSize: 9,
                                            letterSpacing: 1.2,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff98A2B3),
                                          ),
                                        ),

                                        const SizedBox(height: 4),

                                        Text(
                                          "$total",
                                          style: const TextStyle(
                                            fontSize: 26,
                                            height: 1,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xff172B4D),
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        const Text(
                                          "STAFF",
                                          style: TextStyle(
                                            fontSize: 9,
                                            letterSpacing: 1.2,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff98A2B3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _attendanceSummaryItem(
                                    icon: Icons.person,
                                    iconColor: const Color(0xff00A94F),
                                    iconBackground: const Color(0xffDDF9E9),
                                    title: "PRESENT",
                                    value: data?.totalPresentEmployee ?? 0,
                                    percentage: chart?.presentPercentage ?? 0.0,
                                    percentageColor: const Color(0xff00A94F),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: _attendanceSummaryItem(
                                    icon: Icons.person_off,
                                    iconColor: const Color(0xffff4141),
                                    iconBackground: const Color(0xffffe4e4),
                                    title: "ABSENT",
                                    value: data?.absentEmployee ?? 0,
                                    percentage: chart?.absentPercentage ?? 0.0,
                                    percentageColor: const Color(0xffff3333),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: _attendanceSummaryItem(
                                    icon: Icons.beach_access,
                                    iconColor: const Color(0xffff8500),
                                    iconBackground: const Color(0xffffeddb),
                                    title: "ON LEAVE",
                                    value: data?.onLeaveEmployee ?? 0,
                                    percentage: chart?.onLeavePercentage ?? 0.0,
                                    percentageColor: const Color(0xffff7500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 10,),

                    /// Leave Overview
                     if(!AppClient.isAnusamm)...{
                       Container(
                         width: double.infinity,
                         padding: const EdgeInsets.all(14),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(14),
                           border: Border.all(
                             color: const Color(0xffE1E5EA),
                           ),
                         ),
                         child: Obx(() {
                           final leaveData = hrDashboardController
                               .hrLeaveOverViewList.value;

                           final int leaveUsed = leaveData?.leaveUsed ?? 0;
                           final int remainingLeave = leaveData
                               ?.remainingLeave ?? 0;

                           final int totalLeaveDays =
                               leaveUsed + remainingLeave;

                           final double leaveUsedPercentage =
                               leaveData?.leaveUsedPercentage ?? 0;

                           final double remainingLeavePercentage =
                               leaveData?.remainingLeavePercentage ?? 0;

                           return Column(
                             children: [

                               // HEADER
                               Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const Expanded(
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment
                                           .start,
                                       children: [
                                         Text(
                                           "Leave Overview (This Year)",
                                           style: TextStyle(
                                             fontSize: 16,
                                             fontWeight: FontWeight.w700,
                                             color: Color(0xff172B4D),
                                           ),
                                         ),
                                         SizedBox(height: 4),
                                         Text(
                                           "Annual leave usage summary",
                                           style: TextStyle(
                                             fontSize: 10,
                                             fontWeight: FontWeight.w500,
                                             color: Color(0xff98A2B3),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),

                               const SizedBox(height: 8),

                               // CHART
                               SizedBox(
                                 height: 180,
                                 child: SfCircularChart(
                                   tooltipBehavior: _tooltipBehavior,

                                   margin: const EdgeInsets.all(0),

                                   annotations: [
                                     CircularChartAnnotation(
                                       widget: Column(
                                         mainAxisSize: MainAxisSize.min,
                                         children: [
                                           Text(
                                             "$totalLeaveDays",
                                             style: const TextStyle(
                                               fontSize: 25,
                                               height: 1,
                                               fontWeight: FontWeight.w800,
                                               color: Color(0xff172B4D),
                                             ),
                                           ),

                                           const SizedBox(height: 4),

                                           const Text(
                                             "ANNUAL DAYS",
                                             style: TextStyle(
                                               fontSize: 7,
                                               letterSpacing: .5,
                                               fontWeight: FontWeight.w700,
                                               color: Color(0xff98A2B3),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ],

                                   series: [
                                     DoughnutSeries<_LeaveChartData, String>(
                                       dataSource: [
                                         _LeaveChartData(
                                           "Leave Used",
                                           leaveUsed,
                                           const Color(0xff3B82F6),
                                         ),
                                         _LeaveChartData(
                                           "Remaining",
                                           remainingLeave,
                                           const Color(0xff22C55E),
                                         ),
                                       ],

                                       xValueMapper: (data, _) => data.title,
                                       yValueMapper: (data, _) => data.value,
                                       pointColorMapper: (data, _) =>
                                       data.color,

                                       radius: "90%",
                                       innerRadius: "70%",

                                       strokeWidth: 2,
                                       strokeColor: Colors.white,

                                       animationDuration: 700,
                                       enableTooltip: true,
                                     ),
                                   ],
                                 ),
                               ),

                               // DIVIDER
                               const Divider(
                                 height: 1,
                                 color: Color(0xffF0F2F5),
                               ),

                               const SizedBox(height: 8),

                               // BOTTOM DETAILS
                               Row(
                                 children: [
                                   Expanded(
                                     child: _leaveSummaryItem(
                                       title: "Leave Used",
                                       value: leaveUsed,
                                       percentage: leaveUsedPercentage,
                                       color: const Color(0xff3B82F6),
                                     ),
                                   ),

                                   Expanded(
                                     child: _leaveSummaryItem(
                                       title: "Remaining",
                                       value: remainingLeave,
                                       percentage: remainingLeavePercentage,
                                       color: const Color(0xff16A34A),
                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           );
                         }),
                       ),
                       const SizedBox(height: 10,),
                     },

                    /// Today's punch overview
                     if(!AppClient.isAnusamm)...{
                       Obx(() {
                         final totalPunchIn = hrDashboardController
                             .hrCategoryList.value;
                         final data = hrDashboardController.hrTodayPunchViewList
                             .value;

                         final int totalPunchOut = data?.totalPunchOut ?? 0;
                         final int missingpunchOut = data?.missingpunchout ?? 0;
                         final int latePunchOut = data?.latePunchOutEmployee ??
                             0;


                         return Container(
                           width: double.infinity,
                           padding: const EdgeInsets.fromLTRB(
                             16,
                             14,
                             16,
                             16,
                           ),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(16),
                             border: Border.all(
                               color: const Color(0xffE4E7EC),
                             ),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.black.withOpacity(.04),
                                 blurRadius: 8,
                                 offset: const Offset(0, 2),
                               ),
                             ],
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 getAttendanceTitle("Punch Overview"),
                                 // "Today's Punch Overview",
                                 style: TextStyle(
                                   fontSize: 16,
                                   fontWeight: FontWeight.w700,
                                   color: Color(0xff172B4D),
                                 ),
                               ),
                               SizedBox(height: 4),
                               Text(
                                 "Real-time terminal scan count",
                                 style: TextStyle(
                                   fontSize: 10,
                                   fontWeight: FontWeight.w500,
                                   color: Color(0xff98A2B3),
                                 ),
                               ),

                               const SizedBox(height: 18),

                               Row(
                                 children: [
                                   Expanded(
                                     child: _leaveOverviewCard(
                                       title: "TOTAL PUNCH IN",
                                       value: "${totalPunchIn
                                           ?.totalPresentEmployee}",
                                       iconColor: const Color(0xff10b981),
                                       iconBackground: const Color(0xffEEF4FF),
                                       iconAsset: "assets/svg_files/punch.svg",
                                     ),
                                   ),

                                   const SizedBox(width: 8),

                                   Expanded(
                                     child: _leaveOverviewCard(
                                       title: "TOTAL PUNCH OUT",
                                       value: "$totalPunchOut",
                                       iconColor: const Color(0xff8b5cf6),
                                       iconBackground: const Color(0xffE9F9EF),
                                       iconAsset: "assets/svg_files/punchOut.svg",
                                     ),
                                   ),
                                 ],
                               ),

                               const SizedBox(height: 10),

                               Row(
                                 children: [
                                   Expanded(
                                     child: _leaveOverviewCard(
                                       title: "MISSING PUNCH OUT",
                                       value: "$missingpunchOut",
                                       icon: Icons.warning_amber_rounded,
                                       iconColor: const Color(0xfff59e0b),
                                       iconBackground: const Color(0xffF1EDFF),
                                     ),
                                   ),

                                   const SizedBox(width: 8),

                                   Expanded(
                                     child: _leaveOverviewCard(
                                       title: "LATE PUNCH OUT",
                                       value: "$latePunchOut",
                                       icon: Icons.access_time_rounded,
                                       iconColor: const Color(0xfff43f5e),
                                       iconBackground: const Color(0xfffff0df),
                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         );
                       }),
                       const SizedBox(height: 10,),
                     },
                    /// Upcoming holidays

                    Obx(() {
                      final holidays =
                          hrDashboardController.hrUpcomingHolidayList;

                      final int visibleCount =
                      holidays.length > 3 ? 3 : holidays.length;

                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          14,
                          16,
                          16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xffE4E7EC),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            // HEADER
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Upcoming Holidays",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff172B4D),
                                    ),
                                  ),
                                ),

                                if (holidays.length > 3)
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => UpcomingHolidaysPage(holidays: holidays));
                                    },
                                    borderRadius: BorderRadius.circular(24),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF5F8FF),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "View All",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Container(
                                            width: 18,
                                            height: 18,
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 11,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              "Holiday calendar agenda",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff98A2B3),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // HOLIDAYS
                            if (holidays.isEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    "No upcoming holidays",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff98A2B3),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount: visibleCount,
                                itemBuilder: (context, index) {
                                  return _dashboardHolidayItem(
                                    holiday: holidays[index],
                                    isLast:
                                    index == visibleCount - 1,
                                  );
                                },
                              ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 10,),

                    /// Pending approvals

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
                                  fontSize: 16,
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
                                  final visibleItems = pendingApprovalList;
                                  return AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Column(
                                      children: [
                                        ...visibleItems.asMap().entries.map((entry){
                                          final item = entry.value;
                                          return GestureDetector(
                                            onTap: () {
                                              if (AppClient.isAnusamm){
                                                final String title =
                                                item.title.toString().trim().toUpperCase();

                                                late String requisitionType;

                                                if (title == 'LEAVE REQUESTS') {
                                                  requisitionType = 'LEAVE';
                                                } else if (title == 'PERMISSION REQUESTS') {
                                                  requisitionType = 'PERMISSION';
                                                } else if (title == 'COMPENSATE LEAVES') {
                                                  requisitionType = 'COMP OF LEAVE';
                                                } else {
                                                  requisitionType = 'ON DUTY';
                                                }

                                                final filteredRequests = hrDashboardController
                                                    .pendingLeaveReqTypes
                                                    .where(
                                                      (request) =>
                                                  (request.requisitionType ?? '')
                                                      .trim()
                                                      .toUpperCase() ==
                                                      requisitionType,
                                                )
                                                    .toList();

                                                late String screenTitle;

                                                if (requisitionType == 'LEAVE') {
                                                  screenTitle = 'Pending Leave Requests';
                                                } else if (requisitionType == 'PERMISSION') {
                                                  screenTitle = 'Pending Permission Requests';
                                                } else if (requisitionType == 'COMP OF LEAVE') {
                                                  screenTitle = 'Compensate Leave Requests';
                                                } else {
                                                  screenTitle = 'On Duty Requests';
                                                }

                                                Get.to(
                                                      () => LeaveRequestCard(
                                                    requests: filteredRequests,
                                                    type: requisitionType,
                                                    title: screenTitle,
                                                  ),
                                                );}
                                            },

                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 4,
                                              ),

                                              padding: const EdgeInsets.all(
                                                8,
                                              ),

                                              decoration: BoxDecoration(
                                                color: Colors.white,

                                                borderRadius:
                                                BorderRadius.circular(15),

                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),

                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 16,
                                                    backgroundColor: item.color.withOpacity(.15),
                                                    child: Icon(item.icon,
                                                      color: item.color,
                                                      size: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      item.title,
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),

                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Container(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                      item.color.withOpacity(.15),
                                                      borderRadius:
                                                      BorderRadius.circular(25),
                                                    ),
                                                    child: Text('${item.count}',
                                                      style: TextStyle(color: item.color,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                    const SizedBox(height: 10,),

                    /// Recent punch activivty

                    Obx(() {
                      final activities =
                          hrDashboardController.filteredActivities;

                      final int visibleCount =
                      activities.length > 2 ? 2 : activities.length;

                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          14,
                          16,
                          16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xffE4E7EC),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Recent Punch Activity",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff172B4D),
                                    ),
                                  ),
                                ),

                                // VIEW ALL
                                if (activities.length > 2)
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                            () => RecentActivityCardList(
                                          activities: activities,
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(24),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF5F8FF),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "View All",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Container(
                                            width: 18,
                                            height: 18,
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 11,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              "Real-time attendance logs",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff98A2B3),
                              ),
                            ),

                            const SizedBox(height: 18),

                            if (activities.isEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    "No recent punch activity",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff98A2B3),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: visibleCount,
                                itemBuilder: (context, index) {
                                  return RecentActivityCard(
                                    activity: activities[index],
                                  );
                                },
                              ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 10,),

                    /// Smart insights

                    Obx(() {
                      final data = hrDashboardController.hrTodayPunchViewList.value;
                      final int missingpunchOut = data?.missingpunchout ?? 0;
                      final data1 = hrDashboardController.hrCategoryList.value;
                      final holidays = hrDashboardController.hrUpcomingHolidayList;
                      final monthPerformList = hrDashboardController.hrMonthlyPerformance;
                      final String monthName =
                      monthPerformList.isNotEmpty
                          ? monthPerformList.last.monthName ?? ''
                          : '';
                      final double monthPercent =
                      monthPerformList.isNotEmpty
                          ? monthPerformList.last.attendancePercentage ?? 0.0
                          : 0.0;

                      String leaveName = '';
                      String daysLeft = '';

                      if (holidays.isNotEmpty) {
                        final firstHoliday = holidays.first;

                        leaveName = firstHoliday.holidayRemarks ?? '';
                        daysLeft = firstHoliday.remainingDays?.toString() ?? '';
                      }
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          14,
                          16,
                          16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xffE4E7EC),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Smart Insights",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff172B4D),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Automated anomalies, logs warnings and reminders",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff98A2B3),
                              ),
                            ),

                            const SizedBox(height: 18),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffF5F8FF),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xffD9E4FF),
                                ),
                              ),
                              child: Column(
                                children: [
                                  _smartInsightsCard(
                                    title: "EXCESS LATE ATTENDANCE",
                                    value:data1?.latePunchinEmployee == null ||
                                        data1?.latePunchInPercentage == null
                                        ? "-" :
                                    "${data1?.latePunchinEmployee} employees ${data1?.latePunchInPercentage} clocked in late today.",
                                    iconColor: const Color(0xfff43f5e),
                                    icon: Icons.access_time_rounded,
                                  ),

                                  const Divider(thickness: 1,height: 1.5,),

                                  _smartInsightsCard(
                                    title: "LOW ATTENDANCE ALERT",
                                    value:
                                    data1?.presentPercentage == null
                                        ? "-" :
                                    "Only ${data1?.presentPercentage} of staff is present today. Operations might experience delays.",
                                    iconColor: const Color(0xfff59e0b),
                                    icon: Icons.warning_amber_rounded,
                                  ),

                                  const Divider(thickness: 1,height: 1.5,),
                                  _smartInsightsCard(
                                    title: "MISSING PUNCH OUTS",
                                    value:
                                    missingpunchOut == null
                                        ? "-" :
                                    "${missingpunchOut} employees have not punched out yet today. Check shifts and logs.",
                                    iconColor: const Color(0xff8b5cf6),
                                    iconAsset: "assets/svg_files/punchOut.svg",
                                  ),

                                  const Divider(thickness: 1,height: 1.5,),

                                  _smartInsightsCard(
                                    title: "MONTHLY PERFORMANCE",
                                    value: "Average attendance for $monthName is $monthPercent%.",
                                    icon: Icons.bar_chart_rounded,
                                    iconColor: const Color(0xff27AE60),
                                  ),
                                  if (holidays.isNotEmpty)
                                    const Divider(thickness: 1,height: 1.5,),
                                  if (holidays.isNotEmpty)
                                    _smartInsightsCard(
                                      title: "UPCOMING HOLIDAYS",
                                      value: "Next holiday is ${leaveName} in ${daysLeft} days.",
                                      icon: Icons.calendar_today_outlined,
                                      iconColor: const Color(0xff2878F0),
                                    ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 10,),

                    /// Planning calendar
                    if (AppClient.isAnusamm)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xffE4E7EC),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                14,
                                12,
                                14,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Planner Calendar",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff172B4D),
                                          ),
                                        ),

                                        SizedBox(height: 10),

                                        Text(
                                          "Meetings, tasks & events",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff98A2B3),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    _calendarHeaderTitle(),
                                                    // maxLines: 1,
                                                    // overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w700,
                                                      color: Color(0xff172B4D),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(width: 6),

                                              Container(
                                                padding: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xffF2F4F7),
                                                  borderRadius: BorderRadius.circular(18),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    _calendarViewButton("month"),
                                                    _calendarViewButton("week"),
                                                    _calendarViewButton("day"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        if (_calendarView == "month") {
                                          _calendarMonth = DateTime(
                                            _calendarMonth.year,
                                            _calendarMonth.month - 1,
                                            1,
                                          );
                                        } else if (_calendarView == "week") {
                                          _calendarMonth = _calendarMonth.subtract(
                                            const Duration(days: 7),
                                          );
                                        } else {
                                          _calendarMonth = _calendarMonth.subtract(
                                            const Duration(days: 1),
                                          );
                                        }

                                        _updateCalendarDateRange();
                                      });

                                      if (AppClient.isAnusamm) {
                                        await hrDashboardController.getPlanningCalendar_List();
                                      }                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.chevron_left_rounded,
                                        size: 18,
                                        color: Color(0xff667085),
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        final now = DateTime.now();

                                        _calendarMonth = DateTime(
                                          now.year,
                                          now.month,
                                          1,
                                        );

                                        _updateCalendarDateRange();
                                      });

                                      if (AppClient.isAnusamm) {
                                        await hrDashboardController.getPlanningCalendar_List();
                                      }                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEEF4FF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        "Today",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff155EEF),
                                        ),
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        if (_calendarView == "month") {
                                          _calendarMonth = DateTime(
                                            _calendarMonth.year,
                                            _calendarMonth.month + 1,
                                            1,
                                          );
                                        } else if (_calendarView == "week") {
                                          _calendarMonth = _calendarMonth.add(
                                            const Duration(days: 7),
                                          );
                                        } else {
                                          _calendarMonth = _calendarMonth.add(
                                            const Duration(days: 1),
                                          );
                                        }

                                        _updateCalendarDateRange();
                                      });

                                      if (AppClient.isAnusamm) {
                                        await hrDashboardController.getPlanningCalendar_List();
                                      }                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.chevron_right_rounded,
                                        size: 18,
                                        color: Color(0xff667085),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 6),

                                ],
                              ),
                            ),

                            const Divider(
                              height: 1,
                              color: Color(0xffEAECF0),
                            ),

                            if (_calendarView == "month")
                              Obx(() {
                                final meetings =
                                hrDashboardController.hrPlanningCalenList.toList();

                                return Column(
                                  children: [
                                    _buildMonthCalendar(meetings),

                                    const Divider(
                                      height: 1,
                                      color: Color(0xffEAECF0),
                                    ),

                                    _buildUpcomingMeetings(meetings),
                                  ],
                                );
                              }),

                            if (_calendarView == "week")
                              Obx(() {
                                final meetings = hrDashboardController.hrPlanningCalenList.toList(); // 👈 sync read here
                                return _buildWeekCalendar(meetings);
                              }),


                            if (_calendarView == "day")
                              Obx(() {
                                final meetings = hrDashboardController.hrPlanningCalenList.toList(); // 👈 sync read here
                                return _buildDayCalendar(meetings);
                              }),

                          ],
                        ),
                      ),
                    const SizedBox(height: 10,),

                    SizedBox(height: 100,)
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildUpcomingMeetings(
      List<PlanningCalendar> meetings,
      ) {
    final DateTime today = DateTime.now();

    final DateTime todayOnly = DateTime(
      today.year,
      today.month,
      today.day,
    );

    // Get today's and future meetings
    final List<PlanningCalendar> upcoming =
    meetings.where((meeting) {
      final String dateString =
          meeting.meetingDate?.toString().trim() ?? '';

      if (dateString.isEmpty) {
        return false;
      }

      final DateTime? meetingDate =
      DateTime.tryParse(dateString);

      if (meetingDate == null) {
        return false;
      }

      final DateTime dateOnly = DateTime(
        meetingDate.year,
        meetingDate.month,
        meetingDate.day,
      );

      return !dateOnly.isBefore(todayOnly);
    }).toList();

    // Sort by meeting date
    upcoming.sort((a, b) {
      final DateTime? dateA = DateTime.tryParse(
        a.meetingDate?.toString().trim() ?? '',
      );

      final DateTime? dateB = DateTime.tryParse(
        b.meetingDate?.toString().trim() ?? '',
      );

      if (dateA == null && dateB == null) {
        return 0;
      }

      if (dateA == null) {
        return 1;
      }

      if (dateB == null) {
        return -1;
      }

      return dateA.compareTo(dateB);
    });

    // Show only first 3 upcoming meetings
    final List<PlanningCalendar> visibleMeetings =
    upcoming.take(3).toList();

    // No upcoming meetings
    if (visibleMeetings.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
          10,
          8,
          10,
          10,
        ),
        child: Row(
          children: [
            const Text(
              "UPCOMING",
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w800,
                color: Color(0xff98A2B3),
                letterSpacing: .4,
              ),
            ),

            const SizedBox(width: 8),

            const Text(
              "No upcoming meetings",
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Color(0xff98A2B3),
              ),
            ),
          ],
        ),
      );
    }

    // Upcoming meetings
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        10,
        8,
        10,
        10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "UPCOMING",
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: Color(0xff98A2B3),
              letterSpacing: .4,
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: visibleMeetings.map((meeting) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 6,
                    ),
                    child: _upcomingMeetingChip(
                      meeting: meeting,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _upcomingMeetingChip({
    required PlanningCalendar meeting,
  }) {
    final String title =
        meeting.meetingTitle?.toString().trim() ?? '';

    final String displayTitle =
    title.isEmpty ? "Meeting" : title;

    final String status =
        meeting.meetingStatus?.toString().trim() ?? '';

    final bool isCancelled =
        status.toUpperCase() == "CANCELLED";

    return InkWell(
      onTap: () {
        final DateTime? meetingDate = DateTime.tryParse(
          meeting.meetingDate?.toString().trim() ?? '',
        );

        if (meetingDate == null) return;

        _showPlanningCalendarPopup(
          meetingDate,
          [meeting],
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 145,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffEEF2FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xffDDE3FF),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color:  const Color(0xff4F46E5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(width: 5),

            Flexible(
              child: Text(
                displayTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff4F46E5),
                  decoration: isCancelled
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateCalendarDateRange() {
    final DateTime selectedMonth = DateTime(
      _calendarMonth.year,
      _calendarMonth.month,
      1,
    );

    // Previous month - first day
    final DateTime fromDate = DateTime(
      selectedMonth.year,
      selectedMonth.month - 1,
      1,
    );

    // Next month - last day
    final DateTime toDate = DateTime(
      selectedMonth.year,
      selectedMonth.month + 2,
      0,
    );

    hrDashboardController.calendarFromDateController.text =
        DateFormat('yyyy-MM-dd').format(fromDate);

    hrDashboardController.calendarToDateController.text =
        DateFormat('yyyy-MM-dd').format(toDate);
  }

  String _formatWeekRange(
      DateTime start,
      DateTime end,
      ) {
    final String startMonth = _monthName(start.month);
    final String endMonth = _monthName(end.month);

    // Same month
    if (start.year == end.year &&
        start.month == end.month) {
      return "${start.day} $startMonth – "
          "${end.day}, ${end.year}";
    }

    // Different months, same year
    if (start.year == end.year) {
      return "${start.day} $startMonth – "
          "${end.day} $endMonth, ${end.year}";
    }

    // Different years
    return "${start.day} $startMonth ${start.year} – "
        "${end.day} $endMonth ${end.year}";
  }












  String _calendarView = "month";








  String getAttendanceTitle(String title) {
    final fromText = hrDashboardController.entryFromDate.text.trim();
    final toText = hrDashboardController.entryToDate.text.trim();

    final todayStr = DateTime.now().toString().substring(0, 10); // yyyy-MM-dd

    if (fromText.isEmpty || toText.isEmpty) {
      return title == "Punch Overview" ? "Today's ${title}" :"${title} (Today)";
    }

    if (fromText == todayStr && toText == todayStr) {
      return title == "Punch Overview" ? "Today's ${title}" :"${title} (Today)";
    }

    final displayFrom = DateFormat('dd MMM yyyy').format(DateTime.parse(fromText));
    final displayTo = DateFormat('dd MMM yyyy').format(DateTime.parse(toText));

    return "${title} ($displayFrom - $displayTo)";
  }

  Widget _compactDateField({
    required String title,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 130,
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xffF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xffE4E7EC),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: Color(0xff667085),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xff667085),
                    ),
                  ),
                  Text(
                    controller.text.isEmpty
                        ? "Select date"
                        : controller.text,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff101828),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<LabourCardModel> get hrCards {
    final data = hrDashboardController.hrCategoryList.value;
    return [
      LabourCardModel(
        title: "TOTAL EMPLOYEES",
        value: "${data?.activeEmployee ?? 0}",
        subtitle: "Active Employees",
        icon: Icons.groups_outlined,
        color: Color(0xFF2563EB),
      ),

      LabourCardModel(
        title: "PRESENT TODAY",
        value: "${data?.totalPresentEmployee ?? 0}",
        subtitle:"${data?.presentPercentage ?? 0.0} of Total",
        icon: Icons.verified_user_sharp,
        color: Color(0xFF0F9D8A),
      ),

      LabourCardModel(
        title: "ON LEAVE TODAY",
        value: "${data?.onLeaveEmployee ?? 0}",
        subtitle: "${data?.onLeavePercentage ?? 0.0} of Total",
        icon: Icons.calendar_today_outlined,
        color: Color(0xFFD97706),
      ),

      LabourCardModel(
        title: "LATE PUNCH IN",
        value: "${data?.latePunchinEmployee ?? 0}",
        subtitle: "${data?.latePunchInPercentage ?? 0} of Total",
        icon: Icons.access_time,
        color: Color(0xFFE11D48),
      ),

      LabourCardModel(
        title: "ON TIME PUNCH IN",
        value: "${data?.onTimePunchinEmployee ?? 0}",
        subtitle: "${data?.onTimePunchinPercentage ?? 0} of Total",
        icon: Icons.login_rounded,
        color: Color(0xFF0F9D8A),

      ),

      LabourCardModel(
        title: "ON ABSENT",
        value: "${data?.absentEmployee ?? 0}",
        subtitle: "${data?.absentPercentage ?? 0} of Total",
        icon: Icons.warning_amber_rounded,
        color: Color(0xFFD97706),
      ),
    ];
  }

  void _showEmployeeListDialog(
      BuildContext context, {
        required String title,
        required List<Employee> employees,
        required IconData icon,
        required Color color,
      }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: SizedBox(
            width: 650,
            height: 450,
            child: EmployeeListDialog(
              title: title,
              employees: employees,
              icon: icon,
              color: color,
            ),
          ),
        );
      },
    );
  }

  Widget _attendanceSummaryItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required int value,
    required double percentage,
    required Color percentageColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffEAECF0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 14,
                  color: iconColor,
                ),
              ),

              const Spacer(),

              Text(
                "${percentage.toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: percentageColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),

          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xff98A2B3),
            ),
          ),

          const SizedBox(height: 2),

          Text(
            "$value",
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Color(0xff172B4D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _leaveSummaryItem({
    required String title,
    required int value,
    required double percentage,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: 8,
        ),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: color,
              width: 5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff667085),
              ),
            ),

            const SizedBox(height: 2),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$value Days",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff172B4D),
                    ),
                  ),
                  TextSpan(
                    text:
                    " (${percentage.toStringAsFixed(1)}%)",
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff98A2B3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leaveOverviewCard({
    required String title,
    required String value,
    IconData? icon,
    required Color iconColor,
    required Color iconBackground,
    String? iconAsset,
  }) {
    return Container(
      height: 105,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: iconColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: iconAsset != null && iconAsset!.isNotEmpty
                    ? Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: SvgPicture.asset(
                      iconAsset!,
                      fit: BoxFit.fill,
                      color: Colors.white,
                    ),
                  ),
                )
                    : Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Center(
            child: Text(
              value == "null" ? "0" : value,
              style: TextStyle(
                fontSize: 20,
                height: 1,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _smartInsightsCard({
    required String title,
    required String value,
    IconData? icon,
    required Color iconColor,
    String? iconAsset,
  }) {
    return Row(
      children: [
        // Left accent bar
        Container(
          width: 4,
          height: 45,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),

        // Icon circle
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(.12),
            shape: BoxShape.circle,
          ),
          child: iconAsset != null && iconAsset!.isNotEmpty
              ? Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: SvgPicture.asset(
                iconAsset!,
                fit: BoxFit.fill,
                color: iconColor,
              ),
            ),
          )
              : Icon(
            icon,
            size: 16,
            color: iconColor,
          ),
        ),
        const SizedBox(width: 10),

        // Title + value
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value ?? "-",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
        // const SizedBox(width: 10),
      ],
    );
  }

  List<PendingApprovalModel> get pendingApprovalList {
    final data = hrDashboardController.hrPendingLeaveList.value;

    return [
      PendingApprovalModel(
        title: "LEAVE REQUESTS",
        count: data?.pendingLeaveRequest ?? 0,
        color: const Color(0xFF2563EB),
        icon: Icons.description_outlined,
      ),

      PendingApprovalModel(
        title: "PERMISSION REQUESTS",
        count: data?.pendingPermissionRequest ?? 0,
        color: const Color(0xFF7C3AED),
        icon: Icons.access_time_rounded,
      ),

      PendingApprovalModel(
        title: "ON DUTY REQUESTS",
        count: data?.pendingOnDutyLeaveRequest ?? 0,
        color: const Color(0xFFF59E0B),
        icon: Icons.receipt_long_outlined,
      ),

      PendingApprovalModel(
        title: "COMPENSATE LEAVES",
        count: data?.pendingCompensateLeaveRequest ?? 0,
        color: const Color(0xFF10B981),
        icon: Icons.attach_money_outlined,
      ),

    ];
  }

  Widget _dashboardHolidayItem({
    required UpcomingHoliday holiday,
    required bool isLast,
  }) {
    final String holidayName =
        holiday.holidayRemarks ?? '';

    final String holidayDate =
        holiday.dateValue ?? '';

    final int daysLeft =
        holiday.remainingDays ?? 0;

    return Container(
      margin: EdgeInsets.only(
        bottom: isLast ? 0 : 10,
      ),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xffE8ECEF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        child: Row(
          children: [

            Container(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff64D0BA),
                    Color(0xff52B8E9),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    _getHolidayDay(holidayDate),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _getHolidayMonth(holidayDate),
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 11),

            Expanded(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    holidayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff172B4D),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 14,
                        color: Color(0xff98A2B3),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          BaseUtitiles.dateformat(
                            holidayDate,
                          ),
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff98A2B3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffE8F6F2),
                borderRadius:
                BorderRadius.circular(20),
              ),
              child: Text(
                "$daysLeft days",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff258B7C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getHolidayDay(String date) {
    if (date.isEmpty) return '';

    try {
      final parsedDate = DateTime.tryParse(date);

      if (parsedDate != null) {
        return parsedDate.day
            .toString()
            .padLeft(2, '0');
      }

      final parts = date.split(RegExp(r'[-/]'));

      if (parts.length >= 3) {
        if (parts[0].length <= 2) {
          return parts[0].padLeft(2, '0');
        }

        return parts[2].padLeft(2, '0');
      }
    } catch (_) {}

    return date;
  }

  String _getHolidayMonth(String date) {
    if (date.isEmpty) return '';

    try {
      final parsedDate = DateTime.tryParse(date);

      if (parsedDate != null) {
        return _monthName(parsedDate.month);
      }

      final parts = date.split(RegExp(r'[-/]'));

      if (parts.length >= 3) {
        int? month;

        if (parts[0].length <= 2) {
          month = int.tryParse(parts[1]);
        } else {
          month = int.tryParse(parts[1]);
        }

        if (month != null &&
            month >= 1 &&
            month <= 12) {
          return _monthName(month);
        }
      }
    } catch (_) {}

    return '';
  }

  String _monthName(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];

    return months[month - 1];
  }

  DateTime _calendarMonth = DateTime.now();


  Color _meetingStatusColor(String status) {
    switch (status.toLowerCase().trim()) {
      case "completed":
        return const Color(0xff12B76A);

      case "cancelled":
        return const Color(0xffF04438);

      case "in progress":
        return const Color(0xff2E90FA);

      case "planned":
      default:
        return const Color(0xfff59e0b);
    }
  }



  String _monthShort(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    return months[month - 1];
  }

  void _showEditPlanningBottomSheet({
    required PlanningCalendar meeting,
  }) {
    final TextEditingController titleController =
    TextEditingController(
      text: meeting.meetingTitle ?? "",
    );

    final TextEditingController descriptionController =
    TextEditingController(
      text: meeting.meetingDescription ?? "",
    );

    String selectedStatus =
    (meeting.meetingStatus ?? "Planned").trim();

    DateTime selectedDate =
        meeting.meetingDate ?? DateTime.now();

    String selectedTime =
    _formatMeetingTimeForEdit(
      meeting.meetingTime,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(.50),
      useSafeArea: true,
      builder: (bottomContext) {
        return SafeArea(
          top: false,
          child: StatefulBuilder(
            builder: (context, setBottomSheetState) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom,
                ),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight:
                    MediaQuery.of(context).size.height * .58,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    ),
                  ),
                  child: Stack(
                    children: [

                      Positioned(
                        left: 0,
                        top: 20,
                        bottom: 20,
                        child: Container(
                          width: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xff4F46E5),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 16,
                        right: 16,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(bottomContext);
                          },
                          borderRadius:
                          BorderRadius.circular(8),
                          child: Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                              const Color(0xffF8FAFC),
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 18,
                              color: Color(0xff667085),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          30,
                          26,
                          24,
                          20,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  // DATE BOX
                                  Container(
                                    width: 50,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color:
                                      const Color(0xffEEF2FF),
                                      borderRadius:
                                      BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [

                                        Text(
                                          _monthShort(
                                            selectedDate.month,
                                          ).toUpperCase(),
                                          style:
                                          const TextStyle(
                                            fontSize: 9,
                                            fontWeight:
                                            FontWeight.w800,
                                            color:
                                            Color(0xff4F46E5),
                                          ),
                                        ),

                                        const SizedBox(height: 2),

                                        Text(
                                          "${selectedDate.day}",
                                          style:
                                          const TextStyle(
                                            fontSize: 25,
                                            height: 1,
                                            fontWeight:
                                            FontWeight.w800,
                                            color:
                                            Color(0xff4F46E5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 14),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: const [

                                            Icon(
                                              Icons.videocam_rounded,
                                              size: 13,
                                              color:
                                              Color(0xff4F46E5),
                                            ),

                                            SizedBox(width: 5),

                                            Text(
                                              "MEETING",
                                              style: TextStyle(
                                                fontSize: 9,
                                                fontWeight:
                                                FontWeight.w800,
                                                letterSpacing: .5,
                                                color:
                                                Color(0xff4F46E5),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 5),

                                        Text(
                                          meeting.meetingTitle ??
                                              "Meeting",
                                          maxLines: 2,
                                          overflow:
                                          TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            height: 1.1,
                                            fontWeight:
                                            FontWeight.w500,
                                            color:
                                            Color(0xff292D32),
                                          ),
                                        ),

                                        const SizedBox(height: 7),

                                        Text(
                                          "${_weekDayName(selectedDate.weekday)}"
                                              " · "
                                              "${_formatMeetingTime(selectedTime)}",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight:
                                            FontWeight.w600,
                                            color:
                                            Color(0xff98A2B3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              Row(
                                children: [

                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration:
                                    const BoxDecoration(
                                      color:
                                      Color(0xff98A2B3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),

                                  Expanded(
                                    child: CustomPaint(
                                      painter:
                                      _DashedLinePainter(),
                                      child: const SizedBox(
                                        height: 1,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration:
                                    const BoxDecoration(
                                      color:
                                      Color(0xff98A2B3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              _editFieldLabel(
                                "Title",
                                required: true,
                              ),

                              const SizedBox(height: 5),

                              _editTextField(
                                controller: titleController,
                                hintText: "Enter meeting title",
                              ),

                              const SizedBox(height: 10),

                              Row(
                                children: [

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [

                                        _editFieldLabel(
                                          "Date",
                                          required: true,
                                        ),

                                        const SizedBox(height: 5),

                                        InkWell(
                                          onTap: () async {
                                            final DateTime? picked = await showDatePicker(
                                              context: context,
                                              initialDate: selectedDate,
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime(2100),
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context).copyWith(
                                                    colorScheme: ColorScheme.light(
                                                      primary: Theme.of(context).primaryColor,
                                                      onPrimary: Colors.white,
                                                      surface: Colors.white,
                                                      onSurface: const Color(0xff172B4D),
                                                    ),
                                                    datePickerTheme: DatePickerThemeData(
                                                      backgroundColor: Colors.white,
                                                      headerBackgroundColor:
                                                      Theme.of(context).primaryColor,
                                                      headerForegroundColor: Colors.white,

                                                      todayBorder: BorderSide(
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );

                                            if (picked != null) {
                                              setBottomSheetState(() {
                                                selectedDate = picked;
                                              });
                                            }
                                          },
                                          child: _dateTimeBox(
                                            text:
                                            _formatDisplayDate(
                                              selectedDate,
                                            ),
                                            icon:
                                            Icons
                                                .calendar_today_outlined,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [

                                        _editFieldLabel(
                                          "Time",
                                        ),

                                        const SizedBox(height: 5),

                                        InkWell(
                                          onTap: () async {
                                            final TimeOfDay?
                                            picked =
                                            await showTimePicker(
                                              context: context,
                                              initialTime:
                                              _parseTime(
                                                selectedTime,
                                              ),
                                            );

                                            if (picked != null) {
                                              setBottomSheetState(() {
                                                selectedTime =
                                                    picked.format(
                                                      context,
                                                    );
                                              });
                                            }
                                          },
                                          child: _dateTimeBox(
                                            text:
                                            selectedTime,
                                            icon:
                                            Icons
                                                .access_time_rounded,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              _editFieldLabel(
                                "Status",
                                required: true,
                              ),

                              const SizedBox(height: 5),

                              DropdownButtonFormField<String>(
                                value: selectedStatus.isEmpty
                                    ? "Planned"
                                    : selectedStatus,
                                decoration:
                                _editInputDecoration(),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xff98A2B3),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: "Planned",
                                    child: Text("Planned",style: TextStyle(fontSize: 13),),
                                  ),
                                  DropdownMenuItem(
                                    value: "In Progress",
                                    child: Text("In Progress",style: TextStyle(fontSize: 13)),
                                  ),
                                  DropdownMenuItem(
                                    value: "Completed",
                                    child: Text("Completed",style: TextStyle(fontSize: 13)),
                                  ),
                                  DropdownMenuItem(
                                    value: "Cancelled",
                                    child: Text("Cancelled",style: TextStyle(fontSize: 13)),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    setBottomSheetState(() {
                                      selectedStatus = value;
                                    });
                                  }
                                },
                              ),

                              const SizedBox(height: 10),

                              _editFieldLabel("Description"),

                              const SizedBox(height: 5),

                              TextFormField(
                                controller:
                                descriptionController,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff344054),
                                ),
                                decoration:
                                _editInputDecoration(
                                  hintText:
                                  "Enter description",
                                ),
                              ),

                              const SizedBox(height: 10),

                              Row(
                                children: [

                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          bottomContext,
                                        );
                                      },
                                      style:
                                      OutlinedButton.styleFrom(
                                        minimumSize:
                                        const Size(
                                          double.infinity,
                                          35,
                                        ),
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                            24,
                                          ),
                                        ),
                                        side:
                                        const BorderSide(
                                          color:
                                          Color(0xffD0D5DD),
                                        ),
                                      ),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.w700,
                                          color:
                                          Color(0xff667085),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final bool success =
                                        await hrDashboardController.UpdateButton_PlannerCalendar(
                                          context,
                                          id: meeting.id ?? 0,
                                          meetingTitle: titleController.text.trim(),
                                          meetingDate: _formatApiDate(selectedDate),
                                          meetingDescription:
                                          descriptionController.text.trim(),
                                          meetingTime: _formatTimeForApi(selectedTime),
                                          meetingStatus: selectedStatus,
                                          assignedBy: meeting.assignedBy ?? 0,
                                          createdDate:
                                          meeting.createdDate ?? "",
                                          createdBy: meeting.createdBy ?? 0,
                                          active: meeting.active ?? "Y",
                                        );

                                        if (!success) {
                                          return;
                                        }

                                        // ⭐ UPDATE THE EXISTING CALENDAR ITEM IMMEDIATELY
                                        final int index =
                                        hrDashboardController.hrPlanningCalenList.indexWhere(
                                              (item) => item.id == meeting.id,
                                        );

                                        if (index != -1) {
                                          final oldMeeting =
                                          hrDashboardController.hrPlanningCalenList[index];

                                          oldMeeting.meetingTitle =
                                              titleController.text.trim();

                                          oldMeeting.meetingDescription =
                                              descriptionController.text.trim();

                                          oldMeeting.meetingTime =
                                              _formatTimeForApi(selectedTime);

                                          oldMeeting.meetingStatus =
                                              selectedStatus;

                                          oldMeeting.meetingDate =
                                              selectedDate;

                                          hrDashboardController.hrPlanningCalenList.refresh();
                                        }

                                        // Close bottom sheet
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      // onPressed: () async {
                                      //   final String date = _formatApiDate(selectedDate);
                                      //
                                      //   await hrDashboardController.UpdateButton_PlannerCalendar(
                                      //     context,
                                      //     id: meeting.id ?? 0,
                                      //     meetingTitle: titleController.text.trim(),
                                      //     meetingDate: date,
                                      //     meetingDescription:
                                      //     descriptionController.text.trim(),
                                      //     meetingTime: _formatTimeForApi(selectedTime),
                                      //     meetingStatus: selectedStatus,
                                      //     assignedBy: meeting.assignedBy ?? 0,
                                      //     createdDate: meeting.createdDate != null
                                      //         ? meeting.createdDate!
                                      //         : DateTime.now().toString(),
                                      //     createdBy: meeting.createdBy ?? 0,
                                      //     active: meeting.active ?? "Y",
                                      //   );
                                      //
                                      //   if (context.mounted) {
                                      //     Navigator.pop(context);
                                      //   }
                                      // },
                                      style:
                                      ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                        Theme.of(context).primaryColor,
                                        minimumSize:
                                        const Size(
                                          double.infinity,
                                          35,
                                        ),
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                            24,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Save changes",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    ).whenComplete(() {
      titleController.dispose();
      descriptionController.dispose();
    });
  }

  String _formatTimeForApi(String time) {
    try {
      final parsed =
      DateFormat("hh:mm a").parse(time);

      return DateFormat("HH:mm:ss").format(parsed);
    } catch (_) {
      return time;
    }
  }

  String _formatDisplayDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";
  }

  String _formatApiDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  Widget _editFieldLabel(
      String text, {
        bool required = false,
      }) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xff344054),
        ),
        children: [
          if (required)
            const TextSpan(
              text: " *",
              style: TextStyle(
                color: Color(0xffEF4444),
              ),
            ),
        ],
      ),
    );
  }

  Widget _editTextField({
    required TextEditingController controller,
    String? hintText,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        fontSize: 13,
        color: Color(0xff344054),
      ),
      decoration: _editInputDecoration(
        hintText: hintText,
      ),
    );
  }

  InputDecoration _editInputDecoration({
    String? hintText,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 12,
        color: Color(0xff98A2B3),
      ),

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: Color(0xffD0D5DD),
          width: 1,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: Color(0xffD0D5DD),
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: Color(0xff4F46E5),
          width: 1,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: Color(0xffEF4444),
          width: 1,
        ),
      ),
    );
  }

  Widget _dateTimeBox({
    required String text,
    required IconData icon,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xffD0D5DD),
        ),
      ),
      child: Row(
        children: [

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff344054),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Icon(
            icon,
            size: 18,
            color: const Color(0xff98A2B3),
          ),
        ],
      ),
    );
  }


  String _formatMeetingTimeForEdit(
      String? time,
      ) {
    if (time == null || time.trim().isEmpty) {
      return "12:00 AM";
    }

    try {
      final parts = time.split(":");

      final int hour = int.parse(parts[0]);
      final int minute = int.parse(parts[1]);

      final TimeOfDay timeOfDay = TimeOfDay(
        hour: hour,
        minute: minute,
      );

      final int displayHour =
      timeOfDay.hourOfPeriod == 0
          ? 12
          : timeOfDay.hourOfPeriod;

      final String period =
      timeOfDay.period == DayPeriod.am
          ? "AM"
          : "PM";

      return "$displayHour:"
          "${minute.toString().padLeft(2, '0')} "
          "$period";
    } catch (_) {
      return time;
    }
  }

  TimeOfDay _parseTime(String time) {
    try {
      final parts = time.split(" ");
      final hm = parts[0].split(":");

      int hour = int.parse(hm[0]);
      final int minute = int.parse(hm[1]);

      if (parts.length > 1) {
        final period = parts[1].toUpperCase();

        if (period == "PM" && hour != 12) {
          hour += 12;
        }

        if (period == "AM" && hour == 12) {
          hour = 0;
        }
      }

      return TimeOfDay(
        hour: hour,
        minute: minute,
      );
    } catch (_) {
      return const TimeOfDay(
        hour: 12,
        minute: 0,
      );
    }
  }









  /// -------- Planning calendar ----------

  String _calendarHeaderTitle() {
    if (_calendarView == "month") {
      return "${_monthName(_calendarMonth.month)} "
          "${_calendarMonth.year}";
    }

    if (_calendarView == "week") {
      final DateTime start = _startOfWeek(_calendarMonth);
      final DateTime end = start.add(
        const Duration(days: 6),
      );

      return _formatWeekRange(start, end);
    }

    return "${_calendarMonth.day} "
        "${_monthName(_calendarMonth.month)} "
        "${_calendarMonth.year}";
  }

  Widget _calendarViewButton(String title) {
    final bool selected =
        _calendarView == title;

    return InkWell(
      onTap: () {
        setState(() {
          _calendarView = title;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: selected
              ? Colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: selected
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: selected
                ? const Color(0xff155EEF)
                : const Color(0xff667085),
          ),
        ),
      ),
    );
  }

  List<PlanningCalendar> _getMeetingsForDate(
      DateTime date,List<PlanningCalendar> meetingsList,
      ) {
    return meetingsList.where((meeting) {
      final meetingDate = meeting.meetingDate;
      if (meetingDate == null) return false;
      return meetingDate.year == date.year &&
          meetingDate.month == date.month &&
          meetingDate.day == date.day;
    }).toList();
  }

  Widget _meetingEventPill(
      PlanningCalendar meeting,
      ) {

    return Container(
      height: 15,
      margin:
      const EdgeInsets.only(
        bottom: 2,
      ),
      padding:
      const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: Color(0xffEEF2FF),
        borderRadius:
        BorderRadius.circular(4),
      ),
      alignment:
      Alignment.centerLeft,
      child: Text(
        meeting.meetingTitle ?? "",
        maxLines: 1,
        overflow:
        TextOverflow.ellipsis,
        style: TextStyle(
          color: const Color(0xff4F46E5),

          decoration: (meeting.meetingStatus ?? "")
              .trim()
              .toUpperCase() ==
              "CANCELLED"
              ? TextDecoration.lineThrough
              : TextDecoration.none,

          decorationColor: const Color(0xff4F46E5),
          decorationThickness: 1.5,
          fontSize: 7,
          fontWeight:
          FontWeight.w600,
          // color: textColor,
        ),
      ),
    );
  }

  Widget _calendarDayCell({
    required DateTime date,
    required bool isCurrentMonth,
    required bool isToday,
    required List<PlanningCalendar> meetings,
  }) {
    return GestureDetector(
      onTap: meetings.isEmpty
          ? null
          : () {
        _showPlanningCalendarPopup(
          date,
          meetings,
        );
      },

      child: Container(
        decoration: BoxDecoration(
          color: isToday
              ? const Color(0xffF1F6FF)
              : Colors.white,
          borderRadius:
          BorderRadius.circular(7),
          border: Border.all(
            color: isToday
                ? const Color(0xffB8D3FF)
                : const Color(0xffE4E7EC),
            width: 1,
          ),
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
              const EdgeInsets.only(
                top: 4,
                right: 5,
                bottom: 2,
              ),
              child: Align(
                alignment:
                Alignment.topRight,
                child: Text(
                  "${date.day}",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight:
                    FontWeight.w700,
                    color: isCurrentMonth
                        ? isToday
                        ? const Color(
                      0xff155EEF,
                    )
                        : const Color(
                      0xff344054,
                    )
                        : const Color(
                      0xffBFC5CD,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                child: ClipRect(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (meetings.isNotEmpty)
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          height: 10,
                          child: _meetingEventPill(
                            meetings.first,
                          ),
                        ),

                      if (meetings.length > 1)
                        Positioned(
                          left: 2,
                          right: 0,
                          bottom: 0,
                          height: 8,
                          child: Text(
                            "+${meetings.length - 1} more",
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontSize: 6,
                              height: 1,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff155EEF),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Planning calendar popup

  void _showPlanningCalendarPopup(
      DateTime date,
      List<PlanningCalendar> meetings,
      ) {
    // Do not show popup if there are no meetings
    if (meetings.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.50),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 24,
          ),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              maxHeight: 560,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 20,
                  bottom: 20,
                  child: Container(
                    width: 9,
                    decoration: const BoxDecoration(
                      color: Color(0xff4F46E5),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),

                // Positioned(
                //   top: 14,
                //   right: 14,
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.pop(dialogContext);
                //     },
                //     borderRadius: BorderRadius.circular(8),
                //     child: Container(
                //       width: 32,
                //       height: 32,
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         color: const Color(0xffF8FAFC),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: const Icon(
                //         Icons.close_rounded,
                //         size: 20,
                //         color: Color(0xff667085),
                //       ),
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    30,
                    24,
                    24,
                    20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        ...List.generate(
                          meetings.length,
                              (index) {
                            final PlanningCalendar meeting =
                            meetings[index];

                            return Column(
                              children: [

                                _planningMeetingItem(
                                  meeting: meeting,
                                  date: date,
                                ),

                                if (index < meetings.length - 1)
                                  const Padding(
                                    padding:
                                    EdgeInsets.symmetric(
                                      vertical: 18,
                                    ),
                                    child: Divider(
                                      height: 1,
                                      color: Color(0xffEAECF0),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _planningMeetingItem({
    required PlanningCalendar meeting,
    required DateTime date,
  }) {
    final String status =
    (meeting.meetingStatus ?? "")
        .trim();

    final Color statusColor =
    _meetingStatusColor(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // DATE BOX
            Container(
              width: 48,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xffEEF2FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    _monthShort(date.month).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff6366F1),
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    "${date.day}",
                    style: const TextStyle(
                      fontSize: 26,
                      height: 1,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff4F46E5),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // MEETING DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  // MEETING LABEL
                  Row(
                    children: [
                      const Icon(
                        Icons.videocam_rounded,
                        size: 13,
                        color: Color(0xff4F46E5),
                      ),

                      const SizedBox(width: 5),

                      const Text(
                        "MEETING",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .5,
                          color: Color(0xff4F46E5),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  // TITLE
                  Text(
                    meeting.meetingTitle ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.1,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff292D32),
                    ),
                  ),

                  const SizedBox(height: 7),

                  // DATE + TIME
                  Text(
                    "${_weekDayName(date.weekday)}"
                        " · "
                        "${_formatMeetingTime(meeting.meetingTime)}",
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff98A2B3),
                    ),
                  ),
                ],
              ),
            ),
          ],

        ),

        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: statusColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              status.isEmpty
                  ? "PLANNED"
                  : status.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: .5,
                color: statusColor,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Icon(
              Icons.format_align_left_rounded,
              size: 16,
              color: Color(0xffB0B8C4),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                (meeting.meetingDescription ?? "")
                    .trim()
                    .isEmpty
                    ? "No description"
                    : meeting.meetingDescription!.trim(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff667085),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Close",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff667085),
                ),
              ),
            ),

            const SizedBox(width: 12),

            ElevatedButton.icon(
              onPressed: () async {
                // Close the details dialog first
                Navigator.of(context).pop();

                // Wait until the dialog is removed from the navigator
                await Future<void>.delayed(Duration.zero);

                // Open bottom sheet immediately
                if (!mounted) return;

                _showEditPlanningBottomSheet(
                  meeting: meeting,
                );
              },
              icon: const Icon(
                Icons.edit_rounded,
                size: 14,
              ),
              label: const Text(
                "Update",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4F46E5),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthCalendar(List<PlanningCalendar> meetingsList) {
    final DateTime firstDay = DateTime(
      _calendarMonth.year,
      _calendarMonth.month,
      1,
    );

    final int startingWeekday =
        firstDay.weekday % 7;

    final int daysInMonth = DateTime(
      _calendarMonth.year,
      _calendarMonth.month + 1,
      0,
    ).day;

    final int totalCells =
        ((startingWeekday + daysInMonth) / 7).ceil() * 7;

    final List<String> weekDays = [
      "SUN",
      "MON",
      "TUE",
      "WED",
      "THU",
      "FRI",
      "SAT",
    ];

    return GestureDetector(
      onHorizontalDragEnd: (details) async {
        // Ignore tiny/accidental drags
        final double velocity = details.primaryVelocity ?? 0;
        if (velocity.abs() < 100) return;

        setState(() {
          if (velocity < 0) {
            // Swiped left -> next month
            _calendarMonth = DateTime(
              _calendarMonth.year,
              _calendarMonth.month + 1,
              1,
            );
          } else {
            // Swiped right -> previous month
            _calendarMonth = DateTime(
              _calendarMonth.year,
              _calendarMonth.month - 1,
              1,
            );
          }
          _updateCalendarDateRange();
        });

        if (AppClient.isAnusamm) {
          await hrDashboardController.getPlanningCalendar_List();
        }      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: weekDays.map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 7),

            GridView.builder(
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: totalCells,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 1.12,
              ),

              itemBuilder: (context, index) {
                final int dayNumber =
                    index - startingWeekday + 1;

                DateTime date;

                // Previous month
                if (dayNumber < 1) {
                  final previousMonth = DateTime(
                    _calendarMonth.year,
                    _calendarMonth.month,
                    0,
                  );

                  final int previousMonthDay =
                      previousMonth.day + dayNumber;

                  date = DateTime(
                    _calendarMonth.year,
                    _calendarMonth.month - 1,
                    previousMonthDay,
                  );
                }

                // Next month
                else if (dayNumber > daysInMonth) {
                  date = DateTime(
                    _calendarMonth.year,
                    _calendarMonth.month,
                    dayNumber,
                  );
                }

                // Current month
                else {
                  date = DateTime(
                    _calendarMonth.year,
                    _calendarMonth.month,
                    dayNumber,
                  );
                }

                final bool isCurrentMonth =
                    date.month ==
                        _calendarMonth.month &&
                        date.year ==
                            _calendarMonth.year;

                final DateTime today =
                DateTime.now();

                final bool isToday =
                    date.year == today.year &&
                        date.month == today.month &&
                        date.day == today.day;

                final List<PlanningCalendar> meetings =
                _getMeetingsForDate(date, meetingsList);

                return _calendarDayCell(
                  date: date,
                  isCurrentMonth: isCurrentMonth,
                  isToday: isToday,
                  meetings: meetings,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // --------- WEEK CALENDAR -----------

  DateTime _startOfWeek(DateTime date) {
    // Dart: Monday = 1 ... Sunday = 7
    // We need Sunday as the first day.

    final int daysFromSunday =
        date.weekday % 7;

    return DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(
      Duration(days: daysFromSunday),
    );
  }

  Widget _buildWeekCalendar(List<PlanningCalendar> meetingsList,) {
    final DateTime start = _startOfWeek(_calendarMonth);

    final List<DateTime> days = List.generate(
      7,
          (index) => start.add(
        Duration(days: index),
      ),
    );

    final DateTime today = DateTime.now();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragEnd: (details) async {
        final double velocity = details.primaryVelocity ?? 0;
        if (velocity.abs() < 100) return;

        setState(() {
          if (velocity < 0) {
            // Swiped left -> next week
            _calendarMonth = _calendarMonth.add(const Duration(days: 7));
          } else {
            // Swiped right -> previous week
            _calendarMonth = _calendarMonth.subtract(const Duration(days: 7));
          }
          _updateCalendarDateRange();
        });

        if (AppClient.isAnusamm) {
          await hrDashboardController.getPlanningCalendar_List();
        }
        },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          15,
          8,
          15,
          16,
        ),
        child: SizedBox(
          height: 300,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: days.map((date) {

              final bool isToday =
              _isSameDay(date, today);

              final List<PlanningCalendar> events =
              _getMeetingsForDate(date, meetingsList);

              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isToday
                        ? const Color(0xffF5F9FF)
                        : Colors.white,
                    borderRadius:
                    BorderRadius.circular(11),
                    border: Border.all(
                      color: isToday
                          ? const Color(0xffB8D3FF)
                          : const Color(0xffE4E7EC),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                        ),
                        child: Column(
                          children: [

                            Text(
                              _weekDayName(
                                date.weekday,
                              ),
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff98A2B3),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "${date.day}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isToday
                                    ? const Color(0xff155EEF)
                                    : const Color(0xff172B4D),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 1,
                        color: isToday
                            ? const Color(0xffB8D3FF)
                            : const Color(0xffF0F2F5),
                      ),

                      Expanded(
                        child: Padding(
                          padding:
                          const EdgeInsets.all(6),

                          child: events.isEmpty
                              ? const Center(
                            child: Text(
                              "—",
                              style: TextStyle(
                                fontSize: 10,
                                color:
                                Color(0xffD0D5DD),
                              ),
                            ),
                          )
                              : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .stretch,
                              children:
                              events.map((event) {
                                return _weekEventPill(
                                  event,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _weekEventPill(
      PlanningCalendar meeting,
      ) {
    final bool isCancelled =
        (meeting.meetingStatus ?? "")
            .trim()
            .toUpperCase() ==
            "CANCELLED";

    return GestureDetector(
      onTap: () {
        _showPlanningCalendarPopup(
          meeting.meetingDate ?? DateTime.now(),
          [meeting],
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 5,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffEEF2FF),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          meeting.meetingTitle ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 7,
            fontWeight: FontWeight.w600,
            color: const Color(0xff4F46E5),
            decoration: isCancelled
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor:
            const Color(0xff4F46E5),
            decorationThickness: 1.5,
          ),
        ),
      ),
    );
  }

  // --------- DAY CALENDAR -------

  bool _isSameDay(
      DateTime a,
      DateTime b,
      ) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  String _weekDayName(int weekday) {
    const names = [
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun",
    ];

    return names[weekday - 1];
  }


  Widget _buildDayCalendar(List<PlanningCalendar> meetingsList,) {
    final List<PlanningCalendar> events =
    _getMeetingsForDate(_calendarMonth, meetingsList);

    final DateTime today = DateTime.now();

    final bool isToday =
    _isSameDay(_calendarMonth, today);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragEnd: (details) async {
        final double velocity = details.primaryVelocity ?? 0;
        if (velocity.abs() < 100) return;

        setState(() {
          if (velocity < 0) {
            // Swiped left -> next day
            _calendarMonth = _calendarMonth.add(const Duration(days: 1));
          } else {
            // Swiped right -> previous day
            _calendarMonth = _calendarMonth.subtract(const Duration(days: 1));
          }
          _updateCalendarDateRange();
        });

        await hrDashboardController.getPlanningCalendar_List();
      },
      child: SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                14,
                16,
                0,
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [

                  Text(
                    "${_calendarMonth.day}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff172B4D),
                    ),
                  ),

                  const SizedBox(width: 6),

                  Text(
                    "${_monthName(_calendarMonth.month)} "
                        "${_calendarMonth.year}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff172B4D),
                    ),
                  ),

                  if (isToday) ...[
                    const SizedBox(width: 10),

                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffEEF4FF),
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff155EEF),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 61,
                top: 10,
              ),
              child: Text(
                _weekDayName(
                  _calendarMonth.weekday,
                ),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff98A2B3),
                ),
              ),
            ),

            Expanded(
              child: events.isEmpty
                  ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xffF2F4F7,
                        ),
                        borderRadius:
                        BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.event_busy_outlined,
                        size: 18,
                        color: Color(0xffD0D5DD),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      "No events today",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                        FontWeight.w600,
                        color: Color(0xff98A2B3),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Click "Add Event" to schedule one',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                        FontWeight.w500,
                        color: Color(0xffC0C5CD),
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding:
                const EdgeInsets.fromLTRB(
                  16,
                  25,
                  16,
                  16,
                ),
                itemCount: events.length,
                itemBuilder:
                    (context, index) {

                  final PlanningCalendar meeting =
                  events[index];

                  return _dayEventItem(
                    meeting,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dayEventItem(
      PlanningCalendar meeting,
      ) {
    final bool isCancelled =
        (meeting.meetingStatus ?? "")
            .trim()
            .toUpperCase() ==
            "CANCELLED";

    return GestureDetector(
      onTap: () {
        _showPlanningCalendarPopup(
          meeting.meetingDate ?? _calendarMonth,
          [meeting],
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 8,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffEEF2FF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xffC7D2FE),
          ),
        ),
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xff4F46E5),
                borderRadius:
                BorderRadius.circular(4),
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    meeting.meetingTitle ?? "",
                    maxLines: 2,
                    overflow:
                    TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                      FontWeight.w700,
                      color:
                      const Color(0xff4F46E5),
                      decoration: isCancelled
                          ? TextDecoration
                          .lineThrough
                          : TextDecoration.none,
                      decorationColor:
                      const Color(0xff4F46E5),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    _formatMeetingTime(
                      meeting.meetingTime,
                    ),
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight:
                      FontWeight.w500,
                      color: Color(0xff667085),
                    ),
                  ),

                  if ((meeting.meetingDescription ??
                      "")
                      .trim()
                      .isNotEmpty) ...[
                    const SizedBox(height: 3),

                    Text(
                      meeting.meetingDescription!
                          .trim(),
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xff98A2B3),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatMeetingTime(String? time) {
    if (time == null || time.trim().isEmpty) {
      return "";
    }

    try {
      final parts = time.trim().split(":");

      final int hour = int.parse(parts[0]);
      final int minute = int.parse(parts[1]);

      final String period =
      hour >= 12 ? "PM" : "AM";

      final int displayHour =
      hour == 0
          ? 12
          : hour > 12
          ? hour - 12
          : hour;

      return "$displayHour:"
          "${minute.toString().padLeft(2, '0')} "
          "$period";
    } catch (_) {
      return time;
    }
  }


}

class DottedCirclePainter extends CustomPainter {
  final Animation<double> animation;

  DottedCirclePainter({
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffE2E8F0)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = (size.width / 2) - 3;

    const int dotCount = 48;

    // Rotate the dots
    final rotation = animation.value * 2 * pi;

    for (int i = 0; i < dotCount; i++) {
      final angle =
          ((2 * pi * i) / dotCount) + rotation;

      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      canvas.drawCircle(
        Offset(x, y),
        1.7,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
      covariant DottedCirclePainter oldDelegate,
      ) {
    return false;
  }
}

class _LeaveChartData {
  final String title;
  final int value;
  final Color color;

  _LeaveChartData(
      this.title,
      this.value,
      this.color,
      );
}

class AttendanceDonutPainter extends CustomPainter {
  final double presentPercentage;
  final double absentPercentage;
  final double onLeavePercentage;

  AttendanceDonutPainter({
    required this.presentPercentage,
    required this.absentPercentage,
    required this.onLeavePercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.shortestSide / 2 - 14;

    const strokeWidth = 20.0;

    // Only positive values are drawn.
    final present = presentPercentage > 0
        ? presentPercentage
        : 0.0;

    final absent = absentPercentage > 0
        ? absentPercentage
        : 0.0;

    final onLeave = onLeavePercentage > 0
        ? onLeavePercentage
        : 0.0;

    final total = present + absent + onLeave;

    if (total <= 0) return;

    double startAngle = -pi / 2;

    void drawSegment({
      required double value,
      required Color color,
    }) {
      if (value <= 0) return;

      final sweepAngle =
          (value / 100) * 2 * pi;

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true;

      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }

    // PRESENT
    drawSegment(
      value: present,
      color: const Color(0xff22C55E),
    );

    // ABSENT
    // If absentPercentage is negative,
    // nothing will be drawn here.
    drawSegment(
      value: absent,
      color: const Color(0xffFF4141),
    );

    // ON LEAVE
    drawSegment(
      value: onLeave,
      color: const Color(0xffff8500),
    );
  }

  @override
  bool shouldRepaint(
      covariant AttendanceDonutPainter oldDelegate,
      ) {
    return oldDelegate.presentPercentage != presentPercentage ||
        oldDelegate.absentPercentage != absentPercentage ||
        oldDelegate.onLeavePercentage != onLeavePercentage;
  }
}

class RecentActivityCardList extends StatefulWidget {
  final List<RecentActivity> activities;

  const RecentActivityCardList({
    super.key,
    required this.activities,
  });

  @override
  State<RecentActivityCardList> createState() =>
      _RecentActivityCardListState();
}

class _RecentActivityCardListState
    extends State<RecentActivityCardList> {

  final TextEditingController searchController =
  TextEditingController();

  final ScrollController scrollController =
  ScrollController();

  late List<RecentActivity> filteredActivities;

  @override
  void initState() {
    super.initState();

    // Create a local copy.
    filteredActivities = List<RecentActivity>.from(
      widget.activities,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xffF7F9FC),

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xff172B4D),
          title: const Text(
            "Punch In / Out Activity Logs",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff172B4D),
            ),
          ),
        ),

        body: widget.activities.isEmpty
            ? const Center(
          child: Text(
            "No recent punch activity",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xff98A2B3),
            ),
          ),
        )
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                8,
              ),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xffE4E7EC),
                  ),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: searchRecentActivity,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff172B4D),
                  ),
                  decoration: InputDecoration(
                    hintText:
                    "Search employee, punch no, status...",
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff98A2B3),
                    ),

                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: Color(0xff71829D),
                    ),

                    suffixIcon:
                    searchController.text.isNotEmpty
                        ? IconButton(
                      onPressed: () {
                        searchController.clear();

                        setState(() {
                          filteredActivities =
                          List<RecentActivity>.from(
                            widget.activities,
                          );
                        });
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 18,
                        color:
                        Color(0xff71829D),
                      ),
                    )
                        : null,

                    border: InputBorder.none,

                    contentPadding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 11,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: filteredActivities.isEmpty
                  ? const Center(
                child: Text(
                  "No matching activities found",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff98A2B3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
                  : Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                thickness: 5,
                radius: const Radius.circular(10),
                child: ListView.builder(
                  controller: scrollController,
                  padding:
                  const EdgeInsets.fromLTRB(
                    16,
                    8,
                    16,
                    16,
                  ),
                  itemCount:
                  filteredActivities.length,
                  itemBuilder: (context, index) {
                    return RecentActivityCard(
                      activity:
                      filteredActivities[index],
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

  void searchRecentActivity(String query) {
    final searchText =
    query.trim().toLowerCase();

    if (searchText.isEmpty) {
      setState(() {
        filteredActivities =
        List<RecentActivity>.from(
          widget.activities,
        );
      });

      return;
    }

    final result =
    widget.activities.where((activity) {
      final values = [
        activity.punchNo,
        activity.employeeName,
        activity.indate,
        activity.inTime,
        activity.outDate,
        activity.outTime,
        activity.inLoc,
        activity.outLoc,
        activity.instatus,
        activity.outstatus,
        activity.onpininaddress,
        activity.onpinoutaddress,
      ];

      return values.any(
            (value) =>
        value != null &&
            value.toString()
                .toLowerCase()
                .contains(searchText),
      );
    }).toList();

    setState(() {
      filteredActivities = result;
    });
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {
    final paint = Paint()
      ..color = const Color(0xffD0D5DD)
      ..strokeWidth = 2;

    const dashWidth = 6.0;
    const dashSpace = 5.0;

    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(
          startX + dashWidth,
          0,
        ),
        paint,
      );

      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(
      covariant _DashedLinePainter oldDelegate,
      ) {
    return false;
  }
}
