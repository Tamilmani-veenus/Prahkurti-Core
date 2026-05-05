import 'package:prahkurticore/controller/logincontroller.dart';
import 'package:prahkurticore/controller/reports_controller.dart';

import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../home/dpr_report/dpr_popup.dart';
import '../home/pdf_generate/pdf_model/pdfmodel.dart';
import '../provider/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'dailywrk_done_dpr_controller.dart';

class DprController extends GetxController {
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());
  ReportsController reportsController = Get.put(ReportsController());
  LoginController loginController = Get.put(LoginController());

  RxList dprList = [].obs;
  List<PdfListModel> getDprList_Pdf = <PdfListModel>[];
  RxList selctListDatas = [].obs;
  int checkColor = 0;

  Future getDprReportList() async {
    dprList.value.clear();
    await ReportsProvider.getDprReport_List(
        reportsController.selectedProjectId.value,
        reportsController.selectedsiteId.value,
        reportsController.selectedSubcontId.value,
            FromdateController.text,
            TodateController.text,
            dailyWrkDone_DPR_Controller.wrktype_DPR.value,
        loginController.user.value.userType.toString(),
      loginController.user.value.userId!
    ).then((value) async {
      if (value != null && value.length > 0) {
        dprList.value = value;
        return dprList.value;
      }
      else{
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future OnItemsSelected(
      int slectid, String workNo, BuildContext context) async {
    await ReportsProvider.onItemSelctDprList(slectid).then((value) async {
      if (value != null && value.length > 0) {
        selctListDatas.value = value;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return DprPopup(
                list: selctListDatas.value,
                workNo: workNo,
              );
            });
      }
    });
  }
}
