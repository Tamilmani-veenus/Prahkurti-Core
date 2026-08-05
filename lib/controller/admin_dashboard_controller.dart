import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/admin_dashboard_response.dart';
import '../provider/labourDashboard_Provider.dart';

class AdminDashboardController extends GetxController{
  RxBool isLoading = false.obs;
  final entryFromDate = TextEditingController();
  final entryToDate = TextEditingController();
  Rx<AdminDashboardResponse?> dashboardResponse = Rx<AdminDashboardResponse?>(null);
  RxList<PoVsbillTable> poVsBillTableList = <PoVsbillTable>[].obs;
  RxList<PoVsbillTable> allPoVsBillTableList = <PoVsbillTable>[].obs;  // Filter search
  RxList<BudgetVsSpend> allBudgetVsSpendList = <BudgetVsSpend>[].obs;
  RxList<BudgetVsSpend> filteredBudgetVsSpendList = <BudgetVsSpend>[].obs;
  RxList<ExpenseCategoryMix> expenseCategoryMixList = <ExpenseCategoryMix>[].obs;
  RxList<BoqProgress> boqProgressTableList = <BoqProgress>[].obs;
  RxList<BoqProgress> allBoqProgressTableList = <BoqProgress>[].obs;  // Filter search

  final List<String> poVsBillStatusList = [
    "All Status",
    "Match",
    "Under Billed",
    "Over Billed",
  ];

  final List<String> boqProgressStatusList = [
    "All Status",
    "Delayed",
    "Ahead",
    "On-Track",
  ];

  RxString selectedStatus = "All Status".obs;

  Future<void> getAdminDashboardDetails() async {
    try {
      isLoading.value = true;
      final response = await LabourDashboardProvider.getAdminDashboard(entryFromDate.text,entryToDate.text);
      if (response != null && response.success == true) {
        dashboardResponse.value = response;
        poVsBillTableList.assignAll(response.poVsbillTable ?? []);
        allPoVsBillTableList.assignAll(response.poVsbillTable ?? []);
        filteredBudgetVsSpendList.assignAll(response.budgetVsSpend ?? []);
        allBudgetVsSpendList.assignAll(response.budgetVsSpend ?? []);
        expenseCategoryMixList.assignAll(response.expenseCategoryMix != null ? [response.expenseCategoryMix!] : []);
        boqProgressTableList.assignAll(response.boqProgress ?? []);
        allBoqProgressTableList.assignAll(response.boqProgress ?? []);
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

  void filterPoVsBillValues(String query) {
    if (query.trim().isEmpty) {
      poVsBillTableList.assignAll(allPoVsBillTableList);
      return;
    }
    query = query.toLowerCase();

    poVsBillTableList.assignAll(
      allPoVsBillTableList.where((item) {
        return (item.projectName ?? "").toLowerCase().contains(query) ||
            (item.totalPOs?.toString() ?? "").contains(query) ||
            (item.poValue ?? "").toLowerCase().contains(query) ||
            (item.billValue ?? "").toLowerCase().contains(query) ||
            (item.billingPercent ?? "").toLowerCase().contains(query) ||
            (item.variance ?? "").toLowerCase().contains(query) ||
            (item.varianceLabel ?? "").toLowerCase().contains(query);
      }).toList(),
    );
  }

  void filterBOQProgressValues(String query) {
    if (query.trim().isEmpty) {
      boqProgressTableList.assignAll(allBoqProgressTableList);
      return;
    }
    query = query.toLowerCase();

    boqProgressTableList.assignAll(
      allBoqProgressTableList.where((item) {
        return (item.projectName ?? "").toLowerCase().contains(query) ||
            (item.plannedPercentage?.toString() ?? "").contains(query) ||
            (item.actualPercentage?.toString() ?? "").contains(query) ||
            (item.boqValue ?? "").toLowerCase().contains(query) ||
            (item.progress ?? "").toLowerCase().contains(query) ||
            (item.status ?? "").toLowerCase().contains(query) ||
            (item.startDate ?.toString() ?? "").contains(query) ||
            (item.endDate ?.toString() ?? "").contains(query);
      }).toList(),
    );
  }

  double getProgress(String? percentage) {
    if (percentage == null || percentage.isEmpty) return 0.0;

    final value = double.tryParse(
      percentage.replaceAll('%', '').trim(),
    );

    return ((value ?? 0) / 100).clamp(0.0, 1.0);
  }

  Color getVarianceColor(String? label) {
    if (label == null) return Colors.black;

    if (label.startsWith("Match")) {
      return Colors.green; // or Colors.red if you really want Match to be red
    } else if (label.startsWith("Under")) {
      return Colors.orange.shade800;
    } else if (label.startsWith("Over")) {
      return Colors.red;
    }

    return Colors.black;
  }

  Color getStatusColor(String? status) {
    final value = status
        ?.replaceAll(" ", "")
        .replaceAll("-", "")
        .toLowerCase() ??
        "";

    switch (value) {
      case "ahead":
        return Colors.green;

      case "delayed":
        return const Color(0xFFFB2C36);

      case "ontrack":
        return Colors.blueAccent.shade700;

      default:
        return Colors.orange;
    }
  }

  void filterProjects() {
    if (selectedStatus.value == "All Status") {
      poVsBillTableList.assignAll(allPoVsBillTableList);
    } else if (selectedStatus.value == "Match") {
      poVsBillTableList.assignAll(
        allPoVsBillTableList.where(
              (e) => e.varianceLabel?.startsWith("Match") ?? false,
        ),
      );
    } else if (selectedStatus.value == "Under Billed") {
      poVsBillTableList.assignAll(
        allPoVsBillTableList.where(
              (e) => e.varianceLabel?.startsWith("Under") ?? false,
        ),
      );
    } else if (selectedStatus.value == "Over Billed") {
      poVsBillTableList.assignAll(
        allPoVsBillTableList.where(
              (e) => e.varianceLabel?.startsWith("Over") ?? false,
        ),
      );
    }
  }

  void filterBOQProgressProjects() {
    if (selectedStatus.value == "All Status") {
      boqProgressTableList.assignAll(allBoqProgressTableList);
    } else if (selectedStatus.value == "Delayed") {
      boqProgressTableList.assignAll(
        allBoqProgressTableList.where(
              (e) => e.status?.startsWith("Delayed") ?? false,
        ),
      );
    } else if (selectedStatus.value == "Ahead") {
      boqProgressTableList.assignAll(
        allBoqProgressTableList.where(
              (e) => e.status?.startsWith("Ahead") ?? false,
        ),
      );
    } else if (selectedStatus.value == "On-Track") {
      boqProgressTableList.assignAll(
        allBoqProgressTableList.where(
              (e) => e.status?.startsWith("On-Track") ?? false,
        ),
      );
    }
  }


}