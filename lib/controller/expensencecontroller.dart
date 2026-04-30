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



  Future getProjectExpensesList() async {
    await ExpensesProvider.getProject_Expenses_reportList(
            companyController.selectedCompanyId.value, companyController.selectedProjectId_CompanyWise.value).then((value) async {
      if (value != null && value.length > 0) {
        reportExpensesList.value = value;
        totalAmtProject();
        update();
        return reportExpensesList.value;
      }
      else{
        BaseUtitiles.showToast("No Record Found..");
      }
    });
  }

  final prjttotalamtcontroller = TextEditingController();

  RxInt prjttotalamt = 0.obs;
  num prjtbalTotalAmt = 0;

  totalAmtProject(){
    prjtbalTotalAmt = 0;
    for (int i = 0; i < reportExpensesList.value.length; i++) {
      prjtbalTotalAmt = prjtbalTotalAmt + reportExpensesList.value[i].totExpAmt;
    }
    prjttotalamt.value = prjtbalTotalAmt.toInt();
    prjttotalamtcontroller.text = BaseUtitiles.amountFormat(double.parse(prjtbalTotalAmt.toStringAsFixed(3)));
    print("Total Amount :: $prjtbalTotalAmt");
    return prjttotalamtcontroller.text;
  }

  Future getSupplierOS_ExpensesList() async {
    await ExpensesProvider.getSupplierOs_Expenses_reportList(companyController.selectedCompanyId.value).then((value) async {
      if (value != null && value.length > 0) {
        supplierOSExpensesList.value = value;
        totalAmt();
        update();
        return supplierOSExpensesList.value;
      }else{
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  final totalamtcontroller = TextEditingController();

  RxInt totalamt = 0.obs;
  num balTotalAmt = 0;

  totalAmt(){
    balTotalAmt = 0;
    for (int i = 0; i < supplierOSExpensesList.value.length; i++) {
      balTotalAmt = balTotalAmt + supplierOSExpensesList.value[i].balamt;
    }
    totalamt.value = balTotalAmt.toInt();
    totalamtcontroller.text = BaseUtitiles.amountFormat(double.parse(balTotalAmt.toStringAsFixed(3)));
    print("Total Amount :: $balTotalAmt");
    return totalamtcontroller.text;
  }

  Future getSubcontractor_ExpensesList() async {
    await ExpensesProvider.getSubcontractorOs_Expenses_reportList(
        companyController.selectedCompanyId.value)
        .then((value) async {
      if (value != null && value.length > 0) {
        subcontractorOSExpensesList.value = value;
        totalSubAmt();
        update();
        return subcontractorOSExpensesList.value;
      }else{
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  final totalamtSubcontcontroller = TextEditingController();

  RxInt totalSubamt = 0.obs;
  num balTotalSubAmt = 0;

  totalSubAmt(){
    balTotalSubAmt = 0;
    for (int i = 0; i < subcontractorOSExpensesList.value.length; i++) {
      balTotalSubAmt = balTotalSubAmt + subcontractorOSExpensesList.value[i].balAmt;
    }
    totalSubamt.value = balTotalSubAmt.toInt();
    totalamtSubcontcontroller.text = BaseUtitiles.amountFormat(double.parse(balTotalSubAmt.toStringAsFixed(3)));
    print("Total Subcont Amount :: $balTotalSubAmt");
    return totalamtSubcontcontroller.text;
  }

}
