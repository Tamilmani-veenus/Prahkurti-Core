import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/advance_reqvoucher_new_controller.dart';
import '../models/AdvanceReqDeleteModel.dart';
import '../models/advreq_entrylist_editapi_resmodel.dart';
import '../models/advreqvoucher_entrylist_reqqpi_model.dart';
import '../models/sitewisepay_AdvReqVoucNew_model.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';

import '../utilities/requestconstant.dart';
import '../apimanager/apimanager.dart';

class AdvanceReqVoucherProvider{

  AdvanceReqVoucherController_new advanceReqVoucherControllernew = AdvanceReqVoucherController_new();

  static Future<List<AdvReqvoucherentrylistResapi>> getEntry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_ADVREQ_ENTRY_LIST + "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("TransferprojectEntryList:" + value);
      data = advReqvoucherentrylistResapiFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }


  //----------Advance Req Voucher New------------
  static Future<List> getAdvTypeList(String payFor, int accType,int accNameId, int pId  ) async {
    List responseData = [];
      await ApiManager.getAPICall(ApiConstant.GetADVREQ_SITEWIEPAYMENTLIST + "?Type=SP&payfor=$payFor&acctype=$accType&acc_nameid=$accNameId&Prjid=$pId").then((value) {
        responseData = sitewisePaymentListFromJson(value);
        if (responseData!=null&& responseData.length>0) {
          return responseData;
        }
      },onError: (error) {
        print(error);
        print("Error == $error");
        BaseUtitiles.showToast('Something went wrong..');
      });
    return responseData;
  }




  // static SaveApi(String body, int id, buttonControl) async {
  //   var ratingRes = null;
  //
  //   if(id!=0){
  //     await ApiManager.putUpdateAPIButton(ApiConstant.PUT_ADVREQ_UPDATE_API, body).then((value) {
  //           var response = subcontEntryscreenSaveResponseFromJson(value);
  //           if (response.RetString != null) {
  //             ratingRes = response.RetString;
  //             buttonControl=0;
  //             return ratingRes;
  //           }
  //         }, onError: (error) {
  //       print(error);
  //       buttonControl=0;
  //       BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
  //     });
  //   }
  //   else{
  //     await ApiManager.postAPICall(ApiConstant.ADVREQ_SAVE, body).then((value) {
  //       var response = subcontEntryscreenSaveResponseFromJson(value);
  //       if (response.RetString != null) {
  //         ratingRes = response.RetString;
  //         buttonControl=0;
  //         return ratingRes;
  //       }
  //     }, onError: (error) {
  //       print(error);
  //       buttonControl=0;
  //       BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
  //     });
  //   }
  //   return ratingRes;
  // }

  static Future<String?> SaveApi(String body, int id, int buttonControl,context) async {
    String? ratingRes;

    try {
      if (id != 0) {
        // PUT request
        final value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_ADVREQ_UPDATE_API, body);
        // var response = subcontEntryscreenSaveResponseFromJson(value);
        // if (response.RetString != null) {
        //   ratingRes = response.RetString;
        // }
      } else {
        // POST request
        final value = await ApiManager.postAPICall(ApiConstant.ADVREQ_SAVE, body);
        // var response = subcontEntryscreenSaveResponseFromJson(value);
        // if (response.RetString != null) {
        //   ratingRes = response.RetString;
        // }
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
      print('❌ Error in SaveApi: $error');
      buttonControl = 0;
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
      return null;
    }

    buttonControl = 0;
    return ratingRes;
  }


  static Future<List<AdvReqEditApiResmodel>> entryList_editAPI(int VocId,int acctypId,int accnameId, int prjId) async {
    var data = null;
    await ApiManager.getAPICall("${ApiConstant.EDIT_ADVANCEREQ_API}?VocId=$VocId&acctypId=$acctypId&accnameId=$accnameId&prjId=$prjId").then((value) {
      final res = advReqEditApiResmodelFromJson(value);
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

  // static Future AdvanceRequesAprovalAPI(body,context) async {
  //   var ratingRes = null;
  //   // await ApiManager.putUpdateAPIButton(ApiConstant.PUT_ADVANCEREQ_APPROVAL_API, body).then((value) {
  //   await ApiManager.putUpdateAPIButton(ApiConstant.PUT_POAPPROVAL_API, body).then((value) {
  //     var response = dprItemscreenSaveResponseFromJson(value);
  //     if (response.RetString != null) {
  //       ratingRes = response.RetString;
  //       BaseUtitiles.showToast(ratingRes);
  //       return  Navigator.pop(context);
  //     }
  //   }, onError: (error) {
  //     print(error);
  //     BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
  //   });
  // }

  static Future entryList_deleteAPI(body) async {
    var data = null;
    // await ApiManager.deleteAPICall(ApiConstant.DELETE_ADVREQVOUCHER_API + "?VocId=$VocId&VocNo=$VocNo&UserId=$UserId&DeviceName=$DeviceName")
    await ApiManager.deleteBodyAPICall(ApiConstant.DELETE_ADVREQVOUCHER_API ,body).then((value) {
      final res = json.decode(value);
      if (res != null) {
        data = res;
        BaseUtitiles.showToast('${data}');
        print("Delete >> ${data}");
        return data;
      }
      else{
        BaseUtitiles.showToast('Delete failed');
        return value;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG+error);
    });
    return data;
  }
}