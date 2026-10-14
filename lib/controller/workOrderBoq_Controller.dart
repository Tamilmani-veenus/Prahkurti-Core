import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/controller/pendinglistcontroller.dart';
import 'package:prahkurticore/controller/projectcontroller.dart';
import 'package:prahkurticore/controller/sitecontroller.dart';
import 'package:prahkurticore/controller/subcontcontroller.dart';
import 'package:prahkurticore/home/menu/main_menu/workOrder_BOQ/workOrder_BOQ_entryScreen.dart';
import 'package:prahkurticore/provider/workOrderBoq_provider.dart';
import '../db_model/workOrderBoqGST_Cal_model.dart';
import '../db_model/workOrderBoqItemlist_model.dart';
import '../db_services/workOrderboqItemlist_service.dart';
import '../home/menu/main_menu/workOrder_BOQ/workOrder_Boq_Itemlist.dart';
import '../models/termsAndConditionSave_model.dart';
import '../models/termsandCondition_model.dart';
import '../models/workOrderBoqheaditems_model.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import '../models/workOrderDirectSave_model.dart';
import 'logincontroller.dart';


class WorkOrderBoqController extends GetxController{

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  PendingListController pendingListController = Get.put(PendingListController());
  LoginController loginController = Get.put(LoginController());

  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final workOrdentryDateController = TextEditingController();
  final WorkOrdActiveTypeText = TextEditingController();
  final PreparedByController = TextEditingController();
  final RemarksController = TextEditingController();

  final workOrdamount = TextEditingController();
  final rebateAmount = TextEditingController();
  final Roundoff = TextEditingController();
  final netpayamt = TextEditingController();
  List<TextEditingController> percentControllers = [];
  var workOrderTable = WorkOrderBoqGSTCalTable();
  RxList<WorkOrderBoqGSTCalTable> workOrder_ItemReadList = <WorkOrderBoqGSTCalTable>[].obs;
  late List<WorkOrderBoqGSTCalTable> updateBillGen_ItemReadList = <WorkOrderBoqGSTCalTable>[];
  late List<WorkOrderBoqGSTCalTable> workOrderTableModelList = <WorkOrderBoqGSTCalTable>[];

  RxList<SubcontractWorkOrderDetlink> getDetList = <SubcontractWorkOrderDetlink>[].obs;
  RxList<SubcontractWorkOrderAddLessSetuplink> getDetAddLessList = <SubcontractWorkOrderAddLessSetuplink>[].obs;


  var itemTableModel = WorkOrderBoqItemlist();
  var workOrdboqItemlistService = WorkOrderBoqItemlistService();

  late List<WorkOrderBoqItemlist> workOrdboqitemTableList = <WorkOrderBoqItemlist>[];
  late List<WorkOrderBoqItemlist> updateListDatas = <WorkOrderBoqItemlist>[];
  late List<WorkOrderBoqItemlist> deleteModelList = <WorkOrderBoqItemlist>[];
  RxList WorkOrdBoqitem_itemview_GetDbList = [].obs;

  List<TextEditingController> Itemlist_boqCodeControllers = [];
  List<TextEditingController> Itemlist_boqBalQtyControllers = [];
  List<TextEditingController> Itemlist_labRateControllers = [];
  List<TextEditingController> Itemlist_qtyControllers = [];
  List<TextEditingController> Itemlist_AmountControllers = [];
  List<TextEditingController> Itemlist_rateControllers = [];

  List<TextEditingController> Addwork_qtyControllers = [];
  List<TextEditingController> Addwork_rateControllers = [];
  List<TextEditingController> Addwork_AmountControllers = [];
  List<TextEditingController> RemarksControllers = [];
  List<bool> remarksCheckList = [];


  RxList main_entryList = [].obs;
  RxList workOrderBoq_entryList = [].obs;
  RxList workOrderHeadItems = [].obs;
  int workid = 0;
  RxString workOrdActTypeID = "".obs;
  bool isRestoring = false;
  double baseNetPayAmt = 0.0;
  String oldRebateValue = "0.0";
  String oldRoundOffValue = "0.0";
  RxList workOrderDet_Calculation = [].obs;
  RxList<Message> WorkOrdBoq_ItemList = <Message>[].obs;
  RxList<Message> WorkOrdBoq_MainItemList = <Message>[].obs;
  RxList workOrderBoq_editListApiDatas = [].obs;
  RxInt createdById = 0.obs;



