import '../controller/staffcontroller.dart';
import '../provider/cashbook_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class CashBookStaffController extends GetxController{
  final cashbookStaff_frdateController = TextEditingController();
  final cashbookStaff_todateController = TextEditingController();

  final totalDebit = TextEditingController();
  final totalCredit = TextEditingController();
  final closingDebit = TextEditingController();
  final closingCredit = TextEditingController();



  StaffController staffController=Get.put(StaffController());

  RxList cashstaffDatas = [].obs;
  int checkColor = 0;

  Future getcashbookstaffdetails() async {
    cashstaffDatas.clear();
    await CashBookProvider.getcashbookstaffList(
        staffController.selectedstaffId.value,cashbookStaff_frdateController.text,cashbookStaff_todateController.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        cashstaffDatas.value = value;
        return cashstaffDatas.value;
      }
    });
  }

  calculations(){
    totalDebit.text="0.0";
    totalCredit.text="0.0";
    closingDebit.text="0.0";
    closingCredit.text="0.0";
    cashstaffDatas.value.forEach((element) {
      totalDebit.text=(double.parse(totalDebit.text)+element.debit).toString();
      totalCredit.text=(double.parse(totalCredit.text)+element.credit).toString();
      if(double.parse(totalDebit.text)>=double.parse(totalCredit.text)){
        closingDebit.text=(double.parse(totalDebit.text)-double.parse(totalCredit.text)).toString();
      }
      else{
        closingDebit.text="0.0";
      }

      if(double.parse(totalDebit.text)<=double.parse(totalCredit.text)){
        closingCredit.text=(double.parse(totalCredit.text)-double.parse(totalDebit.text)).toString();
      }
      else{
        closingCredit.text="0.0";
      }
    });
    print(totalDebit.text);
    print(totalCredit.text);
  }

}