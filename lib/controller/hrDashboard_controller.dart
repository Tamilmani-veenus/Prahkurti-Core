import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/models/onclick_pendinglist_model.dart';
import '../models/hrDashboardCardsRes.dart';
import '../models/hr_Dashboard_Response.dart';
import '../models/planningCalendarRes_model.dart';
import '../models/planningCalendarUpdateRes_model.dart';
import '../provider/labourDashboard_Provider.dart';
import '../provider/pendinglist_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class HrDashboardController extends GetxController{
  RxBool isLoading = false.obs;

  final entryFromDate = TextEditingController();
  final entryToDate = TextEditingController();

  final TextEditingController calendarFromDateController =
  TextEditingController();

  final TextEditingController calendarToDateController =
  TextEditingController();

  Rx<HrDashboardResponse?> dashboardResponse = Rx<HrDashboardResponse?>(null);
  Rxn<KpiCards> hrCategoryList = Rxn<KpiCards>();
  Rxn<StaffAttendance> hrStaffAttendanceList = Rxn<StaffAttendance>();
  Rxn<LeaveOverview> hrLeaveOverViewList = Rxn<LeaveOverview>();
  Rxn<TodayPunchOverview> hrTodayPunchViewList = Rxn<TodayPunchOverview>();
  RxList<UpcomingHoliday> hrUpcomingHolidayList = <UpcomingHoliday>[].obs;
  RxList<RecentActivity> hrPunchRecentActivityList = <RecentActivity>[].obs;
  RxList<RecentActivity> filteredActivities = <RecentActivity>[].obs;
  Rxn<PendingLeaveRequest> hrPendingLeaveList = Rxn<PendingLeaveRequest>();
  RxList<MonthlyAttendance> hrMonthlyPerformance = <MonthlyAttendance>[].obs;

  RxList<OnClickListResult> pendingLeaveReqTypes = <OnClickListResult>[].obs;

  RxList<Employee> hrCardsactiveEmployeeList = <Employee>[].obs;
  RxList<Employee> hrCardspresentEmployeeList = <Employee>[].obs;
  RxList<Employee> hrCardsonLeaveEmployeeList = <Employee>[].obs;
  RxList<Employee> hrCardsLateEmployeeList = <Employee>[].obs;
  RxList<Employee> hrCardsOnTimeEmployeeList = <Employee>[].obs;
  RxList<Employee> hrCardsAbsentEmployeeList = <Employee>[].obs;

  RxList<PlanningCalendar> hrPlanningCalenList = <PlanningCalendar>[].obs;

  Future<void> getHrDashboardDetails() async {
    dashboardResponse.value = null;
    try {
      isLoading.value = true;
      final response = await LabourDashboardProvider.getHrDashboard(entryFromDate.text,entryToDate.text);
      if (response != null && response.success == true) {
        dashboardResponse.value = response;
        hrCategoryList.value = response.result?.kpiCards;
        hrStaffAttendanceList.value = response.result?.staffAttendance;
        hrLeaveOverViewList.value = response.result?.leaveOverview;
        hrTodayPunchViewList.value = response.result?.todayPunchOverview;
        hrUpcomingHolidayList.assignAll(response.result?.upcomingHoliday ?? []);
        hrPunchRecentActivityList.assignAll(response.result?.recentActivity ?? []);
        filteredActivities.assignAll(response.result?.recentActivity ?? []);
        hrPendingLeaveList.value = response.result?.pendingLeaveRequest;
        hrMonthlyPerformance.assignAll(response.result?.monthlyAttendance ?? []);
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

  Future getHrCardsList() async {
    hrCardsactiveEmployeeList.value.clear();
    final value = await LabourDashboardProvider.getHrDashboardCardsList(entryFromDate.text, entryToDate.text);
    if (value != null) {
      if(value.success == true){
        hrCardsactiveEmployeeList.assignAll(value.result?.activeEmployee ?? []);
        hrCardspresentEmployeeList.assignAll(value.result?.presentEmployee ?? []);
        hrCardsonLeaveEmployeeList.assignAll(value.result?.onLeaveEmployee ?? []);
        hrCardsLateEmployeeList.assignAll(value.result?.lateEmployee ?? []);
        hrCardsOnTimeEmployeeList.assignAll(value.result?.onTimeEmployee ?? []);
        hrCardsAbsentEmployeeList.assignAll(value.result?.absentEmployee ?? []);
      }
      else {
        BaseUtitiles.showToast(value.message ?? RequestConstant.NETWORKERROR);
      }
    }
    else{
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }
  }

  Future getPendingLeaveRequest() async {
    pendingLeaveReqTypes.value=[];
    var response = await PendingListProvider.getOnclickPendingListProvider("STAFF L & P VERIFICATION");
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          pendingLeaveReqTypes.assignAll(response.result!);
        }
        // else {
        //   BaseUtitiles.showToast("No Data Found");
        // }
      }  else {
        BaseUtitiles.showToast(response.message ?? RequestConstant.NETWORKERROR);
      }
    } else {
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }
  }

  Future getPlanningCalendar_List() async {
    hrPlanningCalenList.value.clear();
    var response = await LabourDashboardProvider.getPlanningCalendarList(
        calendarFromDateController.text,calendarToDateController.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          hrPlanningCalenList.assignAll(response.result!);
        }
        // else {
        //   BaseUtitiles.showToast("No Data Found");
        // }
      } else {
        BaseUtitiles.showToast(response.message ?? RequestConstant.NETWORKERROR);
      }
    } else {
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }
  }

  Future UpdateButton_PlannerCalendar(
      BuildContext context, {
        required int id,
        required String meetingTitle,
        required String meetingDate,
        required String meetingDescription,
        required String meetingTime,
        required String meetingStatus,
        required int assignedBy,
        required String createdDate,
        required int createdBy,
        required String active,
      }) async {
    final body = planningCalendarSaveResponseToJson(
      PlanningCalendarSaveResponse(
        id: id,
        meetingTitle: meetingTitle,
        meetingDate: meetingDate,
        meetingDescription: meetingDescription,
        meetingTime: meetingTime,
        meetingStatus: meetingStatus,
        assignedBy: assignedBy,
        createdDate: createdDate,
        createdBy: createdBy,
        active: active,
      ),
    );

    final list =
    await LabourDashboardProvider.UpdatePlanningCalen_EntryAPI(
      body,
      id,
      context,
    );

    if (list != null && list["success"] == true) {
      return true;
    }

    return false;
  }



  List<Employee> getEmployeesForCard(String title) {
    switch (title) {
      case "TOTAL EMPLOYEES":
        return hrCardsactiveEmployeeList.toList();

      case "PRESENT TODAY":
        return hrCardspresentEmployeeList.toList();

      case "ON LEAVE TODAY":
        return hrCardsonLeaveEmployeeList.toList();

      case "LATE PUNCH IN":
        return hrCardsLateEmployeeList.toList();

      case "ON TIME PUNCH IN":
        return hrCardsOnTimeEmployeeList.toList();

      case "ON ABSENT":
        return hrCardsAbsentEmployeeList.toList();


      default:
        return [];
    }
  }

}