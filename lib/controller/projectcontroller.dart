
import '../controller/logincontroller.dart';
import '../provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../provider/mrnfinalapproval_provider.dart';
import '../utilities/baseutitiles.dart';

class ProjectController extends GetxController{
  final projectname=new TextEditingController();
  final projectnameAll=new TextEditingController();


  RxList getdropDownvalue=[].obs;

  RxList mainlist=[].obs;
  RxList getdropDownvalueAll=[].obs;
  RxList ProjectDropdownName=[].obs;
  RxList ToProjectDropdownName=[].obs;
  RxList ProjectDropdownNameAll=[].obs;


  RxInt selectedProjectId = 0.obs;
  RxInt selectedProjectIdAll = 0.obs;

  RxString selectedProjectName = "".obs;
  RxString selectedProjectNameAll = "".obs;


  LoginController loginController=Get.put(LoginController());


  Future getProjectList() async {
    getdropDownvalue.value.clear();
    final value = await CommonProvider.getproject();
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

  Future getToProjectName(Url, int proId) async {
    ToProjectDropdownName.value.clear();
    final value = await MrnFinalApprovalProvider.projectNameProvider(Url,proId);
    if (value != null ) {
      if(value.success == true){
        if( value.result!.isNotEmpty) {
          ToProjectDropdownName.value = value.result!;
        }
        else{
          BaseUtitiles.showToast("No Data Found");
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


  //-----------

  Future getProjectListAll(BuildContext context,int check) async {
    getdropDownvalueAll.value.clear();
    final value = await CommonProvider.getprojectAll();
    if (value != null) {
      if(value.success == true) {
        getdropDownvalueAll.value = value.result!;
        getdropDownvalueAll.forEach((element) {
          return ProjectDropdownNameAll.value.add(element.project);
        });
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }



}