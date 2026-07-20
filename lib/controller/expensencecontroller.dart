import 'package:flutter/cupertino.dart';
import '../controller/projectcontroller.dart';
import '../controller/companycontroller.dart';
import '../provider/expensesprovider.dart';
import '../utilities/baseutitiles.dart';
import 'package:get/get.dart';

import '../utilities/requestconstant.dart';

class ExpensesController extends GetxController {
  CompanyController companyController = Get.put(CompanyController());
  ProjectController projectController = Get.put(ProjectController());
  RxList reportExpensesList = [].obs;
  RxList supplierOSExpensesList = [].obs;
  RxList subcontractorOSExpensesList = [].obs;
  RxString ReportType = "".obs;
  final ReportTypeController = TextEditingController();
  final expensesFromDateController = TextEditingController();
  final expensesToDateController = TextEditingController();



  Future getProjectExpensesList(String fromDate, String Todate) async {
    reportExpensesList.value.clear();
    prjttotalamt.value = 0.0;
    final value = await ExpensesProvider.getProject_Expenses_reportList(companyController.selectedCompanyId.value,fromDate,Todate);
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty){
          reportExpensesList.value = value.result!;
          prjtbalTotalAmt = value.grandTotal?.totalExpenseAmount ?? 0;

          prjttotalamt.value = prjtbalTotalAmt.toDouble();

          prjttotalamtcontroller.text = BaseUtitiles.amountFormat(
            double.parse(prjtbalTotalAmt.toStringAsFixed(3)),
          );
          print("Total Amount :: $prjtbalTotalAmt");

          update();
          return reportExpensesList.value;
        } else {
          BaseUtitiles.showToast("No Record Found..");
        }
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }



  final prjttotalamtcontroller = TextEditingController();

  RxDouble prjttotalamt = 0.0.obs;
  num prjtbalTotalAmt = 0;



  Future getSupplierOS_ExpensesList(fromDate,toDate) async {
    supplierOSExpensesList.value.clear();
    totalamt.value = 0.0;
    final value = await ExpensesProvider.getSupplierOs_Expenses_reportList(companyController.selectedCompanyId.value,fromDate,toDate);
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty){
          supplierOSExpensesList.value = value.result!;
          balTotalAmt = value.grandTotal?["netTotalBalanceAmount"] ?? 0.0;

          totalamt.value = balTotalAmt.toDouble();

          totalamtcontroller.text = BaseUtitiles.amountFormat(
            double.parse(balTotalAmt.toStringAsFixed(3)),
          );
          print("Total Amount :: $balTotalAmt");

          update();
          return supplierOSExpensesList.value;
        } else {
          BaseUtitiles.showToast("No Record Found..");
        }
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }


  final totalamtcontroller = TextEditingController();

  RxDouble totalamt = 0.0.obs;
  num balTotalAmt = 0;



  Future getSubcontractor_ExpensesList(String fromDate,String toDate) async {
    subcontractorOSExpensesList.value.clear();
    totalSubamt.value = 0.0;
    final value = await ExpensesProvider.getSubcontractorOs_Expenses_reportList(companyController.selectedCompanyId.value,fromDate,toDate);
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty){
          subcontractorOSExpensesList.value = value.result!;
          balTotalSubAmt = value.grandTotal?["netBalanceAmount"] ?? 0.0;

          totalSubamt.value = balTotalSubAmt.toDouble();

          totalamtSubcontcontroller.text = BaseUtitiles.amountFormat(
            double.parse(balTotalSubAmt.toStringAsFixed(3)),
          );
          print("Total Amount :: $balTotalSubAmt");

          update();
          return subcontractorOSExpensesList.value;
        } else {
          BaseUtitiles.showToast("No Record Found..");
        }
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }




  final totalamtSubcontcontroller = TextEditingController();

  RxDouble totalSubamt = 0.0.obs;
  num balTotalSubAmt = 0;
}
