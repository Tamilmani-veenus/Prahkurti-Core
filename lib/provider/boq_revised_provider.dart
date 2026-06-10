import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';

import '../models/boq_approval_det_model.dart';
import '../models/boqrevised_itemlist_model.dart';
import '../models/boqrevisededitresponse.dart';
import '../models/boqrevisedentrylist_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class BoqRevised_Provider{

  static Future<BoqRevisedEntryListResponse?> get_boq_EntryList(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_BOQ_ENTRY_LIST}?fromDate=$frdate&toDate=$todate");
      return boqRevisedEntryListResponseFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<ApproveDetResponse?> getApprovalDetList(id) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_APP_DET_LIST}?id=$id");
      return approveDetResponseFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  //-----Itemlist--
  static Future<BoqRevisedItemResponse?> getRevisedItemlist(int? reviseId,int? pid, int? sid, int? headItemId) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GETREVISEDITEMLIST}?revisedId=$reviseId&projectId=$pid&siteId=$sid&headItemId=$headItemId");
      return boqRevisedItemResponseFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }
  // -----------Save API------------

  static SaveBoqRevisedScreenEntryAPI(String body, int reviseId, saveButton) async {
    try {
      var response;

      if (saveButton==RequestConstant.RESUBMIT) {
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_BOQREVISED_UPDATE_API}?id=$reviseId", body);
      } else if (saveButton==RequestConstant.SUBMIT) {
        response = await ApiManager.postAPICall(ApiConstant.BOQREVISED_SAVE, body);
      } else{
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_BOQREVISED_APPROVE_API}?id=$reviseId", body);
      }
      return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
    }
  }

//----Edit---

  static Future<BoqRevisedEditResponse?> Boq_RevisedList_editAPI(int Revise_Id,status) async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_BOQREVISED_EDIT_API + "?id=$Revise_Id&checkEdit=$status");
      return boqRevisedEditResponseFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }
  //---Delete API----

  static Future<bool> BoqRevised_entryList_deleteAPI(int Revise_Id) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_BOQREVISED_ENTRYLIST_API}?id=$Revise_Id");

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

}