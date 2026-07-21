import '../apimanager/apimanager.dart';
import '../models/projectexpensence_model.dart';
import '../models/subcontractors_expenses_model.dart';
import '../models/supplieros_expenses_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';


class ExpensesProvider {


  static Future<ProjectExpensesResponse?> getProject_Expenses_reportList(int companyId,String fromDate, String toDate) async {
    try{
      final response = await ApiManager.getAPICall(ApiConstant.GETPROJECTEXPENSESAPI+"?CompanyId=$companyId&FromDate=$fromDate&ToDate=$toDate");
      print("ProjectExpenses:"+response);
      return projectExpensesResponseFromJson(response);
    }catch(e,error) {
      print("ERROR${e}");
      print("${error}");
      return null;
    }
  }

  static Future<SupplierOsExpensesResponse?> getSupplierOs_Expenses_reportList(int companyId,fromDate,toDate) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.GETSUPPLIEROSEXPENSESAPI+"?companyId=$companyId&FromDate=$fromDate&ToDate=$toDate");
      print("response...${response}");
      return supplierOsExpensesResponseFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR......${e}");
      return null;
    }
  }

  static Future<SubcontractorOsExpensesResponse?> getSubcontractorOs_Expenses_reportList(int companyId,String fromDate, String toDate) async {
    try {
      final response =
      await ApiManager.getAPICall(ApiConstant.GETSUBCONTRACTOROSEXPENSESAPI+"?companyId=$companyId&FromDate=$fromDate&ToDate=$toDate");
      print("response...${response}");
      return subcontractorOsExpensesResponseFromJson(response);
    } catch (error,e) {
      print("Error == $error");
      print("ERROR......${e}");
      return null;
    }
  }

}