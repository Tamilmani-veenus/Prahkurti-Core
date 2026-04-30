import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../apimanager/apimanager.dart';
import '../models/POApprovalSave.dart';
import '../models/dailywrk_done_dpr_itemlist_save_model.dart';
import '../models/mrnPreApproval_model.dart';
import '../models/mrnfinalapproval_detlistmodel.dart';
import '../models/mrnpreapproval_detlistmodel.dart';
import '../models/mrnverification_model.dart';
import '../models/onclick_pendinglist_model.dart';
import '../models/onclickpendingdet_model.dart';
import '../models/pendinglist_model.dart';
import '../models/poapprovalsupplierlist_model.dart';
import '../models/quotesupplierlist_model.dart';
import '../models/transferackmateriallist_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../models/trans_ackno_editapi_resmodel.dart';
import '../models/transfer_acknowledgment_alldatas_resapi.dart';
import '../models/transferack_entrylist_resapi.dart';

class PendingListProvider {
  static Future<GetPendingListResponse?> getPendingListProvider() async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.PENDINGLISTAPI);

      return getPendingListResponseFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<MrnPreApprovalResponse?> getMRNPreApprovalPendingList() async {
    try {
      final response = await ApiManager.getAPICall(
          ApiConstant.GET_MRNPREAPPROVAL_PENDINGLIST);

      return mrnPreApprovalResponseFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<dynamic> getsupplierlistApi(id) async {
    try {
      var value = await ApiManager.getAPICall(
          ApiConstant.GET_SUPPLIER_QUOTE_APPROVAL_LIST + "?reqmasId=$id");
      return quotesupplierlistFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static preapproval_getAutoYearWise() async {
    var datasave;
    await ApiManager.getAPICall(
            "${ApiConstant.GETAUTONO_YEAR_WISE}?FieldName=app_ord_No&TableName=material_req_app_mas&FormName=MaterialRequestApproval")
        .then((value) {
      var decodedJson = json.decode(value);
      datasave = decodedJson;
      if (datasave != null) {
        return datasave;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return datasave;
  }

  static Future<MrnfinalapprovalModel?> getMrnFinalApproval(
      int ReqMasId) async {
    try {
      final response = await ApiManager.getAPICall(
          ApiConstant.GETMRNFINALAPROVALAPI + "/$ReqMasId");
      return mrnfinalapprovalModelFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<MrnpreapprovalModel?> getMrnPreApproval(int ReqMasId) async {
    try {
      final response = await ApiManager.getAPICall(
          ApiConstant.GETMRPREAPROVALAPI + "?id=$ReqMasId");
      return mrnpreapprovalModelFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<OnclickPendingListResponse?> getOnclickPendingListProvider(
      String formName) async {
    var response;
    try {
      if (formName == "MRN VERIFICATION") {
        response = await ApiManager.getAPICall(
            ApiConstant.GET_MRNVERIFICATION_PENDINGLIST);
      } else if (formName == "MRN PRE APPROVAL") {
        response = await ApiManager.getAPICall(
            ApiConstant.GET_MRNPREAPPROVAL_PENDINGLIST);
      } else if (formName == "MRN FINAL APPROVAL") {
        response = await ApiManager.getAPICall(
            ApiConstant.GET_MRNAPPROVAL_PENDINGLIST);
      } else if (formName == "SITE REQUEST VERIFICATION") {
        response = await ApiManager.getAPICall(
            ApiConstant.GET_SITEREQ_VERIFY_PEND_LIST);
      } else if (formName == "SITE REQUEST APPROVAL") {
        response = await ApiManager.getAPICall(
            ApiConstant.GET_SITEREQ_APPROVAL_PEND_LIST);
      } else if (formName == "PENDING PO") {
        response = await ApiManager.getAPICall(ApiConstant.GET_PO_PENDINGLIST);
      } else if (formName == "PO VERIFICATION") {
        response = await ApiManager.getAPICall(
            ApiConstant.GET_POVERIFICATION_PENDINGLIST);
      } else if (formName == "PO APPROVAL") {
        response =
            await ApiManager.getAPICall(ApiConstant.GET_POAPPROVAL_PENDINGLIST);
      } else if (formName == "INWARD PENDING") {
        print("API: ${ApiConstant.GET_INWARD_PENDINGLIST}");
        response =
            await ApiManager.getAPICall(ApiConstant.GET_INWARD_PENDINGLIST);
      } else if (formName == "TRANSFER PENDING") {
        response =
            await ApiManager.getAPICall(ApiConstant.GET_TRANSFER_PENDINGLIST);
      } else if (formName == "TRANSFER REQUEST PENDING VIEW") {
        response = await ApiManager.getAPICall(
            ApiConstant.GET_TRANSFERREQUEST_PENDINGLIST);
      } else if (formName == "TRANSFER ACKNOWLEDGMENT PENDING") {
        response = await ApiManager.getAPICall(
            ApiConstant.GET_TRANSFER_ACKNOWLEGDEMENT_LIST);
      } else if (formName == "SUBCONTRACTOR ATTENDANCE APPROVAL") {
        response =
            await ApiManager.getAPICall(ApiConstant.GET_SUBCON_APPROVAL_LIST);
      } else if (formName == "TRANSFER REQUEST VERIFICATION PENDING") {
        response = await ApiManager.getAPICall(
            ApiConstant.GET_TRANSFER_VERIFI_PEND_LIST);
      } else if (formName == "TRANSFER REQUEST APPROVAL PENDING") {
        response = await ApiManager.getAPICall(
            ApiConstant.GET_TRANSFER_APPROVE_PEND_LIST);
      } else if (formName == "PENDING QUOTE") {
        response =
            await ApiManager.getAPICall(ApiConstant.GET_PENDING_QUOTE_LIST);
      } else if (formName == "QUOTE VERIFICATION PENDING") {
        response =
            await ApiManager.getAPICall(ApiConstant.GET_VERIFY_QUOTE_LIST);
      } else if (formName == "QUOTE APPROVAL PENDING") {
        response =
            await ApiManager.getAPICall(ApiConstant.GET_APPROVE_QUOTE_LIST);
      } else if (formName == "STORE TRANSFER PENDING") {
        response =
            await ApiManager.getAPICall(ApiConstant.GET_STORETRANS_PEND_LIST);
      }
      return onclickPendingListResponseFromJson(response);
    } catch (error, stackTrace) {
      print("ERROR...${error}");
      print("ERROR...${stackTrace}");
      return null;
    }
  }

  static Future<PoapprovalSupplierbuilldlListModel?>
      getPoapproval_SupplierbuildList_Provider(int matId) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_POAPPROVAL_SUPPLIERBUILDLIST_API}?materialID=$matId");

      PoapprovalSupplierbuilldlListModel data =
          poapprovalSupplierbuilldlListModelFromJson(value);

      return data;
    } catch (error, e) {
      print(error);
      print("ERROR....${e}");
      BaseUtitiles.showToast('Something went wrong..');
      return null;
    }
  }

  //----------Transfer Ack Pending------------
  static Future<List<TransferAckMatList>> getTransferAckPending_Provider(
      int transId) async {
    var data = null;
    await ApiManager.getAPICall(
            ApiConstant.GET_TRANSFERACKPENDING_LIST + "?Transfer_id=$transId")
        .then((value) {
      final res = transferAckMatListFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static Future subcontNMR_BillAprovalAPI(body, context) async {
    var ratingRes = null;
    await ApiManager.putUpdateAPIButton(
            ApiConstant.PUT_SUBCONTNMRBILL_APPROVAL_API, body)
        .then((value) {
      var response = dprItemscreenSaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
        BaseUtitiles.showToast(ratingRes);
        return Navigator.pop(context);
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
  }

  // static Future<void> PoAprovalAPI(body, context) async {
  //   String? ratingRes;
  //
  //   try {
  //     final value = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_POAPPROVAL_API, body);
  //
  //     var response = dprItemscreenSaveResponseFromJson(value);
  //
  //     if (response.RetString != null) {
  //       ratingRes = response.RetString;
  //       BaseUtitiles.showToast(ratingRes!);
  //       Navigator.pop(context);
  //     }
  //   }
  //   on SocketException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.NOINTERNETCONNECTION);
  //     Navigator.pop(context);
  //     return null;
  //   }
  //   on TimeoutException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.REQUESTTIMEOUT);
  //     Navigator.pop(context);
  //     return null;
  //   }
  //   on FormatException catch (_) {
  //     BaseUtitiles.showToast(RequestConstant.BADRESPONSE);
  //     Navigator.pop(context);
  //     return null;
  //   }catch (error) {
  //     BaseUtitiles.showToast(RequestConstant.NETWORKERROR);
  //     Navigator.pop(context);
  //   }
  // }

  static Future PoAprovalAPI(Url, body, context) async {
    try {
      var value;
      if (Url == "PO VERIFICATION") {
        value = await ApiManager.putUpdateAPIButton(
            "${ApiConstant.PUT_POVERIFY_API}", jsonEncode(body));
      } else if (Url == "PO APPROVAL") {
        value = await ApiManager.putUpdateAPIButton(
            "${ApiConstant.PUT_POAPPROVAL_API}", jsonEncode(body));
      }
      return poApprovalCheckBoxSaveFromJson(value);
    } catch (error, e) {
      print(error);
      print("ERROR...${e}");
    }
  }

  static Future PO_Approval_deleteAPI(int reqId) async {
    var data = null;
    await ApiManager.deleteAPICall("${ApiConstant.PO_APPROVE_DELETE}?id=$reqId")
        .then((value) {
      final res = json.decode(value);
      if (res["success"] == true) {
        data = res["result"];
        BaseUtitiles.showToast("$data");
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
    return data;
  }

  ///----------------WorkOrder Verify and Approval---------

  static Future AprovalAPI(body, context) async {
    var ratingRes = null;
    await ApiManager.putUpdateAPIButton(ApiConstant.PUT_POAPPROVAL_API, body)
        .then((value) {
      var response = dprItemscreenSaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
        BaseUtitiles.showToast(ratingRes);
        print("RetString :: $ratingRes");
        return Navigator.pop(context);
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
  }

  static Future BillGenAprovalAPI(body, context) async {
    var ratingRes = null;
    await ApiManager.putUpdateAPIButton(
            ApiConstant.PUT_BILLGEN_APPROVAL_API, body)
        .then((value) {
      var response = dprItemscreenSaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
        BaseUtitiles.showToast(ratingRes);
        return Navigator.pop(context);
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
  }

  static Future AdvanceRequesAprovalAPI(body, context) async {
    var ratingRes = null;
    // await ApiManager.putUpdateAPIButton(ApiConstant.PUT_ADVANCEREQ_APPROVAL_API, body).then((value) {
    await ApiManager.putUpdateAPIButton(ApiConstant.PUT_POAPPROVAL_API, body)
        .then((value) {
      var response = dprItemscreenSaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
        BaseUtitiles.showToast(ratingRes);
        return Navigator.pop(context);
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
  }

  static Future<TransferacknowAlldatasRes?> TransferAcknowPendingAPI(
      int TransferId) async {
    try {
      final value = await ApiManager.getAPICall(
          ApiConstant.GET_TRAACK_PENDING_ALLDATAS_API + "?id=$TransferId");
      return transferacknowAlldatasResFromJson(value);
    } catch (error, e) {
      print(error);
      print("ERROR...${e}");
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  static transferACk_SaveApi(String body) async {
    try {
      final response = await ApiManager.postAPICall(
        ApiConstant.TRANSFER_ACKNOW_ENTRYSAVE,
        body,
      );

      return jsonDecode(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<List<TransferAckEntryListApi>> gettransferACk_Entry_List(
      int? Userid, String UserType, String frdate, String todate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GET_TRAACK_ENTYLIST_API +
            "?UserId=$Userid&UserType=$UserType&Frdate=$frdate&Todate=$todate")
        .then((value) {
      print("TransferprojectEntryList:" + value);
      data = transferAckEntryListApiFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static Future<List<TransferAckEditApiRes>> entryList_editAPI(
      int AckId, int TransferId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.EDIT_TRANSFER_ACKNOW_API +
            "?AckId=$AckId&TransferId=$TransferId")
        .then((value) {
      final res = transferAckEditApiResFromJson(value);
      if (res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG + error);
    });
    return data;
  }

  static Future entryList_deleteAPI(int TransferId, String ackNo,
      String TransferNo, String UserId, String DeviceName) async {
    var data = null;
    await ApiManager.deleteAPICall(ApiConstant.DELETE_TRANSACKENTRYLIST_API +
            "?TransferId=$TransferId&AckNo=$ackNo&TransferNo=$TransferNo&UserId=$UserId&DeviceName=$DeviceName")
        .then((value) {
      final res = json.decode(value);
      if (res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG + error);
    });
    return data;
  }

  //---MRN Verification More Details--
  static Future<OnclickPendingDet?> getOnclickDetProvider(String Url, int Rid,
      {String? purchaseType}) async {
    var response;
    try {
      if (Url == "MRN VERIFICATION") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.MRN_VERIFICATION_MOREDETAILS}/$Rid");
      } else if (Url == "MRN PRE APPROVAL") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.MRN_PREAPPROVAL_MOREDETAILS}?id=$Rid");
      } else if (Url == "MRN FINAL APPROVAL") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.MRN_FINALAPPROVAL_MOREDETAILS}/$Rid");
      } else if (Url == "PENDING PO") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.PENDING_PO_MOREDETAILS}?reqMasId=$Rid");
      } else if (Url == "PO VERIFICATION" || Url == "PO APPROVAL") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.POVERIFICATION_MOREDETAILS}?purOrdMasId=$Rid&purType=$purchaseType");
      } else if (Url == "INWARD PENDING") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.INWARD_MOREDETAILS}?PoId=$Rid");
      } else if (Url == "TRANSFER PENDING") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.TRANSFERPENDING_MOREDETAILS}?reqMasId=$Rid");
      } else if (Url == "TRANSFER REQUEST PENDING VIEW") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.TRANSFER_REQUESTPENDING_MOREDETAILS}?Id=$Rid");
      } else if (Url == "TRANSFER REQUEST VERIFICATION PENDING" ||
          Url == "TRANSFER REQUEST APPROVAL PENDING") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.TRANSFERREQ_PEND_APPROVE_MOREDETAILS}?id=$Rid");
      } else if (Url == "TRANSFER ACKNOWLEDGMENT PENDING") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.TRANSFERACKPENDING_MOREDETAILS}?id=$Rid");
      } else if (Url == "SITE REQUEST VERIFICATION") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GET_MATERIALREQPREINDEDNT_EDIT_API}?id=$Rid");
      } else if (Url == "SITE REQUEST APPROVAL") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GET_MATERIALREQPREINDEDNT_EDIT_API}?id=$Rid");
      } else if (Url == "PENDING QUOTE" ||
          Url == "QUOTE VERIFICATION PENDING" ||
          Url == "QUOTE APPROVAL PENDING") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GET_PENDING_QUOTE_MORE_API}?reqmasId=$Rid");
      } else if (Url == "STORE TRANSFER PENDING") {
        response = await ApiManager.getAPICall(
            "${ApiConstant.GET_STORETRANFER_MORE_API}?ReqOrdMasId=$Rid");
      }
      return onclickPendingDetFromJson(response);
    } catch (error, e) {
      print("Error == $error");
      print("ERROR == ${e}");
      return null;
    }
  }

  static Future quoteVerifyApprovalApi(
      int reqmasId, type, verifyRemarks,revertRemarks, quoteMasId) async {
    try {
      final response = await ApiManager.putAPICall(type == "Submit"
          ? "${ApiConstant.PUT_PENDING_QUOTE_API}?reqmasId=$reqmasId"
          : type == "Verify"
              ? "${ApiConstant.PUT_QUOTE_VERIFY_APPROVAL_API}?reqmasId=$reqmasId&isApprove=false&Remarks=$verifyRemarks&quoteMasId=0"
              : type == "Approve"
                  ? "${ApiConstant.PUT_QUOTE_VERIFY_APPROVAL_API}?reqmasId=$reqmasId&isApprove=true&Remarks=&quoteMasId=$quoteMasId"
                  : "${ApiConstant.PUT_QUOTE_REVERT_API}?reqmasId=$reqmasId&remarks=$revertRemarks");

      return jsonDecode(response);
    } catch (error) {
      print("Error: $error");
      return null; // ✅ important
    }
  }

  static Future PunchInAprovalAPI(body, context) async {
    var ratingRes = null;
    await ApiManager.putUpdateAPIButton(ApiConstant.PUT_POAPPROVAL_API, body)
        .then((value) {
      var response = dprItemscreenSaveResponseFromJson(value);
      if (response.RetString != null) {
        ratingRes = response.RetString;
        BaseUtitiles.showToast(ratingRes);
        return Navigator.pop(context);
      }
    }, onError: (error) {
      print(error);
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    });
  }
}
