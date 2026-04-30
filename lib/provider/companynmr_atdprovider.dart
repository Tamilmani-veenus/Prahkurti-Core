import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/cmpnmr_edit_resmodel.dart';
import '../models/companynmrentrylist_model.dart';
import '../models/companynmrlist_resmodel.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class CompanyNmrAttendance_Provider {


  static Future <List> Company_NmrEntryListAPI(int userId, String userType, String Frdate,String Todate ) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_COMPANY_NMRENTRYLISTAPI + "?UserId=$userId&UserType=$userType&Frdate=$Frdate&Todate=$Todate").then((value) {
      final res = companyNmrEntryListmodelFromJson(value);
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

  static Future entryList_deleteAPI(int AttenId, String AttenNo,String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_COMPANYNMRLIST_API + "?AttenId=$AttenId&AttenNo=$AttenNo&UserId=$UserId&DeviceName=$DeviceName")
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

  static Future<List> Company_NmrList_EditAPI(int attenId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_COMPANY_NMRLISTEDIT_API + "?AttenId=$attenId").then((value) {
      final res = cmpNMrEditResModelFromJson(value);
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

  static Future<List<CompanyNmrAddListResModel>> Material_IntentList_editAPI(int cId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_COMPANY_NMRALLLISTAPI + "?CompId=$cId").then((value) {
      final res = companyNmrAddListResModelFromJson(value);
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

  // -----------Save API------------

  static Future<String?> SaveEntryscreenAPI(String body, int reqId, String check,context) async {
    String? ratingRes;

    try {
      dynamic value;

      if (reqId != 0) {
        // Approval case
        if (check == "Aproval") {
          value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_COMPANYNMR_APPROVAL_API, body);
        } else {
          // Update case
          value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_COMPANYNMR_UPDATE_API, body);
        }
      } else {
        // Save new
        value = await ApiManager.postAPICall(ApiConstant.COMPANY_NMR_SAVE_API, body);
      }

      // Parse response
      var response = saveDeduction_SaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
      }

    } on SocketException catch (_) {
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
      print('❌ Error in SaveEntryscreenAPI: $error');
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    }

    return ratingRes;
  }

}