import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';

import '../models/boqrevised_itemlist_model.dart';
import '../models/boqrevisededitresponse.dart';
import '../models/boqrevisedentrylist_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class BoqRevised_Provider{
  static Future<List<BoqRevisedEntrylistResponse>> get_boq_EntryList(int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_BOQ_ENTRY_LIST + "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("BoqRevisedEntryList:" + value);
      data = boqRevisedEntrylistResponseFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(error);
    });
    return data;
  }

  //-----Itemlist--
  static Future<List<BoqRevisedItemlistResponse>> getRevisedItemlist(
      int? pid, int? sid) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETREVISEDITEMLIST +
        "?PId=$pid&SId=$sid&SubId=0&EntryType=N")
        .then((value) {
      print("ItemList:" + value);
      data = boqRevisedItemlistResponseFromJson(value);
      if (data != null && data.length > 0) {
        return data;

      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  // -----------Save API------------

  static SaveBoqRevisedScreenEntryAPI(String body, int reviseId, int buttonControl,context) async {
    String? ratingRes;

    try {
      dynamic value;

      if (reviseId != 0) {
        // Update existing
        value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_BOQREVISED_UPDATE_API, body);
      } else {
        // Save new
        value = await ApiManager.postAPICall(ApiConstant.BOQREVISED_SAVE, body);
      }

      var response = saveDeduction_SaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
      }

    } on SocketException catch (_) {
      BaseUtitiles.showToast(RequestConstant.NOINTERNETCONNECTION);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    }
    on TimeoutException catch (_) {
      BaseUtitiles.showToast(RequestConstant.REQUESTTIMEOUT);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    }
    on FormatException catch (_) {
      BaseUtitiles.showToast(RequestConstant.BADRESPONSE);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    } catch (error) {
      print('❌ Error in SaveBoqRevisedScreenEntryAPI: $error');
      buttonControl = 0;
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
    }

    return ratingRes;
  }

//---Save API---

//----Edit---
  static Future<List<BoqRevisedEditResponse>> Boq_RevisedList_editAPI(int Revise_Id) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_BOQREVISED_EDIT_API + "?Revise_Id=$Revise_Id").then((value) {
      final res = boqRevisedEditResponseFromJson(value);
      if (res != null && res.length > 0) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      // BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }
  //---Delete API----
  static Future BoqRevised_entryList_deleteAPI(int Revise_Id, String Revise_No,String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_BOQREVISED_ENTRYLIST_API + "?Revise_Id=$Revise_Id&Revise_No=$Revise_No&UserId=$UserId&DeviceName=$DeviceName")
        .then((value) {
      final res = json.decode(value);
      if (res != null) {
        data = res;
        if(data=="Deleted"){
          BaseUtitiles.showToast("Deleted Successfully");
        }else{
          BaseUtitiles.showToast("$data");
        }
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

}