import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/bill_genration_direct_entrylist_model.dart';

import '../models/billdirectgstcalculations.dart';
import '../models/directbill_editapi_res_model.dart';
import '../models/directbill_itemlistdet_resmodel.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
// import '../models/workOrderListDet_model.dart';/
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class DirectBillGenerateProvider {

  static Future<BillDirectentrylist?> getBillDirectEntry_List(String frdate, String todate) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_DIRECTBILL_ENTRY_LIST + "?fromDate=$frdate&toDate=$todate");
      print("AdvEntryList:" + value);
      return billDirectentrylistFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }

  static Future<BillDirectDetCalculations?> getBillDirectCalculation_List() async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_DIRECTBILL_CALCULATION_LIST);
      print("AdvEntryList:" + value);
      return billDirectDetCalculationsFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }

  static Future<dynamic> billadv_balance(int pId,int subId) async {
    try {
      final value = await ApiManager.getAPICall(ApiConstant.GET_DIRECTBILL_ADVANCE_BALANCE+"?projectId=$pId&subcontractorId=$subId");
      print('API Response: ${value}');
      return jsonDecode(value);

    } catch (error) {
      print("Error == $error");
      return null;
    }
  }


  static Future<BillDirectWorkOrdDet?> getWorkOrderList(int pId,int sId, int subId, int workOrderNo,type,toDate) async {
    try{
      final value = await ApiManager.getAPICall(
          "${ApiConstant.GET_WORKORDER_ENTRY_LIST}?projectId=$pId&siteId=$sId&subcontractorId=$subId&workOrderId=$workOrderNo"
      );
      print("AdvEntryList:" + value);
      return billDirectWorkOrdDetFromJson(value);
    }
    catch(e,s){
      print("ERROR.....$e");
      print("ERROR...${s}");
      return null;
    }
  }

  static SaveSubContScreenEntryAPI(String body, int id, context) async {
    try {
      var response;

      if (id != 0) {
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_DIRECTBILL_UPDATE_API}?id=$id", body);
      } else {
        response = await ApiManager.postAPICall(ApiConstant.DIRECTBILL_SAVE_API, body);
      }
      return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<DirectbillEditApiResModel?> directBill_entryList_editAPI(int workId) async {
    try{
      final value = await ApiManager.getAPICall("${ApiConstant.EDIT_DIRECTBILL_API}?id=$workId");
      print("AdvEntryList:" + value);
      return directbillEditApiResModelFromJson(value);
    }
    catch(e,F){
      print("ERROR.....$e");
      print("ERROR.....$F");
      return null;
    }
  }





  static Future<bool> entryList_deleteAPI(int WorkId,status) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_DIRECTBILL_API}?id=$WorkId&isList=$status");

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