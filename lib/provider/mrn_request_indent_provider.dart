import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import '../apimanager/apimanager.dart';
import '../models/materialeditresponse_model.dart';
import '../models/mrn_request_indent_model.dart';
import '../models/mrnrq_addmat_resmodel.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class Mrn_Req_provider{

  static Future<MrNentrylist?> getmrnreqEntry_List(String frdate, String todate) async {

    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GETMRNREQUEST_ENTRY_LIST}?Frdate=$frdate&Todate=$todate&projectId=0");

      MrNentrylist data = mrNentrylistFromJson(value);

      return data;

    } catch (error) {
      print(error);
      return null;

    }
  }

  static Future<dynamic> getCheckApprovalLevel() async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_CHECKAPPROVALLEVELAPI);
      return jsonDecode(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<dynamic> getAppTypeListAPI() async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.GET_APPTYPE_API);
      return jsonDecode(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  // -----------Save API------------

  static Future<dynamic> SaveMaterialScreenEntryAPI(String body, reqId, saveButton, context) async {

    try {
      var response;
      if(saveButton == RequestConstant.SUBMIT){
        response = await ApiManager.postAPICall(ApiConstant.MATERIALREQUEST_SAVE, body);
      }
      else if(saveButton == RequestConstant.RESUBMIT || saveButton == RequestConstant.VERIFY){
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_MATERIALREQUEST_UPDATE_API}/$reqId", body);
      }
      else if(saveButton == RequestConstant.PREAPPROVAL){
        response = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_MRNPREAPPROVAL_APPROVE_API, body);
      }
      else if(saveButton == RequestConstant.APPROVAL){
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_MRNFINALAPPROVAL_APPROVE_API}/$reqId", body);
      }

      return jsonDecode(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }



//---Save API---

//----Edit---
  static Future<MaterialeditResponse?> Material_IntentList_editAPI(int reqId) async {
    try {
      final value = await ApiManager.getAPICall("${ApiConstant.GET_MATERIAL_EDIT_API}/$reqId");
      return materialeditResponseFromJson(value);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  //---Delete API----

  static Future<bool> Material_entryList_deleteAPI(int reqId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_MATERIAL_ENTRYLIST_API}/$reqId");

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

  static Future<List<MrnReqAddMaterialResmodel>> addmatGetQtyApi() async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_MRNREQ_ADD_QTY).then((value) {
      final res = mrnReqAddMaterialResmodelFromJson(value);
      if (res != null && res.length > 0) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

}