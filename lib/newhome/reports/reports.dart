import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/newhome/reports/punch_reports/punch_in_out_reports.dart';
import '../../../utilities/baseutitiles.dart';
import '../../app_theme/app_colors.dart';
import '../../controller/attendancecontroller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/menu_controller.dart';
import '../../controller/punch_in_controller.dart';
import '../../controller/staffcontroller.dart';
import '../../controller/stocksite_controller.dart';
import '../../home/attendance_report/attendance_report.dart';
import '../../home/dpr_report/dpr_report.dart';
import '../../home/inward_report/inward_report.dart';
import '../../home/mrn_report/mrn_report.dart';
import '../../home/stock_site/stock_site.dart';
import '../maindashboard/dashboard.dart';
import '../maindashboard/dashboard_otheruser.dart';

class Reports_screen extends StatefulWidget {
  const Reports_screen({Key? key}) : super(key: key);

  @override
  State<Reports_screen> createState() => _Reports_screenState();
}

class _Reports_screenState extends State<Reports_screen> {
  LoginController loginController = Get.put(LoginController());
  PunchInController punchInController = Get.put(PunchInController());
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  final StockSiteController stockSiteController =
      Get.put(StockSiteController());
  StaffController staffController = Get.put(StaffController());
  Menu_Controller menuController = Get.put(Menu_Controller());
  static const IconData fingerprintOutlined =
      IconData(0xf075, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      await menuController.getReportsList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setmybackground,
      body: WillPopScope(
        onWillPop: () => homeScreen(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => menuController.reportListDatas.value.length != 0
                  ? GridView.builder(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 12),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.5,
                      ),
                      shrinkWrap: true,
                      itemCount: menuController.reportListDatas.value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height:
                              BaseUtitiles.getheightofPercentage(context, 15),
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 45),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: InkWell(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                              Colors.indigo.shade50,
                                          child: Icon(
                                            menuController
                                                        .reportListDatas
                                                        .value[index]
                                                        .mobileMenuName ==
                                                    'MRN Report'
                                                ? Icons.add_card
                                                : menuController
                                                            .reportListDatas
                                                            .value[index]
                                                            .mobileMenuName ==
                                                        'Attendance Report'
                                                    ? Icons.read_more
                                                    : menuController
                                                                .reportListDatas
                                                                .value[index]
                                                                .mobileMenuName ==
                                                            'Stock at site'
                                                        ? Icons
                                                            .compare_arrows_rounded
                                                        : menuController
                                                                    .reportListDatas
                                                                    .value[
                                                                        index]
                                                                    .mobileMenuName ==
                                                                'Inward Report'
                                                            ? Icons.add_chart
                                                            : menuController
                                                                        .reportListDatas
                                                                        .value[
                                                                            index]
                                                                        .mobileMenuName ==
                                                                    'DPR Report'
                                                                ? Icons
                                                                    .add_business
                                                                : menuController
                                                                            .reportListDatas
                                                                            .value[index]
                                                                            .mobileMenuName ==
                                                                        'Punch Report'
                                                                    ? fingerprintOutlined
                                                                    : null,
                                            size: 30,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )),
                                      Text(menuController
                                                  .reportListDatas
                                                  .value[index]
                                                  .mobileMenuName ==
                                              'MRN Report'
                                          ? "MRN Report"
                                          : menuController
                                                      .reportListDatas
                                                      .value[index]
                                                      .mobileMenuName ==
                                                  'Attendance Report'
                                              ? "Attendance Report"
                                              : menuController
                                                          .reportListDatas
                                                          .value[index]
                                                          .mobileMenuName ==
                                                      'Stock at site'
                                                  ? "Stock at site"
                                                  : menuController
                                                              .reportListDatas
                                                              .value[index]
                                                              .mobileMenuName ==
                                                          'Inward Report'
                                                      ? "Inward Report"
                                                      : menuController
                                                                  .reportListDatas
                                                                  .value[index]
                                                                  .mobileMenuName ==
                                                              'DPR Report'
                                                          ? "DPR Report"
                                                          : menuController
                                                                      .reportListDatas
                                                                      .value[
                                                                          index]
                                                                      .mobileMenuName ==
                                                                  'Punch Report'
                                                              ? "Punch Report"
                                                              : menuController
                                                                  .reportListDatas
                                                                  .value[index]
                                                                  .mobileMenuName),
                                    ],
                                  )),
                              onTap: () async {
                                if (menuController.reportListDatas.value[index]
                                        .mobileMenuName ==
                                    'MRN Report') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MRNReport()));
                                }

                                if (menuController.reportListDatas.value[index]
                                        .mobileMenuName ==
                                    'Attendance Report') {
                                  attendanceController.attendanceDatas.value
                                      .clear();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              AttendanceReport()));
                                }

                                if (menuController.reportListDatas.value[index]
                                        .mobileMenuName ==
                                    'Stock at site') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              StockSite()));
                                }

                                if (menuController.reportListDatas.value[index]
                                        .mobileMenuName ==
                                    'Inward Report') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const InwardReport()));
                                }

                                if (menuController.reportListDatas.value[index]
                                        .mobileMenuName ==
                                    'DPR Report') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DPRReport()));
                                }
                                if (menuController.reportListDatas.value[index].mobileMenuName == 'Punch Report') {
                                    punchInController.todayDate.text = BaseUtitiles.initiateCurrentDateFormat();
                                    punchInController.fromDate.text =
                                        BaseUtitiles
                                            .initiateCurrentDateFormat();
                                    punchInController.toDate.text = BaseUtitiles
                                        .initiateCurrentDateFormat();
                                    punchInController.filteredList.value =[];
                                    punchInController.punchFilterRxList.value = [];
                                    if (loginController.user.value.userType == "A") {
                                      staffController.Staffname.text = "--SELECT--";
                                      staffController.selectedstaffId.value = 0;
                                    } else {
                                      staffController.Staffname.text =
                                          loginController.user.value.empName
                                              .toString();
                                      staffController.selectedstaffId.value =
                                          loginController.user.value.empId!;
                                    }
                                    Get.to(() => const PunchInOutReports());
                                }
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  homeScreen() {
    if (loginController.user.value.userType == "A") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Dashboard_screen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
    }
  }
}
