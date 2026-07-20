import '../apimanager/apimanager.dart';
import '../models/dashboardres_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';


class Dashboard_Provider {


  //---------Dashboard Api-------------

  static Future<DashboardResModel?> getDashboardAPI_List() async {
    try{
      final response =
    await ApiManager.getAPICall(ApiConstant.DASHBOARD_API);
      return dashboardResModelFromJson(response);
    }catch(error,e) {
      print(error);
      print("Error == $e");
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

}