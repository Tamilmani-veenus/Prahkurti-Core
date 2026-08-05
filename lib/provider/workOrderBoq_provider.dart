import 'dart:convert';

import '../apimanager/apimanager.dart';
import '../models/billdirectgstcalculations.dart';
import '../models/termsandCondition_model.dart';
import '../models/workOrderBoqheaditems_model.dart';
import '../models/workOrderBoqlist_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class WorkOrderBoqProvider{

  static Future<WorkOrderBoqModel?> getWorkOrdBoqEntry_List(String frdate, String todate) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_WORKORDBOQ_ENTRY_LIST + "?fromDate=$frdate&toDate=$todate");
      print("AdvEntryList:" + value);
      return workOrderBoqModelFromJson(value);
    }
    catch(e,error){
      print("ERROR.....$e");
      print("ERROR......${error}");
      return null;
    }
  }

  static Future<dynamic> SaveTermsAndCondition(String body, saveButton) async {
    try {
      var response;
      if(saveButton == RequestConstant.SUBMIT){
        response = await ApiManager.postAPICall(ApiConstant.TERMSANDCONDITION_SAVEAPI, body);
      }
      else if(saveButton == RequestConstant.RESUBMIT){
        response = await ApiManager.putUpdateAPIButton(ApiConstant.PUT_TERMSANDCONDITION, body);
      }
      return jsonDecode(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }


  static Future<WorkOrderHeadItems?> getWorkOrderBoqHeadItem(int SubContId, int headItemId) async {
    try {
      var value = await ApiManager.getAPICall(
          "${ApiConstant.GETWORKORD_BOQITEMLIST}?SubContId=$SubContId&HeadItemId=$headItemId");
      return workOrderHeadItemsFromJson(value);
    } catch (error,e) {
      print(error);
      print("${e}");
      return null;
    }
  }

  static Future<BillDirectDetCalculations?> getWorkOrderCalculation_List() async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_DIRECTBILL_CALCULATION_LIST);
      print("AdvEntryList:" + value);
      return billDirectDetCalculationsFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }

  static Future<TermsandCondition?> getWorkOrdBoqTermsandCondition() async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_WORKORDBOQ_TERMSANDCONDITION);
      print("AdvEntryList:" + value);
      return termsandConditionFromJson(value);
    }
    catch(e,error){
      print("ERROR.....$e");
      print("ERROR......${error}");
      return null;
    }
  }

  static Future<bool> entryList_deleteAPI(int WorkId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_WORKORDER_BOQ_API}?id=$WorkId");

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

  static Future<bool> delete_TermsAndCondition(int WorkId) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_TERMSANDCONDITION}?id=$WorkId");

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