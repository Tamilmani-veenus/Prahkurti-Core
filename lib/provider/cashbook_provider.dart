
import '../apimanager/apimanager.dart';
import '../models/casebooksite_model.dart';
import '../models/cashbookstaff_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';

class CashBookProvider {
  static Future<List<Casebooksite>> getcashbooksiteList(int? Id, String FrDate,String ToDate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETCASHBOOK_SITE + "?Id=$Id&FrDate=$FrDate&ToDate=$ToDate&PaidFrom=0")
        .then((value) {
      data = casebooksiteFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static Future<List<Casebookstaff>> getcashbookstaffList(int? Id, String FrDate,String ToDate) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETCASHBOOK_STAFF + "?Id=$Id&FrDate=$FrDate&ToDate=$ToDate")
        .then((value) {
      data = casebookstaffFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }


}


