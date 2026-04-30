import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';

import '../apimanager/apimanager.dart';
import '../models/companynmrentrylist_model.dart';
import '../models/cons_type_list_model.dart';
import '../models/consumption_edit_model.dart';
import '../models/consumption_entrylisy_model.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../models/stock_material_model.dart';

import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class Consumption_provider{


  static Future<MaterialExpenseList?> getConsumEntry_List(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GETCONSUMPTION_ENTRY_LIST}?fromdate=$frdate&Todate=$todate");

      MaterialExpenseList data = materialExpenseListFromJson(value);

      return data;

    } catch (error) {
      print(error);
      return null;
    }
  }


  //--------StockMaterial-------
  static Future<Stockmaterial?> getStockmaterial(int? pid, int? sid, {String? type,int? reqId}) async {
    try {
      String? response;
      if(type=="A"){
         response = await ApiManager.getAPICall("${ApiConstant.GET_TRANSFER_DET_LIST}?No=$reqId&projectId=$pid&siteId=$sid&type=$type");
      }else{
        response = await ApiManager.getAPICall("${ApiConstant.GETSTOCKMATERIALLIST}?ProjectId=$pid&SiteId=$sid");
      }
      return stockmaterialFromJson(response!);
    } catch (error,e) {
      print("Error == $error");
      print("Error == $e");
      return null;
    }
  }


  static Future<ConsumptionTypeResponse?> getConsTypeList() async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GETCONSTYPELIST);
      return consumptionTypeResponseFromJson(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }

  // -----------Save API------------
  static SaveConumScreenEntryAPI(String body, int UsageId, context) async {

    try {
      var response;

      if (UsageId != 0) {
        response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_Conum_UPDATE_API}/$UsageId", body);
      } else {
        response = await ApiManager.postAPICall(ApiConstant.CONSUM_SAVE, body);
      }
      return jsonDecode(response);

    }  catch (error) {
      print("Error == $error");
      return null;
    }
  }

  //---Save API---

  static Future<ConumEditResponse?> Consum_entryList_editAPI(int UsageId) async {
    try {
      final response = await ApiManager.getAPICall(
          ApiConstant.GET_CONSUM_EDIT_API + "/$UsageId");
      return conumEditResponseFromJson(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }



  //---Delete API----

  static Future<bool> Consum_entryList_deleteAPI(int UsageId) async {
    try {
      final response = await ApiManager.deleteAPICall(ApiConstant.DELETE_CONSUM_ENTRYLIST_API + "/$UsageId");

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


}