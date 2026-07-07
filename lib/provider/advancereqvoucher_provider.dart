import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/advance_reqvoucher_new_controller.dart';
import '../models/AdvanceReqDeleteModel.dart';
import '../models/advreq_entrylist_editapi_resmodel.dart';
import '../models/advreqvoucher_entrylist_reqqpi_model.dart';
import '../models/sitewisepay_AdvReqVoucNew_model.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';

import '../utilities/requestconstant.dart';
import '../apimanager/apimanager.dart';

class AdvanceReqVoucherProvider{

  AdvanceReqVoucherController_new advanceReqVoucherControllernew = AdvanceReqVoucherController_new();

  static Future<AdvReqvoucherentrylistResapi?> getEntry_List(String frdate, String todate) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_ADVREQ_ENTRY_LIST + "?fromDate=$frdate&toDate=$todate");
      print("AdvanceEntryList:" + value);
      return advReqvoucherentrylistResapiFromJson(value);
    }
    catch(e,stack){
      print("ERROR.....$e");
      print("ERROR....${stack}");
      return null;
    }
  }

  //----------Advance Req Voucher New------------

  static Future<SitewisePaymentList?> getAdvTypeList(String payFor, int accTypeId,int accNameId, int pId  ) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GetADVREQ_SITEWISEPAYMENTLIST + "?AccountTypeId=$accTypeId&payFor=$payFor&accNameId=$accNameId&projectId=$pId");
      print("AdvanceEntryList:" + value);
      return sitewisePaymentListFromJson(value);
    }
    catch(e,stack){
      print("ERROR.....$e");
      print("ERROR....${stack}");
      return null;
    }
  }

  static SaveApi(String body, int id, saveButton) async {
    try {
      var response;

      if (saveButton==RequestConstant.RESUBMIT || saveButton==RequestConstant.APPROVAL) {
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_ADVREQ_UPDATE_API}?id=$id", body);
      } else if (saveButton==RequestConstant.SUBMIT) {
        response = await ApiManager.postAPICall(ApiConstant.ADVREQ_SAVE, body);
      }
      print("response....${response}");
      return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<AdvReqEditApiRes?> entryList_editAPI(vocId,status) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.EDIT_ADVANCEREQ_API + "?id=$vocId&CheckEdit=$status");
      print("AdvanceEntryList:" + value);
      return advReqEditApiResFromJson(value);
    }
    catch(e,stack){
      print("ERROR.....$e");
      print("ERROR....${stack}");
      return null;
    }
  }


  static Future<bool> entryList_deleteAPI(int vocId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_ADVREQVOUCHER_API}?id=$vocId");

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