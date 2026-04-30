import 'dart:convert';

import '../apimanager/apimanager.dart';
import '../models/materialeditresponse_model.dart';
import '../models/mrn_request_indent_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class MRNRequest_PreIndent_Provider{


  static Future<MrNentrylist?> getMRNReqPreIndent_EntryList(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GETMRNREQUEST_PREINDENT_ENTRYLIST}?fromDate=$frdate&toDate=$todate");
      MrNentrylist data = mrNentrylistFromJson(value);
      return data;
    }
    catch (error) {
      print(error);
      return null;
    }
  }


  // -----------Save API------------

  static Future<dynamic> SaveMaterialPreIndentEntryAPII(String body, reqId, saveButton, context) async {

    try {
      var response;
      if(saveButton == RequestConstant.SUBMIT){
        response = await ApiManager.postAPICall(ApiConstant.MATERIALREQUEST_PREINDENT_SAVE, body);
      }
      else if(saveButton == RequestConstant.RESUBMIT || saveButton == RequestConstant.VERIFY || saveButton == RequestConstant.APPROVAL){
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_MATERIALREQUEST_PREINDENT_UPDATE_API}?id=$reqId", body);
      }
      return jsonDecode(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static SaveMaterialPreIndentEntryAPI(String body, int reqId) async {
    var ratingRes = null;
    if(reqId!=0){
      await ApiManager.putUpdateAPIButton(ApiConstant.PUT_MATERIALREQUEST_PREINDENT_UPDATE_API, body).then((value) {
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          return ratingRes;
        }
      }, onError: (error) {
        print(error);
        BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      });
    }
    else{
      await ApiManager.postAPICall(ApiConstant.MATERIALREQUEST_PREINDENT_SAVE, body).then((value) {
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          return ratingRes;
        }
      }, onError: (error) {
        print(error);
        BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      });
    }
    return ratingRes;
  }

//----Edit---
  static Future<MaterialeditResponse?> Material_PreIntentList_editAPI(int reqId) async {
    try {
      final value = await ApiManager.getAPICall("${ApiConstant.GET_MATERIALREQPREINDEDNT_EDIT_API}?id=$reqId");
      return materialeditResponseFromJson(value);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }


  static Future<bool> Material_entryList_deleteAPI(int reqId) async {
    try {
      final response = await ApiManager.deleteAPICall("${ApiConstant.DELETE_MATERIALREQPREINDENT_ENTRYLIST_API}?id=$reqId");

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