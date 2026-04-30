import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/dailywrk_done_dpr_itemlist_save_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/requisitionslipeditlist_model.dart';
import '../models/requisitionslipentrylist_model.dart';
import '../models/staffleavedetails.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class RequisitionslipProvider{

  static Future<List<RequisitonSlipEntrylistResponse>> getReqSlipEntry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETREQUISITIONSLIP_ENTRY_LIST + "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate").then((value) {
      print("ReqSlip:" + value);
      data = requisitonSlipEntrylistResponseFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }


  static SaveReqslipScreenEntryAPI(String body, int reqId,context) async {
    String? ratingRes;

    try {
      if (reqId != 0) {
        final value = await ApiManager.putUpdateAPIButton(
          ApiConstant.PUT_REQUISITIONSLIP_UPDATE_API,
          body,
        );
        final response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          print('$ratingRes');
        }
      } else {
        final value = await ApiManager.postAPICall(
          ApiConstant.REQUISITION_SAVE,
          body,
        );
        final response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          print('$ratingRes');
        }
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
    }catch (error) {
      print(error);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    }

    return ratingRes;
  }


//----Edit---
  static Future<List<RequisitonSlipeditlist>> Requisitionslip_editAPI(int reqId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_REQUISITION_EDIT_API + "?ReqId=$reqId").then((value) {
      final res = requisitonSlipeditlistFromJson(value);
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


  //---Delete API----
  static Future Requisitionslip_entryList_deleteAPI(int reqId, String reqNo,String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_REQUISITION_ENTRYLIST_API + "?ReqId=$reqId&ReqNo=$reqNo&UserId=$UserId&DeviceName=$DeviceName").then((value) {
      final res = json.decode(value);
      if (res != null && res=="Deleted") {
        BaseUtitiles.showToast("Record deleted successfully");
        data = res;
        return data;
      }
      else{
        BaseUtitiles.showToast(res);

      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }


  //------------Requisition Slip--------------
  static Future<String?> RequisitionSlipAPI(body, context) async {
    String? ratingRes;
    try {
      final value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_POAPPROVAL_API, body);
      var response = dprItemscreenSaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
        print('RequisitionSlip :: $ratingRes');
      }
    } catch (error) {
      // printToLog(error.toString());
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    }
    return ratingRes;
  }

  //----------Satff Name leave details Pending------------
  static Future getStaffLeaveInfo_Provider(int empId) async {
    var data = null;
    await ApiManager.getAPICall("${ApiConstant.GETSTAFFLEAVECAL}?EmpId=$empId").then((value) {
      final res = staffLeaveDetailsFromJson(value);
      if (res != null) {
        data = res;
        return data;
      }else{
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    }, onError: (error) {
      // printToLog(error.toString());
      // printToLog("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }


}