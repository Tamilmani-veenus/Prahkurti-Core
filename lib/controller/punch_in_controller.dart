import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:prahkurticore/controller/site_location_controller.dart';
import '../constants/storage_constant.dart';
import '../models/punch_filter_response.dart';
import '../models/punch_in_model.dart';
import '../models/punch_in_payload.dart';
import '../models/punch_out_payload.dart';
import '../newhome/maindashboard/dashboard_otheruser.dart';
import '../provider/punch_in_provider.dart';
import '../utilities/baseutitiles.dart';
import 'logincontroller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeState {

  PunchFilterResponse? _punchFilterResponse;
  PunchFilterResponse? get punchFilterResponse => _punchFilterResponse;

  // TodayPunchInResponse? _todayPunchInResponse;
  // TodayPunchInResponse? get todayPunchInResponse => _todayPunchInResponse;

  HomeState();
}

class PunchInController extends GetxController with StateMixin<HomeState> {
  LoginController loginController = Get.put(LoginController());
  SiteLocationController siteLocationController = Get.put(SiteLocationController());

  final Rxn<XFile> imageFile = Rxn<XFile>();
  final Rxn<XFile> punchOutImageFile = Rxn<XFile>();
  RxBool isSelect = false.obs;
  String? currentTime = "";
  String? currentDate = "";
  String? networkTime = "";
  String currentDates = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<Result>? todayPunchInList = [];
  List<EmployeeTiming>? punchFilterList = [];
  RxList punchFilterRxList = [].obs;
  TextEditingController todayDate = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController punchInRemarks = TextEditingController();
  TextEditingController punchOutRemarks = TextEditingController();
  TextEditingController todayTaskPunchOut = TextEditingController();
  TextEditingController tomorrowPlanPunchOut = TextEditingController();
  TextEditingController todayRpteditingController = TextEditingController();
  List<PunchInPayload> punchInDetails = [];
  List<PunchOutPayload> punchOutDetails = [];
  RxInt punchInButtonSts=0.obs;
  RxString resPunchSts="FALSE".obs;
  RxString allotedSts="false".obs;
  RxString appStatus="N".obs;
  RxString punchInLat="0".obs;
  RxString punchInLon="0".obs;
  RxString punchInAddress="0".obs;
  RxString punchInDate="0".obs;
  RxString punchNo="0".obs;
  RxInt selectedRadio=0.obs;
  RxList originalList = [].obs; // Full list from API
  RxList filteredList = [].obs; // List to display based on search

  @override
  void onInit() async {
    super.onInit();
    change(HomeState(), status: RxStatus.success());
  }

  Future<void> getDateAndTime() async {
    DateTime now = DateTime.now();
    currentTime = DateFormat('hh:mm:ss a').format(now);
    currentDate = DateFormat('yyyy-MM-dd').format(now);

    if (kDebugMode) {
      print("Current time :: $currentTime");
      print("Current date :: $currentDate");
    }
  }

  Future<void> getNetworkTime() async {
    DateTime now = await NTP.now();
    currentTime = DateFormat('hh:mm:ss a').format(now);
    currentDate = DateFormat('yyyy-MM-dd').format(now);
    networkTime = DateFormat('dd-MM-yyyy hh:mm a').format(now);
    print("Current time (via NTP): $currentTime");
    print("Current date (via NTP): $currentDate");
  }

  getProjectPunchInSts() async {
    await loginController.getPunchInStatus().then((value){
      resPunchSts.value=value.punchStatus.toString();
      siteLocationController.punchInID.value=value.punchInandOutId.toString();
      allotedSts.value=value.punchInStatus.toString();
      appStatus.value=value.approveStatus.toString();
      punchInDate.value=value.punchInDate.toString();
      punchNo.value=value.punchNo.toString();
      selectedRadio.value=0;
    });
  }

  /// ---------- PunchIn Controller -------------

