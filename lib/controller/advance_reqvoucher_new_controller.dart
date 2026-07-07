import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:prahkurticore/controller/pendinglistcontroller.dart';

import '../controller/commonvoucher_controller.dart';
import '../controller/logincontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../db_model/advReqVoc_SitewisePayTable_model.dart';
import '../db_model/advReqvoucher_itemlistTable_model.dart';
import '../db_services/advReqVouc_SitewisePaylist_service.dart';
import '../db_services/advReqvoucher_itemlist_service.dart';
import '../home/menu/daily_entries/advance_requs_voucher/advance_req_entry.dart';
import '../home/menu/daily_entries/advance_requs_voucher/advance_req_entrylist.dart';
import '../home/menu/daily_entries/advance_requs_voucher/advancereq_voucher.dart';
import '../home/menu/daily_entries/advancereques_voucher_new/advance_req_entry_new.dart';
import '../home/menu/daily_entries/advancereques_voucher_new/advance_req_entrylist_new.dart';
import '../models/AdvanceReqDeleteModel.dart';
import '../models/advancereqvouche_saveapi_reqmodel.dart';
import '../models/pendingpo_aprovalapi_resmodel.dart';
import '../provider/advancereqvoucher_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvanceReqVoucherController_new extends GetxController {
  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
  SiteController siteController = Get.put(SiteController());
  final autoYearWiseNoController = TextEditingController();
  final entryDateController = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());

  final itemlistDetAmount = TextEditingController();
  final itemlistTds_Percent = TextEditingController();
  final itemlistTdsamount = TextEditingController();
  final itemlistNetAmount = TextEditingController();
  final remarksController = TextEditingController();
  final entry_amount = TextEditingController();

  final entrlistFdateController = TextEditingController();
  final entrlistTdateController = TextEditingController();

  List<TextEditingController> Itemlist_siteName_ListController = [];
  List<TextEditingController> Itemlist_paymentType_ListController = [];
  List<TextEditingController> Itemlist_amount_ListControllers = [];
  List<TextEditingController> Itemlist_netAmount_ListController = [];

  RxList<AccountAdvanceReqVoucherSwPayment> getDetList_NMR = <AccountAdvanceReqVoucherSwPayment>[].obs;
  RxList<AccountAdvanceReqVoucherSwPayment> getDetList_Advance = <AccountAdvanceReqVoucherSwPayment>[].obs;
  RxList entryList = [].obs;
  RxList mainlist = [].obs;
  RxList editListApiDatas = [].obs;
  int vocId = 0;

  RxString saveButton = RequestConstant.SUBMIT.obs;
  RxString listButton = "List".obs;

  late List<AdvReqVoucherItemListTableModel> ItemListTableModelList = <AdvReqVoucherItemListTableModel>[];
  var ItemListTableModel = new AdvReqVoucherItemListTableModel();
  var advreqVoucher_ItemlistService = AdvreqVoucher_ItemlistService();
  List ItemListTableModelReadList = <AdvReqVoucherItemListTableModel>[];
  late List<AdvReqVoucherItemListTableModel> itemListUpdateModelList = <AdvReqVoucherItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  List<AdvReqVoucherItemListTableModel> deleteTableModelList = <AdvReqVoucherItemListTableModel>[];
  PendingListController pendingListController = Get.put(PendingListController());


  calculation(double? amt, double? tds) {
    itemlistTdsamount.text = (amt! * tds! / 100).toString();
    itemlistNetAmount.text = (amt - double.parse(itemlistTdsamount.text)).toString();
  }

  Future getEntryList() async {
    entryList.value.clear();
    final value = await AdvanceReqVoucherProvider.getEntry_List(entrlistFdateController.text,
        entrlistTdateController.text);
    if (value != null) {
      if(value.success==true){
        if(value.result!.isNotEmpty){
          entryList.value = value.result!;
          mainlist.value = value.result!;
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


  itemlistTable_Delete() async {
    await advreqVoucher_ItemlistService.AdvreqVoucher_ItemlistTable_delete();
  }

  itemlistPopup_saveLabTableDatas(BuildContext context) async {
    int j = 0;
    ItemListTableModelList=[];
    if(itemlistNetAmount.text == "0.0" || itemlistNetAmount.text == "0.00" || itemlistNetAmount.text == "0") {
    } else {
      ItemListTableModel =  AdvReqVoucherItemListTableModel();
      ItemListTableModel.reqDetId = 0;
      ItemListTableModel.siteId = siteController.selectedsiteId.value;
      ItemListTableModel.siteName = siteController.Sitename.text;
      ItemListTableModel.paymentType = commonVoucherController.detVocType;
      ItemListTableModel.amount = double.tryParse(itemlistDetAmount.value.text) ?? 0.0;
      ItemListTableModel.tds_percent = double.tryParse(itemlistTds_Percent.value.text)?? 0.0;
      ItemListTableModel.tds_amount = double.tryParse(itemlistTdsamount.value.text)?? 0.0;
      ItemListTableModel.netAmount = double.tryParse(itemlistNetAmount.value.text)?? 0.0;
      ItemGetTableListdata.value.forEach((element) {
        if (element.siteId == ItemListTableModel.siteId) {
          j = 1;
          BaseUtitiles.showToast("Site already exist");
        }
      });
      if (j == 0) {
        ItemListTableModelList.add(ItemListTableModel);
      } else {
        j = 0;
      }
    }
    var savedatas =
    await advreqVoucher_ItemlistService.AdvreqVoucher_ItemlistTable_Save(
        ItemListTableModelList);
    return Navigator.pop(context, savedatas);
  }

  Future getItemlistTablesDatas() async {
    ItemGetTableListdata.value=[];
    var datas = await advreqVoucher_ItemlistService.AdvreqVoucher_ItemlistTable_readAll();

    datas.forEach((value) {
      var ItemListTableModel =  AdvReqVoucherItemListTableModel();
      ItemListTableModel.id = value['id'];
      ItemListTableModel.reqDetId = value['reqDetId'];
      ItemListTableModel.siteId = value['siteId'];
      ItemListTableModel.siteName = value['siteName'];
      ItemListTableModel.paymentType = value['paymentType'];
      ItemListTableModel.amount = value['amount'];
      ItemListTableModel.tds_percent = value['tds_percent'];
      ItemListTableModel.tds_amount = value['tds_amount'];
      ItemListTableModel.netAmount = value['netAmount'];
      ItemGetTableListdata.add(ItemListTableModel);
    });
  }

  itemlist_textControllersInitiate() {
    Itemlist_siteName_ListController.add(new TextEditingController());
    Itemlist_paymentType_ListController.add(new TextEditingController());
    Itemlist_amount_ListControllers.add(new TextEditingController());
    Itemlist_netAmount_ListController.add(new TextEditingController());
  }

  Future deleteParticularList(AdvReqVoucherItemListTableModel data) async {
    deleteTableModelList.clear();
    ItemListTableModel = new AdvReqVoucherItemListTableModel();
    ItemListTableModel.siteId = data.siteId;
    deleteTableModelList.add(ItemListTableModel);
    await advreqVoucher_ItemlistService.AdvreqVoucher_ItemlistTable_deleteById(deleteTableModelList);
  }

  //------------AdvReqVoucher SitewisePayment Local DB----------------------
  // final AmountController = TextEditingController();
  List<TextEditingController> amount_ListControllers = [];

  late List<AdvReqVoucher_SiteWisePayment_TableModel> DBTableModelList = <AdvReqVoucher_SiteWisePayment_TableModel>[];
  late List<AdvReqVoucher_SiteWisePayment_TableModel> delete_DBTableModelList = <AdvReqVoucher_SiteWisePayment_TableModel>[];
  late List<AdvReqVoucher_SiteWisePayment_TableModel> update_DBTableModelList = <AdvReqVoucher_SiteWisePayment_TableModel>[];

  List DBTableModel_ReadList = <AdvReqVoucher_SiteWisePayment_TableModel>[];
  RxList GetTableList = [].obs;
  var advReqVou_sitewisePayService = AdvReqVoucher_SiteWisePayment_Service();
  var advreqvouModel = new AdvReqVoucher_SiteWisePayment_TableModel();

  RxList AdvanceList = [].obs;

  // -----------Get AdvReqVoucher SitewisePAyment List---------------

  Future getAdvList() async {
    GetTableList.value=[];
    AdvanceList.value=[];
    final value = await AdvanceReqVoucherProvider.getAdvTypeList(commonVoucherController.payfor.value, commonVoucherController.selectedAccTypeId.value, commonVoucherController.selectedAccnameId.value, projectController.selectedProjectId.value);
    if (value != null) {
      if(value.success==true){
        if(value.result!.isNotEmpty){
          AdvanceList.value = value.result!;
          await saveListTable();
          await getTableListDatas();
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

  delete_ListTable() async {
    await advReqVou_sitewisePayService.AdvreqVoucher_SiteWisePaymentTable_delete();
  }

  saveListTable() async {
    DBTableModelList.clear();
    AdvanceList.forEach((element) {
      advreqvouModel = new AdvReqVoucher_SiteWisePayment_TableModel();
      advreqvouModel.reqDetId = 0;
      advreqvouModel.purOrdMasId = element.purOrdMasId;
      advreqvouModel.orderNo = element.poNo;
      advreqvouModel.project = element.projectName;
      advreqvouModel.projectId = element.projectId;
      advreqvouModel.siteName = element.siteName;
      advreqvouModel.siteId = element.siteId;
      advreqvouModel.dprAmt = element.netamt;
      advreqvouModel.advanceAmt = element.advanceAmt;
      advreqvouModel.bAmount = element.balanceAmount;
      advreqvouModel.amount = double.parse("0");
      DBTableModelList.add(advreqvouModel);
    });

    var saveDataValue = await advReqVou_sitewisePayService.AdvreqVoucher_SiteWisePaymentTable_Save(DBTableModelList);
    return saveDataValue;
  }

  Future getTableListDatas() async {
    var datas = await advReqVou_sitewisePayService.AdvreqVoucher_SiteWisePaymentTable_readAll();
    DBTableModel_ReadList = <AdvReqVoucher_SiteWisePayment_TableModel>[];
    DBTableModel_ReadList.clear();
    GetTableList.value=[];
    datas.forEach((value) {
      advreqvouModel = new AdvReqVoucher_SiteWisePayment_TableModel();
      TableList_textControllersInitiate();
      advreqvouModel.reqDetId = value['reqDetId'];
      advreqvouModel.purOrdMasId = value['PurOrdMasId'];
      advreqvouModel.orderNo = value['OrderNo'];
      advreqvouModel.project = value['Project'];
      advreqvouModel.projectId = value['ProjectId'];
      advreqvouModel.siteName = value['SiteName'];
      advreqvouModel.siteId = value['SiteId'];
      advreqvouModel.dprAmt = value['DPRAmt'];
      advreqvouModel.advanceAmt = value['AdvanceAmt'];
      advreqvouModel.bAmount = value['BAmount'];
      advreqvouModel.amount = value['Amount'];
      DBTableModel_ReadList.add(advreqvouModel);
      GetTableList.value = DBTableModel_ReadList;
    });
    setTextControllersValue();
  }

  //Set Value
  setTextControllersValue() async {
    for (var index = 0; index < GetTableList.value.length; index++) {
      TableList_textControllersInitiate();
      amount_ListControllers[index].text = GetTableList.value[index].amount.toString();
    }
  }
  TableList_textControllersInitiate() {
    amount_ListControllers.add(new TextEditingController());
  }


  //qty Update to db
  updateConsumTables() async {
    int i = 0;
    update_DBTableModelList.clear();
    GetTableList.forEach((element) {
      advreqvouModel = new AdvReqVoucher_SiteWisePayment_TableModel();
      advreqvouModel.reqDetId = element.reqDetId;
      advreqvouModel.purOrdMasId = element.purOrdMasId;
      advreqvouModel.orderNo = element.orderNo;
      advreqvouModel.project = element.project;
      advreqvouModel.projectId = element.projectId;
      advreqvouModel.siteName = element.siteName;
      advreqvouModel.siteId = element.siteId;
      advreqvouModel.dprAmt = element.dprAmt;
      advreqvouModel.advanceAmt = element.advanceAmt;
      advreqvouModel.bAmount = element.bAmount;
      advreqvouModel.amount = double.parse(amount_ListControllers[i].value.text);
      update_DBTableModelList.add(advreqvouModel);
      i++;
    });
    await advReqVou_sitewisePayService.AdvreqVoucher_SiteWisePaymentTable_Update(update_DBTableModelList);
  }

  //-----------Particular delete--------------
  Future deleteParticularTableList(AdvReqVoucher_SiteWisePayment_TableModel data) async {
    delete_DBTableModelList.clear();
    advreqvouModel = new AdvReqVoucher_SiteWisePayment_TableModel();
    advreqvouModel.orderNo = data.orderNo;
    delete_DBTableModelList.add(advreqvouModel);
    await advReqVou_sitewisePayService.AdvreqVoucher_SiteWisePaymentTable_deleteById(delete_DBTableModelList);
  }



  Future SaveApi_ItemlistScreen(BuildContext context, int id) async {
    await Future.delayed(const Duration(seconds: 0));
    String body = advanceReqvoucherSaveApiReqToJson(AdvanceReqvoucherSaveApiReq(
      id: id,
      advanceReqVoucherNo: autoYearWiseNoController.text,
      advanceReqVoucherDate: entryDateController.text,
      advanceReqVoucherType: commonVoucherController.VocType.value,
      projectId: projectController.selectedProjectId.value,
      companyId: 0,
      accountTypeId: commonVoucherController.selectedAccTypeId.value,
      accountNameId: commonVoucherController.selectedAccnameId.value,
      payForType: commonVoucherController.payfor.value,
      payModeId: 1,
      paymentType: commonVoucherController.payfor.value=="SU" ? "DP" : "SP",
      advanceReqVoucherAmount: double.tryParse(entry_amount.text),
      paidBy: 0,
      remarks: remarksController.text,
      companyBankId: 0,
      chequeNo: "0",
      chequeDate: entryDateController.text,
      nameThrough: commonVoucherController.payfor.value=="SU" ?"-":commonVoucherController.Accountname.text,
      actualVoucherAmount: double.tryParse(entry_amount.text),
      createdBy: int.tryParse(loginController.EmpId()),
      createdDt: BaseUtitiles().convertToUtcIso(entryDateController.text),
      verifyStatus: saveButton.value == RequestConstant.APPROVAL?"Y":"N",
      approveStatus: saveButton.value == RequestConstant.APPROVAL?"Y":"N",
      accountAdvanceReqVoucherSwPayments : commonVoucherController.VocType.value == "A" && commonVoucherController.payfor.value == "A"
            ? getDetPayforAdvDetails(id)
            : commonVoucherController.VocType.value == "A" && commonVoucherController.payfor.value == "AD"
            ? getDetDetails(id)
            : []
    ));

    final decodedJson = jsonDecode(body);

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(decodedJson);

    debugPrint(prettyJson, wrapWidth: 1024);
    final list = await AdvanceReqVoucherProvider.SaveApi(body, id ,saveButton.value);
    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        if(saveButton.value == RequestConstant.APPROVAL){
          await pendingListController.getPendingList();
        }else {
          await getEntryList();
        }
        BaseUtitiles.popMultiple(context, count: 3);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }


   ///--------Pay For Advance----------
  List<AccountAdvanceReqVoucherSwPayment>? getDetPayforAdvDetails(masId) {
    getDetList_Advance.value=[];
    for (var element in GetTableList) {
      if(element.amount > 0.0){
        var list = AccountAdvanceReqVoucherSwPayment(
           id: saveButton.value == RequestConstant.RESUBMIT || saveButton.value == RequestConstant.APPROVAL? element.reqDetId : 0,
           advanceReqVoucherId: saveButton.value == RequestConstant.RESUBMIT || saveButton.value == RequestConstant.APPROVAL? masId :  0,
            payType: commonVoucherController.payfor.value,
            siteId: element.siteId,
            purOrdmasId: commonVoucherController.selectedAccTypeId.value==4 ? element.purOrdMasId : 0,
            purOrdBillmasId: 0,
            workOrderId: commonVoucherController.selectedAccTypeId.value==4 ? 0 : element.purOrdMasId,
            workId: 0,
            tdsPercentage: 0,
            tdsAmount: 0,
            amount: element.amount,
            netAmount: element.amount,
            actualNetAmount: element.amount,
        );
        getDetList_Advance.add(list);
      }
    }
    return getDetList_Advance.value;
  }

  ///--------------pay for NMR---------------
  List<AccountAdvanceReqVoucherSwPayment>? getDetDetails(masId) {
    getDetList_NMR.value=[];
    for (var element in ItemGetTableListdata) {
      if(element.amount > 0.0){
        var list = AccountAdvanceReqVoucherSwPayment(
          id: saveButton.value == RequestConstant.RESUBMIT || saveButton.value == RequestConstant.APPROVAL? element.reqDetId : 0,
          advanceReqVoucherId: saveButton.value == RequestConstant.RESUBMIT || saveButton.value == RequestConstant.APPROVAL? masId :  0,
          payType: element.paymentType,
          siteId: element.siteId,
          purOrdmasId: 0,
          purOrdBillmasId: 0,
          workOrderId: 0,
          workId: 0,
          tdsPercentage: 0,
          tdsAmount: 0,
          amount: element.amount,
          netAmount: element.amount,
          actualNetAmount: element.amount,
        );
        getDetList_NMR.add(list);
      }
    }
    return getDetList_NMR.value;
  }


  Future<bool> EntryList_DeleteApi(int vocId) async {
    return AdvanceReqVoucherProvider.entryList_deleteAPI(vocId);
  }


  Future EntryList_EditApi(type,vocId,status,String MenuName, context) async {
    editListApiDatas.value=[];
    final value = await AdvanceReqVoucherProvider.entryList_editAPI(vocId, status);
    if (value != null) {
      if(value.success==true){
        editListApiDatas.value = [value.result];
        saveButton.value = type == "edit"? RequestConstant.RESUBMIT : RequestConstant.APPROVAL;
        if(editListApiDatas.isNotEmpty){
          for (var element in editListApiDatas.value) {
            if (element.payForType == "A") {
              await EditAdvTable_SaveTable();
              await getTableListDatas();
            } else if (element.payForType == "AD") {
              await EditTable_SaveTable();
              await getItemlistTablesDatas();
            }
          }
          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdvReq_voucher_New(heading: MenuName,)),
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
  }

  ///-------ADVANCE-------------------
  EditTable_SaveTable() async {
    ItemListTableModelList.clear();
    editListApiDatas.value.forEach((element) {
      element.accountAdvanceReqVoucherSwPayments.forEach((value) {
        ItemListTableModel = AdvReqVoucherItemListTableModel();
        ItemListTableModel.reqDetId = value.id;
        ItemListTableModel.siteId = value.siteId;
        ItemListTableModel.siteName = value.siteName;
        ItemListTableModel.paymentType = value.payType;
        ItemListTableModel.amount = value.amount;
        ItemListTableModel.tds_percent = value.tdsPercentage;
        ItemListTableModel.tds_amount = value.tdsAmount;
        ItemListTableModel.netAmount = value.netAmount;
        ItemListTableModelList.add(ItemListTableModel);
      });
    });
    var savedatas =
    await advreqVoucher_ItemlistService.AdvreqVoucher_ItemlistTable_Save(ItemListTableModelList);
    return savedatas;
  }
  ///------Advance----
  EditAdvTable_SaveTable() async {
    DBTableModelList.clear();
    editListApiDatas.value.forEach((element) {
      final details = element.payForType == "A" &&
          element.accountTypeId == 5
          ? element.subContractorAdvanceDetails
          : element.supplierAdvanceDetails;

      details?.forEach((value) {
        advreqvouModel = AdvReqVoucher_SiteWisePayment_TableModel();

        advreqvouModel.reqDetId = value.swPayId;
        advreqvouModel.purOrdMasId = value.purOrdMasId;
        advreqvouModel.orderNo = value.poNo;
        advreqvouModel.project = value.projectName;
        advreqvouModel.projectId = value.projectId;
        advreqvouModel.siteName = value.siteName;
        advreqvouModel.siteId = value.siteId;
        advreqvouModel.paymentType = value.payType;
        advreqvouModel.dprAmt = value.netAmt;
        advreqvouModel.advanceAmt = value.advanceAmt;
        advreqvouModel.bAmount = value.bAmount;
        advreqvouModel.amount = value.amount;

        DBTableModelList.add(advreqvouModel);
      });
    });
    var savedatas =
    await advReqVou_sitewisePayService.AdvreqVoucher_SiteWisePaymentTable_Save(DBTableModelList);
    return savedatas;
  }


  AmtItemlist_clickEdit() {
    for (var index = 0; index < GetTableList.value.length; index++) {
      double balAmt = double.parse(GetTableList.value[index].bAmount.toString());
      double enteredAmt = 0;
      if(GetTableList.value[index].bAmount.toString() == ""){
        enteredAmt = 0;
      }
      else{
        enteredAmt = double.parse(amount_ListControllers[index].value.text);
      }
      if (balAmt < enteredAmt) {
        // Display a message and clear the text if balQty is less than enteredQty
        BaseUtitiles.showToast("More than Bal Amt, Not Allowed");
        enteredAmt = 0;
        amount_ListControllers[index].text = "0";
      }
      else {
        // If none of the above conditions are met, call updateConsumTables()
        updateConsumTables();
      }
    }
  }

  netamountCalculation() {
    entry_amount.text = "0.0";
    if (ItemGetTableListdata.value.isNotEmpty) {
      ItemGetTableListdata.value.forEach((element) {
        entry_amount.text = (double.parse(entry_amount.text) + element.netAmount).toString();
      });
    }else if(GetTableList.value.isNotEmpty){
      int i=0;
      GetTableList.value.forEach((element){
        entry_amount.text = (double.parse(entry_amount.text) + double.parse(amount_ListControllers[i].value.text)).toString();
        i++;
      });
    }
    else {
      entry_amount.text = "0.0";
    }
  }

  void reduceAmount(double amount) {
    final current = double.tryParse(entry_amount.text) ?? 0.0;
    entry_amount.text = (current - amount).toString();
  }

  Future DeleteAlert(BuildContext context,int index) async {
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
                          bool result = await EntryList_DeleteApi(entryList[index].id);
                          if (result) {
                            entryList.removeAt(index);
                            Navigator.of(context).pop();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
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
