import '../apimanager/apimanager.dart';
import '../models/projectexpensence_model.dart';
import '../models/subcontractors_expenses_model.dart';
import '../models/supplieros_expenses_model.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';


class ExpensesProvider {


  static Future<List<ProjectExpensesResponse>> getProject_Expenses_reportList(int companyId, int pId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETPROJECTEXPENSESAPI+"?CompId=$companyId&PrjtID=$pId").then((value) {
      print("PojectExpenses:"+value);
      data = projectExpensesResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static Future<List<SupplierOsExpensesResponse>> getSupplierOs_Expenses_reportList(int companyId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSUPPLIEROSEXPENSESAPI+"?CompId=$companyId").then((value) {
      print("AttendanceReportList:"+value);
      data = supplierOsExpensesResponseFromJson(value);
      if (data!=null&& data.length>0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong..');
    });
    return data;
  }

  static Future<List<SubcontractorOsExpensesResponse>> getSubcontractorOs_Expenses_reportList(int companyId) async {
    var data = null;
    await ApiManager.getAPICall(ApiConstant.GETSUBCONTRACTOREXPENSESAPI+"?CompId=$companyId").then((value) {
      print("AttendanceReportList:"+value);
      data = subcontractorOsExpensesResponseFromJson(value);
      if (data!=null&& data.length>0) {
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