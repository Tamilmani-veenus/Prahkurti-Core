import 'package:prahkurticore/controller/logincontroller.dart';
import 'package:prahkurticore/controller/reports_controller.dart';

import '../controller/projectcontroller.dart';
import '../controller/subcontcontroller.dart';
import '../home/attendance_report/attendance_popup.dart';
import '../home/pdf_generate/pdf_model/pdfmodel.dart';
import '../provider/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class AttendanceController extends GetxController {
  final ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontcontroller = Get.put(SubcontractorController());
  ReportsController reportsController = Get.put(ReportsController());
  LoginController loginController = Get.put(LoginController());

  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  final workTypeController = TextEditingController();
  RxString wrktype ="".obs;
  int checkColor = 0;


  RxList attendanceDatas = [].obs;
  List <PdfListModel> getSubcontAttdList_Pdf = <PdfListModel>[];

  RxList selctListDatas = [].obs;


  Future getAttendance_rptList(workType) async {
    attendanceDatas.value.clear();
    final value = await ReportsProvider.getAttendancereportList(
        reportsController.selectedProjectId.value,
        reportsController.selectedsiteId.value,
        subcontcontroller.selectedSubcontId.value,
        FromdateController.text,TodateController.text,workType);
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty) {
          attendanceDatas.value = value.result!;
        }
        else {
          BaseUtitiles.showToast(value.message ?? "No Data Found");
        }
      }
      else{
        BaseUtitiles.showToast(value.message ??"Something went wrong..");
      }
    }else
    {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future OnItemsSelected(int slectid,String attenNo,BuildContext context) async {
    final value = await ReportsProvider.onItemSelctAttendanceList(slectid);
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty) {
          selctListDatas.value = value.result!;
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AttendancePopup(list:selctListDatas.value, attendNo:attenNo,);
              });
        }
        else {
          BaseUtitiles.showToast(value.message ?? "No Data Found");
        }
      }
      else{
        BaseUtitiles.showToast(value.message ??"Something went wrong..");
      }
    }else
    {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

}
