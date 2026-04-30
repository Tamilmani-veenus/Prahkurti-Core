import '../commonpopup/fromprojectalert.dart';
import '../controller/logincontroller.dart';
import '../provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';

class FromProjectController extends GetxController{

  final fromprojectname= TextEditingController();
  RxInt selectedProjectId = 0.obs;
  RxString selectedProjectName = "".obs;
  RxList FrProjectDropdownName=[].obs;
  RxList FrProjectDropdownId=[].obs;
  RxList getdropDownvalue=[].obs;
  RxList mainlist=[].obs;
  LoginController loginController = Get.put(LoginController());


  Future getFromProjectList({String? type,id}) async {
    FrProjectDropdownName.value=[];
    FrProjectDropdownId.value=[];
    getdropDownvalue.value=[];
    final value = await CommonProvider.getFromproject(type,id);
    if (value != null ) {
      if(value.success == true){
      getdropDownvalue.value = value.result!;
        getdropDownvalue.value.forEach((element) {
          FrProjectDropdownName.value.add(element.project);
          FrProjectDropdownId.value.add(element.projectId);
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


  setSelectedProjectID(String value) {
    if (getdropDownvalue.value.length>0) {
      getdropDownvalue.forEach((element) {
        if(value == element.project){
          selectedProjectId(element.projectId);
        }
      });
    }
    setSelectedProjectListName(selectedProjectId.value);
  }

  setSelectedProjectListName(int? id) {
    if (getdropDownvalue.value != null) {
      getdropDownvalue.value.forEach((element) {
        if (id == element.projectId) {
          selectedProjectName(element.project.toString());
        }
      });
    }
    fromprojectname.text=selectedProjectName.value;
  }
}