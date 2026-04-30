import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prahkurticore/models/project_name_response.dart';
import 'package:prahkurticore/utilities/print_logger.dart';

import '../apimanager/apimanager.dart';
import '../home/pending_list/pending_list.dart';
import '../models/mrn_stockmaterialwiselist_model.dart';
import '../models/project_dropdownlist_model.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import 'package:http/http.dart' as http;

import '../utilities/requestconstant.dart';

class MrnFinalApprovalProvider{

  final http.Client _httpClient = http.Client();

  /// Send Request.....

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return _httpClient.send(request);
  }


//---------------Get Stock Material Wise---------------

  static Future<Stockwisematerialwise?> getStockmaterialWise(int? mid) async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GETSTOCKLISTMATERIALWISE + "/$mid");
      print("response...${response}");
      return stockwisematerialwiseFromJson(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  static Future<ProjectDropdownListResponse?> projectNameProvider(int proId) async {
    try {
      final response = await ApiManager.getAPICall(
          "${ApiConstant.PROJECT_NAME_TRANSFER}?projectId=$proId");
      print("response...${response}");
      return projectDropdownListResponseFromJson(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  ///---------------------------mrn_VERIFY DELETE---------------------------------
  // static Future mrnverifydeleteApi(String body) async {
  //   var ratingRes = null;
  //   await ApiManager.deletebuttonAPICall(ApiConstant.MRL_VERIFY_DELETE, body).then((value) {
  //     var response = subcontEntryscreenSaveResponseFromJson (value);
  //     if (response.RetString != null) {
  //       ratingRes = response.RetString;
  //       BaseUtitiles.showToast(ratingRes);
  //       return ratingRes;
  //     }
  //   }, onError: (error) {
  //     print(error);
  //   });
  //   return ratingRes;
  // }
  ///----------------------------MRL_PREAPPROVE_DELETE----------------------
  static Future mrlpreapproveapi(String body) async {
    var ratingRes = null;
    await ApiManager.deletebuttonAPICall(ApiConstant.MRL_PREAPPROVE_DELETE, body).then((value) {
      // var response = subcontEntryscreenSaveResponseFromJson (value);
      // if (response.RetString != null) {
      //   ratingRes = response.RetString;
      //   BaseUtitiles.showToast(ratingRes);
      //   return ratingRes;
      // }
    }, onError: (error) {
      print(error);
    });
    return ratingRes;
  }
  ///--------------------PO APPROVE DELETE-------------------------------------
  static Future poapprovaldeleteapi(String body) async {
    var ratingRes = null;
    await ApiManager.deletebuttonAPICall(ApiConstant.PO_APPROVE_DELETE, body).then((value) {
      // var response = subcontEntryscreenSaveResponseFromJson (value);
      // if (response.RetString != null) {
      //   ratingRes = response.RetString;
      //   BaseUtitiles.showToast(ratingRes);
      //   return ratingRes;
      // }
    }, onError: (error) {
      print(error);
    });
    return ratingRes;
  }
  ///--------------------PO verification DELETE-------------------------------------
  static Future poverificationdeleteapi(String body) async {
    var ratingRes = null;
    await ApiManager.deletebuttonAPICall(ApiConstant.PO_APPROVE_DELETE, body).then((value) {
      // var response = subcontEntryscreenSaveResponseFromJson (value);
      // if (response.RetString != null) {
      //   ratingRes = response.RetString;
      //   print('ratingRes...$ratingRes');
      //   BaseUtitiles.showToast('$ratingRes');
      //   return ratingRes;
      //
      // }
    }, onError: (error) {
      print(error);
    });
    return ratingRes;
  }


  ///-------------------------mrnfinal_approval_DELETE ------------------------------------
  static Future mrnfinaldeleteApi(String body) async {
    var ratingRes = null;
    await ApiManager.deletebuttonAPICall(ApiConstant.MRL_FINAL_APPROVIAL_DELETE, body).then((value) {
      // var response = subcontEntryscreenSaveResponseFromJson (value);
      // if (response.RetString != null) {
      //   ratingRes = response.RetString;
      //   BaseUtitiles.showToast(ratingRes);
      //   return ratingRes;
      // }
    }, onError: (error) {
      print(error);
    });
    return ratingRes;
  }
///--------------------TRANSFER REQUEST verifily----------------------------


  static Future<String?> TransferReq_Verify_deleteAPI(Url,int reqId) async {
    var response;
    try {
      if(Url == "TRANSFER REQUEST VERIFICATION PENDING")
      {
       response = await ApiManager.deleteAPICall("${ApiConstant.TRANSFER_VERIFICATION_DELETE}?id=$reqId");
      }
      else if(Url == "TRANSFER REQUEST APPROVAL PENDING")
      {
        response = await ApiManager.deleteAPICall("${ApiConstant.TRANSFERREQ_PENDAPPROVAL_DELETE}?id=$reqId");
      }
      final Map<String, dynamic> decoded = jsonDecode(response);
      final message = decoded["message"] ??
          (decoded["success"] == true
              ? "Deleted successfully"
              : "Something went wrong");

      BaseUtitiles.showToast(message);
      return message;

    } catch (error) {
      print("Delete API Error: $error");
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
      return RequestConstant.SOMETHINGWENT_WRONG; // ✅ important
    }
  }

}