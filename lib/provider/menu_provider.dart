
import '../apimanager/apimanager.dart';
import '../models/home_menulistres_model.dart';
import '../models/report_list_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';


class MenuProvider{


  static Future<GetHomeMenuListResponse?> getMenuListProvider() async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GETMENU_LIST_API);

      return getHomeMenuListResponseFromJson(response);
    } catch (error) {
      print("Error == $error");
      return null;
    }
  }


  static Future<GetReportListResponse?> getReportsListProvider() async {
    try {
      final response = await ApiManager.getAPICall(ApiConstant.GETREPORT_LIST_API);
      return getReportListResponseFromJson(response);
    }

    catch (error) {
      print("Error == $error");
      return null;
    }
  }

}