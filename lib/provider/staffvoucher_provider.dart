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

  static Future<Staffvoucherentrylist?> getStaffVouc_Entry_List(String frdate, String todate) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GETSTAFFVOC_ENTRY_LIST + "?fromDate=$frdate&toDate=$todate");
      print("SitevocEntryList:" + value);
      return staffvoucherentrylistFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }

  //--------BankName List--------------

  static Future<BankNamelistModel?> getBankName_List() async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_STAFFVOUCHER_BANKNAMELIST_API);
      print("SitevocEntryList:" + value);
      return bankNamelistModelFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }


  // -----------Save API------------

  static SaveSitevoucherScreenEntryAPI(String body, int id) async {
    try {
      var response;

      if (id != 0) {
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_STAFFVOUCHER_UPDATE_API}?id=$id", body);
      } else {
        response = await ApiManager.postAPICall(ApiConstant.STAFFVOUCHER_SAVE, body);
      }
      return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
    }
  }

//---Delete API----

  static Future<bool> Staffvoucher_entryList_deleteAPI(int vocId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_STAFFVOUCHERSITE_ENTRYLIST_API}?id=$vocId");

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

  //--EditAPI

  static Future<StaffvouchereditResponse?> SitevoucherSite_entryList_editAPI(int VocId) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_STAFFVOUCHERSITE_EDIT_API + "?id=$VocId");
      print("SitevocEntryList:" + value);
      return staffvouchereditResponseFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }

}