  RxString saveButton = RequestConstant.SUBMIT.obs;

  List<bool> selected = [];
  bool selectAll = false;
  RxList<Result> selectedTerms = <Result>[].obs;
  RxList<Result> termsAndCondition = <Result>[].obs;
  RxList<Result> filteredTermsAndCondition = <Result>[].obs;
  List<Result> tempTerms = [];



  Future WorkOrdBoq_EntryList() async {
    workOrderBoq_entryList.value = [];
    main_entryList.value = [];
    final value = await WorkOrderBoqProvider.getWorkOrdBoqEntry_List(
        EntrylistFrDate.text, EntrylistToDate.text);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          workOrderBoq_entryList.value = value.result!;
          main_entryList.value = value.result!;
        } else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future WorkOrdBoq_TermsCondition() async {
    termsAndCondition.clear();
    filteredTermsAndCondition.clear();
    // selected.clear();
    final value = await WorkOrderBoqProvider.getWorkOrdBoqTermsandCondition();
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          termsAndCondition.assignAll(value.result!);

          filteredTermsAndCondition.assignAll(value.result!);

          selected = List<bool>.filled(value.result!.length, false);
          termsAndCondition.addAll(
            value.result!.where((e) => !termsAndCondition.any(
                    (x) => x.id == e.id)), // Replace id with your unique field
          );
        } else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future SaveTermsAndCondition(List<Result> termsList,saveButton) async {
    for (var item in termsList) {
      String body = termsandConditionSaveResToJson(
        TermsandConditionSaveRes(
          id: item.id,
          termsAndCondition: item.termsAndCondition,
          active: item.active,
          createdBy: item.createdBy,
          createdDt: item.createdDt,
        ),
      );
      final response =
      await WorkOrderBoqProvider.SaveTermsAndCondition(body,saveButton);
      print("Terms And Condition save API ${response}");

      if (response == null) {
        BaseUtitiles.showToast("Something went wrong");
        return false;
      }
      BaseUtitiles.showToast(response["result"]);
    }
    return true;
  }


  WorkOrdboqitemlist_Save_DB(BuildContext context) async {
    workOrdboqitemTableList.clear();
    int j = 0;
    for (var subItem in WorkOrdBoq_MainItemList) {
        for (var level3 in subItem.measureLevel3ItemS ?? []) {
          if (level3.isCheck == true) {
            if (Itemlist_qtyControllers[j].text == "0.0" ||
                Itemlist_qtyControllers[j].text == "0" ||
                Itemlist_qtyControllers[j].text.isEmpty) {
            } else {
              itemTableModel = new WorkOrderBoqItemlist();
              itemTableModel.reqDetId = 0;
              itemTableModel.headItemId = subItem.headItemid;
              itemTableModel.subItemId = level3.subItemid;
              itemTableModel.measureLevel3ItemId = level3.measureid;
              itemTableModel.itemDesc = level3.level3Item;
              itemTableModel.unit = level3.scaleId;
              itemTableModel.scaleName = level3.scaleName;
              itemTableModel.rate = level3.labourrate;
              itemTableModel.qty = level3.balqty;
              itemTableModel.balqty = level3.balqty;
              itemTableModel.labrate = level3.labourrate;
              itemTableModel.boqcode = level3.seqNo;
              itemTableModel.remarks = "";
              itemTableModel.workOrderStatus = true;
              itemTableModel.amt = itemTableModel.rate! * itemTableModel.qty!;
              int i = 0;
              WorkOrdBoqitem_itemview_GetDbList.forEach((element) {
                if (element.measureLevel3ItemId == itemTableModel.measureLevel3ItemId) {
                  i = 1;
                }
              });
              if (i == 0) {
                workOrdboqitemTableList.add(itemTableModel);
              }
              else{
                BaseUtitiles.showToast("Entry already exist");
              }
            }
          }
          j++;
        }
    }
    var savedatas = await workOrdboqItemlistService.WorkOrdBoqItem_table_Save(workOrdboqitemTableList);
    return Navigator.pop(context, savedatas);
  }

