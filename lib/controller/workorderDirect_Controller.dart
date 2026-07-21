import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/controller/pendinglistcontroller.dart';
import 'package:prahkurticore/controller/projectcontroller.dart';
import 'package:prahkurticore/controller/sitecontroller.dart';
import 'package:prahkurticore/controller/subcontcontroller.dart';
import '../db_model/wordOrder_itemlist_model.dart';
import '../db_model/workOrderGST_calculation_model.dart';
import '../db_services/workOrdDirect_itemlist_service.dart';
import '../home/menu/main_menu/workOrder_Direct/workOrder_Direct_EntryScreen.dart';
import '../models/workOrderDirectSave_model.dart';
import '../provider/workOrderDirectProvider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class WorkOrderDirectController extends GetxController{

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
  final WorkStatusTypeText = TextEditingController();
  final PreparedByController = TextEditingController();
  final RemarksController = TextEditingController();



  ///----------Det-------------
    final itemDescController = TextEditingController();
    final itemUnitController = TextEditingController();
    final itemQuantityController = TextEditingController();
    final itemRateController = TextEditingController();
    final workOrdamount = TextEditingController();
    final rebateAmount = TextEditingController();
    final Roundoff = TextEditingController();
    final netpayamt = TextEditingController();

  List<TextEditingController> itemlist_ListDescController = [];
  List<TextEditingController> itemlist_ListUnitsController = [];
  List<TextEditingController> itemlist_ListQtyController = [];
  List<TextEditingController> itemlist_ListRateController = [];
  List<TextEditingController> itemlist_ListAmtController = [];

  var ItemListTableModel = WorkOrderItemListTableModel();
  var workOrder_ItemlistService = WorkOrder_ItemlistService();
  late List<WorkOrderItemListTableModel> ItemListTableModelList = <WorkOrderItemListTableModel>[];
  late List<WorkOrderItemListTableModel> itemListUpdateModelList = <WorkOrderItemListTableModel>[];
  late List<WorkOrderItemListTableModel> deleteitemListModelList = <WorkOrderItemListTableModel>[];
  List ItemListTableModelReadList = <WorkOrderItemListTableModel>[];

  ///---------GST CALCULATION------------
  List<TextEditingController> percentControllers = [];

  var workOrderTable = WorkOrderGSTCalTable();
  RxList<WorkOrderGSTCalTable> workOrder_ItemReadList = <WorkOrderGSTCalTable>[].obs;
  late List<WorkOrderGSTCalTable> updateBillGen_ItemReadList = <WorkOrderGSTCalTable>[];
  late List<WorkOrderGSTCalTable> workOrderTableModelList = <WorkOrderGSTCalTable>[];

  RxList<SubcontractWorkOrderDetlink> getDetList = <SubcontractWorkOrderDetlink>[].obs;
  RxList<SubcontractWorkOrderAddLessSetuplink> getDetAddLessList = <SubcontractWorkOrderAddLessSetuplink>[].obs;


  RxList ItemGetTableListdata = [].obs;

  RxList main_entryList = [].obs;
  RxList workOrderDir_entryList = [].obs;
  int workid = 0;
  RxString workOrdActTypeID = "".obs;
  RxString workOrdStsTypeId = "".obs;
  bool isRestoring = false;
  double baseNetPayAmt = 0.0;
  String oldRebateValue = "0.0";
  String oldRoundOffValue = "0.0";
  RxList workOrderDet_Calculation = [].obs;
  RxList workOrder_editListApiDatas = [].obs;


  RxString saveButton = RequestConstant.SUBMIT.obs;


  Future WorkOrdDirect_EntryList() async {
    workOrderDir_entryList.value = [];
    main_entryList.value = [];
    final value = await WorkOrderDirectProvider.getWorkOrdDirectEntry_List(
        EntrylistFrDate.text, EntrylistToDate.text);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          workOrderDir_entryList.value = value.result!;
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

  Future WorkOrder_CalculationList() async {
    workOrderDet_Calculation.value.clear();
    final value =
    await WorkOrderDirectProvider.getWorkOrderCalculation_List();
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
                workOrder_editListApiDatas[0].subcontractWorkOrderAddLessSetuplink);
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

  itemListclickChanged() {
    int i = 0;
    ItemGetTableListdata.value.forEach((element) {
      ItemListTextInitiate();
      itemlist_ListAmtController[i].text = (double.parse(
          itemlist_ListQtyController[i].text != ""
              ? itemlist_ListQtyController[i].text
              : "0") *
          double.parse(itemlist_ListRateController[i].text != ""
              ? itemlist_ListRateController[i].text
              : "0"))
          .toString();
      i++;
    });
    updateItemlistTable();
  }

  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      ItemListTableModel = WorkOrderItemListTableModel();
      ItemListTableModel.Id = element.Id;
      ItemListTableModel.reqDetId = element.reqDetId;
      ItemListTableModel.Name = element.Name;
      ItemListTableModel.unit = itemlist_ListUnitsController[i].text;
      ItemListTableModel.qty = double.parse(
          itemlist_ListQtyController[i].text != ""
              ? itemlist_ListQtyController[i].text
              : "0");
      ItemListTableModel.rate = double.parse(
          itemlist_ListRateController[i].text != ""
              ? itemlist_ListRateController[i].text
              : "0");
      ItemListTableModel.amount =
          ItemListTableModel.qty! * ItemListTableModel.rate!;
      itemListUpdateModelList.add(ItemListTableModel);
      i++;
    });
    await workOrder_ItemlistService.workOrder_ItemlistTable_Update(
        itemListUpdateModelList);
  }


  workOrder_itemlist_SaveTable() async {
    ItemListTableModelList.clear();
    ItemListTableModel = new WorkOrderItemListTableModel();
    ItemListTableModel.Name = itemDescController.text;
    ItemListTableModel.unit = itemUnitController.text;
    ItemListTableModel.qty = double.parse(itemQuantityController.text);
    ItemListTableModel.rate = double.parse(itemRateController.text);
    ItemListTableModel.amount =
        (ItemListTableModel.qty!) * (ItemListTableModel.rate!);
    ItemListTableModelList.add(ItemListTableModel);
    var savedatas =
    await workOrder_ItemlistService.workOrder_ItemlistTable_Save(
        ItemListTableModelList);
    return savedatas;
  }

  Future getItemlistTablesDatas() async {
    var datas = await workOrder_ItemlistService.workOrder_ItemlistTable_readAll();
    ItemListTableModelReadList = <WorkOrderItemListTableModel>[];
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    datas.forEach((value) {
      ItemListTableModel = new WorkOrderItemListTableModel();
      ItemListTextInitiate();
      ItemListTableModel.Id = value['id'];
      ItemListTableModel.reqDetId = value['reqDetId'];
      ItemListTableModel.Name = value['Name'];
      ItemListTableModel.unit = value['unit'];
      ItemListTableModel.qty = value['qty'];
      ItemListTableModel.rate = value['rate'];
      ItemListTableModel.amount = value['amount'];
      ItemListTableModelReadList.add(ItemListTableModel);
      ItemGetTableListdata.value = ItemListTableModelReadList;
    });
    setItemListListTextValue(ItemGetTableListdata.value);
  }

  ItemListTextInitiate() {
    itemlist_ListDescController.add(new TextEditingController());
    itemlist_ListUnitsController.add(new TextEditingController());
    itemlist_ListQtyController.add(new TextEditingController());
    itemlist_ListRateController.add(new TextEditingController());
    itemlist_ListAmtController.add(new TextEditingController());
  }

  setItemListListTextValue(vale) {
    int i = 0;
    vale.forEach((datas) {
      ItemListTextInitiate();
      itemlist_ListDescController[i].text = datas.Name.toString();
      itemlist_ListUnitsController[i].text = datas.unit.toString();
      itemlist_ListQtyController[i].text = datas.qty.toString();
      itemlist_ListRateController[i].text = datas.rate.toString();
      itemlist_ListAmtController[i].text = datas.amount.toString();
      i++;
    });
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
    WorkStatusTypeText.text = "";
    workOrdStsTypeId.value = "";
    WorkOrdActiveTypeText.text = "";
    workOrdActTypeID.value = "";
    workOrder_itemlistTable_Delete();
    ItemGetTableListdata.value.clear();
    workOrdamount.text = "0.0";
    Roundoff.text = "0";
    netpayamt.text = "0.0";
    rebateAmount.text = "0.0";
  }


  Future SaveButton_DeductionScreen(
      BuildContext context, int id, int workOrderId, status) async {
    getDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = workOrdDirectSaveModelToJson(WorkOrdDirectSaveModel(
      id:id != 0 ? id : 0,
      workOrderNo: autoYearWiseNoController.text,
      entryDate: workOrdentryDateController.text,
      entryType: "D",
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      subContractorId: subcontractorController.selectedSubcontId.value,
      workStatus: workOrdStsTypeId.value,
      active: workOrdActTypeID.value,
      roundOff: double.tryParse(Roundoff.text) ?? 0.0,
      workOrderAmount: double.tryParse(workOrdamount.text)?? 0.0,
      netAmount: double.tryParse(netpayamt.text)?? 0.0,
      termsCondition: "",
      remarks: RemarksController.text,
      createdBy: int.parse(loginController.EmpId()),
      createdDt: BaseUtitiles().convertToUtcIso(workOrdentryDateController.text),
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

    final list = await WorkOrderDirectProvider.SaveWorkOrderScreenEntryAPI(
        body, id, context,status);

    if (list != null) {
      if (list["success"] == true) {
        clearDatas();
        BaseUtitiles.showToast(list["message"]);
        if (saveButton.value == RequestConstant.VERIFY ||
            saveButton.value == RequestConstant.APPROVAL) {
          await pendingListController.getPendingList();
        } else {
          await WorkOrdDirect_EntryList();
          workOrder_itemlistTable_Delete();
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
    ItemGetTableListdata.value.forEach((element) {
      var list = SubcontractWorkOrderDetlink(
        id: saveButton.value == RequestConstant.RESUBMIT ? element.reqDetId : 0,
        subcontractWorkOrderMasId: id != 0 ? id : 0,
        headItemId: 0,
        subItemId: 0,
        level3ItemId: 0,
        itemDes: element.Name.toString(),
        unit: element.unit.toString(),
        qty: element.qty,
        rate: element.rate,
        oldRate: element.rate,
        amount: element.amount,
        siteId: siteController.selectedsiteId.value,
        boqCode: "",
        workOrderStatus: false,
        workRemarks: ""
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

  Future workOrderEntryList_EditApi(int workId, status,String MenuName, BuildContext context,{String? type}) async {
    var response = await WorkOrderDirectProvider.workOrder_entryList_editAPI(workId,status);
    if (response != null) {
      if (response.success == true) {
        workOrder_editListApiDatas.value = [response.result];
        if (workOrder_editListApiDatas.isNotEmpty) {
          saveButton.value = type == "Approve"? RequestConstant.APPROVAL: type == "Verify" ? RequestConstant.VERIFY : RequestConstant.RESUBMIT;
          workOrder_EditTable_SaveTable("");
          getItemlistTablesDatas();
          return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WorkOrdDirectEntryScreen(heading: MenuName,)));
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  workOrder_EditTable_SaveTable(name) async {
    ItemListTableModelList.clear();
    workOrder_editListApiDatas.value.forEach((element) {
      if (name == "ItemListDet") {
        ItemListTableModel = new WorkOrderItemListTableModel();
        ItemListTableModel.Name = element.itemDesc.toString();
        ItemListTableModel.unit = element.unit.toString();
        ItemListTableModel.qty = element.qty;
        ItemListTableModel.rate = element.rate;
        ItemListTableModel.amount = element.amount;
        ItemListTableModelList.add(ItemListTableModel);
      } else {
        element.subcontractWorkOrderDetlink!.forEach((value) {
          ItemListTableModel = new WorkOrderItemListTableModel();
          ItemListTableModel.reqDetId = value.reqDetId;
          ItemListTableModel.Name = value.itemDesc.toString();
          ItemListTableModel.unit = value.unit.toString();
          ItemListTableModel.qty = value.qty;
          ItemListTableModel.rate = value.rate;
          ItemListTableModel.amount = value.amount;
          ItemListTableModelList.add(ItemListTableModel);
        });
      }
    });

    var savedatas =
    await workOrder_ItemlistService.workOrder_ItemlistTable_Save(
        ItemListTableModelList);
    return savedatas;
  }

  Future<bool> deductionPaymentCalculation() async {
    await getItemlistTablesDatas();


    if (ItemGetTableListdata.value.isEmpty) return false;

    double totalNetAmount = 0.0;

    for (var item in ItemGetTableListdata.value) {
      totalNetAmount += (saveButton.value == RequestConstant.RESUBMIT ||
          saveButton.value == RequestConstant.VERIFY ||
          saveButton.value == RequestConstant.APPROVAL)
          ? (item.amount ?? 0)
          : (item.amount ?? 0);
    }

    workOrdamount.text = totalNetAmount.toStringAsFixed(2);

    double bill = double.tryParse(workOrdamount.text) ?? 0;

    double rebateAmt = double.tryParse(rebateAmount.text) ?? 0;

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

  Future<void> saveUpdatedCalcData() async {
    await updateDirectBillCalDatas();
  }

  updateDirectBillCalDatas() async {
    int i = 0;
    updateBillGen_ItemReadList.clear();
    workOrder_ItemReadList.forEach((element) {
      workOrderTable = WorkOrderGSTCalTable();
      workOrderTable.reqDetId = element.reqDetId;
      workOrderTable.addLessId = element.addLessId;
      workOrderTable.percentValue = element.percentValue;
      workOrderTable.amount = element.amount;
      workOrderTable.addLessName = element.addLessName;
      workOrderTable.addLessType = element.addLessType;
      updateBillGen_ItemReadList.add(workOrderTable);
      i++;
    });
    await workOrder_ItemlistService.workOrderGST_ItemlistTable_Update(
        updateBillGen_ItemReadList);
  }

  double get totalAddLess {
    return workOrder_ItemReadList.fold(
      0.0,
          (sum, item) => sum + (item.amount ?? 0.0),
    );
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
      workOrderTable = new WorkOrderGSTCalTable();
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
    await workOrder_ItemlistService.workOrderGST_ItemTable_Save(
        workOrderTableModelList);
    return savedatas;
  }

  Future getWorkorderCalDatas() async {
    var datas = await workOrder_ItemlistService
        .workOrderGST_ItemlistTable_readAll();
    workOrder_ItemReadList.value = <WorkOrderGSTCalTable>[];
    workOrder_ItemReadList.clear();
    datas.forEach((value) {
      workOrderTable = WorkOrderGSTCalTable();
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
    double rebateAmt = double.tryParse(rebateAmount.text) ?? 0;
    double round = double.tryParse(Roundoff.text) ?? 0;

    double addLessTotal = totalAddLess;

    double netAmount = bill + round + addLessTotal;

    netpayamt.text = netAmount.toStringAsFixed(2);
  }


  workOrderCal_itemlistTable_Delete() async {
    await workOrder_ItemlistService.workOrderGST_ItemlistTable_delete();
  }

  workOrder_itemlistTable_Delete() async {
    await workOrder_ItemlistService.workOrder_ItemlistTable_delete();
  }

  Future deleteByIditemlistTableable(
      WorkOrderItemListTableModel data) async {
    deleteitemListModelList.clear();
    ItemListTableModel = new WorkOrderItemListTableModel();
    ItemListTableModel.Id = data.Id;
    ItemListTableModel.Name = data.Name;
    deleteitemListModelList.add(ItemListTableModel);
    await workOrder_ItemlistService.workOrder_ItemlistTable_deleteById(
        deleteitemListModelList);
  }

  Future DeleteAlert(BuildContext context, int index) async {
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
                          bool result = await EntryList_DeleteApi(
                              workOrderDir_entryList[index].id);
                          if (result) {
                            workOrderDir_entryList.removeAt(index);
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
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
    return WorkOrderDirectProvider.entryList_deleteAPI(WorkId);
  }

}