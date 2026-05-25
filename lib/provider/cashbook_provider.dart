
import '../apimanager/apimanager.dart';
import '../models/casebooksite_model.dart';
import '../models/cashbookstaff_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';

class CashBookProvider {


  static Future<Casebooksite?> getcashbooksiteList(int? pId, String FrDate,String ToDate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GETCASHBOOK_SITE}?fromDate=$FrDate&toDate=$ToDate&projectId=$pId&PaidFromType=0");
      return casebooksiteFromJson(value);
    } catch (error, e) {
      print(error);
      print("ERROR....${e}");
      return null;
    }
  }


  static Future<Casebookstaff?> getcashbookstaffList(int? eId, String FrDate,String ToDate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.GETCASHBOOK_STAFF}?fromdate=$FrDate&toDate=$ToDate&EmployeeID=$eId");
      return casebookstaffFromJson(value);
    } catch (error, e) {
      print(error);
      print("ERROR....${e}");
      return null;
    }
  }




}


