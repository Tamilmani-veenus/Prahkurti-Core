import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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

  RxList<VocDet> getDetList_NMR = <VocDet>[].obs;
  RxList<VocDet> getDetList_Advance = <VocDet>[].obs;
  RxList entryList = [].obs;
  RxList mainlist = [].obs;
  RxList editListApiDatas = [].obs;
  RxString radioType = "".obs;
  int vocId = 0;
  int checkColor = 0;
  int buttonControl = 0;

  RxString saveButton = RequestConstant.SUBMIT.obs;
  RxString listButton = "List".obs;

  late List<AdvReqVoucherItemListTableModel> ItemListTableModelList = <AdvReqVoucherItemListTableModel>[];
  var ItemListTableModel = new AdvReqVoucherItemListTableModel();
  var advreqVoucher_ItemlistService = AdvreqVoucher_ItemlistService();
  List ItemListTableModelReadList = <AdvReqVoucherItemListTableModel>[];
  late List<AdvReqVoucherItemListTableModel> itemListUpdateModelList = <AdvReqVoucherItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  List<AdvReqVoucherItemListTableModel> deleteTableModelList = <AdvReqVoucherItemListTableModel>[];
  int entrycheck = 0;
  int editcheck = 0;

  calculation(double? amt, double? tds) {
    itemlistTdsamount.text = (amt! * tds! / 100).toString();
    itemlistNetAmount.text = (amt - double.parse(itemlistTdsamount.text)).toString();
  }

  Future getEntryList() async {
    mainlist.value.clear();
    entryList.value.clear();
    await AdvanceReqVoucherProvider.getEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        entrlistFdateController.text,
        entrlistTdateController.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        mainlist.value = value;
        entryList.value = mainlist.value;
        return mainlist.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  itemlistTable_Delete() async {
    await advreqVoucher_ItemlistService.AdvreqVoucher_ItemlistTable_delete();
  }

  itemlistPopup_saveLabTableDatas(BuildContext context) async {
    int j = 0;
    int amt = 0;
    int netAmount = 0;
    ItemListTableModelList.clear();
    if(itemlistNetAmount.text == "0.0" || itemlistNetAmount.text == "0.00" || itemlistNetAmount.text == "0") {
    } else {
      ItemListTableModel =  AdvReqVoucherItemListTableModel();
      ItemListTableModel.siteId = siteController.selectedsiteId.value;
      ItemListTableModel.siteName = siteController.Sitename.text;
      ItemListTableModel.paymentType = commonVoucherController.detVocType;
      ItemListTableModel.amount = double.parse(itemlistDetAmount.value.text);
      ItemListTableModel.tds_percent =
          double.parse(itemlistTds_Percent.value.text);
      ItemListTableModel.tds_amount = double.parse(itemlistTdsamount.value.text);
      ItemListTableModel.netAmount = double.parse(itemlistNetAmount.value.text);
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
    await AdvanceReqVoucherProvider.getAdvTypeList(
        commonVoucherController.payfor.value,
        commonVoucherController.selectedAccTypeId.value,
        commonVoucherController.selectedAccnameId.value,
        projectController.selectedProjectId.value)
        .then((value) async {
      if (value != null && value.length > 0) {
        AdvanceList.value = value;
        return AdvanceList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  delete_ListTable() async {
    await advReqVou_sitewisePayService.AdvreqVoucher_SiteWisePaymentTable_delete();
  }

  saveListTable() async {
    DBTableModelList.clear();
    AdvanceList.forEach((element) {
      advreqvouModel = new AdvReqVoucher_SiteWisePayment_TableModel();
      advreqvouModel.purOrdMasId = element.purOrdMasId;
      advreqvouModel.orderNo = element.orderNo;
      advreqvouModel.project = element.project;
      advreqvouModel.projectId = element.projectid;
      advreqvouModel.siteName = element.siteName;
      advreqvouModel.siteId = element.siteid;
      advreqvouModel.dprAmt = element.netamt;
      advreqvouModel.advanceAmt = element.advanceAmt;
      advreqvouModel.bAmount = element.bAmount;
      advreqvouModel.amount = element.amount;
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
    GetTableList.value.clear();
    datas.forEach((value) {
      advreqvouModel = new AdvReqVoucher_SiteWisePayment_TableModel();
      TableList_textControllersInitiate();
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
    buttonControl=1;
    getDetList_NMR.value.clear();
    getDetList_Advance.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = advanceReqvoucherSaveApiReqToJson(AdvanceReqvoucherSaveApiReq(
        vocId: id != 0 ? id.toString() : "0",
        vocNo: autoYearWiseNoController.text,
        vocDate: entryDateController.text,
        vocType: commonVoucherController.VocType.value,
        projectId: projectController.selectedProjectId.value.toString(),
        accTypeId: commonVoucherController.selectedAccTypeId.value.toString(),
        accNameId: commonVoucherController.selectedAccnameId.value.toString(),
        payFor: commonVoucherController.payfor.value.toString(),
        // payMode: commonVoucherController.selectedPaymodeId.value.toString(),
        payMode: "1",
        payType: commonVoucherController.payfor.value=="SU" ? "DP" : "SP",
        vocAmt: entry_amount.text,
        // vocAmt: itemlistNetAmount.text,
        companyId: "0",
        bankId: "0",
        chqNo: "0",
        chqDate:  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        nameThrough: commonVoucherController.payfor.value=="SU" ?"-":commonVoucherController.Accountname.text,
        remarks: remarksController.text,
        preparedby: loginController.EmpId(),
        userId: loginController.UserId(),
        deviceName: BaseUtitiles.deviceName,
        entryMode: saveButton.value == "Submit"
            ? "ADD"
            : saveButton.value == "Re-Submit"
            ? "UPDATE"
            : saveButton.value == "Verify"
            ? "VERIFY"
            : saveButton.value == "Approve"
            ? "APPROVE"
            : "",
        vocDet : commonVoucherController.VocType.value == "A" && commonVoucherController.selectedAccTypeId.value==4
            ? (getDetList_Advance.value.isEmpty
            ? getDetPayforAdvDetails()
            : getDetList_Advance.value):commonVoucherController.VocType.value == "A" && commonVoucherController.selectedAccTypeId.value==5
            ? (getDetList_NMR.value.isEmpty
            ? getDetDetails()
            : getDetList_NMR.value): []
    ));
    final list = await AdvanceReqVoucherProvider.SaveApi(body, id, buttonControl ,context);
    if (list != null && id != 0) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new AdvReq_Voucher_EntryList_new()));
      buttonControl=0;
      editcheck=0;
      BaseUtitiles.showToast(list);
      getEntryList();
      return Navigator.pop(context);
    }
    else {
      if (list == RequestConstant.DUPLICATE_OCCURED) {
        Navigator.pop(context);
        Navigator.pop(context);
        buttonControl=0;
        return BaseUtitiles.showToast(list!);
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                new AdvReq_Voucher_EntryList_new()));
        buttonControl=0;
        editcheck=0;
        BaseUtitiles.showToast(list!);
        getEntryList();
        return Navigator.pop(context);
      }
    }
  }



  ///--------------pay for NMR---------------
  List<VocDet>? getDetDetails() {
    for (int index = 0; index < ItemGetTableListdata.length; index++) {
      var list = VocDet(
        purOrdMasId: "0",
        workOrdId: "0",
        siteId: ItemGetTableListdata[index].siteId.toString(),
        payType: ItemGetTableListdata[index].paymentType.toString(),
        amt: ItemGetTableListdata[index].amount.toString(),
        tdsPer: ItemGetTableListdata[index].tds_percent.toString(),
        tdsAmt: ItemGetTableListdata[index].tds_amount.toString(),
        netAmt: ItemGetTableListdata[index].netAmount.toString(),
      );
      getDetList_NMR.add(list);
    }
    return getDetList_NMR.value;
  }

  // ///--------Pay For Advance----------
  List<VocDet>? getDetPayforAdvDetails() {
    for (int index = 0; index < GetTableList.length; index++) {
      if(GetTableList[index].amount > 0.0){
        var list = VocDet(
            purOrdMasId: commonVoucherController.selectedAccTypeId.value == 4 ? GetTableList[index].purOrdMasId.toString() : "0",  //----(4 means SUPPLIER)
            workOrdId: commonVoucherController.selectedAccTypeId.value == 5 ? GetTableList[index].purOrdMasId.toString() : "0", //----(5 means SUBCONTRACTOR)
            payType: commonVoucherController.payfor.value.toString(),
            siteId: GetTableList[index].siteId.toString(),
            amt: amount_ListControllers[index].text,
            netAmt: amount_ListControllers[index].text,
            tdsAmt: "0",
            tdsPer: "0"

        );
        getDetList_Advance.add(list);
      }
    }
    return getDetList_Advance.value;
  }

  // Future EntryList_DeleteApi(int InwId, String InwNo) async {
  //   await AdvanceReqVoucherProvider.entryList_deleteAPI(InwId, InwNo, loginController.UserId(), BaseUtitiles.deviceName)
  //       .then((value) async {
  //     if (value != null && value.length > 0) {
  //       BaseUtitiles.showToast("Record deleted successfully");
  //       return value;
  //     }
  //   });
  // }

  Future<dynamic> EntryList_DeleteApi(List<int> InwId, List<String> InwNo) async {
    String body = advanceReqDeleteModelToJson(
      AdvanceReqDeleteModel(
        vocIds: InwId,
        vocNos: InwNo,
        userId: loginController.UserId(),
        deviceName: BaseUtitiles.deviceName,
      ),
    );

    final value = await AdvanceReqVoucherProvider.entryList_deleteAPI(body);

    if (value != null && value.isNotEmpty) {
      return value;
    } else {
      return null;
    }
  }


  Future EntryList_EditApi(int vocId,int acctypId,int accnameId, int prjId, BuildContext context) async {
    await AdvanceReqVoucherProvider.entryList_editAPI(vocId, acctypId,accnameId,prjId).then((value) async {
      if (value != null && value.length > 0) {
        editcheck = 1;
        entrycheck = 1;
        editListApiDatas.value = value;
        for (var element in editListApiDatas.value) {
          if (element.accTypeName == "SUPPLIER") {
            await EditAdvTable_SaveTable();
            await getTableListDatas();
          } else {
            await EditTable_SaveTable();
            await getItemlistTablesDatas();
          }
        }
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdvReq_voucher_New()),
        );
      }
    });
  }

  ///-------ADVANCE-------------------
  EditTable_SaveTable() async {
    ItemListTableModelList.clear();
    editListApiDatas.value.forEach((element) {
      element.vocEditDet.forEach((value) {
        ItemListTableModel = AdvReqVoucherItemListTableModel();
        ItemListTableModel.siteId = value.siteId;
        ItemListTableModel.siteName = value.siteName;
        ItemListTableModel.paymentType = value.payType;
        ItemListTableModel.amount = value.amount;
        ItemListTableModel.tds_percent = value.tdsPer;
        ItemListTableModel.tds_amount = value.tdsAmt;
        ItemListTableModel.netAmount = value.netAmt;
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
      element.vocEditDet.forEach((value) {
        advreqvouModel = AdvReqVoucher_SiteWisePayment_TableModel();
        advreqvouModel.purOrdMasId = value.purOrdMasId;
        advreqvouModel.orderNo = value.poNo;
        advreqvouModel.project = value.project;
        advreqvouModel.projectId = value.projectId;
        advreqvouModel.siteName = value.siteName;
        advreqvouModel.siteId = value.siteId;
        advreqvouModel.paymentType = value.payType;
        advreqvouModel.dprAmt = value.netAmt;
        advreqvouModel.advanceAmt = value.advancAmt;
        advreqvouModel.bAmount = value.bAmount;
        advreqvouModel.amount = value.amount;
        DBTableModelList.add(advreqvouModel);
      });
    });
    var savedatas =
    await advReqVou_sitewisePayService.AdvreqVoucher_SiteWisePaymentTable_Save(DBTableModelList);
    return savedatas;
  }

  String ButtonChanges(int id) {
    if (id != 0)
      return saveButton.value = RequestConstant.RESUBMIT;
    else
      return saveButton.value = RequestConstant.SUBMIT;
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
                        onPressed: () {
                          entrycheck = 0;
                          editcheck = 0;
                          List<int> IdList=[entryList[index].vocId];
                          List<String> NoList=[ entryList[index].vocNo];
                          EntryList_DeleteApi(IdList,NoList);
                          entryList.removeAt(index);
                          Navigator.of(context).pop();
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
