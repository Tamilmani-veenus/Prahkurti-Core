import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../newhome/reports/punch_reports/punch_search_reports.dart';
import '../../../../newhome/reports/punch_reports/punch_today_reports.dart';
import '../../../app_theme/app_colors.dart';
import '../../../controller/bottomsheet_Controllers.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/punch_in_controller.dart';
import '../../../controller/staffcontroller.dart';
import '../../../utilities/baseutitiles.dart';

class PunchInOutReports extends StatefulWidget {
  const PunchInOutReports({Key? key}) : super(key: key);

  @override
  State<PunchInOutReports> createState() => _PunchInOutReportsState();
}

class _PunchInOutReportsState extends State<PunchInOutReports> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  PunchInController punchInController = Get.put(PunchInController());
  LoginController loginController = Get.put(LoginController());
  StaffController staffController = Get.put(StaffController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        punchInController.filteredList.clear();
        punchInController.punchFilterRxList.clear();
        punchInController.todayRpteditingController.text = "";
        if (loginController.user.value.userType == "A") {
          staffController.Staffname.text = "--SELECT--";
          staffController.selectedstaffId.value = 0;
        }
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Setmybackground,
          title: const Text(
            'Punch reports',
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.watch_later_outlined, color: Colors.indigo), text: 'Today report'),
              Tab(icon: Icon(Icons.calendar_month_outlined, color: Colors.indigo), text: 'Old reports')
            ],
          ),
        ),
        body: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: TabBarView(
            controller: _tabController,
            children: [ PunchTodayReports(), PunchSearchReports()],
          ),
        ),
      ),
    );
  }
}
