import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/controller/projectcontroller.dart';
import 'package:prahkurticore/controller/sitecontroller.dart';
import 'package:prahkurticore/controller/subcontcontroller.dart';
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

class WorkOrderBoqController extends GetxController{

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());

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


  RxString saveButton = RequestConstant.SUBMIT.obs;

  List<bool> selected = [];
  bool selectAll = false;
  RxList<Result> selectedTerms = <Result>[].obs;
  RxList<Result> termsAndCondition = <Result>[].obs;
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
    termsAndCondition.value = [];
    final value = await WorkOrderBoqProvider.getWorkOrdBoqTermsandCondition();
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          termsAndCondition.value = value.result!;
          termsAndCondition.addAll(
            value.result!.where((e) => !termsAndCondition.any(
                    (x) => x.id == e.id)), // Replace id with your unique field
          );
          selected.addAll(
            List.generate(value.result!.length, (_) => false),
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
              itemTableModel.subItemId = subItem.subItemid;
              itemTableModel.measureLevel3ItemId = level3.id;
              itemTableModel.itemDesc = level3.level3Item;
              itemTableModel.unit = level3.scaleId;
              itemTableModel.scaleName = level3.scaleName;
              itemTableModel.rate = level3.labourrate;
              itemTableModel.qty = level3.balqty;
              itemTableModel.balqty = level3.balqty;
              itemTableModel.labrate = level3.labourrate;
              itemTableModel.boqcode = level3.seqNo;
              itemTableModel.remarks = "";
              itemTableModel.workOrderStatus = j < remarksCheckList.length ? remarksCheckList[j] : true;
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
    for (var index = 0; index < WorkOrdBoqitem_itemview_GetDbList.length; index++) {
      Item_itemlist_textControllersInitiate();
      remarksCheckList.add(
        WorkOrdBoqitem_itemview_GetDbList[index].workOrderStatus ?? true,
      );
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

      itemTableModel.workOrderStatus =
      i < remarksCheckList.length ? remarksCheckList[i] : true;
      // itemTableModel.oldRate = element.reviseQty;
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

    var response = await WorkOrderBoqProvider.getWorkOrderBoqHeadItem(
      subcontractorController.selectedSubcontId.value,
      siteController.selectedHeadId.value,
    );

    if (response != null) {
      if (response.success == true) {
        if (response.message!.isNotEmpty) {

          WorkOrdBoq_ItemList.value = response.message!;
          WorkOrdBoq_MainItemList.value = response.message!;

          Navigator.push(
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
  }

  setCheck(int mainIndex, int id, bool value,) {
    WorkOrdBoq_MainItemList[mainIndex]
        .measureLevel3ItemS?.forEach((element) {

      if (element.id == id) {
        element.isCheck = value;
      }
    });
    WorkOrdBoq_MainItemList.refresh();
  }

  Future<bool> deductionPaymentCalculation() async {
    await getItemTablesDatas();


    if (WorkOrdBoqitem_itemview_GetDbList.value.isEmpty) return false;

    double totalNetAmount = 0.0;

    for (var item in WorkOrdBoqitem_itemview_GetDbList.value) {
      totalNetAmount += (saveButton.value == RequestConstant.RESUBMIT ||
          saveButton.value == RequestConstant.VERIFY ||
          saveButton.value == RequestConstant.APPROVAL)
          ? (item.amount ?? 0)
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
                            bool result = await Delete_termsAndCondition(
                                termsAndCondition[index].id!);

                            if (result) {
                              termsAndCondition.removeAt(index);

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



}