  Future getItemTablesDatas() async {
    WorkOrdBoqitem_itemview_GetDbList.clear();
    var Itemlist = await workOrdboqItemlistService.WorkOrdBoqItemlist_table_readAll();

    Itemlist.forEach((user) {
      var workOrdboqitemlist = WorkOrderBoqItemlist();
      workOrdboqitemlist.reqDetId = user['reqDetId'];
      workOrdboqitemlist.headItemId = user['headItemId'];
      workOrdboqitemlist.subItemId = user['subItemId'];
      workOrdboqitemlist.measureLevel3ItemId = user['measureLevel3ItemId'];
      workOrdboqitemlist.itemDesc = user['itemDesc'];
      workOrdboqitemlist.unit = user['unit'];
      workOrdboqitemlist.scaleName = user['scaleName'];
      workOrdboqitemlist.rate = user['rate'];
      workOrdboqitemlist.qty = user['qty'];
      workOrdboqitemlist.oldRate = user['oldRate'];
      workOrdboqitemlist.amt = user['amt'];
      workOrdboqitemlist.balqty = user['balqty'];
      workOrdboqitemlist.labrate = user['labrate'];
      workOrdboqitemlist.boqcode = user['boqcode'];
      workOrdboqitemlist.remarks = user['remarks'];
      workOrdboqitemlist.workOrderStatus = user['workOrderStatus'] == 1;
      WorkOrdBoqitem_itemview_GetDbList.add(workOrdboqitemlist);
    });
    setTextControllersValue();
  }

  setTextControllersValue() async {
    remarksCheckList.clear();
    for (var index = 0; index < WorkOrdBoqitem_itemview_GetDbList.length; index++) {
      Item_itemlist_textControllersInitiate();
      remarksCheckList.add(
        WorkOrdBoqitem_itemview_GetDbList[index].workOrderStatus);
      Itemlist_boqCodeControllers[index].text = WorkOrdBoqitem_itemview_GetDbList.value[index].boqcode.toString();
      Itemlist_boqBalQtyControllers[index].text = WorkOrdBoqitem_itemview_GetDbList.value[index].balqty.toString();
      Itemlist_labRateControllers[index].text = WorkOrdBoqitem_itemview_GetDbList.value[index].labrate.toString();
      Addwork_qtyControllers[index].text = WorkOrdBoqitem_itemview_GetDbList.value[index].qty.toString();
      Addwork_rateControllers[index].text = WorkOrdBoqitem_itemview_GetDbList.value[index].rate.toString();
      Addwork_AmountControllers[index].text = WorkOrdBoqitem_itemview_GetDbList.value[index].amt.toString();
      RemarksControllers[index].text = WorkOrdBoqitem_itemview_GetDbList.value[index].remarks.toString();
    }
  }

  Item_itemlist_textControllersInitiate() {
    Itemlist_boqCodeControllers.add(TextEditingController());
    Itemlist_boqBalQtyControllers.add(TextEditingController());
    Itemlist_labRateControllers.add(TextEditingController());
    Itemlist_qtyControllers.add(TextEditingController());
    Itemlist_rateControllers.add(TextEditingController());
    Itemlist_AmountControllers.add(TextEditingController());
    Addwork_qtyControllers.add(TextEditingController());
    Addwork_rateControllers.add(TextEditingController());
    Addwork_AmountControllers.add(TextEditingController());
    RemarksControllers.add(TextEditingController());
  }


  /// Rate Textformfield color

  bool isRateExceeded(int index) {
    double rate =
        double.tryParse(Addwork_rateControllers[index].text) ?? 0.0;

    double labourRate =
        double.tryParse(Itemlist_labRateControllers[index].text) ?? 0.0;

    return rate > labourRate;
  }

  bool validateQty(int index) {
    double qty =
        double.tryParse(Addwork_qtyControllers[index].text) ?? 0.0;

    double balQty =
        double.tryParse(Itemlist_boqBalQtyControllers[index].text) ?? 0.0;

    if (qty > balQty) {
      BaseUtitiles.showToast("Qty should not exceed BOQ BalQty");

      Addwork_qtyControllers[index].text = "0.00";
      Addwork_AmountControllers[index].text = "0.00";

      updateItemlistTable();
      return false;
    }

    calculateAmount(index);
    return true;
  }

