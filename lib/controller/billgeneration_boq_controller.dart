import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prahkurticore/controller/pendinglistcontroller.dart';
import '../controller/logincontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/billgen_boq_itemlist_model.dart';
import '../db_model/direct_bill_gst_calculation_model.dart';
import '../db_services/bill_boq_itemlist_service.dart';
import '../home/menu/daily_entries/bill_generation/bill_generation_boq_entry.dart';
import '../models/directbill_gener_saveapireq_model.dart';
import '../provider/billgeneration_boq_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dailywrk_done_dpr_controller.dart';

class BillGenerationBoqController extends GetxController {
  final billentryDateController = TextEditingController();
  final billInvoiceDateController = TextEditingController();
  final billPaymentWkDateController = TextEditingController();
  final entryTypeController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final DirectBillTypeText = TextEditingController();
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  final RemarksController = TextEditingController();
  final itemDescController = TextEditingController();
  final itemUnitController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final itemRateController = TextEditingController();
  List<TextEditingController> itemlist_ListDescController = [];
  List<TextEditingController> itemlist_ListUnitsController = [];
  List<TextEditingController> itemlist_ListQtyController = [];
  List<TextEditingController> itemlist_ListRateController = [];
  List<TextEditingController> itemlist_ListAmtController = [];
  List<TextEditingController> itemlist_ListAppQtyController = [];
  List<TextEditingController> itemlist_ListBalQtyController = [];
  List<TextEditingController> itemlist_ListCurQtyController = [];

  final billamount = TextEditingController();
  final Creditamt = TextEditingController();
  final CreditRemarksController = TextEditingController();
  final materialDebitamt = TextEditingController();
  final materialDebitRemarks = TextEditingController();


