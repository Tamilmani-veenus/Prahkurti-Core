import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/banknamelist_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/staffvoucher_entrylist_model.dart';
import '../models/staffvouchersiteresponse_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class StaffVoucher_provider{

  static Future<List<Staffvoucherentrylist>> getStaffVouc_Entry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSTAFFVOC_ENTRY_LIST +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("StaffvocEntryList:" + value);
      data = staffvoucherentrylistFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  //--------BankName List--------------

  static Future<List<BankNamelistModel>> getBankName_List() async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_STAFFVOUCHER_BankNAMELIST_API).then((value) {
      print("BankNameList:" + value);
      data = bankNamelistModelFromJson(value);
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

  static Future<String?> SaveSitevoucherScreenEntryAPI(String body, int vocid, int buttonControl,context) async {
    String? ratingRes;

    try {
      if (vocid != 0) {
        // PUT request
        final value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_STAFFVOUCHER_UPDATE_API, body);
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
        }
      } else {
        // POST request
        final value = await ApiManager.postAPICall(ApiConstant.STAFFVOUCHER_SAVE, body);
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
        }
      }
    }on SocketException catch (_) {
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
      print(' Error in SaveSitevoucherScreenEntryAPI: $error');
      buttonControl = 0;
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      return null;
    }

    return ratingRes;
  }

//---Save API---

//---Delete API----
  static Future Staffvoucher_entryList_deleteAPI(int VocId, String VocNo,String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_STAFFVOUCHERSITE_ENTRYLIST_API + "?VocId=$VocId&VocNo=$VocNo&UserId=$UserId&DeviceName=$DeviceName")
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

  //---Delete API----
  static Future StaffvoucherSite_entryList_deleteAPI(int VocId, String VocNo,String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_SITEVOUCHER_ENTRYLIST_API + "?VocId=$VocId&VocNo=$VocNo&UserId=$UserId&DeviceName=$DeviceName")
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
  //--EditAPI
  static Future<List<StaffvouchereditResponse>> SitevoucherSite_entryList_editAPI(int VocId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_STAFFVOUCHERSITE_EDIT_API + "?VocId=$VocId").then((value) {
      final res = staffvouchereditResponseFromJson(value);
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