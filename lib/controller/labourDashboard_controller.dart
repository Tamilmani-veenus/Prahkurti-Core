import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../commonpopup/labourAttendanceChart.dart';
import '../commonpopup/labourAttendanceTable.dart';
import '../models/labourDashboard_model.dart';
import '../newhome/maindashboard/labourDashboard.dart';
import '../provider/labourDashboard_Provider.dart';
import '../utilities/baseutitiles.dart';

class LabourDashboardController extends GetxController{

  final labourEntryFromDate = TextEditingController();
  final labourEntryToDate = TextEditingController();
  RxString selectedDate = BaseUtitiles.selectDateFormat(DateTime.now()).obs;
  RxBool isLoading = false.obs;

  Rx<LabourDashboardResponse?> dashboardResponse = Rx<LabourDashboardResponse?>(null);
  RxList<LabourCategoryWise> labourCategoryList = <LabourCategoryWise>[].obs;
  RxList<TodayAttendance> todayAttendanceList = <TodayAttendance>[].obs;
  RxList<TodayAttendance> allTodayAttendanceList = <TodayAttendance>[].obs;  // Filter search
  RxList<ProjectWiseLabour> projectWiseLabourList = <ProjectWiseLabour>[].obs;
  RxList<ProjectWiseLabour> filteredProjects = <ProjectWiseLabour>[].obs;
  RxList<SubContractorWiseLabourTradeChart> subcontWiseLabourSummaryList = <SubContractorWiseLabourTradeChart>[].obs;
  RxList<SubContractorWiseLabourTradeChart> subcontractorfilteredProjects = <SubContractorWiseLabourTradeChart>[].obs;
  RxList<SubContractorWiseLabour> subContractorWiseLabour = <SubContractorWiseLabour>[].obs;

/// -------Category-wise
  final RxBool showAllLabours = false.obs;
  RxBool showAll = false.obs;
  RxList<String> projectList = <String>[].obs;

  Future<void> getLabourDashboardDetails() async {

    try {
      isLoading.value = true;
      final response = await LabourDashboardProvider.getLabourDashboard(labourEntryFromDate.text,labourEntryToDate.text);
      if (response != null && response.success == true) {
        dashboardResponse.value = response;
        labourCategoryList.assignAll(response.labourCategoryWise ?? []);
        todayAttendanceList.assignAll(response.todayAttendance ?? [],);
        allTodayAttendanceList.assignAll(response.todayAttendance ?? []);
        projectList.assignAll(
          allTodayAttendanceList
              .map((e) => e.projectName ?? "")
              .toSet()
              .toList(),
        );
        projectList.insert(0, "All");
        filteredProjects.assignAll(response.projectWiseLabour ?? []);
        projectWiseLabourList.assignAll(response.projectWiseLabour ?? []);
        subcontractorfilteredProjects.assignAll(response.subContractorWiseLabourTradeChart ?? []);
        subcontWiseLabourSummaryList.assignAll(response.subContractorWiseLabourTradeChart ?? []);
        subContractorWiseLabour.assignAll(response.subContractorWiseLabour ?? []);

      } else {
        dashboardResponse.value = null;
      }
    } catch (e) {
      print("Dashboard Error : $e");
      dashboardResponse.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Color getCategoryColor(int index) {
    const colors = [
      Color(0xff2563eb),
      Color(0xff7c3aed),
      Color(0xfff97316),
      Color(0xff0d9488),
      Color(0xffd97706),
      Color(0xffe11d48),
      Color(0xff68717c),
      Color(0xff76c5ad),
      Color(0xffb574f0),
      Color(0xffF97316),
    ];

    return colors[index % colors.length];
  }

  IconData getCategoryIcon(String? name) {
    switch ((name ?? "").toLowerCase()) {
      case "mc":
        return Icons.engineering;

      case "fc":
        return Icons.person;

      case "mason":
        return Icons.construction;

      case "fitter":
        return Icons.build;

      case "fitter helper":
        return Icons.handyman;

      case "surveyor":
        return Icons.straighten;

      case "painter":
        return Icons.format_paint;

      case "plumber":
        return Icons.plumbing;

      case "tiles mason":
        return Icons.grid_view;

      default:
        return Icons.groups;
    }
  }
  double get totalLabour {
    return labourCategoryList.fold(
      0.0,
          (sum, item) => sum + (item.totalNos ?? 0),
    );
  }




  void filterAttendance(String query) {
    if (query.trim().isEmpty) {
      todayAttendanceList.assignAll(allTodayAttendanceList);
      return;
    }

    query = query.toLowerCase();

    todayAttendanceList.assignAll(
      allTodayAttendanceList.where((item) {
        return (item.labourAttendanceNo ?? "")
            .toLowerCase()
            .contains(query) ||
            (item.projectName ?? "")
                .toLowerCase()
                .contains(query) ||
            (item.siteName ?? "")
                .toLowerCase()
                .contains(query) ||
            (item.subContractorName ?? "")
                .toLowerCase()
                .contains(query) ||
            // (item.employeeName ?? "")
            //     .toLowerCase()
            //     .contains(query) ||
            (item.totNos?.toString() ?? "")
                .contains(query) ||
            (item.totAmt?.toString() ?? "")
                .contains(query);
      }).toList(),
    );
  }

  void filterByProject(String project) {
    if (project == "All") {
      todayAttendanceList.assignAll(allTodayAttendanceList);
      return;
    }

    todayAttendanceList.assignAll(
      allTodayAttendanceList.where(
            (e) => e.projectName == project,
      ),
    );
  }
}



