import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/dailywrk_done_dpr_itemlist_save_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/requisitionslipeditlist_model.dart';
import '../models/requisitionslipentrylist_model.dart';
import '../models/staffReqType_model.dart';
import '../models/staffleavedetails.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class RequisitionslipProvider{


  static Future<RequisitonSlipEntrylistResponse?> getReqSlipEntry_List(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GETREQUISITIONSLIP_ENTRY_LIST}?fromDate=$frdate&toDate=$todate");
      return requisitonSlipEntrylistResponseFromJson(value);
    } catch (error,e) {
      print(error);
      print(e);
      return null;
    }
  }

  static Future<StaffReqTypeResponse?> getStaffReqTypeList() async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_STAFF_REQ_TYPE_LIST);
      return staffReqTypeResponseFromJson(value);
    } catch (error, e) {
      print(error);
      print("ERROR....${e}");
      return null;
    }
  }

  static SaveReqslipScreenEntryAPI(String body, int reqId) async {

    try {
      var response;

      if (reqId != 0) {
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_REQUISITIONSLIP_UPDATE_API}?id=$reqId", body);
      } else {
        response = await ApiManager.postAPICall(ApiConstant.REQUISITION_SAVE, body);
      }
      return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
    }
  }


//----Edit---

  static Future<RequisitonSlipEditList?> Requisitionslip_editAPI(int reqId,status) async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_REQUISITION_EDIT_API + "?id=$reqId&CheckEdit=$status");
      return requisitonSlipEditListFromJson(value);
    } catch (error,e) {
      print(error);
      print(e);
      return null;
    }
  }

  //---Delete API----

  static Future<bool> Requisitionslip_entryList_deleteAPI(int reqId,bool status) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_REQUISITION_ENTRYLIST_API}?id=$reqId&InList=$status");

      final Map<String, dynamic> decoded = jsonDecode(response);

      bool isSuccess = decoded["success"] == true;

      final message = decoded["message"] ??
          (isSuccess
              ? "Deleted successfully"
              : "Something went wrong");

      BaseUtitiles.showToast(message);

      return isSuccess;
    } catch (error) {
      print("Delete API Error: $error");
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      return false;
    }
  }

  //----------Satff Name leave details Pending------------
  static Future getStaffLeaveInfo_Provider(int empId) async {
    var data = null;
    await ApiManager.getAPICall("${"ApiConstant.GETSTAFFLEAVECAL"}?EmpId=$empId").then((value) {
      final res = staffLeaveDetailsFromJson(value);
      if (res != null) {
        data = res;
        return data;
      }else{
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    }, onError: (error) {
      // printToLog(error.toString());
      // printToLog("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }


}