import '../apimanager/apimanager.dart';
import '../models/admin_dashboard_response.dart';
import '../models/labourDashboard_model.dart';
import '../utilities/apiconstant.dart';

class LabourDashboardProvider {

  static Future<LabourDashboardResponse?> getLabourDashboard(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.LABOURDASHBOARD_API}?FromDate=$frdate&ToDate=$todate");
      return labourDashboardResponseFromJson(value);
    } catch (error,e) {
      print(error);
      print("ERROR.....${e}");
      return null;
    }
  }

  static Future<AdminDashboardResponse?> getAdminDashboard(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.ADMINDASHBOARD_API}?startDate=$frdate&endDate=$todate");
      return adminDashboardResponseFromJson(value);
    } catch (error,e) {
      print(error);
      print("ERROR.....${e}");
      return null;
    }
  }
}