  Future punchInSave(allotedStatus,context) async {
    final data = await PunchInProvider.punchInProvider(
        PunchInSaveModel(
          Id: 0,
          EmployeeId: int.tryParse(loginController.EmpId()),
          InLocid:int.tryParse(siteLocationController.locId!),
          InDate: currentDate.toString(),
          InTime: currentTime.toString(),
          InStatus: allotedStatus,
          InNAPRemarks: allotedStatus=="Y"?"-":punchInRemarks.text.toString(),
        ),
        File(imageFile.value!.path),
        context);

    if(data!=null) {
      if (data["success"] == true) {
        BaseUtitiles.showToast(data["message"]);
        Get.to(() => DashboardScreen_OtherUser());
        getProjectPunchInSts();
      }
      else {
        BaseUtitiles.showToast(data["message"] ?? "Something went wrong...");
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong...");
    }
  }


  /// ---------- PunchOut Controller -------------

  Future punchOutUpdate(context,fromStatus) async {
    final data = await PunchInProvider.punchOutProvider(
        PunchOutSaveModel(
          id: int.tryParse(siteLocationController.punchInID.value),
      EmployeeId: int.tryParse(loginController.EmpId()),
      OutLocId: int.tryParse(siteLocationController.locId!),
      OutDate: currentDate,
      OutTime: currentTime,
      OutStatus: fromStatus,
      TodayTask: todayTaskPunchOut.text,
      TomorrowTask: tomorrowPlanPunchOut.text,
          OutNAPRemarks: fromStatus=="N"?punchOutRemarks.text:"-",
      InDate: punchInDate.toString(),
    ),
        File(punchOutImageFile.value!.path),
        context);

    if(data!=null) {
      if (data["success"] == true) {
        BaseUtitiles.showToast(data["message"]);
        Get.to(() => DashboardScreen_OtherUser());
        getProjectPunchInSts();
      }
      else {
        BaseUtitiles.showToast(data["message"] ?? "Something went wrong...");
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong...");
    }
  }

  /// ---------- Today Punch In Controller -------------

  Future todayPunchInController(Url, String todayDate,{String? todate,int? empId}) async {
    originalList.value= [];
    punchFilterRxList.value = [];
    filteredList.value=[];
    var response = await PunchInProvider.todayPunchInProvider(
        todayDate.toString(),
        Url == "Old Reports" ? todate.toString() : todayDate.toString(),Url == "Old Reports" ? empId : 0);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          if(Url == "Old Reports")
            {
              punchFilterRxList?.assignAll(response.result!);
            }
          else
            {
              originalList?.assignAll(response.result!);
              filteredList.value = List.from(originalList!);
            }
        }
        else {
          BaseUtitiles.showToast("No Data Found");
        }
      }  else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  // Future<void> todayPunchInController(String todayDate) async {
  //   HomeState homeState = state!;
  //   TodayPunchInResponse todayPunchInResponse = await PunchInProvider().todayPunchInProvider(todayDate.toString());
  //   homeState._todayPunchInResponse = todayPunchInResponse;
  //   if (todayPunchInResponse.employeeTimingTodaywise!.isNotEmpty) {
  //     originalList = todayPunchInResponse.employeeTimingTodaywise;
  //     update();
  //     // todayPunchInList = todayPunchInResponse.employeeTimingTodaywise;
  //     // update();
  //   } else {
  //     BaseUtitiles.showToast("No record found...");
  //   }
  // }




  void filterSearchTodayReport(String value) {
    if (value.isNotEmpty) {
      filteredList.value = originalList!
          .where((item) =>
      (item.staffName ?? "").toLowerCase().contains(value.toLowerCase()) ||
          (item.punchDetails?.any((detail) =>
          (detail.projectAddress ?? "").toLowerCase().contains(value.toLowerCase()) ||
              (detail.punchInTime ?? "").contains(value) ||
              (detail.projectAddress ?? "").toLowerCase().contains(value) ||
              (detail.punchOutTime ?? "").contains(value) )?? false)
      )
          .toList();
    } else {
      filteredList.value = List.from(originalList!);
    }
    update(); // or setState if using StatefulWidget
  }




}
