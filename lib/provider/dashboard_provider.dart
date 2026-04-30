import '../apimanager/apimanager.dart';
import '../models/dashboardres_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';


class Dashboard_Provider {


  //---------Dashboard Api-------------

  static Future<List> getDashboardAPI_List(String userType) async {
    List responseData = [];
    await ApiManager.getAPICall(ApiConstant.DASHBOARD_API + "?UserType=$userType").then((value) {
      responseData = dashboardResModelFromJson(value);
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

}