  void calculateAmount(int index) {
    double qty =
        double.tryParse(Addwork_qtyControllers[index].text) ?? 0.0;

    double rate =
        double.tryParse(Addwork_rateControllers[index].text) ?? 0.0;

    Addwork_AmountControllers[index].text =
        (qty * rate).toStringAsFixed(2);

    updateItemlistTable();
  }

  clearDatas() {
    saveButton.value = RequestConstant.SUBMIT;
    workid = 0;
    projectController.projectname.text = "--Select--";
    projectController.selectedProjectId.value = 0;
    subcontractorController.Subcontractorname.text = "--Select--";
    subcontractorController.selectedSubcontId.value = 0;
    workOrdentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    siteController.selectedsiteId = 0.obs;
    siteController.selectedsitedropdownName = "--Select--".obs;
    siteController.getSiteDropdownvalue.value.clear();
    siteController.Sitename.text = RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
    WorkOrdActiveTypeText.text = "";
    workOrdActTypeID.value = "";
    delete_WorkOrderBoq_itemlist_Table();
    WorkOrdBoqitem_itemview_GetDbList.value.clear();
    workOrdamount.text = "0.0";
    Roundoff.text = "0";
    netpayamt.text = "0.0";
    rebateAmount.text = "0.0";
  }

  Future SaveButton_DeductionScreen(
      BuildContext context, int id, int workOrderId, status) async {
    getDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String termsConditionIds = selectedTerms
        .map((e) => e.id.toString())
        .join(",");
    String body = workOrdDirectSaveModelToJson(WorkOrdDirectSaveModel(
      id:id != 0 ? id : 0,
      workOrderNo: autoYearWiseNoController.text,
      entryDate: workOrdentryDateController.text,
      entryType: "B",
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      subContractorId: subcontractorController.selectedSubcontId.value,
      workStatus: "N",
      active: workOrdActTypeID.value,
      roundOff: double.tryParse(Roundoff.text) ?? 0.0,
      workOrderAmount: double.tryParse(workOrdamount.text)?? 0.0,
      netAmount: double.tryParse(netpayamt.text)?? 0.0,
      termsCondition:termsConditionIds,
      mailStatus: "N",
      downloadStatus: "N",
      remarks: RemarksController.text,
      createdBy: saveButton.value == RequestConstant.SUBMIT?int.parse(loginController.EmpId()):createdById.value,
      // createdDt: BaseUtitiles().convertToUtcIso(workOrdentryDateController.text),
      verifyStatus: saveButton.value == RequestConstant.VERIFY ||
          saveButton.value == RequestConstant.APPROVAL
          ? "Y"
          : "N",
      approveStatus: saveButton.value == RequestConstant.APPROVAL ? "Y" : "N",
      subcontractWorkOrderDetlink: getWorkOrderDet(id),
      subcontractWorkOrderAddLessSetuplink:
      getWorkOrderDetAddLess(id, autoYearWiseNoController.text),
    ));
    final decodedJson = jsonDecode(body);

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(decodedJson);

    debugPrint(prettyJson, wrapWidth: 1024);

    final list = await WorkOrderBoqProvider.SaveWorkOrderScreenEntryAPI(
        body, id, context,status);

    if (list != null) {
      if (list["success"] == true) {
        clearDatas();
        BaseUtitiles.showToast(list["message"]);
        if (saveButton.value == RequestConstant.VERIFY ||
            saveButton.value == RequestConstant.APPROVAL) {
          await pendingListController.getPendingList();
        } else {
          await WorkOrdBoq_EntryList();
          delete_WorkOrderBoq_itemlist_Table();
        }
        BaseUtitiles.popMultiple(context, count: 5);
      } else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  List<SubcontractWorkOrderDetlink>? getWorkOrderDet(id) {
    getDetList.value.clear();
    WorkOrdBoqitem_itemview_GetDbList.value.forEach((element) {
      var list = SubcontractWorkOrderDetlink(
          id: saveButton.value == RequestConstant.SUBMIT ? 0 : element.reqDetId,
          subcontractWorkOrderMasId: id != 0 ? id : 0,
          headItemId: element.headItemId,
          subItemId: element.subItemId,
          level3ItemId: element.measureLevel3ItemId,
          itemDes: element.itemDesc.toString(),
          unit: element.unit.toString(),
          qty: element.qty,
          rate: element.rate,
          oldRate: 0,
          amount: element.amt,
          siteId: siteController.selectedsiteId.value,
          boqCode: element.boqcode,
          workOrderStatus: element.workOrderStatus,
          workRemarks: element.remarks.toString()
      );
      getDetList.value.add(list);
    });
    return getDetList.value;
  }

  List<SubcontractWorkOrderAddLessSetuplink>? getWorkOrderDetAddLess(int id, workNo) {
    getDetAddLessList.value.clear();
    workOrder_ItemReadList.value.forEach((element) {
      if (element.percentValue! > 0) {
        var list = SubcontractWorkOrderAddLessSetuplink(
          id: element.reqDetId,
          subcontractWorkOrderMasId: id,
          workOrderNo: autoYearWiseNoController.text,
          addLessId: element.addLessId,
          percentValue: element.percentValue,
          amount: element.amount,
        );
        getDetAddLessList.value.add(list);
      }
    });
    return getDetAddLessList.value;
  }

  updateItemlistTable() async {
    int i = 0;
    updateListDatas.clear();
    WorkOrdBoqitem_itemview_GetDbList.forEach((element) {
      itemTableModel = new WorkOrderBoqItemlist();
      itemTableModel.reqDetId = element.reqDetId;
      itemTableModel.headItemId = element.headItemId;
      itemTableModel.subItemId = element.subItemId;
      itemTableModel.measureLevel3ItemId = element.measureLevel3ItemId;
      itemTableModel.itemDesc = element.itemDesc;
      itemTableModel.unit = element.unit;
      itemTableModel.scaleName = element.scaleName;
      itemTableModel.rate = double.tryParse(Addwork_rateControllers[i].text)??0;
      itemTableModel.qty = double.tryParse(Addwork_qtyControllers[i].text)??0;
      itemTableModel.balqty = element.balqty;
      itemTableModel.labrate = element.labrate;
      itemTableModel.boqcode = element.boqcode;

      itemTableModel.remarks = RemarksControllers[i].text;

      itemTableModel.workOrderStatus =  remarksCheckList[i];
      itemTableModel.amt = double.tryParse(Addwork_AmountControllers[i].text)??0;
      updateListDatas.add(itemTableModel);
      i++;
    });
    await workOrdboqItemlistService.WorkOrdBoqItemlist_table_Update(updateListDatas);
  }

  Future WorkOrder_CalculationList() async {
    workOrderDet_Calculation.value.clear();
    final value =
    await WorkOrderBoqProvider.getWorkOrderCalculation_List();
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          workOrderDet_Calculation.value = value.result!;
          await workOrderCal_itemlistTable_Delete();
          await workOrderCalculationSave();
          await getWorkorderCalDatas();
          if (saveButton.value == RequestConstant.RESUBMIT ||
              saveButton.value == RequestConstant.VERIFY ||
              saveButton.value == RequestConstant.APPROVAL) {
            setBaseNetPay(workOrdamount.text);
            await preloadEditAddLessData(
                workOrderBoq_editListApiDatas[0].subcontractWorkOrderAddLessSetuplink);
          }
        } else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future getWorkOrdItemList(BuildContext context) async {
    WorkOrdBoq_MainItemList.value = [];
    WorkOrdBoq_ItemList.value = [];
    await ClickUtils.run(() async {
    var response = await WorkOrderBoqProvider.getWorkOrderBoqHeadItem(
      subcontractorController.selectedSubcontId.value,
      siteController.selectedHeadId.value,
    );

    if (response != null) {
      if (response.success == true) {
        if (response.message!.isNotEmpty) {

          WorkOrdBoq_ItemList.value = response.message!;
          WorkOrdBoq_MainItemList.value = response.message!;

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkOrderBoqItemList(),
            ),
          );
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        // BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
    });
  }

  setCheck(int mainIndex, int id, bool value,) {
    WorkOrdBoq_MainItemList[mainIndex]
        .measureLevel3ItemS?.forEach((element) {

      if (element.measureid == id) {
        element.isCheck = value;
      }
    });
    WorkOrdBoq_MainItemList.refresh();
  }

  Future workOrderEntryList_EditApi(int workId, status,String MenuName, BuildContext context,{String? type}) async {
    await ClickUtils.run(() async {
    var response = await WorkOrderBoqProvider.workOrder_entryList_editAPI(workId,status);
    if (response != null) {
      if (response.success == true) {
        workOrderBoq_editListApiDatas.value = [response.result];
        if (workOrderBoq_editListApiDatas.isNotEmpty) {
          saveButton.value = type == "Approve"? RequestConstant.APPROVAL: type == "Verify" ? RequestConstant.VERIFY : RequestConstant.RESUBMIT;
          workOrder_EditTable_SaveTable("");
          getItemTablesDatas();
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WorkOrderBoqEntryScreen(heading: MenuName,)));
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
    });
  }

  workOrder_EditTable_SaveTable(name) async {
    workOrdboqitemTableList.clear();
    workOrderBoq_editListApiDatas.value.forEach((element) {
      if (name == "ItemListDet") {
        itemTableModel = new WorkOrderBoqItemlist();
        itemTableModel.itemDesc = element.itemDesc.toString();
        itemTableModel.unit = element.unit;
        itemTableModel.qty = element.qty;
        itemTableModel.rate = element.rate;
        itemTableModel.amt = element.amount;
        workOrdboqitemTableList.add(itemTableModel);
      } else {
        element.subcontractWorkOrderDetlink!.forEach((value) {
          itemTableModel = new WorkOrderBoqItemlist();
          itemTableModel.reqDetId = value.reqDetId;
          itemTableModel.headItemId = value.headItemId;
          itemTableModel.subItemId = value.subItemId;
          itemTableModel.measureLevel3ItemId = value.level3ItemId;
          itemTableModel.itemDesc = value.itemDesc == null ? "-" : value.itemDesc.toString();
          itemTableModel.unit = value.unit;
          itemTableModel.scaleName = value.scaleName == null ? "-" : value.scaleName;
          itemTableModel.boqcode = value.boqCode;
          itemTableModel.labrate = value.labourRate;
          itemTableModel.balqty = value.balQty;
          itemTableModel.qty = value.qty;
          itemTableModel.rate = value.rate;
          itemTableModel.amt = value.amount;
          itemTableModel.remarks = value.remarks;
          itemTableModel.workOrderStatus = value.workOrderStatus;
          workOrdboqitemTableList.add(itemTableModel);
        });
      }
    });
    var savedatas =
    await workOrdboqItemlistService.WorkOrdBoqItem_table_Save(
        workOrdboqitemTableList);
    return savedatas;
  }

  Future<bool> deductionPaymentCalculation() async {
    await getItemTablesDatas();


    if (WorkOrdBoqitem_itemview_GetDbList.value.isEmpty) return false;

    double totalNetAmount = 0.0;

    for (var item in WorkOrdBoqitem_itemview_GetDbList.value) {
      totalNetAmount += (saveButton.value == RequestConstant.RESUBMIT ||
          saveButton.value == RequestConstant.VERIFY ||
          saveButton.value == RequestConstant.APPROVAL)
          ? (item.amt ?? 0)
          : (item.amt ?? 0);
    }

    workOrdamount.text = totalNetAmount.toStringAsFixed(2);

    double bill = double.tryParse(workOrdamount.text) ?? 0;

    double round = double.tryParse(Roundoff.text) ?? 0;

    // IMPORTANT
    setBaseNetPay(workOrdamount.text);

    // RECALCULATE ADD/LESS FIRST
    for (var item in workOrder_ItemReadList) {
      double percent = item.percentValue ?? 0.0;

      double amt = (bill * percent) / 100;

      if (amt == 0) {
        item.amount = 0.0;
      } else {
        item.amount = item.addLessType == "-" ? -amt : amt;
      }
    }

    // NOW GET UPDATED TOTAL
    double addLessTotal = totalAddLess;

    // FINAL NET
    double netAmount =
        bill + round + addLessTotal;

    // VALIDATION
    if (netAmount < 0) {
      return false;
    }

    netpayamt.text = netAmount.toStringAsFixed(2);

    workOrder_ItemReadList.refresh();

    await saveUpdatedCalcData();

    return true;
  }

  double get totalAddLess {
    return workOrder_ItemReadList.fold(
      0.0,
          (sum, item) => sum + (item.amount ?? 0.0),
    );
  }

  Future<void> saveUpdatedCalcData() async {
    await updateDirectBillCalDatas();
  }

  updateDirectBillCalDatas() async {
    int i = 0;
    updateBillGen_ItemReadList.clear();
    workOrder_ItemReadList.forEach((element) {
      workOrderTable = WorkOrderBoqGSTCalTable();
      workOrderTable.reqDetId = element.reqDetId;
      workOrderTable.addLessId = element.addLessId;
      workOrderTable.percentValue = element.percentValue;
      workOrderTable.amount = element.amount;
      workOrderTable.addLessName = element.addLessName;
      workOrderTable.addLessType = element.addLessType;
      updateBillGen_ItemReadList.add(workOrderTable);
      i++;
    });
    await workOrdboqItemlistService.workOrderGST_ItemlistTable_Update(
        updateBillGen_ItemReadList);
  }

  void setBaseNetPay(String value) {
    baseNetPayAmt = double.tryParse(value) ?? 0.0;
    netpayamt.text = baseNetPayAmt.toStringAsFixed(2);
    print("=== setBaseNetPay called: $baseNetPayAmt ==="); // 👈 add this
  }

  bool calculateAndUpdate(
      int addLessId,
      double percent,
      double baseAmount,
      ) {
    final item = workOrder_ItemReadList.firstWhereOrNull(
          (e) => e.addLessId == addLessId,
    );

    if (item == null) return false;

    // OLD VALUES
    double oldPercent = item.percentValue ?? 0.0;

    double oldAmount = item.amount ?? 0.0;

    // NEW AMOUNT
    double amt = (baseAmount * percent) / 100;

    double newAmount;

    if (amt == 0) {
      newAmount = 0.0;
    } else {
      newAmount = item.addLessType == "-" ? -amt : amt;
    }

    // TEMP TOTAL
    double tempTotal = totalAddLess - oldAmount + newAmount;

    double bill = double.tryParse(workOrdamount.text) ?? 0;

    double matDebitAmt = double.tryParse(rebateAmount.text) ?? 0;

    double round = double.tryParse(Roundoff.text) ?? 0;

    double netAmount = bill + round + tempTotal;

    // NEGATIVE VALIDATION
    if (netAmount < 0) {
      BaseUtitiles.showToast(
        "Net Bill Amount cannot be negative. "
            "Please reduce the deductions "
            "or add-less percentages.",
      );

      // RESTORE OLD VALUES
      item.percentValue = oldPercent;
      item.amount = oldAmount;

      workOrder_ItemReadList.refresh();

      return false;
    }

    item.percentValue = percent;
    item.amount = newAmount;

    netpayamt.text = netAmount.toStringAsFixed(2);

    workOrder_ItemReadList.refresh();

    update();

    return true;
  }

  workOrderCalculationSave() async {
    int i = 0;
    workOrderTableModelList = [];
    workOrderDet_Calculation.value.forEach((element) {
      workOrderTable = new WorkOrderBoqGSTCalTable();
      workOrderTable.reqDetId = 0;
      workOrderTable.addLessId = element.id;
      workOrderTable.percentValue = 0.0;
      workOrderTable.amount = 0.0;
      workOrderTable.addLessName = element.addLessName;
      workOrderTable.addLessType = element.addLessType;
      workOrderTableModelList.add(workOrderTable);
      i++;
    });
    var savedatas =
    await workOrdboqItemlistService.workOrderGST_ItemTable_Save(
        workOrderTableModelList);
    return savedatas;
  }

  Future getWorkorderCalDatas() async {
    var datas = await workOrdboqItemlistService
        .workOrderGST_ItemlistTable_readAll();
    workOrder_ItemReadList.value = <WorkOrderBoqGSTCalTable>[];
    workOrder_ItemReadList.clear();
    datas.forEach((value) {
      workOrderTable = WorkOrderBoqGSTCalTable();
      workOrderTable.reqDetId = value['reqDetId'];
      workOrderTable.addLessId = value['addLessId'];
      workOrderTable.percentValue = value['percentValue'];
      workOrderTable.amount = value['amount'];
      workOrderTable.addLessName = value['addLessName'];
      workOrderTable.addLessType = value['addLessType'];
      workOrder_ItemReadList.add(workOrderTable);
    });
    initPercentControllers();
  }

  void initPercentControllers() {
    percentControllers.clear();
    for (var item in workOrder_ItemReadList) {
      percentControllers.add(
        TextEditingController(
          text: (item.percentValue ?? 0.0) == 0.0
              ? ''
              : item.percentValue.toString(),
        ),
      );
    }
  }

  Future<void> preloadEditAddLessData(List<dynamic> editAddLessList) async {
    // First load local DB rows
    await getWorkorderCalDatas();

    for (var editItem in editAddLessList) {
      print("ID: ${editItem.addLessId}");
      print("Percent: ${editItem.percentValue}");
      print("Amount: ${editItem.amount}");
    }

    // Update local rows with edit API values
    for (var editItem in editAddLessList) {
      int index = workOrder_ItemReadList.indexWhere(
            (e) => e.addLessId == editItem.addLessId,
      );

      if (index != -1) {
        workOrder_ItemReadList[index].reqDetId = editItem.id;

        workOrder_ItemReadList[index].percentValue =
            (editItem.percentValue ?? 0).toDouble();

        workOrder_ItemReadList[index].amount =
            (editItem.amount ?? 0).toDouble();

        // Update controller text also
        percentControllers[index].text = (editItem.percentValue ?? 0) == 0
            ? ''
            : editItem.percentValue.toString();
      }
    }

    // Refresh UI
    workOrder_ItemReadList.refresh();

    // Recalculate total/netpay
    updateNetPay();
  }

  void updateNetPay() {
    double bill = double.tryParse(workOrdamount.text) ?? 0;
    double round = double.tryParse(Roundoff.text) ?? 0;

    double addLessTotal = totalAddLess;

    double netAmount = bill + round + addLessTotal;

    netpayamt.text = netAmount.toStringAsFixed(2);
  }


  workOrderCal_itemlistTable_Delete() async {
    await workOrdboqItemlistService.workOrderGST_ItemlistTable_delete();
  }

  Future DeleteAlert(BuildContext context, int index,type) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if(type == "EntryList"){
                          bool result = await EntryList_DeleteApi(
                              workOrderBoq_entryList[index].id);
                          if (result) {
                            workOrderBoq_entryList.removeAt(index);
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
                          }}
                          else {
                            bool result = await Delete_termsAndCondition(index);

                            if (result) {
                              termsAndCondition.removeWhere((e) => e.id == index);
                              filteredTermsAndCondition.removeWhere((e) => e.id == index);

                              // Optional: Refresh from API
                              await WorkOrdBoq_TermsCondition();

                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).pop();
                            }
                            }
                        },
                        child: Text("Delete",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> EntryList_DeleteApi(int WorkId) async {
    return WorkOrderBoqProvider.entryList_deleteAPI(WorkId);
  }

  Future<bool> Delete_termsAndCondition(int WorkId) async {
    return WorkOrderBoqProvider.delete_TermsAndCondition(WorkId);
  }

  workOrder_itemlistTable_Delete() async {
    await workOrdboqItemlistService.WorkOrdBoqItemlist_table_delete();
  }

  delete_WorkOrderBoq_itemlist_Table() async {
    await workOrdboqItemlistService.WorkOrdBoqItemlist_table_delete();
  }

  Future deleteParticularList(WorkOrderBoqItemlist data) async {
    deleteModelList.clear();
    itemTableModel = new WorkOrderBoqItemlist();
    itemTableModel.measureLevel3ItemId = data.measureLevel3ItemId;
    deleteModelList.add(itemTableModel);
    await workOrdboqItemlistService.itemdeleteById(deleteModelList);
  }

  void searchTerms(String value) {
    if (value.trim().isEmpty) {
      filteredTermsAndCondition.assignAll(termsAndCondition);
    } else {
      filteredTermsAndCondition.assignAll(
        termsAndCondition.where(
              (e) => (e.termsAndCondition ?? "")
              .toLowerCase()
              .contains(value.toLowerCase()),
        ),
      );
    }
  }

}