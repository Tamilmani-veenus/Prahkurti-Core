import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../commonpopup/headname_alert.dart';
import '../provider/common_provider.dart';

class HeadNameController extends GetxController{
  final headName=new TextEditingController();

  RxList getdropDownvalue=[].obs;
  RxList HeadDropdownName=[].obs;
  RxList mainlist=[].obs;
  RxInt selectedHeadId = 0.obs;
  RxString selectHeadName = "".obs;


  Future getHeadList(BuildContext context,int pid,int sid) async {
    getdropDownvalue.value= await CommonProvider.getHeadName(pid,sid);
      getdropDownvalue.value.forEach((element) {
        return HeadDropdownName.value.add(element.headItem);
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return HeadNameAlert(list:getdropDownvalue.value);
          });
  }


  setSelectedHeadID(String value) {
    if (getdropDownvalue.value.length>0) {
      getdropDownvalue.forEach((element) {
        if(value == element.headItem){
          selectedHeadId(element.headitemId);
        }
      });
    }
    setSelectedHeadListName(selectedHeadId.value);
  }


  setSelectedHeadListName(int? id) {
    if (getdropDownvalue.value != null) {
      getdropDownvalue.value.forEach((element) {
        if (id == element.headitemId) {
          selectHeadName(element.headItem.toString());
        }
      });
    }
    headName.text=selectHeadName.value;
  }

}