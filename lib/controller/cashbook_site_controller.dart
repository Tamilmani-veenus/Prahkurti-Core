import '../controller/projectcontroller.dart';
import '../provider/cashbook_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class CashBookSiteController extends GetxController{
  final cashbooksite_frdateController = TextEditingController();
  final cashbooksite_todateController = TextEditingController();

  final totalDebit = TextEditingController();
  final totalCredit = TextEditingController();
  final closingDebit = TextEditingController();
  final closingCredit = TextEditingController();

  ProjectController projectController=Get.put(ProjectController());

  RxList cashsiteDatas = [].obs;
  int checkColor = 0;

  Future getcashbooksitedetails() async {
   cashsiteDatas.value=[];
    await CashBookProvider.getcashbooksiteList(
        projectController.selectedProjectId.value,cashbooksite_frdateController.text,cashbooksite_todateController.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        cashsiteDatas.value = value;
        calculations();
        return cashsiteDatas.value;
      }
      else{
        calculations();
      }
    });

  }

  calculations(){
    totalDebit.text="0.0";
    totalCredit.text="0.0";
    closingDebit.text="0.0";
    closingCredit.text="0.0";
    cashsiteDatas.value.forEach((element) {
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