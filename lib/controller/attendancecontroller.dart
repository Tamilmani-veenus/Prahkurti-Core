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

  Future getAttendance_rptList() async {
    attendanceDatas.value.clear();
    await ReportsProvider.getAttendancereportList( reportsController.selectedProjectId.value,reportsController.selectedSubcontId.value, FromdateController.text,TodateController.text,wrktype.value, loginController.user.value.userType.toString(), loginController.user.value.userId!).then((value)async{
      if(value!=null&& value.length>0){
        attendanceDatas.value=value;
        return attendanceDatas.value;
      }
      else{
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        // attendanceDatas.value.clear();
      }
    });
  }

  Future OnItemsSelected(int slectid,String attenNo,BuildContext context)async{
    await ReportsProvider.onItemSelctAttendanceList(slectid).then((value)async{
      if(value!=null&&value.length>0){
        selctListDatas.value=value;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AttendancePopup(list:selctListDatas.value, attendNo:attenNo,);
            });
      }
    });
  }
}
