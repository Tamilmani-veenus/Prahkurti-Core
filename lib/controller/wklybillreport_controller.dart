import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../controller/projectcontroller.dart';

import '../provider/reports_provider.dart';

class WklyBillReport_controller extends GetxController{
  final fromdate=new TextEditingController();
  final todate=new TextEditingController();
  final ProjectController projectController = Get.put(ProjectController());

  RxList wklyreportDatas = [].obs;

  Future wklybill_rptList() async {
    wklyreportDatas.value.clear();
    await ReportsProvider.getNMRreportList(projectController.selectedProjectId.value,0,fromdate.text,todate.text).then((value)async{
      if(value!=null&& value.length>0){
        wklyreportDatas.value=value;
        return wklyreportDatas.value;
      }
    });
  }
}