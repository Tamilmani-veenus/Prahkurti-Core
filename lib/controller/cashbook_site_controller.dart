import 'package:prahkurticore/controller/reports_controller.dart';
import '../provider/cashbook_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../utilities/baseutitiles.dart';

class CashBookSiteController extends GetxController{
  final cashbooksite_frdateController = TextEditingController();
  final cashbooksite_todateController = TextEditingController();

  final totalDebit = TextEditingController();
  final totalCredit = TextEditingController();
  final closingDebit = TextEditingController();
  final closingCredit = TextEditingController();

  ReportsController reportsController = Get.put(ReportsController());

  RxList cashsiteDatas = [].obs;

  Future getcashbooksitedetails() async {
    cashsiteDatas.value = [];

    final value = await CashBookProvider.getcashbooksiteList(
      reportsController.selectedProjectId.value,
      cashbooksite_frdateController.text,
      cashbooksite_todateController.text,
       reportsController.selectedCompanyId.value
    );

    if (value != null) {
      if (value.success == true) {

        // List data
        if (value.result != null) {
          cashsiteDatas.value = value.result![0].vouchers!;
        }
        // Totals
        totalDebit.text = value.totalDebit.toString();
        totalCredit.text = value.totalCredit.toString();

        // Closing balance logic
        double closing =
            double.tryParse(value.closingBalance.toString()) ?? 0.0;

        if (closing >= 0) {
          closingCredit.text = closing.toString();
          closingDebit.text = "0.0";
        } else {
          closingDebit.text = closing.abs().toString();
          closingCredit.text = "0.0";
        }

      } else {
        BaseUtitiles.showToast(
            value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

}