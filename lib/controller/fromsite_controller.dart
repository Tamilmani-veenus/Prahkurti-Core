import '../controller/projectcontroller.dart';

import '../provider/common_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';
import 'fromproject_ccontroller.dart';

class FromSiteController extends GetxController{



  final FromSitename=new TextEditingController();
  RxList getSiteDropdownvalue = [].obs;
  RxList mainlist=[].obs;
  RxList siteDropdownName = [].obs;
  RxInt selectedsiteId = 0.obs;
  RxString selectedsitedropdownName = "".obs;

  final ProjectController projectcontroller = Get.put(ProjectController());
  FromProjectController fromprojectController=Get.put(FromProjectController());


  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  RxList mrnListValue=[].obs;
  RxList selctListDatas = [].obs;




  setSelectedSiteID(String value) {
    if (getSiteDropdownvalue.value.length>0) {
      getSiteDropdownvalue.forEach((element) {
        if(value == element.siteName){
          selectedsiteId(element.siteId);
        }
      });
    }
    setSelectedMRNListName(selectedsiteId.value);
  }

  setSelectedMRNListName(int? id) {
    if (getSiteDropdownvalue.value != null) {
      getSiteDropdownvalue.value.forEach((element) {
        if (id == element.siteId) {
          selectedsitedropdownName(element.siteName.toString());
        }
      });
    }
    FromSitename.text=selectedsitedropdownName.value;
  }





}