import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../apimanager/apimanager.dart';
import '../models/materialtransreqsave_model.dart';
import '../models/mattransreqedit_model.dart';
import '../models/mattransreqitemlist_model.dart';
import '../models/mattransreqlist_model.dart';
import '../newhome/maindashboard/dashboard_otheruser.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class MaterialTransReqProvider {
  ///-----------Api MatTransReq Get List----------

  static Future<MatTransferListResponse?> getMatTransReqListApi(
      int? Userid, String UserType, String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GET_MATTRANSREQ_LIST}?fromdate=$frdate&Todate=$todate");

      MatTransferListResponse data = matTransferListResponseFromJson(value);

      return data;
    } catch (error) {
      print(error);
      return null;
    }
  }


  ///------------Api Save Button--------
  static Future<dynamic> matTransReqSaveApi(String body, saveButton, context) async {
    try {
      final url = (saveButton == RequestConstant.VERIFY)
          ? ApiConstant.MATTRANSREQ_VERIFY_API
          : (saveButton == RequestConstant.APPROVAL)
          ? ApiConstant.MATTRANSREQ_APPROVE_API
          : ApiConstant.MatTransReq_SAVE_API;

      final response = await ApiManager.postAPICall(url, body);

      return jsonDecode(response);

    } catch (error) {
      print("Error == $error");
      return null;
    }
  }
  ///----------API Edit Button-------------

  static Future<MatTransReqEdit?> matTransReqeditAPI(int transId) async {
    try {
      final value = await ApiManager.getAPICall(
          ApiConstant.GET_MATTRANSREQ_EDIT_API + "?id=$transId");
      return matTransReqEditFromJson(value);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }

  ///--------API DELETE Button-------------

  static Future<bool> MatTransReqdeleteAPI(int transId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_MATTRANSREQLIST_API}?id=$transId");

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
      return false; // ✅ important
    }
  }
}
