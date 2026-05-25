import '../controller/staffcontroller.dart';
import '../provider/cashbook_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';


class CashBookStaffController extends GetxController{
  final cashbookStaff_frdateController = TextEditingController();
  final cashbookStaff_todateController = TextEditingController();

  final totalDebit = TextEditingController();
  final totalCredit = TextEditingController();
  final closingDebit = TextEditingController();
  final closingCredit = TextEditingController();



  StaffController staffController=Get.put(StaffController());

  RxList cashstaffDatas = [].obs;

  Future getcashbookstaffdetails() async {
    cashstaffDatas.value = [];

    final value = await CashBookProvider.getcashbookstaffList(
        staffController.selectedstaffId.value,cashbookStaff_frdateController.text,cashbookStaff_todateController.text
    );

    if (value != null) {
      if (value.success == true) {

        // List data
        if (value.result != null) {
          cashstaffDatas.value = value.result!;
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