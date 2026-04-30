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


  static Future<List<NmrEntrylist>> getSubcontNmrEntry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSUBCONT_NMR_ENTRY_LIST +
        "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("NMREntryList:" + value);
      data = nmrEntrylistFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
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

  static Future<List<NmrItemlist>> getSubcontNmrItem_List_Site(
      int? Subcontid, int? Projectid,int? Siteid, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSUBCONT_NMR_ITEM_LIST +
        "?Subcontid=$Subcontid&Projectid=$Projectid&Siteid=$Siteid&Frdate=$frdate&Todate=$todate")
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
    var ratingRes = null;
    if(workId!=0){
        await ApiManager.putUpdateAPIButton(ApiConstant.PUT_NMR_UPDATE_API, body).then(
                (value) {
              var response = saveDeduction_SaveResponseFromJson(value);
              if (response.RetString != null) {
                ratingRes = response.RetString;
                return ratingRes;
              }
            }, onError: (error) {
          print(error);
          BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
        });
    }
    else{
      await ApiManager.postAPICall(
          ApiConstant.NMR_SAVE_DEDUCTION, body).then((value) {
        var response = saveDeduction_SaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
          return ratingRes;
        }
      }, onError: (error) {
        print(error);
        BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      });
    }
    return ratingRes;
  }

  static Future<List<NmrEditResponse>> nmr_entryList_editAPI(int workId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.EDIT_NMR_DEDUCTION + "?WorkId=$workId").then((value) {
      final res = nmrEditResponseFromJson(value);
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

  static Future nmr_entryList_deleteAPI(int WorkId, int subid, String WorkNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_NMR_ENTRYLIST_API +
        "?WorkId=$WorkId&subid=$subid&WorkNo=$WorkNo&UserId=$UserId&DeviceName=$DeviceName")
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



  static Future<List<GetNmrAprovedstatusmodel>> getNmrcheckedapproved(int? ProjId,String SubContId,int Siteid, String Frdate, String Todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSUBCONT_NMR_CHECKSTATUS +
        "?ProjId=$ProjId&SubContId=$SubContId&Siteid=$Siteid&Frdate=$Frdate&Todate=$Todate")
        .then((value) {
      print("NMRAprovedStatus:" + value);
      data = getNmrAprovedstatusmodelFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }


  static Future<List<GetNmrstatuscountresmodel>> getNmrcheckedapprovedCount(int? ProjId,String SubContId,int Siteid, String Frdate, String Todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSUBCONT_NMR_COUNT_CHECKSTATUS +
        "?ProjId=$ProjId&SubContId=$SubContId&Siteid=$Siteid&Frdate=$Frdate&Todate=$Todate")
        .then((value) {
      print("NMRAprovedStatus:" + value);
      data = getNmrstatuscountresmodelFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }



}