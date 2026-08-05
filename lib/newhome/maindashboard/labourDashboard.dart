import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:prahkurticore/controller/labourDashboard_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../app_theme/app_colors.dart';
import '../../commonpopup/labourAttendanceChart.dart';
import '../../commonpopup/labourAttendanceTable.dart';
import '../../constants/storage_constant.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/logincontroller.dart';
import '../../controller/menu_controller.dart';
import '../../home/account_settings/account_setting.dart';
import '../../models/labourDashboard_model.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';
import '../menus/main_menuslist.dart';
import '../pendinglist.dart';
import '../reports/reports.dart';
import 'dashboard.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:math' as math;


class LabourDashboard extends StatefulWidget {
  const LabourDashboard({super.key});

  @override
  State<LabourDashboard> createState() => _LabourDashboardState();
}

class _LabourDashboardState extends State<LabourDashboard> {
  final _pageController = PageController();
  Menu_Controller menuController = Get.put(Menu_Controller());
  LoginController loginController = Get.put(LoginController());
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: BottomBar(
            selectedIndex: _currentPage,
            onTap: (int index) {
              menuController.formMenuId.value = 0;
              _pageController.jumpToPage(index);
              setState(() => _currentPage = index);
            },
            items: const <BottomBarItem>[
              BottomBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Color(0xFF4B3FFF),
              ),
              BottomBarItem(
                icon: Icon(Icons.menu_open),
                title: Text('Menus'),
                activeColor: Color(0xFF4B3FFF),
              ),
              BottomBarItem(
                icon: Icon(Icons.list_alt),
                title: Text('List'),
                activeColor: Color(0xFF4B3FFF),
              ),
              BottomBarItem(
                icon: Icon(Icons.file_copy_outlined),
                title: Text('Reports'),
                activeColor: Color(0xFF4B3FFF),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      const Expanded(
                          flex: 3,
                          child: Text(
                            "Labour Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      Container(
                        child: InkWell(
                          child: Container(
                              margin:
                              const EdgeInsets.only(left: 20, right: 10),
                              child: Icon(Icons.settings,
                                  color: Theme.of(context).primaryColor)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    const AccountSettings()));
                          },
                        ),
                      ),
                      Container(
                        child: InkWell(
                          child: Container(
                              margin:
                              const EdgeInsets.only(left: 20, right: 10),
                              child: Icon(Icons.logout,
                                  color: Theme.of(context).primaryColor)),
                          onTap: () {
                            logoutPopup(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 15)
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: BaseUtitiles.getheightofPercentage(context, 84),
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const HomeScreen(),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const MainManusList(),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const PendingList_Screen(),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Reports_screen(),
                        ),
                      ],
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future logoutPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Are you sure to Logout?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          return Navigator.of(context).pop();
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          await loginController.usertoken_DeleteApi(context);
                          await loginController.deleteLoginDetails();
                          await SessionStorage.removeUser();
                        },
                        child: const Text("Logout",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final bool isLabour;
  const HomeScreen({super.key, this.isLabour = false,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  LabourDashboardController labourDashboardController = Get.put(LabourDashboardController());
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime currentDate = DateTime.now();
    labourDashboardController.labourEntryFromDate.text = currentDate.toString().substring(0, 10);
    labourDashboardController.labourEntryToDate.text = currentDate.toString().substring(0, 10);
    labourDashboardController.getLabourDashboardDetails();

    _tooltipBehavior = TooltipBehavior(
      enable: true,
      color: Colors.black87,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      canShowMarker: true,
      header: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
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
                      margin: EdgeInsets.only(top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: BaseUtitiles.getWidthtofPercentage(context, 45),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: TextFormField(
                                  readOnly: true,
                                  controller:
                                  labourDashboardController.labourEntryFromDate,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black,fontSize: 14),
                                  decoration:  InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "From Date",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon(Icons.calendar_today_outlined,size:18,color: Theme.of(context).primaryColor,),
                                    ),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon(Icons.keyboard_arrow_down,size:18,color: Theme.of(context).primaryColor,),
                                    ),
                                  ),
                                  onTap: () async {
                                    var Frdate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2010),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary:
                                                Theme.of(context).primaryColor,
                                                onPrimary: Colors.white,
                                                onSurface:
                                                Colors.black, // body text color
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
                                    if (Frdate != null) {
                                      labourDashboardController.labourEntryFromDate.text =
                                          Frdate.toString().substring(0, 10);

                                      // Refresh API
                                      await labourDashboardController.getLabourDashboardDetails();
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select Date';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: BaseUtitiles.getWidthtofPercentage(context, 45),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: TextFormField(
                                  readOnly: true,
                                  controller:
                                  labourDashboardController.labourEntryToDate,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black,fontSize: 14),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "To Date",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: Icon(Icons.calendar_today,size:18,
                                            color: Theme.of(context).primaryColor)),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon(Icons.keyboard_arrow_down,size:18,color: Theme.of(context).primaryColor,),
                                    ),
                                  ),
                                  onTap: () async {
                                    var Todate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2010),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary:
                                                Theme.of(context).primaryColor,
                                                // header background color
                                                onPrimary: Colors.white,
                                                // header text color
                                                onSurface:
                                                Colors.black, // body text color
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
                                    if (Todate != null) {
                                      labourDashboardController.labourEntryToDate.text =
                                          Todate.toString().substring(0, 10);

                                      // Refresh API
                                      await labourDashboardController.getLabourDashboardDetails();
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select Date';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /// Cards ---------
                    Obx(()=>
                      GridView.builder(
                        padding: EdgeInsets.only(top: 8),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: labourCards.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 2,
                          childAspectRatio: 1.45,
                        ),
                        itemBuilder: (_, index) {
                          final item = labourCards[index];

                          return LabourCard(item: item, index: index);
                          },
                      ),
                    ),

