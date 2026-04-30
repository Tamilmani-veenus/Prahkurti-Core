import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../models/tansferbet_getitemlist_resapi_model.dart';
import '../models/transbet_site_entrylistmodel.dart';
import '../models/transferbet_site_editapi_resmodel.dart';
import '../models/transferbet_site_getallpending_resmodel.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class TransferBetSiteProvider{

  static Future<List<TransferbetItemListApiRes>> getItemList(int? proId, int siteId, int reqId, String type) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETTRANSITEMLIST +
        "?ProjectId=$proId&SiteId=$siteId&ReqId=$reqId&Type=$type")
        .then((value) {
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

  static transferbet_Site_SaveApi(String body, int id) async {

    try {
      var response;
      if (id != 0) {
        response = await ApiManager.putUpdateAPIButton(
            "${ApiConstant.PUT_TRANSFERBET_SITE_UPDATE_API}?id=$id", body);
      }
      else{
        response = await ApiManager.postAPICall(
          ApiConstant.TRANSFERBET_SITE_SAVE_API,
          body,
        );
      }
      return jsonDecode(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<GetTransferSiteListResponse?> get_Entry_List(int? Userid, String UserType, String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_TRANSBETSITE_ENTRYLIST}?fromDate=$frdate&toDate=$todate");


      GetTransferSiteListResponse data = getTransferSiteListResponseFromJson(value);

      return data;
    } catch (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
      return null;
    }
  }

  static Future<StoreTransPendingView?> getStoreTransPendingViewAPI(int? trId, frSiteId) async {
    try{
      final value =await ApiManager.getAPICall("${ApiConstant.GETSTORETRANSPENDINGVIEWLIST}?ReqordId=$trId&FromSite=$frSiteId");
      return  storeTransPendingViewFromJson(value);
    } catch (error,e) {
      print(error);
      print("ERROR....${e}");
      BaseUtitiles.showToast('Something went wrong..');
      return null;
    }
  }



  static Future<TransferbetSiteEditApiResmodel?> entryList_editAPI(int pId,int sId, int frsId, int TransferId) async {
    try {
      final response = await ApiManager.getAPICall("${ApiConstant.EDIT_TRANSFERBET_SITE_API}?ProjectId=$pId&SiteId=$sId&FromSiteId=$frsId&TransferId=$TransferId");
      return transferbetSiteEditApiResmodelFromJson(response);
    }catch (error,e) {
    print("Delete API Error: $error");
    print("ERROR....${e}");
    return null; // ✅ important
    }
  }


  static Future<bool> entryList_deleteAPI(int TransferId) async {
    try {
      final response = await ApiManager.deleteAPICall("${ApiConstant.DELETE_TRANSFERBET_SITE_API}/$TransferId");

      final Map<String, dynamic> decoded = jsonDecode(response);
      print("response...${decoded}");

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

