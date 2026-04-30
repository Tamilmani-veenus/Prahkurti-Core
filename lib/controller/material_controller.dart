import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';



import '../commonpopup/materialhead_alert.dart';
import '../home/menu/menulist.dart';
import '../provider/common_provider.dart';
import '../utilities/baseutitiles.dart';

class MaterialController extends GetxController {

  //--Material Head---
  final MaterialHeadname=new TextEditingController();
  final MaterialName=new TextEditingController();
  final MaterialQty=new TextEditingController();
  RxList materialheadListDropdown = [].obs;
  RxList materialheadDropdownName = [].obs;
  RxList mainlist=[].obs;

  RxInt selectedMaterialheadId = 0.obs;
  RxString selectedMaterialHeadName = "".obs;



  // Future getmaterialheadList(reportScreen) async {
  //   materialheadListDropdown.value = await CommonProvider.materialWise_sub_HeadDropdown(reportScreen);
  //   materialheadListDropdown.value.forEach((element) {
  //     return materialheadDropdownName.value.add(element.materialHead);
  //   });
  // }


  setSelectMaterialheadID(String value) {
    if (materialheadListDropdown.value.length > 0) {
      materialheadListDropdown.forEach((element) {
        if (value == element.materialHead) {
          selectedMaterialheadId(element.materialheadid);
        }
      });
    }
    setSelectSupplierName(selectedMaterialheadId.value);
  }


  setSelectSupplierName(int? id) {
    if (materialheadListDropdown.value != null) {
      materialheadListDropdown.value.forEach((element) {
        if (id == element.materialheadid) {
          selectedMaterialHeadName(element.materialHead.toString());
        }
      });
    }
    MaterialHeadname.text=selectedMaterialHeadName.value;
  }

  MaterialAdded(BuildContext context,String mtName,String scale,int headId,int subId,String date) async {
    await CommonProvider.MaterialPost(mtName,scale,headId,subId,date)
        .then((value) async {
      if (value != null) {
        if(value=="Duplication Occurred... Please Check again..."){
          BaseUtitiles.showToast(value);
        }
        else{
          BaseUtitiles.showToast(value);
          Navigator.of(context).pop();
        }
      }
    });
  }




}