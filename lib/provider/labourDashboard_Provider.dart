import 'dart:convert';
import '../apimanager/apimanager.dart';
import '../models/MaterialDash_matHead_model.dart';
import '../models/admin_dashboard_response.dart';
import '../models/hrDashboardCardsRes.dart';
import '../models/hr_Dashboard_Response.dart';
import '../models/labourDashboard_model.dart';
import '../models/materialDash_projectwise_model.dart';
import '../models/material_dashboard_supplier_wise.dart';
import '../models/planningCalendarRes_model.dart';
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

  static Future<AdminDashboardResponse?> getAdminDashboard() async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.ADMINDASHBOARD_API}?startDate=null&endDate=null");
      return adminDashboardResponseFromJson(value);
    } catch (error,e) {
      print(error);
      print("ERROR.....${e}");
      return null;
    }
  }

  static Future<MaterialDashProjectWise?> getMatDashProjectWise(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.MATERIALDASHPROJWISE_API}?startDate=$frdate&endDate=$todate");
      return materialDashProjectWiseFromJson(value);
    } catch (error,e) {
      print(error);
      print("ERROR.....${e}");
      return null;
    }
  }

  static Future<MaterialDashMatHead?> getMatDashMaterialHeadAPI(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.MATERIALDASHMATHEAD_API}?startDate=$frdate&endDate=$todate");
      return materialDashMatHeadFromJson(value);
    } catch (error,e) {
      print(error);
      print("ERROR.....${e}");
      return null;
    }
  }

  static Future<MaterialDashSupWise?> getMatDashSupWiseAPI(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.MATERIALDASHSUPWISE_API}?startDate=$frdate&endDate=$todate");
      return materialDashSupWiseFromJson(value);
    } catch (error,e) {
      print(error);
      print("ERROR.....${e}");
      return null;
    }
  }

  static Future<HrDashboardResponse?> getHrDashboard(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.HRDASHBOARD_API}?startDate=$frdate&endDate=$todate");
      return hrDashboardResponseFromJson(value);
    } catch (error,e) {
      print(error);
      print("ERROR.....${e}");
      return null;
    }
  }

  static Future<HrDashboardCardsListRes?> getHrDashboardCardsList(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.HRDASHBOARDCARDS_API}?startDate=$frdate&endDate=$todate");
      return hrDashboardCardsListResFromJson(value);
    } catch (error,e) {
      print(error);
      print("ERROR.....${e}");
      return null;
    }
  }

  static Future<PlanningCalendarResponse?> getPlanningCalendarList(String frdate, String todate) async {
    try {
      var value = await ApiManager.getAPICall("${ApiConstant.HRDASHBOARD_PLANNINGCALEN_API}?Fromdate=$frdate&ToDate=$todate");
      return planningCalendarResponseFromJson(value);
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<dynamic> UpdatePlanningCalen_EntryAPI(String body, reqId, context) async {
    try {
      var response = await ApiManager.putUpdateAPIButton("${ApiConstant.PUT_PLANNING_CALENDAR_API}?id=$reqId", body);
      return jsonDecode(response);
    }
    catch (error) {
      print("Error == $error");
      return null;
    }
  }
}