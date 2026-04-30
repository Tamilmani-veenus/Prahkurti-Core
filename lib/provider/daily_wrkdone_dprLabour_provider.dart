import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/dailywrk_don_dpr_entrylistres_model.dart';
import '../models/dailywrk_don_dpr_labour_editapi_model.dart';
import '../models/dailywrk_done_dpr_itemlist_save_model.dart';
import '../models/dailywrk_done_dpr_labouritemlist.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class DPRLabourProvider{

  static Future<List<DprLaourItemlistRes>> get_DprLabour_ItemList(
      int? Projectid, int? SiteId, int? Subcontid, String entryType) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DPR_ITEM_LIST +
        "?PId=$Projectid&SId=$SiteId&SubId=$Subcontid&EntryType=$entryType")
        .then((value) {
      print("DPRLabourItemList:" + value);
      data = dprLaourItemlistResFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }


  static Future<String?> DPR_Labour_SaveAPI(dynamic body, int workId, int aprovedButton,context) async {
    String? ratingRes;

    try {
      dynamic value;

      if (workId != 0) {
        // If it's an approval update
        if (aprovedButton != 0) {
          value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_DPR_LABOUR_APROVE_API, body);
        } else {
          // Just update
          value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_DPR_LABOUR_UPDATE_API, body);
        }
      } else {
        // Save new record
        value = await ApiManager.postAPICall(ApiConstant.DPR_LABOUR_SAVE_API, body);
      }

      var response = dprItemscreenSaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
      }

    }  on SocketException catch (_) {
      BaseUtitiles.showToast(RequestConstant.NOINTERNETCONNECTION);
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    }
    on TimeoutException catch (_) {
      BaseUtitiles.showToast(RequestConstant.REQUESTTIMEOUT);
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    }
    on FormatException catch (_) {
      BaseUtitiles.showToast(RequestConstant.BADRESPONSE);
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    } catch (error) {
      print('❌ Error in DPR_Labour_SaveAPI: $error');
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }

    return ratingRes;
  }

  static Future<List<DailywrkDoneDprEntrylistResmodel>> getLabour_dpr_EntryList(int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DPR_LABOUR_ENTRY_LIST + "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      data = dailywrkDoneDprEntrylistResmodelFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(error);
    });
    return data;
  }

  static Future<List<DailywrkdonDprLabourEditApiRes>> dprLabour_entryList_editAPI(int workId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DPR_LABOUR_EDIT_API + "?WorkId=$workId").then((value) {
      final res = dailywrkdonDprLabourEditApiResFromJson(value);
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

  static Future entryList_deleteAPI(int WorkId,  String WorkNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_DPRLABOUR_ENTRYLIST_API +
        "?WorkId=$WorkId&WorkNo=$WorkNo&UserId=$UserId&DeviceName=$DeviceName")
        .then((value) {
      final res = json.decode(value);
      if (res != null) {
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