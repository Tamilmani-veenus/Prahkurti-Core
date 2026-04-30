import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';

import '../models/subcont_entryscreen_save_model.dart';
import '../models/tansferbet_getitemlist_resapi_model.dart';
import '../models/transferbet_editapires_model.dart';
import '../models/transferbet_getalldatas_resapi_model.dart';
import '../utilities/requestconstant.dart';

import '../apimanager/apimanager.dart';
import '../models/transferbetweenproject_entrylist_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';

class TransferBetweenProject_provider{


  static Future<TransferbetAlldatasApiRes?> getTransferProj_ALLDatas(int? reqId) async {
    try{
     final value =await ApiManager.getAPICall(ApiConstant.TRANSFERPENDING_MOREDETAILS + "?reqMasId=$reqId");
      print("TransferAllDatast:" + value);
      return transferbetAlldatasApiResFromJson(value);

  }catch (error) {
       print(error);
       BaseUtitiles.showToast('Something went wrong..');
       return null;
     }
  }

  static Future<TransReqPendingView?> getTransPendingViewAPI(int? trId) async {
    try{
    final value =await ApiManager.getAPICall(ApiConstant.TRANSFER_REQUESTPENDING_MOREDETAILS + "?id=$trId");
      return  transReqPendingViewFromJson(value);
    } catch (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
      return null;
    }
  }

  static Future<GetTransferListResponse?> getTransProjectEntryList(int? Userid, String UserType, String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GETTRANSPROJECT_ENTRY_LIST}?fromDate=$frdate&ToDate=$todate");

      GetTransferListResponse data = getTransferListResponseFromJson(value);

      return data;
    } catch (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
      return null;
    }
  }


  static Future<List<TransferbetItemListApiRes>> getItemList(int? proId, int siteId, int reqId, String type) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETTRANSITEMLIST + "?ProjectId=$proId&SiteId=$siteId&ReqId=$reqId&Type=$type").then((value) {
      print("TransferprojectEntryList:" + value);
      data = transferbetItemListApiResFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static transferbet_SaveApi(String body, context) async {
    try {
        final response = await ApiManager.postAPICall(
          ApiConstant.TRANSFERBET_SAVE_API,
          body,
        );
        print("response...${response}");
        return jsonDecode(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<TransferbetEditApiRes?> entryList_editAPI(int TransferId) async {
    try {
      final value = await ApiManager.getAPICall(ApiConstant.EDIT_TRANSFERBET_API + "?id=$TransferId");
      return transferbetEditApiResFromJson(value);
    }
    catch (error, stackTrace)  {
      print("Error == $error");
      print("Error == ${stackTrace}");
      return null;
    }
  }

  static Future<bool> entryList_deleteAPI(int transferId) async {
    try {
      final response = await ApiManager.deleteAPICall(
        "${ApiConstant.DELETE_TRANSFERBET_API}?id=$transferId",
      );

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