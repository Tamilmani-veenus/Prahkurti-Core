import 'package:prahkurticore/controller/logincontroller.dart';
import 'package:prahkurticore/controller/reports_controller.dart';
import 'package:prahkurticore/controller/transfer_acknowledgment_pending_controller.dart';

import '../controller/projectcontroller.dart';
import '../home/mrn_report/mrn_popup.dart';
import '../home/pdf_generate/pdf_model/pdfmodel.dart';
import '../provider/common_provider.dart';
import '../provider/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'fromproject_ccontroller.dart';
import 'fromsite_controller.dart';

class SiteController extends GetxController {
  final Sitename = TextEditingController();
  RxList getSiteDropdownvalue = [].obs;
  RxList getToSiteDropdownvalue = [].obs;
  RxList mainlist = [].obs;
  RxList siteDropdownId = [].obs;
  RxList siteDropdownName = [].obs;
  RxInt selectedsiteId = 0.obs;
  RxString selectedsitedropdownName = "".obs;
  ProjectController projectController = Get.put(ProjectController());
  ReportsController reportsController = Get.put(ReportsController());
  LoginController loginController = Get.put(LoginController());
  FromSiteController fromsiteController = Get.put(FromSiteController());
  FromProjectController fromprojectController =
      Get.put(FromProjectController());
  TransferAcknowledgmentPendingController transferAcknowController =
      Get.put(TransferAcknowledgmentPendingController());

  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  RxList mrnListValue = [].obs;
  List<PdfListModel> getMNRList_Pdf = <PdfListModel>[];
  RxList selctListDatas = [].obs;
  int checkColor = 0;

  Future subcontEntry_siteDropdowntList(BuildContext context, int editvalue,
      {String? type}) async {
    getSiteDropdownvalue.value.clear();
    final value = await CommonProvider.getSiteDropdown(
        type=="transb/wproj&site"?fromprojectController.selectedProjectId.value:
        type=="transAck"?transferAcknowController.frProjectID.value:
        type=="StoreTransfer"?projectController.selectedProjectId.value:
        type=="InwardReport"?reportsController.selectedProjectId.value:
        projectController.selectedProjectId.value,
        0,
        type == "StoreTransfer" ? "StoreTransfer" : "Fromsite",toSiteId:selectedsiteId.value);
    if (value != null) {
      if(value.success == true) {
      if(value.result!.isNotEmpty) {
      getSiteDropdownvalue.value = value.result!;
        }
      else {
        BaseUtitiles.showToast(value.message ?? "No Data Found");
      }
      }
      else {
        BaseUtitiles.showToast(value.message ?? "Something went wrong..");
      }
    }
    else{
      BaseUtitiles.showToast("Something went wrong..");
    }
  }



  Future toSiteDropdowntList() async {
    getToSiteDropdownvalue.value.clear();
    final value = await CommonProvider.getSiteDropdown(projectController.selectedProjectId.value,fromsiteController.selectedsiteId.value,"Tosite");
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty) {
      getToSiteDropdownvalue.value = value.result!;
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

  Future getMrnReporttList() async {
    mrnListValue.value.clear();
    final value = await ReportsProvider.getMrn_Report_List(
            reportsController.selectedProjectId.value,
            reportsController.selectedsiteId.value,
            FromdateController.text,
            TodateController.text);
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty) {
          mrnListValue.value = value.result!;
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


  Future OnItemsSelected(int slectid, String MrnReqNo, BuildContext context) async {
    final value = await ReportsProvider.onItemSelctMrnList(slectid);
    if (value != null) {
      if(value.success == true){
        if(value.result!.isNotEmpty) {
          selctListDatas.value = value.result!;
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return mrnPopup(list: selctListDatas.value, MrnReqNo: MrnReqNo);
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
