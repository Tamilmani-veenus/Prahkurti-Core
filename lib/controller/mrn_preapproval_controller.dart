import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/models/project_name_response.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../commonpopup/mrnfinalApprovalfrmproject_alert.dart';
import '../db_model/materialapprlist_model.dart';
import '../db_services/materialapprlist_service.dart';
import '../home/pending_list/mrnpre_aproval/mrnpreapr_entryscreen.dart';
import '../home/pending_list/mrnpre_aproval/mrnpreapr_stockmaterialwiselist_popup.dart';
import '../home/pending_list/pending_list.dart';
import '../models/materialintentsave_model.dart';
import '../models/mrnfinalapproval_aproveapiresmodel.dart';
import '../provider/common_provider.dart';
import '../provider/mrn_request_indent_provider.dart';
import '../provider/mrnfinalapproval_provider.dart';
import '../provider/pendinglist_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';
import 'mrn_request_indent_controller.dart';

class MrnPreApprovalController extends GetxController {
  final mrnpre_RequestNoText = TextEditingController();
  final mrnpre_RequestDateText = TextEditingController();
  final mrnpre_DueDateText = TextEditingController();
  final mrnpre_ApprovalNoText = TextEditingController();
  final mrnpre_ApprovalDateText = TextEditingController();
  final mrnpre_ReqremarksText = TextEditingController();
  final mrnpre_ApprovalremarksText = TextEditingController();
  final mrnpre_ApprovedbyText = TextEditingController();
  final mrnpre_VerifiedbyText = TextEditingController();
  final mrnpre_PreparedbyText = TextEditingController();
  final searchcontroller = TextEditingController();

  int entrycheck = 0;
  int reqId = 0;
  int checkColor = 0;
  int qtycheck = 0;
  // int setValueCheck = 0;
  int? preparedById;

  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  PendingListController pendingListController =
      Get.put(PendingListController());
  // MrnFinalApprovalController mrnFinalApprovalController=Get.put(MrnFinalApprovalController());
  MRN_Request_Controller mrn_request_controller =
      Get.put(MRN_Request_Controller());

  List<TextEditingController> mrnpre_BalQty_ListController = [];
  List<TextEditingController> mrnpre_ReqQty_ListController = [];
  List<TextEditingController> mrnpre_ApprQty_ListController = [];
  List<TextEditingController> mrnpre_Approval_ListController = [];
  List<TextEditingController> mrnpre_Description_ListController = [];
  List<TextEditingController> mrnpre_Remarks_ListController = [];
  List<TextEditingController> mrnpre_projectId = [];
  List<TextEditingController> mrnpre_TransfrProject_ListController = [];

  //  RxInt mrnpre_projectId =0.obs;
  // final mrnpre_TransfrProject = TextEditingController();

  RxList mrngetdropDownvalue = [].obs;
  RxList mrnProjectDropdownName = [].obs;
  List mainlist = [];
  RxList<MMatReqMasLink> getsaveDetList = <MMatReqMasLink>[].obs;
  RxList MaterialAppr_itemview_GetDbList = [].obs;
  late List<Materialapprlist> materialApprTableList = <Materialapprlist>[];
  late List<Materialapprlist> updateTableListDatas = <Materialapprlist>[];
  RxList mrnPreAppDetList = [].obs;
  List projectName = [];

  var materialapprlistTableModel = Materialapprlist();
  var materialapprlistService = MaterialapprlistService();