  final Debitamt = TextEditingController();
  final DebitRemarksController = TextEditingController();
  final tobededadv = TextEditingController();
  final Advded = TextEditingController();
  final Roundoff = TextEditingController();
  final netBillAmt = TextEditingController();
  final finalBillAmt = TextEditingController();
  final netpayamt = TextEditingController();
  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  RxList main_entryList = [].obs;
  RxList bill_entryList = [].obs;
  RxList billDet_Calculation = [].obs;
  RxList bill_itemList = [].obs;
  RxList bill_editListApiDatas = [].obs;
  RxString directBillTypeID = "".obs;
  RxList reqDetIdNmrDet = [].obs;
  double baseNetPayAmt = 0.0;
  double totalNetBillamount = 0.0;
  double totalNetPayAmt = 0.0;
  String oldCreditValue = "0.0";
  String oldDebitValue = "0.0";
  bool isRestoring = false;
  String oldRoundOffValue = "0.0";
  String oldmatDebitValue = "0.0";
  RxString entryType = "".obs;
  RxBool isAdvanceReadOnly = true.obs;
  RxInt createdById = 0.obs;


  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController =
  Get.put(SubcontractorController());
  PendingListController pendingListController = Get.put(PendingListController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller =
  Get.put(DailyWrkDone_DPR_Controller());

  String to_be_dection_advance = "0";

  int workid = 0;

  RxString saveButton=RequestConstant.SUBMIT.obs;

  var directBillGen_ItemlistService = BillGenBoq_ItemlistService();

  var ItemListTableModel = BillGenBoqItemListTableModel();
  late List<BillGenBoqItemListTableModel> ItemListTableModelList = <BillGenBoqItemListTableModel>[];
  List ItemListTableModelReadList = <BillGenBoqItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  late List<BillGenBoqItemListTableModel> itemListUpdateModelList = <BillGenBoqItemListTableModel>[];
  late List<BillGenBoqItemListTableModel> deleteitemListModelList = <BillGenBoqItemListTableModel>[];

  var directBillTable = DirectBillGSTCalTable();
  late List<DirectBillGSTCalTable> directBillTableModelList = <DirectBillGSTCalTable>[];
  RxList<DirectBillGSTCalTable> directBillGen_ItemReadList = <DirectBillGSTCalTable>[].obs;
  late List<DirectBillGSTCalTable> updateBillGen_ItemReadList = <DirectBillGSTCalTable>[];
  List<TextEditingController> percentControllers = [];

  RxList<SubContractorWorkQtyDet> getDetList = <SubContractorWorkQtyDet>[].obs;
  RxList<SubContractorBillAddLessSetup> getDetAddLessList = <SubContractorBillAddLessSetup>[].obs;

  List<XFile> imageFiles = [];
  int pickedImageCount = 0;
  bool isSelected = false;
  bool isNetSelected = false;
  // String? gettingNetworkImage;
  // int? imageId;
  List<String> gettingNetworkImages = []; // store multiple URLs
  List<int> imageIds = [];

  Future DirectBill_EntryList() async {
    bill_entryList.value=[];
    main_entryList.value=[];
    final value = await BillGenerateBoqProvider.getBillDirectEntry_List(
        EntrylistFrDate.text,
        EntrylistToDate.text);
    if (value != null) {
      if(value.success==true){
        if(value.result!.isNotEmpty){
          bill_entryList.value = value.result!;
          main_entryList.value = value.result!;

        }
        else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future DirectBill_CalculationList({type}) async {
    billDet_Calculation.value.clear();
    final value = await BillGenerateBoqProvider.getBillDirectCalculation_List(
      pId:projectController.selectedProjectId.value,
      siteId:siteController.selectedsiteId.value,
      subId:dailyWrkDone_DPR_Controller.TypeSubcontId.value,
      wrkOrdId:subcontractorController.selectedWorkOrderId.value,
      type: type,
    );
    if (value != null) {
      if(value.success==true){
        if(value.result!.isNotEmpty){
          billDet_Calculation.value = value.result!;
          await DirectBillCal_itemlistTable_Delete();
          await directBillCalculationSave();
          await getDirectBillCalDatas();
          if(saveButton.value == RequestConstant.RESUBMIT || saveButton.value == RequestConstant.VERIFY || saveButton.value == RequestConstant.APPROVAL) {
            setBaseNetPay();
            await preloadEditAddLessData(bill_editListApiDatas[0].subContractorBillAddLessSetupS);
          }
        }
        // else {
        //   BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        // }
      }
      // else {
      //   BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      // }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  void setBaseNetPay() {

    double bill = double.tryParse(billamount.text) ?? 0;

    double credit = double.tryParse(Creditamt.text) ?? 0;

    double debit = double.tryParse(Debitamt.text) ?? 0;

    double netBill =
        bill +
            credit -
            debit;

    baseNetPayAmt = netBill;

    netBillAmt.text = netBill.toStringAsFixed(2);

    print("=== Base Net Bill : $baseNetPayAmt ===");
  }


  Future<String?> getNmrAdvance() async {
    final value = await BillGenerateBoqProvider.billadv_balance(
        projectController.selectedProjectId.value,
        dailyWrkDone_DPR_Controller.TypeSubcontId.value);
    if (value != null) {
      if (value["success"] == true) {
        if (value["result"].isNotEmpty) {
          to_be_dection_advance = value["result"]["AdvanceAmount"].toString();
          return to_be_dection_advance;
        }
        else {
          BaseUtitiles.showToast('No Data Found');
        }
      }
      else {
        BaseUtitiles.showToast(value["message"] ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  billgen_itemlistTable_Delete() async {
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_delete();
  }

  Future deleteByIditemlistTableable(BillGenBoqItemListTableModel data) async {
    deleteitemListModelList.clear();
    ItemListTableModel = new BillGenBoqItemListTableModel();
    ItemListTableModel.level3ItemId = data.level3ItemId;
    ItemListTableModel.Name = data.Name;
    deleteitemListModelList.add(ItemListTableModel);
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_deleteById(deleteitemListModelList);
  }

  billgen_itemlist_SaveTable() async {
    ItemListTableModelList.clear();
    ItemListTableModel = new BillGenBoqItemListTableModel();
    ItemListTableModel.Name = itemDescController.text;
    ItemListTableModel.unit = itemUnitController.text;
    ItemListTableModel.qty = double.parse(itemQuantityController.text);
    ItemListTableModel.rate = double.parse(itemRateController.text);
    ItemListTableModel.amount = (ItemListTableModel.appQty!) * (ItemListTableModel.rate!);
    ItemListTableModelList.add(ItemListTableModel);
    var savedatas = await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_Save(ItemListTableModelList);
    return savedatas;
  }

  Future getItemlistTablesDatas() async {

    for (var controller in itemlist_ListAppQtyController) {
      controller.dispose();
    }

    // Clear controller lists
    itemlist_ListAppQtyController.clear();

    var datas =
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_readAll();

    ItemListTableModelReadList = <BillGenBoqItemListTableModel>[];
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();

    for (var value in datas) {

      // Create controllers for this row
      ItemListTextInitiate();

      ItemListTableModel = BillGenBoqItemListTableModel();
      ItemListTableModel.reqDetId = value['reqDetId'];
      ItemListTableModel.Name = value['Name'];
      ItemListTableModel.unit = value['unit'];
      ItemListTableModel.qty = value['qty'];
      ItemListTableModel.rate = value['rate'];
      ItemListTableModel.balbillqty = value['balbillqty'];
      ItemListTableModel.CurBillQty = value['CurBillQty'];
      ItemListTableModel.appQty = value['appQty'];
      ItemListTableModel.level3ItemId = value['level3ItemId'];
      ItemListTableModel.headItemid = value['headItemid'];
      ItemListTableModel.subItemid = value['subItemid'];
      ItemListTableModel.amount = value['amount'];
      ItemListTableModelReadList.add(ItemListTableModel);
    }
    ItemGetTableListdata.value = ItemListTableModelReadList;
    setItemListListTextValue(ItemGetTableListdata.value);
  }


  ItemListTextInitiate() {
    itemlist_ListDescController.add(new TextEditingController());
    itemlist_ListUnitsController.add(new TextEditingController());
    itemlist_ListQtyController.add(new TextEditingController());
    itemlist_ListRateController.add(new TextEditingController());
    itemlist_ListAmtController.add(new TextEditingController());
    itemlist_ListBalQtyController.add(new TextEditingController());
    itemlist_ListCurQtyController.add(new TextEditingController());
    itemlist_ListAppQtyController.add(new TextEditingController());
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
      itemlist_ListBalQtyController[i].text = datas.balbillqty.toString();
      itemlist_ListCurQtyController[i].text = datas.CurBillQty.toString();
      itemlist_ListAppQtyController[i].text = datas.appQty.toString();
      i++;
    });
  }

  itemListclickChanged() async {
    int i=0;
    ItemGetTableListdata.value.forEach((element) {
      ItemListTextInitiate();
      itemlist_ListAmtController[i].text = (double.parse(itemlist_ListAppQtyController[i].text != "" ? itemlist_ListAppQtyController[i].text : "0")* double.parse(itemlist_ListRateController[i].text != "" ? itemlist_ListRateController[i].text : "0")).toString();
      i++;
    });
   await updateItemlistTable();
  }

  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      ItemListTableModel = BillGenBoqItemListTableModel();
      ItemListTableModel.reqDetId = element.reqDetId!;
      ItemListTableModel.Name = element.Name;
      ItemListTableModel.unit = element.unit;
      ItemListTableModel.qty = element.qty;
      ItemListTableModel.rate = element.rate;
      ItemListTableModel.level3ItemId = element.level3ItemId;
      ItemListTableModel.headItemid = element.headItemid;
      ItemListTableModel.subItemid = element.subItemid;
      ItemListTableModel.balbillqty = element.balbillqty;
      ItemListTableModel.CurBillQty = element.CurBillQty;
      ItemListTableModel.appQty = double.parse(itemlist_ListAppQtyController[i].text != "" ? itemlist_ListAppQtyController[i].text : "0");

      ItemListTableModel.amount = ItemListTableModel.appQty! * ItemListTableModel.rate!;
      itemListUpdateModelList.add(ItemListTableModel);
      i++;
    });
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_Update(itemListUpdateModelList);
  }

  Future<void> validateTotalQty(int index) async {
    double totalQty =
        double.tryParse(itemlist_ListQtyController[index].text) ?? 0.0;

    double appQty =
        double.tryParse(itemlist_ListAppQtyController[index].text) ?? 0.0;

    if (appQty > totalQty) {
      Fluttertoast.showToast(
        msg: "AppQty should not be greater than Total Qty",
        toastLength: Toast.LENGTH_SHORT,
      );

      itemlist_ListAppQtyController[index].text = "0.0";
    }
  }

  Future getWorkOrderList(name,toDate) async {
    ItemGetTableListdata.value = [];
    bill_editListApiDatas.value = [];
    final value = await BillGenerateBoqProvider.getWorkOrderList(
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,
        dailyWrkDone_DPR_Controller.TypeSubcontId.value,
        subcontractorController.selectedWorkOrderId.value,
        toDate);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          await billgen_itemlistTable_Delete();

          itemlist_ListDescController.clear();
          itemlist_ListUnitsController.clear();
          itemlist_ListQtyController.clear();
          itemlist_ListRateController.clear();
          itemlist_ListAmtController.clear();
          itemlist_ListBalQtyController.clear();
          itemlist_ListCurQtyController.clear();
          itemlist_ListAppQtyController.clear();
          bill_editListApiDatas.value = value.result!;
          await billgen_EditTable_SaveTable(name);
          await getItemlistTablesDatas();
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


  clearDatas(){
    to_be_dection_advance="0";
    saveButton.value=RequestConstant.SUBMIT;
    workid=0;
    projectController.projectname.text="--SELECT--";
    projectController.selectedProjectId.value=0;
    subcontractorController.Subcontractorname.text="--SELECT--";
    subcontractorController.selectedSubcontId.value=0;
    RemarksController.clear();
    billentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    billPaymentWkDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    billInvoiceDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    FromdateController.text=BaseUtitiles.initiateCurrentDateFormat();
    TodateController.text=BaseUtitiles.initiateCurrentDateFormat();
    siteController.selectedsiteId=0.obs;
    siteController.selectedsitedropdownName="--SELECT--".obs;
    siteController.getSiteDropdownvalue.value.clear();
    siteController.Sitename.text=RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
    DirectBillTypeText.text="";
    directBillTypeID.value="";
    billgen_itemlistTable_Delete();
    ItemGetTableListdata.value.clear();
    billamount.text="0.0";
    Creditamt.text="0.0";
    Debitamt.text="0.0";
    CreditRemarksController.text="-";
    DebitRemarksController.text="-";
    Advded.text="0.0";
    Roundoff.text="0";
    netpayamt.text="0.0";
    materialDebitamt.text="0.0";
    tobededadv.text= to_be_dection_advance;
  }


  Future SaveButton_DeductionScreen(BuildContext context, int id,int workOrderId) async {
    await Future.delayed(const Duration(seconds: 0));
    String body = billDirectGenSaveApiReqToJson(BillDirectGenSaveApiReq(
      workId: id != 0 ? id : 0,
      workNo: autoYearWiseNoController.text,
      workDate: billentryDateController.text,
      entryType: entryType.value,
      billType: directBillTypeID.value,
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      subContId:  dailyWrkDone_DPR_Controller.TypeSubcontId.value,
      workOrderId: workOrderId,
      // refWorkId: 0,
      fromDate: FromdateController.text,
      toDate: TodateController.text,
      billno: subcontractorController.InvoiceNo.text,
      remarks: RemarksController.text,
      rndOff: double.tryParse(Roundoff.text) ?? 0.0,
      billAmount: double.tryParse(billamount.text)?? 0.0,
      netBillAmount: double.tryParse(netBillAmt.text)?? 0.0,
      actAdvAmt: double.tryParse(tobededadv.text)?? 0.0,
      advAmt: double.tryParse(Advded.text)?? 0.0,
      netPayAmt: double.tryParse(netpayamt.text)?? 0.0,
      debitAmt: double.tryParse(Debitamt.text)?? 0.0,
      creditAmt: double.tryParse(Creditamt.text)?? 0.0,
      debitRemarks: DebitRemarksController.text,
      creditRemarks: CreditRemarksController.text,
      materialDebitRemarks: materialDebitRemarks.text,
      materialDebitAmount: double.tryParse(materialDebitamt.text)?? 0.0,
      finalBillAmount: double.tryParse(finalBillAmt.text)?? 0.0,
      penaltyAmount: 0,
      paymentDate: billPaymentWkDateController.text,
      partRateStatus: 0,
      createdBy: saveButton.value == RequestConstant.SUBMIT?int.parse(loginController.EmpId()):createdById.value,
      // createdDt: BaseUtitiles().convertToUtcIso(billentryDateController.text),
      verifyStatus: saveButton.value == RequestConstant.VERIFY || saveButton.value == RequestConstant.APPROVAL? "Y":"N",
      approveStatus: saveButton.value == RequestConstant.APPROVAL? "Y":"N",
      subContractorWorkQtyDetS: getNmrBillDet(id,entryType.value),
      subContractorBillAddLessSetupS: getNmrBillDetAddLess(id, autoYearWiseNoController.text),

    ));
    final decodedJson = jsonDecode(body);

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(decodedJson);

    debugPrint(prettyJson, wrapWidth: 1024);


    final list = await BillGenerateBoqProvider.SaveSubContScreenEntryAPI(
        body, id,  context);

    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        if(saveButton.value == RequestConstant.VERIFY || saveButton.value == RequestConstant.APPROVAL){
          await pendingListController.getPendingList();
        }else{
          await DirectBill_EntryList();
        }
        clearDatas();
        BaseUtitiles.popMultiple(context, count: 5);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  List<SubContractorWorkQtyDet>? getNmrBillDet(id,workType) {
    getDetList.value.clear();
    ItemGetTableListdata.value.forEach((element) {
      var list = SubContractorWorkQtyDet(
        id: saveButton.value == RequestConstant.RESUBMIT?element.reqDetId:0,
        subContractorWorkQtyMasId:  id != 0 ? id : 0,
        headItemid: element.headItemid,
        subItemid: element.subItemid,
        level3ItemId: element.level3ItemId,
        // refWorkDetId: 0,
        flatNo: "0",
        actualQty: 0,
        actualAmount: 0,
        itemDes:element.Name.toString(),
        unit:element.unit.toString(),
        qty:element.appQty,
        rate:element.rate,
        amount:element.amount,
        balanceBillQty: element.balbillqty,
        currentBillQty: element.CurBillQty,
        // balanceQty: 0,
        partRateStatus: 0,
        qtysClosed: "0",
        totalQty: element.qty,
        workType: workType,
        dbrWorkDetId: 0,
        siteId: siteController.selectedsiteId.value,
        boqCode: "0",
      );
      getDetList.value.add(list);
    });
    return getDetList.value;
  }

  List<SubContractorBillAddLessSetup>? getNmrBillDetAddLess(int id,workNo) {
    getDetAddLessList.value.clear();
    directBillGen_ItemReadList.value.forEach((element) {
      if(element.percentValue!>0) {
        var list = SubContractorBillAddLessSetup(
          id: element.reqDetId,
          subContractorWorkQtyMasId: id,
          addLessId: element.addLessId,
          percentValue: element.percentValue,
          workNo: workNo,
          amount: element.amount,
        );
        getDetAddLessList.value.add(list);
      }});
    return getDetAddLessList.value;
  }


  void updateAdvanceReadOnly() {
    final amt = double.tryParse(tobededadv.text) ?? 0.0;
    isAdvanceReadOnly.value = amt <= 0;
  }

  Future<bool> deductionPaymentCalculation() async {
    await getItemlistTablesDatas();

    double advLimit = double.tryParse(tobededadv.text) ?? 0;
    double advDed = double.tryParse(Advded.text) ?? 0;

    if (advLimit < advDed) {
      BaseUtitiles.showToast(
          "Please change the adv deduction amount");
      return false;
    }

    if (ItemGetTableListdata.value.isEmpty) return false;

    double totalNetAmount = 0.0;

    for (var item in ItemGetTableListdata.value) {
      totalNetAmount += item.amount ?? 0;
    }

    billamount.text = totalNetAmount.toStringAsFixed(2);

    double bill = double.tryParse(billamount.text) ?? 0;
    double credit = double.tryParse(Creditamt.text) ?? 0;
    double debit = double.tryParse(Debitamt.text) ?? 0;
    double matDebit = double.tryParse(materialDebitamt.text) ?? 0;
    double adv = double.tryParse(Advded.text) ?? 0;
    String roundText = Roundoff.text.trim();

    double round =
    (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;
    // Recalculate all Add/Less, NetBill and NetPay
    recalculateAddLessAmounts(
      bill: bill,
      credit: credit,
      debit: debit,
      adv: adv,
      matDebit: matDebit,
      round: round,
    );

    // Optional validation
    if ((double.tryParse(netpayamt.text) ?? 0) < 0) {
      return false;
    }

    directBillGen_ItemReadList.refresh();

    await saveUpdatedCalcData();

    return true;
  }
  // ADD THIS
  bool calculateAndUpdate(
      int addLessId,
      double percent,
      ) {
    final item = directBillGen_ItemReadList.firstWhereOrNull(
          (e) => e.addLessId == addLessId,
    );

    if (item == null) return false;

    // Store old percentage
    final oldPercent = item.percentValue ?? 0.0;

    // Update percentage
    item.percentValue = percent;
    String roundText = Roundoff.text.trim();

    double round =
    (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;
    // Recalculate everything
    recalculateAddLessAmounts(
      bill: double.tryParse(billamount.text) ?? 0,
      credit: double.tryParse(Creditamt.text) ?? 0,
      debit: double.tryParse(Debitamt.text) ?? 0,
      adv: double.tryParse(Advded.text) ?? 0,
      matDebit: double.tryParse(materialDebitamt.text) ?? 0,
      round: round,
    );

    // Validate Net Pay
    final netPay = double.tryParse(netpayamt.text) ?? 0;

    if (netPay < 0) {
      BaseUtitiles.showToast(
        "Net Pay Amount cannot be negative.",
      );

      // Restore only percentage
      item.percentValue = oldPercent;

      // Recalculate again using restored percentage
      recalculateAddLessAmounts(
        bill: double.tryParse(billamount.text) ?? 0,
        credit: double.tryParse(Creditamt.text) ?? 0,
        debit: double.tryParse(Debitamt.text) ?? 0,
        adv: double.tryParse(Advded.text) ?? 0,
        matDebit: double.tryParse(materialDebitamt.text) ?? 0,
        round: round,
      );

      directBillGen_ItemReadList.refresh();
      update();

      return false;
    }

    directBillGen_ItemReadList.refresh();
    update();

    return true;
  }

  void recalculateAddLessAmounts({
    required double bill,
    required double credit,
    required double debit,
    required double adv,
    required double matDebit,
    required double round,
  }) {

    double baseNetBill = bill + credit - debit;

    for (var item in directBillGen_ItemReadList) {
      final name = (item.addLessName ?? "").trim().toUpperCase();
      final percent = item.percentValue ?? 0;

      switch (name) {
        case "SGST":
        case "CGST":
        case "IGST":
          double amt = baseNetBill * percent / 100;

          item.amount =
          item.addLessType == "-" ? -amt : amt;
          break;

        default:
          break;
      }
    }

    //----------------------------------
    // STEP 3
    // Read GST Amounts
    //----------------------------------

    double sgst = 0;
    double cgst = 0;
    double igst = 0;

    for (var item in directBillGen_ItemReadList) {
      switch ((item.addLessName ?? "").trim().toUpperCase()) {
        case "SGST":
          sgst = item.amount ?? 0;
          break;

        case "CGST":
          cgst = item.amount ?? 0;
          break;

        case "IGST":
          igst = item.amount ?? 0;
          break;
      }
    }

    //----------------------------------
    // STEP 4
    // Net Bill
    //----------------------------------

    double netBill = baseNetBill + sgst + cgst + igst;

    netBillAmt.text = netBill.toStringAsFixed(2);

    //----------------------------------
    // STEP 5
    // Final Bill
    //----------------------------------

    double finalBill = netBill - round;

    finalBillAmt.text = finalBill.toStringAsFixed(2);

    //----------------------------------
    // STEP 6
    // Calculate TDS / Retention / GST Hold
    // Base = Net Bill
    //----------------------------------

    for (var item in directBillGen_ItemReadList) {
      final name = (item.addLessName ?? "").trim().toUpperCase();
      final percent = item.percentValue ?? 0;

      switch (name) {
        case "RETENTION":
        case "TDS":
        case "GST HOLD":
          double amt = netBill * percent / 100;

          item.amount =
          item.addLessType == "-" ? -amt : amt;
          break;

        default:
          break;
      }
    }

    //----------------------------------
    // STEP 7
    // Read Deductions
    //----------------------------------

    double retention = 0;
    double tds = 0;
    double gstHold = 0;

    for (var item in directBillGen_ItemReadList) {
      switch ((item.addLessName ?? "").trim().toUpperCase()) {
        case "RETENTION":
          retention = item.amount ?? 0;
          break;

        case "TDS":
          tds = item.amount ?? 0;
          break;

        case "GST HOLD":
          gstHold = item.amount ?? 0;
          break;
      }
    }

    //----------------------------------
    // STEP 8
    // Net Pay
    //----------------------------------

    double netPay =
        finalBill +
            retention +
            tds +
            gstHold -
            adv -
            matDebit;

    //----------------------------------
    // Validation
    //----------------------------------

    if (netPay < 0) {
      BaseUtitiles.showToast("Net Pay Amount cannot be negative.");
    }

    //----------------------------------
    // Update UI
    //----------------------------------

    netBillAmt.text = netBill.toStringAsFixed(2);
    finalBillAmt.text = finalBill.toStringAsFixed(2);
    netpayamt.text = netPay.toStringAsFixed(2);

    directBillGen_ItemReadList.refresh();
    update();
  }

  void updateNetPay() {
    String roundText = Roundoff.text.trim();

    double round =
    (roundText.isEmpty || roundText == "-")
        ? 0
        : double.tryParse(roundText) ?? 0;
    recalculateAddLessAmounts(
      bill: double.tryParse(billamount.text) ?? 0,
      credit: double.tryParse(Creditamt.text) ?? 0,
      debit: double.tryParse(Debitamt.text) ?? 0,
      adv: double.tryParse(Advded.text) ?? 0,
      matDebit: double.tryParse(materialDebitamt.text) ?? 0,
      round: round,
    );

  }

// ADD THIS
  Future<void> saveUpdatedCalcData() async {
    await updateDirectBillCalDatas();
  }

// ADD THIS
  double getTotalAddLess() {

    double total = 0;

    for (final item in directBillGen_ItemReadList) {
      total += item.amount ?? 0;
    }

    return total;
  }

  Future<void> directBillCalculationSave() async {
    directBillTableModelList = [];

    for (final element in billDet_Calculation.value) {
      final directBillTable = DirectBillGSTCalTable();

      directBillTable.reqDetId = 0;
      directBillTable.addLessId = element.id;
      directBillTable.percentValue = element.percentage.value;
      directBillTable.amount = 0.0;
      directBillTable.addLessName = element.addLessName;
      directBillTable.addLessType = element.addLessType;

      directBillTableModelList.add(directBillTable);
    }

    await directBillGen_ItemlistService
        .DirectBillGST_ItemTable_Save(directBillTableModelList);
  }

  Future getDirectBillCalDatas() async {
    var datas = await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_readAll();
    directBillGen_ItemReadList.value = <DirectBillGSTCalTable>[];
    directBillGen_ItemReadList.clear();
    datas.forEach((value) {
      directBillTable = DirectBillGSTCalTable();
      directBillTable.reqDetId=value['reqDetId'];
      directBillTable.addLessId=value['addLessId'];
      directBillTable.percentValue=value['percentValue'];
      directBillTable.amount=value['amount'];
      directBillTable.addLessName=value['addLessName'];
      directBillTable.addLessType=value['addLessType'];
      directBillGen_ItemReadList.add(directBillTable);
    });
    initPercentControllers();
  }


  updateDirectBillCalDatas() async {
    int i=0;
    updateBillGen_ItemReadList.clear();
    directBillGen_ItemReadList.forEach((element) {
      directBillTable = DirectBillGSTCalTable();
      directBillTable.reqDetId=element.reqDetId;
      directBillTable.addLessId=element.addLessId;
      directBillTable.percentValue=element.percentValue;
      directBillTable.amount=element.amount;
      directBillTable.addLessName=element.addLessName;
      directBillTable.addLessType=element.addLessType;
      updateBillGen_ItemReadList.add(directBillTable);
      i++;
    });
    await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_Update(updateBillGen_ItemReadList);
  }

  DirectBillCal_itemlistTable_Delete() async {
    await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_delete();
  }

  Future<void> preloadEditAddLessData(List<dynamic> editAddLessList) async {

    // First load local DB rows
    await getDirectBillCalDatas();

    // Update local rows with edit API values
    for (var editItem in editAddLessList) {

      int index = directBillGen_ItemReadList.indexWhere(
            (e) => e.addLessId == editItem.addLessId,
      );

      if (index != -1) {

        directBillGen_ItemReadList[index].reqDetId =
            editItem.id;

        directBillGen_ItemReadList[index].percentValue =
            (editItem.percentValue ?? 0).toDouble();

        directBillGen_ItemReadList[index].amount =
            (editItem.amount ?? 0).toDouble();

        // Update controller text also
        percentControllers[index].text =
        (editItem.percentValue ?? 0) == 0
            ? ''
            : editItem.percentValue.toString();
      }
    }

    // Refresh UI
    directBillGen_ItemReadList.refresh();

    // Recalculate total/netpay
    updateNetPay();
  }

  void initPercentControllers() {
    percentControllers.clear();
    for (var item in directBillGen_ItemReadList) {
      percentControllers.add(
        TextEditingController(
          text: (item.percentValue ?? 0.0) == 0.0
              ? ''
              : item.percentValue.toString(),
        ),
      );
    }
  }

  Future directBillEntryList_EditApi(int workid, String MenuName,BuildContext context,Url,status) async {
    bill_editListApiDatas.value=[];
    await ClickUtils.run(() async {
    final value = await BillGenerateBoqProvider.directBill_entryList_editAPI(workid,status);
    if (value != null) {
      if(value.success==true){
        bill_editListApiDatas.value = [value.result];
        if(bill_editListApiDatas.isNotEmpty){
          if(Url=="Verify") {
            saveButton.value = RequestConstant.VERIFY;
          }
          else if(Url=="Approve"){
            saveButton.value = RequestConstant.APPROVAL;
          }
          else{
            saveButton.value = RequestConstant.RESUBMIT;
          }
          await billgen_EditTable_SaveTable("");
          await getItemlistTablesDatas();
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Bill_Generation_Boq_EntryScreen(heading: MenuName,)),
          );

        }
        else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
    });
  }



  Future<bool> EntryList_DeleteApi(int WorkId,status) async {
    return BillGenerateBoqProvider.entryList_deleteAPI(WorkId,status);
  }




  billgen_EditTable_SaveTable(name) async {
    ItemListTableModelList.clear();
    bill_editListApiDatas.value.asMap().forEach((index, element) {
      if(name == "ItemListDet") {
        double appQty;
        if (index < itemlist_ListAppQtyController.length && itemlist_ListAppQtyController[index].text.isNotEmpty) {
          appQty = double.tryParse(itemlist_ListAppQtyController[index].text) ?? (element.totalqty ?? 0.0);
        } else {
          appQty = element.totalqty ?? 0.0;
        }
        double rate = element.rate ?? 0.0;
        ItemListTableModel = new BillGenBoqItemListTableModel();
        ItemListTableModel.reqDetId = 0;
        ItemListTableModel.Name = element.itemDesc.toString();
        ItemListTableModel.unit = element.unit.toString();
        ItemListTableModel.qty = element.totalqty;
        ItemListTableModel.rate = rate;
        ItemListTableModel.balbillqty = element.balbillqty;
        ItemListTableModel.CurBillQty = element.CurBillQty;
        ItemListTableModel.level3ItemId = element.level3ItemId;
        ItemListTableModel.headItemid = element.headItemid;
        ItemListTableModel.subItemid = element.subItemid;
        ItemListTableModel.appQty = appQty;
        ItemListTableModel.amount = appQty * rate;
        ItemListTableModelList.add(ItemListTableModel);
      }
      else {
        element.subContractorWorkQtyDetS!.forEach((value) {
          ItemListTableModel = new BillGenBoqItemListTableModel();
          ItemListTableModel.reqDetId = value.reqDetId;
          ItemListTableModel.Name = value.itemDesc.toString();
          ItemListTableModel.unit = value.unit.toString();
          ItemListTableModel.qty = value.totalqty;
          ItemListTableModel.rate = value.rate;
          ItemListTableModel.appQty = value.qty;
          ItemListTableModel.amount = value.amount;
          ItemListTableModel.balbillqty = value.balbillqty;
          ItemListTableModel.CurBillQty = value.CurBillQty;
          ItemListTableModel.level3ItemId = value.level3ItemId;
          ItemListTableModel.headItemid = value.headItemid;
          ItemListTableModel.subItemid = value.subItemid;
          ItemListTableModelList.add(ItemListTableModel);
        });
      } });

    var savedatas = await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_Save(ItemListTableModelList);
    return savedatas;
  }


  Future DeleteAlert(BuildContext context,int index,status) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          bool result = await EntryList_DeleteApi(bill_entryList[index].id,status);
                          if (result) {
                            bill_entryList.removeAt(index);
                            Navigator.of(context).pop();
                          }
                          else{
                            Navigator.of(context).pop();
                          }},
                        child: Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