                    SizedBox(height: 12,),

                    /// Labour category distribution---------

                    Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
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

                      Obx(()=>
                         Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Doughnut
                            Expanded(
                              flex: 4,
                              child:
                                 SizedBox(
                                  height: 200,
                                  child: SfCircularChart(
                                    tooltipBehavior: _tooltipBehavior,
                                    annotations: [
                                      CircularChartAnnotation(
                                        widget: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(BaseUtitiles.formatNumber(
                                              labourDashboardController.totalLabour),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
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
                                      DoughnutSeries<LabourCategoryWise, String>(
                                        dataSource: labourDashboardController.labourCategoryList,
                                        xValueMapper: (e, _) => e.categoryName ?? "",
                                        yValueMapper: (e, _) => e.totalNos ?? 0,
                                        pointColorMapper: (e, index) =>
                                            labourDashboardController.getCategoryColor(index!),
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
                                final visibleItems = labourDashboardController.showAll.value
                                    ? labourDashboardController.labourCategoryList
                                    : labourDashboardController.labourCategoryList.take(4).toList();
                                return AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: Column(
                                    children: [
                                      ...visibleItems.asMap().entries.map((entry){
                                        final index = entry.key;
                                        final item = entry.value;
                                        final color =
                                        labourDashboardController.getCategoryColor(index);

                                        final percent = labourDashboardController.totalLabour == 0
                                            ? 0
                                            : ((item.totalNos ?? 0) /
                                            labourDashboardController.totalLabour) *
                                            100;
                                        return Container(
                                          margin: const EdgeInsets.only(bottom: 4),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                          ),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor: color.withOpacity(.15),
                                                child: Icon(
                                                      labourDashboardController
                                                          .getCategoryIcon(item.categoryName),
                                                  color: color,
                                                  size: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  item.categoryName ?? "",
                                                  style: const TextStyle(fontSize: 11,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: color.withOpacity(.15),
                                                    borderRadius: BorderRadius.circular(25)
                                                ),
                                                child: Text(
                                                  "${item.totalNos?.toInt()} (${percent.toStringAsFixed(1)}%)",
                                                  style: TextStyle(
                                                    color: color,
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.bold,
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
                        if (labourDashboardController.labourCategoryList.length <= 4) {
                          return const SizedBox();
                        }

                        return InkWell(
                          onTap: () {
                            labourDashboardController.showAll.toggle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  labourDashboardController.showAll.value
                                      ? "Show Less"
                                      : "Show More",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  labourDashboardController.showAll.value
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
                    SizedBox(height: 12,),
                    /// ------------- ATTENDANCE CHART ---------

                    // Container(
                    //   margin: const EdgeInsets.only(top: 15),
                    //   padding: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(15),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(.12),
                    //         blurRadius: 8,
                    //       )
                    //     ],
                    //   ),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //
                    //           const Expanded(
                    //             child: Text(
                    //               "Labour Attendance Today",
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //
                    //           IconButton(
                    //             onPressed: () {},
                    //             icon: const Icon(Icons.arrow_forward_ios,size:16),
                    //           )
                    //         ],
                    //       ),
                    //       Row(
                    //         children: [
                    //           /// Doughnut Chart
                    //           Expanded(
                    //             flex: 4,
                    //             child: SizedBox(
                    //               height: 160,
                    //               child: AttendanceChart(chartData: chartData, totalCount: 19,),
                    //             ),
                    //           ),
                    //
                    //           const SizedBox(width:20),
                    //
                    //           /// Legend
                    //           Expanded(
                    //             flex: 5,
                    //             child: Column(
                    //
                    //               children: [
                    //
                    //                 attendanceRow(
                    //                   Colors.green,
                    //                   "Present",
                    //                   "212",
                    //                   "85.48%",
                    //                 ),
                    //
                    //                 const SizedBox(height:15),
                    //
                    //                 attendanceRow(
                    //                   Colors.red,
                    //                   "Absent",
                    //                   "28",
                    //                   "11.29%",
                    //                 ),
                    //
                    //                 const SizedBox(height:15),
                    //
                    //                 attendanceRow(
                    //                   Colors.orange,
                    //                   "On Leave",
                    //                   "8",
                    //                   "3.23%",
                    //                 ),
                    //
                    //                 const SizedBox(height:15),
                    //
                    //                 attendanceRow(
                    //                   Colors.purple,
                    //                   "Half Day",
                    //                   "6",
                    //                   "2.42%",
                    //                 ),
                    //
                    //                 const SizedBox(height:15),
                    //
                    //                 attendanceRow(
                    //                   Colors.cyan,
                    //                   "Permission",
                    //                   "4",
                    //                   "1.61%",
                    //                 ),
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),

                    SizedBox(height: 12),

                    /// ----------- OT ANALYSIS TODAY ------------

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => ProjectWiseLabourDialog(),
                                      );},
                                    child: Obx(()=>
                                       Visibility(
                                        visible: labourDashboardController.filteredProjects.isNotEmpty,
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
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _legend(Color(0xFF2563EB), "NMR Work%"),
                                      const SizedBox(width: 15),
                                      _legend(Color(0xFFF97316), "Rate Work%"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Obx(() {
                            final axisValues = getYAxisValues(
                              labourDashboardController.filteredProjects,
                            );
                            return  SizedBox(
                              height: 250,
                              child:
                              SfCartesianChart(
                                legend:  Legend(isVisible: false),
                                plotAreaBorderWidth: 0,

                                primaryXAxis: CategoryAxis(
                                  majorGridLines: const MajorGridLines(width: 0),
                                  axisLine: const AxisLine(width: 0),
                                  labelStyle: const TextStyle(
                                    fontSize: 7,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
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

                                ),

                                series: <CartesianSeries>[
                                  ColumnSeries<ProjectWiseLabour, String>(
                                    width: 0.65,
                                    spacing: 0.25,
                                    dataSource: labourDashboardController.filteredProjects
                                        .take(3)
                                        .toList(), // Dashboard preview
                                    xValueMapper: (item, _) =>
                                        BaseUtitiles.formatProjectName(item.projectName?.trim() ?? ""),
                                    yValueMapper: (item, _) => item.nmrNos ?? 0,
                                    color: const Color(0xFF2563EB),
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(
                                        color: Color(0xFF2563EB), // Orange label color
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  ColumnSeries<ProjectWiseLabour, String>(
                                    width: 0.65,
                                    spacing: 0.25,
                                    dataSource: labourDashboardController.filteredProjects
                                        .take(3)
                                        .toList(),
                                    xValueMapper: (item, _) =>
                                        BaseUtitiles.formatProjectName(item.projectName?.trim() ?? ""),
                                    yValueMapper: (item, _) => item.rateNos ?? 0,
                                    color: const Color(0xFFF97316),
                                    dataLabelSettings: const DataLabelSettings(
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => SubcontractortWiseLabourSummaryDialog(),
                                      );},
                                    child: Visibility(
                                      visible: labourDashboardController.subcontractorfilteredProjects.isNotEmpty,
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
                                      _legend(Color(0xFF2563EB), "NMR Work%"),
                                      const SizedBox(width: 15),
                                      _legend(Color(0xFFF97316), "Rate Work%"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Obx(() {
                            final axisValues = getSubcontYAxisValues(
                              labourDashboardController.subcontractorfilteredProjects,
                            );
                            return SizedBox(
                              height: 250,
                              child:
                              SfCartesianChart(
                                legend:  Legend(isVisible: false),
                                plotAreaBorderWidth: 0,
                                primaryXAxis: CategoryAxis(
                                  majorGridLines: const MajorGridLines(width: 0),
                                  axisLine: const AxisLine(width: 0),
                                  labelStyle: const TextStyle(
                                    fontSize: 7,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
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
                                ),
                                series: <CartesianSeries>[
                                  ColumnSeries<SubContractorWiseLabourTradeChart, String>(
                                    width: 0.65,
                                    spacing: 0.25,
                                    dataSource: labourDashboardController.subcontractorfilteredProjects
                                        .take(3)
                                        .toList(), // Dashboard preview
                                    xValueMapper: (item, _) =>
                                        BaseUtitiles.formatProjectName(item.subcontractName?.trim() ?? ""),
                                    yValueMapper: (item, _) => item.nmrNos ?? 0,
                                    color: const Color(0xFF2563EB),
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(
                                        color: Color(0xFF2563EB), // Orange label color
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ColumnSeries<SubContractorWiseLabourTradeChart, String>(
                                    width: 0.65,
                                    spacing: 0.25,
                                    dataSource: labourDashboardController.subcontractorfilteredProjects
                                        .take(3)
                                        .toList(),
                                    xValueMapper: (item, _) =>
                                        BaseUtitiles.formatProjectName(item.subcontractName?.trim() ?? ""),
                                    yValueMapper: (item, _) => item.rateNos ?? 0,
                                    color: const Color(0xFFF97316),
                                    dataLabelSettings: const DataLabelSettings(
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
                          })
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    /// ----------- TABULAR COLUMN

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
                    //               "Subcontractor Attendance",
                    //               style: TextStyle(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //
                    //           InkWell(
                    //             onTap: () {
                    //               Get.to(() => const AttendanceListScreen());
                    //             },
                    //             child: const Row(
                    //               children: [
                    //                 Text(
                    //                   "View All",
                    //                   style: TextStyle(
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 ),
                    //                 SizedBox(width: 4),
                    //                 Icon(Icons.arrow_forward_ios, size: 12),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //
                    //       const SizedBox(height: 15),
                    //
                    //       /// Horizontal Table
                    //       SingleChildScrollView(
                    //         scrollDirection: Axis.horizontal,
                    //         child: SizedBox(
                    //           width: 1035,
                    //           child: Column(
                    //             children: [
                    //
                    //               /// Header
                    //               Table(
                    //                 border: TableBorder.all(color: Colors.grey.shade300),
                    //                 columnWidths: const {
                    //                   0: FixedColumnWidth(135),
                    //                   1: FixedColumnWidth(90),
                    //                   2: FixedColumnWidth(200),
                    //                   3: FixedColumnWidth(180),
                    //                   4: FixedColumnWidth(150),
                    //                   5: FixedColumnWidth(70),
                    //                   6: FixedColumnWidth(90),
                    //                   7: FixedColumnWidth(120),
                    //                 },
                    //                 children: [
                    //                   TableRow(
                    //                     decoration: BoxDecoration(
                    //                       color: Theme.of(context).primaryColor,
                    //                     ),
                    //                     children: const [
                    //                       HeaderCell("Attendance No"),
                    //                       HeaderCell("Date"),
                    //                       HeaderCell("Project"),
                    //                       HeaderCell("Site"),
                    //                       HeaderCell("Subcontractor"),
                    //                       HeaderCell("Labour"),
                    //                       HeaderCell("Amount"),
                    //                       HeaderCell("Prepared By"),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //
                    //               /// Only First 4 Items
                    //               Obx(() {
                    //                 final list =
                    //                 labourDashboardController.todayAttendanceList.take(5).toList();
                    //
                    //                 return Column(
                    //                   children: List.generate(list.length, (index) {
                    //                     final item = list[index];
                    //
                    //                     return Table(
                    //                       border: TableBorder.all(color: Colors.grey.shade300),
                    //                       columnWidths: const {
                    //                         0: FixedColumnWidth(135),
                    //                         1: FixedColumnWidth(90),
                    //                         2: FixedColumnWidth(200),
                    //                         3: FixedColumnWidth(180),
                    //                         4: FixedColumnWidth(150),
                    //                         5: FixedColumnWidth(70),
                    //                         6: FixedColumnWidth(90),
                    //                         7: FixedColumnWidth(120),
                    //                       },
                    //                       children: [
                    //                         TableRow(
                    //                           decoration: BoxDecoration(
                    //                             color: index.isEven
                    //                                 ? Colors.white
                    //                                 : Colors.grey.shade50,
                    //                           ),
                    //                           children: [
                    //
                    //                             TableCellWidget(
                    //                                 item.labourAttendanceNo ?? ""),
                    //
                    //                             TableCellWidget(
                    //                               item.labourAttendanceDate != null
                    //                                   ? DateFormat('yyyy-MM-dd').format(
                    //                                   DateTime.parse(
                    //                                       item.labourAttendanceDate!))
                    //                                   : "",
                    //                             ),
                    //
                    //                             TableCellWidget(item.projectName ?? ""),
                    //
                    //                             TableCellWidget(item.siteName ?? ""),
                    //
                    //                             TableCellWidget(
                    //                                 item.subContractorName ?? ""),
                    //
                    //                             TableCellWidget(
                    //                               item.totNos?.toStringAsFixed(0) ?? "0",
                    //                             ),
                    //
                    //                             TableCellWidget(
                    //                               "₹${item.totAmt?.toStringAsFixed(2) ?? "0.00"}",
                    //                               color: Colors.green,
                    //                               isBold: true,
                    //                             ),
                    //
                    //                             TableCellWidget(
                    //                                 item.employeeName ?? ""),
                    //                           ],
                    //                         ),
                    //                       ],
                    //                     );
                    //                   }),
                    //                 );
                    //               }),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // SizedBox(height: 24,),

                    /// ---------Pending Approvals Count

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
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
                                  final visibleItems = pendingApprovalList;
                                  return AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: Column(
                                      children: [
                                        ...visibleItems.asMap().entries.map((entry){
                                          final index = entry.key;
                                          final item = entry.value;
                                          return Container(
                                            margin: const EdgeInsets.only(bottom: 4),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.grey.shade300),
                                            ),
                                            child: Row(
                                              children: [
                                              CircleAvatar(
                                              radius: 16,
                                              backgroundColor: item.color.withOpacity(.15),
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
                                                    style: const TextStyle(fontSize: 13,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: item.color.withOpacity(.15),
                                                      borderRadius: BorderRadius.circular(25)
                                                  ),
                                                  child: Text(
                                                    "${item.count}",
                                                    style: TextStyle(
                                                      color: item.color,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
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
                    SizedBox(height: 24,),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.15),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// Header
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Subcontractor wise labour",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  Get.dialog(
                                    SubcontractorPerformanceDialog(
                                      labourList: labourDashboardController.subContractorWiseLabour,
                                      totalLabourStrength:
                                      labourDashboardController.dashboardResponse.value?.totalLabourStrength ?? 0,
                                    ),
                                  );
                                },
                                child: Obx(()=>
                                   Visibility(
                                    visible: labourDashboardController.subContractorWiseLabour.isNotEmpty,
                                    child: Row(
                                      children: [
                                        Text(
                                          "View All",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(Icons.arrow_forward_ios, size: 12),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("Based on work completion",style: TextStyle(fontSize: 13,color: Colors.grey),),

                          const SizedBox(height: 20),

                          /// Horizontal Table
                          Obx(() {

                            if (labourDashboardController.subContractorWiseLabour.isEmpty) {
                              return const Center(
                                child: Text("No Data"),
                              );
                            }

                            final list = labourDashboardController.subContractorWiseLabour;

                            final displayList = list.take(5).toList();

                            final totalLabourStrength =
                                labourDashboardController.dashboardResponse.value?.totalLabourStrength ?? 0;

                            const colors = [
                              Colors.green,
                              Colors.blue,
                              Colors.orange,
                              Colors.purple,
                            ];

                            return Column(
                              children: List.generate(displayList.length, (index) {

                                final item = displayList[index];
                                final count = item.labourCount ?? 0;

                                /// Percentage for progress bar (0.0 - 1.0)
                                final double percent = totalLabourStrength == 0
                                    ? 0.0
                                    : (count / totalLabourStrength).clamp(0.0, 1.0);

                                /// Percentage text (0 - 100)
                                final double percentageValue = totalLabourStrength == 0
                                    ? 0.0
                                    : (count / totalLabourStrength) * 100;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    children: [

                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          item.subcontractName ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 10),

                                      Expanded(
                                        child: LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          lineHeight: 18,
                                          animation: true,
                                          animationDuration: 1000,
                                          percent: percent,
                                          barRadius: const Radius.circular(20),
                                          backgroundColor: Colors.grey.shade200,
                                          progressColor: colors[index % colors.length],
                                        ),
                                      ),

                                      const SizedBox(width: 5),

                                      SizedBox(
                                        width: 65,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(BaseUtitiles.formatNumber(count),
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
                                  ),
                                );
                              }),
                            );
                          })
                        ],
                      ),
                    ),
                    SizedBox(height: 24,),

                    /// -----------Payment Pending--------
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.15),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Header
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Payment Pending",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                        () => PaymentPendingScreen(
                                      paymentList: labourDashboardController
                                          .dashboardResponse
                                          .value
                                          ?.subContractPaymentPending ??
                                          [],
                                    ),
                                  );
                                },
                                child:  Obx(() =>
                                   Visibility(
                                    visible: labourDashboardController
                                        .dashboardResponse.value?.subContractPaymentPending
                                        ?.isNotEmpty ??
                                        false,
                                    child: Row(
                                      children: [
                                        Text(
                                          "View All",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(Icons.arrow_forward_ios, size: 12),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          SizedBox(height: 10,),
                          /// Horizontal Table
                          Obx(() {

                            final paymentList = labourDashboardController
                                .dashboardResponse.value?.subContractPaymentPending ??
                                [];
                            if (paymentList.isEmpty) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("No Payment Pending"),
                                ),
                              );
                            }
                            return
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),),
                                    ),
                                    child: const Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Subcontractor",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Amount",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.separated(
                                    padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: paymentList.length > 5 ? 5 : paymentList.length,
                                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final item = paymentList[index];
                                    return Container(
                                      padding: const EdgeInsets.all(8),
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

                                          /// Leading Icon
                                          Container(
                                            height: 38,
                                            width: 38,
                                            decoration: BoxDecoration(
                                              color: item.billType == "WORK BILL" ? Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(.1) : item.billType == "NMR BILL" ? Colors.orange.withOpacity(.2) :
                                            item.billType == "RATE BILL" ? Colors.green.withOpacity(.2) : Colors.orange.withOpacity(.2),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              Icons.account_balance_wallet_outlined,
                                              color: item.billType == "WORK BILL" ? Theme.of(context).primaryColor : item.billType == "NMR BILL" ? Colors.orange.shade700 :
                                              item.billType == "RATE BILL" ? Colors.green.shade700 : Colors.orange.shade700,
                                            ),
                                          ),

                                          const SizedBox(width: 12),

                                          /// Left
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Text(
                                                  item.subcontractName ?? "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                const SizedBox(height: 4),

                                                Text(
                                                  item.projectName ?? "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          const SizedBox(width: 10),

                                          /// Right
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [

                                              Text(
                                                " ${'\u20B9'} ${(item.balAmt ?? 0).toStringAsFixed(0)}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),

                                              const SizedBox(height: 5),

                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: item.billType == "WORK BILL" ? Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(.1) : item.billType == "NMR BILL" ? Colors.orange.withOpacity(.2) :
                                                  item.billType == "RATE BILL" ? Colors.green.withOpacity(.2) : Colors.orange.shade700,
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: item.billType == "WORK BILL" ? Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(.4) : item.billType == "NMR BILL" ? Colors.orange.shade700 :
                                                    item.billType == "RATE BILL" ? Colors.green.shade700 : Colors.orange.shade700,
                                                  ),
                                                ),
                                                child: Text(
                                                  item.billType ?? "",
                                                  style: TextStyle(
                                                    color: item.billType == "WORK BILL" ? Theme.of(context).primaryColor :
                                                    item.billType == "NMR BILL" ? Colors.orange.shade700 :
                                                    item.billType == "RATE BILL" ? Colors.green.shade700 : Colors.orange.shade700,
                                                    fontSize: 10,
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
                                ],
                              );
                          })
                        ],
                      ),
                    ),
                    SizedBox(height: 24,),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        builder: (_) => AttendanceViewAllScreen(
                                          attendanceList: labourDashboardController.todayAttendanceList,
                                        ),
                                      ),
                                    );
                                    },
                                borderRadius: BorderRadius.circular(20),
                                child: Obx(()=>
                                   Visibility(
                                    visible: labourDashboardController.todayAttendanceList.isNotEmpty,
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
                                        Icon(Icons.arrow_forward_ios, size: 12),
                                      ],
                                    ),
                                  ),
                                ),

                              )
                            ],
                          ),

                          const SizedBox(height: 18),

                          /// Table Container
                          Obx((){

                            final attendanceList =
                            labourDashboardController.todayAttendanceList;

                            if(attendanceList.isEmpty){
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("No Subcontractor Attendance"),
                                ),
                              );
                            }

                            return ListView.separated(
                              padding:  EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: attendanceList.length > 3 ? 3 : attendanceList.length,
                              shrinkWrap: true,
                              separatorBuilder: (_, __) => const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final item = attendanceList[index];

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
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
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
                                                DateTime.parse(item.labourAttendanceDate!),
                                              )
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
                                            child: Row(
                                              children: [
                                                // const Icon(
                                                //   Icons.add_chart_rounded,
                                                //   size: 18,
                                                //   color: Colors.blue,
                                                // ),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    item.projectName ?? "",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                                                const Icon(
                                                  Icons.groups,
                                                  size: 18,
                                                  color: Colors.green,
                                                ),
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
                                            child: Row(
                                              children: [
                                                // const Icon(
                                                //   Icons.add_card_rounded,
                                                //   size: 18,
                                                //   color: Colors.red,
                                                // ),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    item.siteName ?? "",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Text( "${'\u20B9'} ${BaseUtitiles.formatNumber(item.totAmt)}",
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
                            );},
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 100,),
                  ],
                ),

              ),
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

    double maximum;
    double interval;

    if (maxValue <= 50) {
      maximum = 50;
      interval = 10;
    }
    else if (maxValue <= 100) {
      maximum = 100;
      interval = 20;
    } else if (maxValue <= 500) {
      maximum = 500;
      interval = 100;
    }else if (maxValue <= 1000) {
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

  Map<String, double> getSubcontYAxisValues(List<SubContractorWiseLabourTradeChart> list) {
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
    }
    else if (maxValue <= 100) {
      maximum = 100;
      interval = 20;
    }
    else if (maxValue <= 500) {
      maximum = 500;
      interval = 100;
    }else if (maxValue <= 1000) {
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
          style: const TextStyle(fontSize: 12),
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
        subtitle: "${difference > 0 ? '+' : ''}$difference vs previous period",
        icon: Icons.groups,
        color: Color(0xFF2563EB),
      ),

      LabourCardModel(
        title: "NMR WORK",
        value: BaseUtitiles.formatNumber(data?.nmrLabourDetails?.isNotEmpty == true ? data!.nmrLabourDetails!.first.totalNmrNos : 0),
        subtitle:"${'\u20B9'} ${data?.nmrLabourDetails?.isNotEmpty == true ? data!.nmrLabourDetails!.first.totalNmrAmount ?? 0.0 : 0.0} Total cost",
        icon: Icons.assignment_turned_in_outlined,
        color: Color(0xFF7C3AED),
      ),

      LabourCardModel(
        title: "RATE WORK",
        value: BaseUtitiles.formatNumber(data?.rateWorkDetails?.isNotEmpty == true ? data!.rateWorkDetails!.first.totalNosRateWise : 0),
        subtitle: "${'\u20B9'} ${data?.rateWorkDetails?.isNotEmpty == true ? data!.rateWorkDetails!.first.totalAmountRateWise ?? 0.0 : 0.0} Total cost",
        icon: Icons.view_week_outlined,
        color: Color(0xFFD97706),
      ),

      LabourCardModel(
        title: "TOTAL NMR COST",
        value:
        "${data?.todayLabourCost?.isNotEmpty == true ? data!.todayLabourCost!.first.todayLabourCost ?? 0 : 0}",
        subtitle: "${'\u20B9'} ${data?.todayLabourCost?.isNotEmpty == true ? data!.todayLabourCost!.first.yesterdayLabourCost ?? 0.0 : 0.0} Yesterday",
        icon: Icons.currency_rupee,
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

        const SizedBox(width:12),

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

        const SizedBox(width:8),

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



class LabourCardModel {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  LabourCardModel({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
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
      margin: EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Icon Box
              Container(
                height: 45,
                width: 42,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 22,
                ),
              ),

              const SizedBox(width: 8),

              /// Text Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      item.title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .3,
                      ),
                    ),

                    const SizedBox(height: 6),

                    SizedBox(
                      height: 18,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.value,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),


                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: 5,),
          Text(
            item.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
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




