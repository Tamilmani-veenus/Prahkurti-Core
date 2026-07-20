import '../controller/projectcontroller.dart';

import '../commonpopup/companyalert.dart';
import '../controller/logincontroller.dart';
import '../provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';

class CompanyController extends GetxController{
  RxList getdropDownvalue=[].obs;
  RxList CompanyDropdownName=[].obs;
  RxList getProjectdropDownvalue=[].obs;
  RxList ProjectdropdownList=[].obs;
  RxList mainlist=[].obs;
  final CompanyName=new TextEditingController();
  final projectname_CompanyWise=new TextEditingController();
  final SupplierlistFrDate = TextEditingController();
  final SupplierlistToDate = TextEditingController();

  LoginController loginController=Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());

  RxInt selectedCompanyId = 0.obs;
  RxString selectedCompanyName = "".obs;

  RxList getdropDownvalue_Companywise=[].obs;
  RxList ProjectDropdown_CompanyWiseName=[].obs;
  RxInt selectedProjectId_CompanyWise = 0.obs;
  RxString selectedProjectName_ComapnyWise = "".obs;



  Future getCompanyList() async {
    getdropDownvalue.value.clear();
    final value = await CommonProvider.getCompany();
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty){
          getdropDownvalue.value = value.result!;
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







  //-----------Project Name Company Wise----------------

  Future getProjectList_CompanyWise(BuildContext context,int check) async {
    getdropDownvalue_Companywise.value.clear();
    getdropDownvalue_Companywise.value.forEach((element) {
      return ProjectDropdown_CompanyWiseName.value.add(element.project);
    });

  }
}