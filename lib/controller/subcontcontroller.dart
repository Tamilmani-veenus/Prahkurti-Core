import '../provider/common_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';
import 'nmrweeklybill_controller.dart';

class SubcontractorController extends GetxController {

  final Subcontractorname=new TextEditingController();
  final WorkOrderNo=new TextEditingController();
  final InvoiceNo=new TextEditingController();
  RxList getdropDownvalue = [].obs;
  RxList getdpDnWrkOrderValue = [].obs;
  RxList getInvoiceNoValue = [].obs;
  RxList SubcontDropdownName = [].obs;
  RxList mainlist=[].obs;


  RxInt selectedSubcontId = 0.obs;
  RxString selectedSubconttName = "".obs;

  RxInt selectedWorkOrderId = 0.obs;
  RxString selectedWorkOdrName = "".obs;

  RxInt labourId=0.obs;
  RxString labourName="".obs;
  RxList labourList=[].obs;
  RxList labourmainList=[].obs;
  final LabournameText=new TextEditingController();

  Future getLabourList(BuildContext context) async {
    labourList.value = await CommonProvider.getLabour();
  }

  setSelectedLabourID(String value) {
    if (labourList.value.length>0) {
      labourList.forEach((element) {
        if (value == element.labourName) {
          labourId(element.labourId);
        }
      });
    }
    setSelectedLabourName(labourId.value);
  }

  setSelectedLabourName(int? id) {
    if (labourList.value != null) {
      labourList.value.forEach((element) {
        if (id == element.labourId) {
          labourName(element.labourName.toString());
        }
      });
    }
    LabournameText.text=labourName.value;
  }

  int checkScreen = 0;

  checkSubcontList(){
   return checkScreen = 0;
  }

  Future getSubcontList(BuildContext context,int pid,int sid,checkScreen) async {
    getdropDownvalue.value.clear();
    final value = await CommonProvider.getSubcontrator(pid,sid, checkScreen);
    if (value != null) {
      if(value.success == true){
      getdropDownvalue.value = value.result!;
      getdropDownvalue.forEach((element) {
        return SubcontDropdownName.value.add(element.subContName);
      });
      }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  setSelectedSubcontID(String value) {
    if (getdropDownvalue.value.length>0) {
      getdropDownvalue.forEach((element) {
        if (value == element.subContName) {
          selectedSubcontId(element.subContId);
        }
      });
    }
    setSelectedsubcontListName(selectedSubcontId.value);
  }

  setSelectedsubcontListName(int? id) {
    if (getdropDownvalue.value != null) {
      getdropDownvalue.value.forEach((element) {
        if (id == element.subContId) {
          selectedSubconttName(element.subContName.toString());
        }
      });
    }
    Subcontractorname.text=selectedSubconttName.value;
  }

  Future getWorkOrderNoList(int pid, int sid, int subid) async {
    getdpDnWrkOrderValue.value = await CommonProvider.getWorkOrderNoList(pid, sid,subid);
  }

  Future getInvoiceNoList(int pid,  int subid) async {
    getInvoiceNoValue.value = await CommonProvider.getInvoiceNoList(pid,subid);
    getInvoiceNoValue.value.forEach((element){
      InvoiceNo.text=element.entryAutoNo.toString();
    });
  }

  setselectedWorkOrderId(String value) {
    if (getdpDnWrkOrderValue.value.length>0) {
      getdpDnWrkOrderValue.forEach((element) {
        if (value == element.subContName) {
          selectedWorkOrderId(element.workOrderId);
        }
      });
    }
    setselectedWorkOdrName(selectedWorkOrderId.value);
  }

  setselectedWorkOdrName(int? id) {
    if (getdpDnWrkOrderValue.value != null) {
      getdpDnWrkOrderValue.value.forEach((element) {
        if (id == element.subContId) {
          selectedWorkOdrName(element.workOrderNo.toString());
        }
      });
    }
    WorkOrderNo.text = selectedWorkOdrName.value;
  }

}
