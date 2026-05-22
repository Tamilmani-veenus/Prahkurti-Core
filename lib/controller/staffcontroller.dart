import '../commonpopup/staffalert.dart';
import '../controller/logincontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../provider/common_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class StaffController extends GetxController{
  final Staffname=new TextEditingController();
  final StaffVocEntrylistFrDate = TextEditingController();
  final StaffVocEntrylistToDate = TextEditingController();
  final AutoYearwiseStaffVoc=new TextEditingController();
  final staffvocDate=new TextEditingController();
  final DetAmount=TextEditingController();
  final Tds=TextEditingController();
  final Tdsamount=TextEditingController();
  final NetAmount=TextEditingController();
  final Amount=TextEditingController();
  final Remarks=TextEditingController();
  int editcheck=0;
  int VocID=0;
  RxString type="Direct Payment/Office".obs;
  RxString Button=RequestConstant.SAVE.obs;
  RxString SaveButton=RequestConstant.SAVE.obs;
  RxList getStaffDropdownvalue = [].obs;
  RxList mainlist=[].obs;
  RxInt selectedstaffId = 0.obs;
  RxString selectedstaffdropdownName = "".obs;

  LoginController loginController=Get.put(LoginController());



  Future get_staffDropdowntList(BuildContext,type) async {
    getStaffDropdownvalue.value.clear();
    final value = await CommonProvider.getStaffDropdown(type);
    if (value != null) {
      if(value.success == true){
        getStaffDropdownvalue.value = value.result!;
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  setSelectedStaffID(String value) {
    if (getStaffDropdownvalue.value.length>0) {
      getStaffDropdownvalue.forEach((element) {
        if(value == element.staffName){
          selectedstaffId(element.id);
        }
      });
    }
    setSelectedstafftName(selectedstaffId.value);
  }

  setSelectedstafftName(int? id) {
    if (getStaffDropdownvalue.value != null) {
      getStaffDropdownvalue.value.forEach((element) {
        if (id == element.empid) {
          selectedstaffdropdownName(element.staffName.toString());
        }
      });
    }
    Staffname.text=selectedstaffdropdownName.value;
  }


}