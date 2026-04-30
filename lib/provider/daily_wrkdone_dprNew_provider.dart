import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../controller/dailywrk_done_dprnew_controller.dart';
import '../models/dailywrk_don_dpr_entrylistres_model.dart';
import '../models/dailywrk_don_dprnew_editresapi.dart';
import '../models/dailywrk_done_dprNew_getMaterialApi_model.dart';
import '../models/dailywrk_done_dpr_itemlist_save_model.dart';
import '../models/dailywrkdon_dprNew_getBoqdetailsRes.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:get/get.dart';


class DPR_New_Provider{



  static Future<List<DailywrkdonDprNewGetBoqdetailsRes>> dprNew_getBoqDetails(int? PId, int SId, int SubId,int Headid, String EntryType) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DPRNEW_BOQDETAILSLIST + "?PId=$PId&SId=$SId&SubId=$SubId&Headid=$Headid&EntryType=$EntryType")
        .then((value) {
      data = dailywrkdonDprNewGetBoqdetailsResFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(error);
    });
    return data;
  }


  static Future<String?> DPR_NEW_SaveAPI(body, workId, aprovedButton, context) async {
    String? ratingRes;

    try {
      if (workId != 0) {
        if (aprovedButton != 0) {
          var value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_DPR_NEW_APROVE_API, body);
          var response = dprItemscreenSaveResponseFromJson(value);
          if (response.RetString != null) {
            ratingRes = response.RetString;
          }
        } else {
          var value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_DPR_NEW_UPDATE_API, body);
          var response = dprItemscreenSaveResponseFromJson(value);
          if (response.RetString != null) {
            ratingRes = response.RetString;
          }
        }
      } else {
        var value = await ApiManager.postAPICall(ApiConstant.DPR_NEW_SAVE_API, body);
        var response = dprItemscreenSaveResponseFromJson(value);
        if (response.RetString != null) {
          ratingRes = response.RetString;
        }
      }
    } on SocketException catch (_) {
      BaseUtitiles.showToast(RequestConstant.NOINTERNETCONNECTION);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
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
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    }catch (error) {
      print('❌ Error in SaveApi: $error');
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      return null;
    }
    return ratingRes;
  }


  static Future<List> getMaterial() async {
    DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.GET_DPRNEW_MATERIAL_API).then((value) {
      responseData = dailywrkdonDprNewGetMaterialResFromJson(value);
      if (responseData!=null&& responseData.length>0) {
        dailyWrkDone_DPRNEW_Controller.mainlist.value.clear();
        dailyWrkDone_DPRNEW_Controller.MaterialApiLIst.value.clear();
        dailyWrkDone_DPRNEW_Controller.MaterialApiLIst.value=responseData;
        dailyWrkDone_DPRNEW_Controller.mainlist.value=dailyWrkDone_DPRNEW_Controller.MaterialApiLIst.value;
        return dailyWrkDone_DPRNEW_Controller.MaterialApiLIst.value;
      }
    },onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return responseData;
  }

  static Future<List<DailywrkDoneDprEntrylistResmodel>> get_dprNew_EntryList(int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DPR_NEW_ENTRY_LIST + "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("DPR_New_EntryList:" + value);
      data = dailywrkDoneDprEntrylistResmodelFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      // BaseUtitiles.showToast(error);
    });
    return data;
  }

  static Future<List<DailywrkdonDprNewEditApiRes>> dpr_New_entryList_editAPI(int workId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_DPRNEW_EDIT_API + "?WorkId=$workId").then((value) {
      final res = dailywrkdonDprNewEditApiResFromJson(value);
      if (res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      // BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }

  static Future dprNew_entryList_deleteAPI(int WorkId,String WorkNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_DPR_ENTRYLIST_API + "?WorkId=$WorkId&WorkNo=$WorkNo&UserId=$UserId&DeviceName=$DeviceName")
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