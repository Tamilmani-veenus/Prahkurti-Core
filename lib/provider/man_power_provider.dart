import 'dart:convert';

import '../apimanager/apimanager.dart';
import '../models/manpower_category_model.dart';
import '../models/manpower_entrylist_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class ManPowerProvider{

  static Future<ManPowerEntryListModel?> getManPowerEntry_List(String frdate, String todate) async {
    try{
      final value = await ApiManager.getAPICall(ApiConstant.GET_MANPOWER_ENTRY_LIST + "?fromDate=$frdate&toDate=$todate");
      print("AdvEntryList:" + value);
      return manPowerEntryListModelFromJson(value);
    }
    catch(e){
      print("ERROR.....$e");
      return null;
    }
  }

  static Future<bool> entryList_deleteAPI(int id) async {
    try {
      final response = await ApiManager.deleteAPICall(
          "${ApiConstant.DELETE_MANPOWERLIST_API}?id=$id");

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

  static Future<ManPowerCategoryListModel?> getManPowerCategoryList() async {
    try{
      final value =await ApiManager.getAPICall(ApiConstant.GETMANPOWER_CATEGORY_CLICK);
      return manPowerCategoryListModelFromJson(value);
    }
    catch (error, e) {
      print(error);
      print("ERROR...${e}");
      return null;
    }
  }

}