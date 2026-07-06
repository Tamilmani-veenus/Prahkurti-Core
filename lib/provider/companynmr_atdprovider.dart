import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/cmpnmr_edit_resmodel.dart';
import '../models/companynmrentrylist_model.dart';
import '../models/companynmrlist_resmodel.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class CompanyNmrAttendance_Provider {

  static Future<CompanyNmrEntryListmodel?> Company_NmrEntryListAPI(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GET_COMPANY_NMRENTRYLISTAPI}?FromDate=$frdate&ToDate=$todate");
      return companyNmrEntryListmodelFromJson(value);
    } catch (error) {
      print(error);
      return null;

    }
  }

  static Future getLabourStatusListAPI() async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_LABOUR_STATUS_LISTAPI);
      return jsonDecode(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<bool> entryList_deleteAPI(int reqId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_COMPANYNMRLIST_API}?id=$reqId");

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

  static Future<CmpNmrEditResModel?> Company_NmrList_EditAPI(attenId,status) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GET_COMPANY_NMRLISTEDIT_API}?LabrAttdId=$attenId&CheckEdit=$status");
      return cmpNmrEditResModelFromJson(value);
    } catch (error) {
      print(error);
      return null;

    }
  }

  static Future<CompanyNmrAddListResModel?> getLabourListAPI(SubcontId) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GET_COMPANY_NMRALLLISTAPI}?subcontractorId=$SubcontId");
      return companyNmrAddListResModelFromJson(value);
    } catch (error) {
      print(error);
      return null;

    }
  }

  // -----------Save API------------

  static SaveEntryScreenAPI(String body, int reqId, context) async {

    try {
      var response;
       response = await ApiManager.postAPICall(ApiConstant.COMPANY_NMR_SAVE_API, body);
      return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
    }
  }

}