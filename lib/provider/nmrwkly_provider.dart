import 'dart:convert';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/nmrwklybill_edit_entrylist.dart';
import '../models/nmrwklybill_itemlist_model.dart';
import '../models/nmrwklyentrylist_model.dart';
import '../utilities/requestconstant.dart';
import '../apimanager/apimanager.dart';

import '../models/nmr_approved_resmodel.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';

class NMRWklyprovider{

  static Future<NmrEntryList?> getSubcontNmrEntry_List(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GETSUBCONT_NMR_ENTRY_LIST}?fromDate=$frdate&toDate=$todate");
      return nmrEntryListFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<List<NmrItemlist>> getSubcontNmrItem_List(
      int? Subcontid, int? Projectid, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSUBCONT_NMR_ITEM_LIST +
        "?Subcontid=$Subcontid&Projectid=$Projectid&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("NMRItemList:" + value);
      data = nmrItemlistFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }


  static Future<NmrItemlist?> getSubcontNmrItem_List_Site(int? Subcontid, int? Projectid,int? Siteid, String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          ApiConstant.GETSUBCONT_NMR_ITEM_LIST + "?ProjectId=$Projectid&subcontractorId=$Subcontid&SiteId=$Siteid&FromDate=$frdate&Todate=$todate");
      return nmrItemlistFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }


  static Future NMR_adv_balance(int pId,int subId) async {
    var datasave;
    await ApiManager.getAPICall(ApiConstant.GETSUBCONT_NMR_ADVANCE_BALANCE+"?PID=$pId&SubID=$subId").then((value) {
      var decodedJson = json.decode(value);
      datasave=decodedJson;
      if (datasave!=null) {
        return datasave;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return datasave;
  }

  static SaveSubContScreenEntryAPI(String body, int workId) async {

    try {
      var response;

      if (workId != 0) {
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_NMR_UPDATE_API}?id=$workId", body);
      } else {
        response = await ApiManager.postAPICall(ApiConstant.NMR_SAVE_DEDUCTION, body);
      }
      print("eeeeeeeeee...${response}");
      return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<NmrEditResponse?> nmr_entryList_editAPI(int workId,checkSts) async {
    try {
      var value = await ApiManager.getAPICall(ApiConstant.EDIT_NMR_DEDUCTION + "?id=$workId&CheckEdit=$checkSts");
      return nmrEditResponseFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<bool> nmr_entryList_deleteAPI(int WorkId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_NMR_ENTRYLIST_API}?id=$WorkId");

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

  static Future<NmrApprovedStatus?> getNmrcheckedapproved(int? ProjId,String SubContId,int Siteid, String Frdate, String Todate) async {
    try {
      var value = await ApiManager.getAPICall(
          ApiConstant.GETSUBCONT_NMR_CHECKSTATUS + "?ProjectId=$ProjId&subcontractorId=$SubContId&SiteId=$Siteid&FromDate=$Frdate&Todate=$Todate");
      return nmrApprovedStatusFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<NmrCountList?> getNmrcheckedapprovedCount(int? ProjId,String SubContId,int Siteid, String Frdate, String Todate) async {
    try {
      var value = await ApiManager.getAPICall(
          ApiConstant.GETSUBCONT_NMR_COUNT_CHECKSTATUS + "?ProjectId=$ProjId&subcontractorId=$SubContId&SiteId=$Siteid&FromDate=$Frdate&Todate=$Todate");
      return nmrCountListFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }



}