  Future gettingProjectName(int reqMasId, int proId, BuildContext context) async {
    final value = await MrnFinalApprovalProvider.projectNameProvider("MRN Pre Approve",proId);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MrnPreaproProjectAlert(
                    list: value.result!, data: reqMasId);
              });
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  //-------------Itemlist save in DB----------------

  malerialitemlist_save_DB(BuildContext context) {
    materialApprTableList.clear();
    var result = mrnPreAppDetList.value.first;
    result.mMatReqMasLink?.forEach((element) {
      itemlist_textControllersInitiate();
      materialapprlistTableModel = new Materialapprlist();
      materialapprlistTableModel.reqDetId = element.reqMasDetId;
      materialapprlistTableModel.materialid = element.materialid;
      materialapprlistTableModel.tranfromprjid = "0";
      materialapprlistTableModel.materialname = element.material.toString();
      materialapprlistTableModel.tranfromprjname = "--SELECT--";
      materialapprlistTableModel.scale = element.scale.toString();
      materialapprlistTableModel.scaleId = element.scaleId;
      materialapprlistTableModel.balqty = element.balQty;
      materialapprlistTableModel.appqty = element.qty;
      materialapprlistTableModel.reqqty = element.reqQty;
      materialapprlistTableModel.apptype = "P";
      materialapprlistTableModel.remarks = element.remarks;
      materialapprlistTableModel.desc = element.description;
      materialApprTableList.add(materialapprlistTableModel);
    });
    var saveData = materialapprlistService.MaterialApproval_table_Save(
        materialApprTableList);
    // Navigator.pop(context, saveData);
    return saveData;
  }

  //---------Get itemlist from local DB---------------
  getMaterialsItemlist_TableDatas() async {
    MaterialAppr_itemview_GetDbList.value = [];
    var MatAppList =
        await materialapprlistService.Material_ApprovalItemlist_table_readAll();
    MatAppList.forEach((getdatas) {
      var materialapprlist = new Materialapprlist();
      materialapprlist.reqDetId = getdatas['reqDetId'];
      materialapprlist.materialid = getdatas['materialid'];
      materialapprlist.tranfromprjid = getdatas['tranfromprjid'];
      materialapprlist.materialname = getdatas['materialname'];
      materialapprlist.tranfromprjname = getdatas['tranfromprjname'];
      materialapprlist.scale = getdatas['scale'];
      materialapprlist.scaleId = getdatas['scaleId'];
      materialapprlist.balqty = getdatas['balqty'];
      materialapprlist.appqty = getdatas['appqty'];
      materialapprlist.reqqty = getdatas['reqqty'];
      materialapprlist.apptype = getdatas['apptype'];
      materialapprlist.remarks = getdatas['remarks'];
      materialapprlist.desc = getdatas['desc'];
      MaterialAppr_itemview_GetDbList.add(materialapprlist);
    });
    setTextControllersValue();
  }

  //Set Value---
  setTextControllersValue() async {
    // if(setValueCheck == 0){
    /// ---- PreApproval-------------------
    for (var index = 0;
        index < MaterialAppr_itemview_GetDbList.length;
        index++) {
      itemlist_textControllersInitiate();
      mrnpre_BalQty_ListController[index].text =
          MaterialAppr_itemview_GetDbList.value[index].balqty.toString();
      mrnpre_ReqQty_ListController[index].text =
          MaterialAppr_itemview_GetDbList.value[index].reqqty.toString();
      mrnpre_ApprQty_ListController[index].text =
          MaterialAppr_itemview_GetDbList.value[index].appqty.toString();
      mrnpre_Approval_ListController[index].text = MaterialAppr_itemview_GetDbList.value[index].apptype;
      mrnpre_TransfrProject_ListController[index].text =
          MaterialAppr_itemview_GetDbList.value[index].tranfromprjname == ""
              ? "--SELECT--"
              : MaterialAppr_itemview_GetDbList.value[index].tranfromprjname;
      mrnpre_projectId[index].text =
          MaterialAppr_itemview_GetDbList.value[index].tranfromprjid.toString();
      mrnpre_Description_ListController[index].text =
          MaterialAppr_itemview_GetDbList.value[index].desc.toString();
      mrnpre_Remarks_ListController[index].text =
          MaterialAppr_itemview_GetDbList.value[index].remarks.toString();
    }
  }

  MaterialItemlistBal_clickEdit(int index) {
    double balQty = double.parse(
        MaterialAppr_itemview_GetDbList.value[index].balqty.toString());

    double enteredQty = mrnpre_ApprQty_ListController[index].value.text.isEmpty
        ? 0
        : double.parse(mrnpre_ApprQty_ListController[index].value.text);
    if(mrn_request_controller.ReqType.value == "PO")
    {
      if (enteredQty > balQty) {
        enteredQty = 0;
        mrnpre_ApprQty_ListController[index].text = "0.0";
        BaseUtitiles.showToast("More than Bal Qty, Not Allowed");
      }
      else {
        // If none of the above conditions are met, call updateConsumTables()
        Approval_updateConsumTables();
      }
    }
    else {
      Approval_updateConsumTables();
    }
  }

  /// ---------Update tableList Datas-----------

  Approval_updateConsumTables() async {
    int i = 0;
    updateTableListDatas.clear();
    MaterialAppr_itemview_GetDbList.forEach((element) {
      if (mrnpre_ApprQty_ListController[i].value.text == "") {
        materialapprlistTableModel = Materialapprlist();
        materialapprlistTableModel.reqDetId = element.reqDetId;
        materialapprlistTableModel.materialid = element.materialid;
        materialapprlistTableModel.tranfromprjid = mrnpre_projectId[i].text;
        materialapprlistTableModel.materialname =
            element.materialname.toString();
        materialapprlistTableModel.tranfromprjname =
            mrnpre_TransfrProject_ListController[i].text;
        materialapprlistTableModel.scale = element.scale;
        materialapprlistTableModel.scaleId = element.scaleId;
        materialapprlistTableModel.balqty = element.balqty;
        materialapprlistTableModel.appqty = 0;
        materialapprlistTableModel.reqqty = element.reqqty;
        materialapprlistTableModel.apptype =
            mrnpre_Approval_ListController[i].text;
        materialapprlistTableModel.remarks =
            mrnpre_Remarks_ListController[i].text;
        materialapprlistTableModel.desc =
            mrnpre_Description_ListController[i].text;
        updateTableListDatas.add(materialapprlistTableModel);
        i++;
      } else {
        materialapprlistTableModel = Materialapprlist();
        materialapprlistTableModel.reqDetId = element.reqDetId;
        materialapprlistTableModel.materialid = element.materialid;
        materialapprlistTableModel.tranfromprjid = mrnpre_projectId[i].text;
        materialapprlistTableModel.materialname =
            element.materialname.toString();
        materialapprlistTableModel.tranfromprjname =
            mrnpre_TransfrProject_ListController[i].text;
        materialapprlistTableModel.scale = element.scale;
        materialapprlistTableModel.scaleId = element.scaleId;
        materialapprlistTableModel.balqty = element.balqty;
        materialapprlistTableModel.reqqty = element.reqqty;
        materialapprlistTableModel.appqty =
            double.parse(mrnpre_ApprQty_ListController[i].value.text);
        materialapprlistTableModel.apptype =
            mrnpre_Approval_ListController[i].text;
        materialapprlistTableModel.remarks =
            mrnpre_Remarks_ListController[i].text;
        materialapprlistTableModel.desc =
            mrnpre_Description_ListController[i].text;
        updateTableListDatas.add(materialapprlistTableModel);
        i++;
      }
    });
    await materialapprlistService.Material_ApprovalItemlist_table_Update(
        updateTableListDatas);
  }

  /// ----delete Table data------

  deleteMaterialApprvalTable() async {
    await materialapprlistService.Material_ApprovalItemlist_table_delete();
  }

  /// ---------MRN PreApproval list---------------

  Future mrnPreapprovalDetListApi(
      String url, int ReqMasId, BuildContext context) async {
    mrnPreAppDetList.value = [];
    final value = await PendingListProvider.getMrnPreApproval(ReqMasId);
    if (value != null) {
      if (value.success == true) {
        mrnPreAppDetList.value = [value.result];
        if (mrnPreAppDetList.isNotEmpty) {
          await malerialitemlist_save_DB(context);
          await getMaterialsItemlist_TableDatas();
          await mrn_request_controller.getCheckApprovalLevel();
          mrn_request_controller.saveButton.value = RequestConstant.PREAPPROVAL;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MrnPreApprovalEntryScreen(heading: url)));
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  /// ----- MRN PreApproval -----

  itemlist_textControllersInitiate() {
    mrnpre_BalQty_ListController.add(TextEditingController());
    mrnpre_ReqQty_ListController.add(TextEditingController());
    mrnpre_ApprQty_ListController.add(TextEditingController());
    mrnpre_Approval_ListController.add(TextEditingController());
    mrnpre_TransfrProject_ListController.add(TextEditingController());
    mrnpre_Description_ListController.add(TextEditingController());
    mrnpre_Remarks_ListController.add(TextEditingController());
    mrnpre_projectId.add(TextEditingController());
  }

  RxList StockListMaterialWise = [].obs;

  /// -----------Get Stockmaterialwise List---------

  Future getStock_MaterialWise(
      int mid, String materialname, String scale, BuildContext context) async {
    StockListMaterialWise.value.clear();
    final value = await MrnFinalApprovalProvider.getStockmaterialWise(mid);
    if (value != null) {
      if (value.success == true) {
        if(value.result!.isNotEmpty) {
          StockListMaterialWise.value = value.result!;
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Mrnpreapr_Stockmaterialwise_Popup(
                    MaterialName: materialname, MaterialId: mid, Scale: scale);
              });
        }else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  Future ApproveAPI(BuildContext context) async {
    getsaveDetList.value = [];
    await Future.delayed(const Duration(seconds: 0));
    String body = materiasaveResponseToJson(MateriasaveResponse(
        id: reqId,
        reqOrdNo: mrnpre_RequestNoText.text.trim(),
        reqOrdDate: mrnpre_RequestDateText.text,
        reqdueDate: mrnpre_DueDateText.text,
        projectId: projectController.selectedProjectId.value,
        siteId: siteController.selectedsiteId.value,
        reqRemarks: mrnpre_ReqremarksText.text,
        requestType: mrn_request_controller.ReqType.value.toString(),
        preApproveBy: int.parse(loginController.EmpId()),
        preApproveDate:
            BaseUtitiles().convertToUtcIso(mrnpre_RequestDateText.text),
        verifyStatus: "Y",
        preApproveStatus: "Y",
        approveStatus: "N",
        approveRemarks: mrnpre_ApprovalremarksText.text,
        mMatReqMasLink: getsaveDetList.value.isEmpty
            ? attendanceListDet(reqId)
            : getsaveDetList.value));
    print("DDDDDD....${jsonEncode(body)}");
    final list = await Mrn_Req_provider.SaveMaterialScreenEntryAPI(
        body, reqId, mrn_request_controller.saveButton.value, context);

    if (list != null) {
      if(list["success"] == true){
      BaseUtitiles.showToast(list["message"]);
      await pendingListController.getPendingList();
      BaseUtitiles.popMultiple(context, count: 4);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    }else
      {
        BaseUtitiles.showToast("Something went wrong..");
        BaseUtitiles.popMultiple(context, count: 2);
      }
  }

  List<MMatReqMasLink>? attendanceListDet(reqId) {
    getsaveDetList.value = [];
    MaterialAppr_itemview_GetDbList.value.forEach((element) {
      itemlist_textControllersInitiate();
      if (element.reqqty > 0) {
        var list = new MMatReqMasLink(
          id: element.reqDetId,
          materialReqOrdMasid: reqId,
          materialId: element.materialid,
          qty: element.appqty,
          scaleId: element.scaleId,
          siteId: siteController.selectedsiteId.value,
          reqQty: element.reqqty,
          remarks: element.remarks,
          reqDescription: element.desc,
          refProjectId: int.tryParse(element.tranfromprjid),
          preApproveType: element.apptype,
          preApproveStatus: "Y",
          approveStatus: "N"
        );
        getsaveDetList.value.add(list);
      }
    });
    return getsaveDetList.value;
  }
}
