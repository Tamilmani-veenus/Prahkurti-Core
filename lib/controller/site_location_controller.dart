import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/storage_constant.dart';
import '../db_model/siteLocation_DB_Model.dart';
import '../db_services/sitelocation_db_services.dart';
import '../models/set_site_location_payload.dart';
import '../models/set_site_location_response.dart';
import '../models/site_location_payload.dart';
import '../models/site_location_response.dart';
import '../newhome/maindashboard/dashboard.dart';
import '../provider/site_location_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class SiteLocationController extends GetxController {

  TextEditingController radius = TextEditingController();
  TextEditingController projectNameSearch = TextEditingController();
  LoginController loginController = Get.put (LoginController());
  RxList<Result> projectNameRxList = <Result>[].obs;
  List<Result> projectNameList = <Result>[].obs;

  String? siteName;
  String? punchInAddress = "";
  String? latitude = "";
  String? longitude = "";
  String? projectId = "";
  String? locId = "";
  RxString punchInID="0".obs;

  /// Get Site Name.....

  Future<void> getProjectName(allotedStatus,checkValue) async {
    projectNameList=[];
    projectNameRxList.value=[];
    final value = await SiteLocationProvider.siteLocationProvider(
        loginController.user.value.userId,
        loginController.user.value.empId,
        punchInID.value,
        checkValue,
        allotedStatus,
        loginController.UserType(),
        projectNameSearch.text
    );
    if(value!=null) {
      if(value.success==true ) {
        if (value.result!.isNotEmpty) {
          projectNameList = value.result!;
          projectNameRxList.value = projectNameList;
        }
        else{
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      }
      else{
        BaseUtitiles.showToast(value.message ?? "Something went wrong..");
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  /// Set Site Location .....

  Future<void> setSiteLocation(String pId) async {
    final payload = SetSiteLocationPayload(
      id:0,
      projectid: int.tryParse(pId),
      latitude: latitude,
      longitude: longitude,
      address: punchInAddress,
      radius: int.tryParse(radius.text),
    );
    final value = await SiteLocationProvider.setSiteLocationAPI(payload);
    if (value != null) {
      if(value["success"] == true){
        BaseUtitiles.showToast(value["message"]);
        Get.to(()=> const Dashboard_screen());
      }
      else {
        BaseUtitiles.showToast(value?.message ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast( "Something went wrong..");
    }
  }

}