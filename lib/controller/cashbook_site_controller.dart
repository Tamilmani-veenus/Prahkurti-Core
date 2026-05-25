import '../controller/projectcontroller.dart';
import '../provider/cashbook_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';


class CashBookSiteController extends GetxController{
  final cashbooksite_frdateController = TextEditingController();
  final cashbooksite_todateController = TextEditingController();

  final totalDebit = TextEditingController();
  final totalCredit = TextEditingController();
  final closingDebit = TextEditingController();
  final closingCredit = TextEditingController();

  ProjectController projectController=Get.put(ProjectController());

  RxList cashsiteDatas = [].obs;

  Future getcashbooksitedetails() async {
    cashsiteDatas.value = [];

    final value = await CashBookProvider.getcashbooksiteList(
      projectController.selectedProjectId.value,
      cashbooksite_frdateController.text,
      cashbooksite_todateController.text,
    );

    if (value != null) {
      if (value.success == true) {

        // List data
        if (value.result != null) {
          cashsiteDatas.value = value.result!;
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