import 'package:fluttertoast/fluttertoast.dart';

import '../controller/fromproject_ccontroller.dart';
import '../controller/fromsite_controller.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../db_model/transbet_itemlistTable_model.dart';
import '../db_services/transferbet_itemlist_service.dart';
import '../home/menu/materials/transfer_between_projects/transfer_between_project_itemlist.dart';
import '../home/menu/materials/transfer_between_projects/transferbetween_projects_entry.dart';
import '../home/menu/materials/transfer_between_projects/transferbetween_projects_list.dart';
import '../home/pending_list/pending_list.dart';
import '../models/cons_type_list_model.dart';
import '../models/transferbet_editapires_model.dart';
import '../models/transferbet_save_apireq_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../provider/consumption_provider.dart';
import '../provider/transferbetweenproject_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class TransferBW_project_Controller extends GetxController {
  final TRPEntrylistFrDate = TextEditingController();
  final TRPEntrylistToDate = TextEditingController();

  final autoyrwiseText = TextEditingController();
  final entryDateText = TextEditingController();
  final transferTypeText = TextEditingController();
  final appNoText = TextEditingController();
  final prearedbyText = TextEditingController();
  final vechicleNoText = TextEditingController();
  final driverNameText = TextEditingController();
  final dcNoText = TextEditingController();
  final transportCostText = TextEditingController();
  final transportAmtText = TextEditingController();
  final remarksText = TextEditingController();

  List<TextEditingController> Itemlist_stockQty_ListController = [];
  List<TextEditingController> Itemlist_balQty_ListControllers = [];
  List<TextEditingController> Itemlist_TransQty_ListController = [];
  List<TextEditingController> Itemlist_Rate_ListController = [];
  List<TextEditingController> Itemlist_Amt_ListController = [];

  List<TextEditingController> Show_Itemlist_stockQtyControllers = [];
  List<TextEditingController> Show_Itemlist_TransQtyController = [];
  List<TextEditingController> Show_Itemlist_RateController = [];
  List<TextEditingController> Show_Itemlist_AmtController = [];

  bool get isSubmit => saveButton.value == RequestConstant.SUBMIT;
  bool get isResubmit => saveButton.value == RequestConstant.RESUBMIT;

  final toprojectname = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  FromProjectController fromprojectController =
      Get.put(FromProjectController());
  FromSiteController fromsiteController = Get.put(FromSiteController());
  ProjectController projectController = Get.put(ProjectController());
  PendingListController pendingListController =
      Get.put(PendingListController());

  RxList transferAllDatasList = [].obs;
  RxList transReqPendingViewList = [].obs;
  RxList transReqPendingViewAllList = [].obs;
  RxList transferItemListdatas = [].obs;
  RxList mainlist = [].obs;
  RxList TRPEtyList = [].obs;
  RxList mainEntrylist = [].obs;
  RxInt selectedFrProjectId = 0.obs;
  RxInt AgMRNAppreqMasid = 0.obs;
  RxInt AgTransReqMasid = 0.obs;
  RxString selectedFrProjectName = "".obs;

  late List<TransferBetItemListTableModel> ItemListTableModelList =
      <TransferBetItemListTableModel>[];
  late List<TransferBetItemListTableModel> detTransReqItemListTableList =
      <TransferBetItemListTableModel>[];
  late List<TransferBetItemListTableModel> itemListUpdateModelList =
      <TransferBetItemListTableModel>[];
  late List<TransferBetItemListTableModel> deleteModelList =
      <TransferBetItemListTableModel>[];

  var ItemListTableModel = TransferBetItemListTableModel();
  var transfer_ItemlistService = Transferbet_ItemlistService();
  List ItemListTableModelReadList = <TransferBetItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  RxList<MaterialTransLink> getTransfferbetDetList = <MaterialTransLink>[].obs;
  RxList<transEditResult> editListApiDatas = <transEditResult>[].obs;
  RxList detTransReqPendingView = [].obs;

  int transferId = 0;
  RxString type = "".obs;
  RxString saveButton = RequestConstant.SUBMIT.obs;

  clearDatas() {
    transferId = 0;
    itemlistTable_Delete();
    entryDateText.text = BaseUtitiles.initiateCurrentDateFormat();
    projectController.projectnameAll.text = "--SELECT--";
    projectController.selectedProjectIdAll.value = 0;
    fromprojectController.fromprojectname.text = "--SELECT--";
    fromprojectController.selectedProjectId = 0.obs;
    fromsiteController.selectedsiteId = 0.obs;
    fromsiteController.FromSitename.text = "--SELECT--";
    vechicleNoText.text = "";
    prearedbyText.text = "";
    dcNoText.text = "";
    transportCostText.text = "0.0";
    transportAmtText.text = "0.0";
    remarksText.text = "";
    transferTypeText.text = "";
    autoyrwiseText.text = "";
    entryDateText.text = "";
    appNoText.text = "";
    ItemGetTableListdata.value = [];
  }

  ///----Transfer Pending---------
  Future getTransferProject_Alldatas(int reqId, BuildContext context) async {
    transferAllDatasList.value = [];
    transferItemListdatas.value = [];
    final value =
        await TransferBetweenProject_provider.getTransferProj_ALLDatas(reqId);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          transferAllDatasList.value = value.result!;
          saveButton.value = RequestConstant.SUBMIT;
          FocusScope.of(context).unfocus();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TrasferBetweenProjects_Entry()));
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    }
  }

  ///--------Transfer Request Pending-----------
  Future getTransPendingView(trId, BuildContext context) async {
    transferAllDatasList.value = [];
    transferItemListdatas.value = [];
    final value =
        await TransferBetweenProject_provider.getTransPendingViewAPI(trId);
    if (value != null) {
      if (value.success == true) {
        if (value.transferEditDet!.isNotEmpty) {
          transferAllDatasList.value = value.transferEditDet!;
          saveButton.value = RequestConstant.SUBMIT;
          await detTransReqPendingViewTable();
          await getItemlistTablesDatas();
          FocusScope.of(context).unfocus();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TrasferBetweenProjects_Entry()));
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    }
  }

  ///-------Det TransReqPendingView-------
  detTransReqPendingViewTable() async {
    detTransReqItemListTableList.clear();
    transferAllDatasList.value.forEach((value) {
      ItemListTableModel = TransferBetItemListTableModel();
      ItemListTableModel.materialId = value.materialId;
      ItemListTableModel.materialName = value.materialName.toString();
      ItemListTableModel.stockQty = value.stockQty;
      ItemListTableModel.balQty = value.balQty;
      ItemListTableModel.scale = value.scale;
      ItemListTableModel.scaleId = value.scaleId;
      ItemListTableModel.Qty = 0;
      ItemListTableModel.amount = 0;
      ItemListTableModel.rate = 0;
      ItemListTableModel.transReqDetId = value.detId;
      ItemListTableModel.reqDetId = 0;
      detTransReqItemListTableList.add(ItemListTableModel);
    });
    var savedatas =
        await transfer_ItemlistService.Transferbet_ItemlistTable_Save(
            detTransReqItemListTableList);
    return savedatas;
  }

  Future getTransproject_EntryList() async {
    mainEntrylist.value.clear();
    TRPEtyList.value.clear();
    var response =
        await TransferBetweenProject_provider.getTransProjectEntryList(
            loginController.user.value.userId,
            loginController.UserType(),
            TRPEntrylistFrDate.text,
            TRPEntrylistToDate.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          mainEntrylist.assignAll(response.result!);
          TRPEtyList.assignAll(response.result!);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response?.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future getTransproject_ItemList(
      int prid, int siteId, int reqId, BuildContext context) async {
    mainlist.value = [];
    transferItemListdatas.value = [];
    final value = await Consumption_provider.getStockmaterial(prid, siteId,
        type: type.value == "Direct" ? "D" : "A", reqId: reqId);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          transferItemListdatas.value = value.result ?? [];
          if (type.value == "Direct" ||
              type.value == "Against Transfer Request") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Transfer_Between_Project_ItemList(),
              ),
            );
          }
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  itemlistTable_Delete() async {
    await transfer_ItemlistService.Transferbet_ItemlistTable_delete();
  }

  itemlist_SaveTable() async {
    ItemListTableModelList.clear();
    transferItemListdatas.value.forEach((element) {
      // if(element.stockQty>0){
      ItemListTableModel = TransferBetItemListTableModel();
      ItemListTableModel.materialId = element.materialId;
      ItemListTableModel.materialName = element.material.toString();
      ItemListTableModel.scale = element.scale.toString();
      ItemListTableModel.scaleId = element.scaleId;
      ItemListTableModel.stockQty = element.stockQty;
      ItemListTableModel.balQty = element.balQty;
      ItemListTableModel.Qty = 0.0;
      ItemListTableModel.reqDetId = element.reqDetId;
      ItemListTableModel.transReqDetId = element.transReqDetId;
      ItemListTableModel.rate = 0.0;
      ItemListTableModel.amount = 0.0;
      ItemListTableModelList.add(ItemListTableModel);
      // }
    });
    var savedatas =
        await transfer_ItemlistService.Transferbet_ItemlistTable_Save(
            ItemListTableModelList);
    return savedatas;
  }

  Future getItemlistTablesDatas() async {
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    for (final c in Itemlist_TransQty_ListController) {
      c.dispose();
    }
    Itemlist_TransQty_ListController.clear();
    var datas =
        await transfer_ItemlistService.Transferbet_ItemlistTable_readAll();
    ItemListTableModelReadList = <TransferBetItemListTableModel>[];
    datas.forEach((value) {
      ItemListTableModel = TransferBetItemListTableModel();
      itemlist_textControllersInitiate();
      ItemListTableModel.id = value['id'];
      ItemListTableModel.materialId = value['materialId'];
      ItemListTableModel.materialName = value['materialName'];
      ItemListTableModel.scale = value['scale'];
      ItemListTableModel.scaleId = value['scaleId'];
      ItemListTableModel.stockQty = value['stockQty'];
      ItemListTableModel.balQty = value['balQty'];
      ItemListTableModel.Qty = value['Qty'];
      ItemListTableModel.reqDetId = value['reqDetId'];
      ItemListTableModel.reqMasDetId = value['reqMasDetId'];
      ItemListTableModel.rate = value['rate'];
      ItemListTableModel.amount = value['amount'];
      ItemListTableModel.transReqDetId = value['transReqDetId'];
      ItemListTableModelReadList.add(ItemListTableModel);
      ItemGetTableListdata.value = ItemListTableModelReadList;
    });
    setItemListListTextValue(ItemGetTableListdata.value);
  }

  itemlist_textControllersInitiate() {
    Itemlist_stockQty_ListController.add(new TextEditingController());
    Itemlist_balQty_ListControllers.add(new TextEditingController());
    Itemlist_TransQty_ListController.add(new TextEditingController());
    Itemlist_Rate_ListController.add(new TextEditingController());
    Itemlist_Amt_ListController.add(new TextEditingController());

    Show_Itemlist_stockQtyControllers.add(new TextEditingController());
    Show_Itemlist_TransQtyController.add(new TextEditingController());
    Show_Itemlist_RateController.add(new TextEditingController());
    Show_Itemlist_AmtController.add(new TextEditingController());
  }

  setItemListListTextValue(vale) {
    int i = 0;
    vale.forEach((datas) {
      itemlist_textControllersInitiate();
      Itemlist_stockQty_ListController[i].text = datas.stockQty.toString();
      Itemlist_balQty_ListControllers[i].text = datas.balQty.toString();
      Itemlist_TransQty_ListController[i].text = datas.Qty.toString();
      Itemlist_Rate_ListController[i].text = datas.rate.toString();
      Itemlist_Amt_ListController[i].text = datas.amount.toString();
      i++;
    });
  }

  Future deleteParticularList(TransferBetItemListTableModel data) async {
    deleteModelList = [];
    ItemListTableModel = new TransferBetItemListTableModel();
    ItemListTableModel.materialId = data.materialId;
    deleteModelList.add(ItemListTableModel);
    await transfer_ItemlistService.Transferbet_ItemlistTable_deleteById(
        deleteModelList);
  }

  double totAmtText = 0.0;

  void ItemListclickEdit() {
    bool isToastDisplayed = false;

    double totalItemAmount = 0;
    double transportCost = double.tryParse(transportCostText.text) ?? 0;

    for (var index = 0; index < ItemGetTableListdata.length; index++) {
      double transQty =
          double.tryParse(Itemlist_TransQty_ListController[index].text) ?? 0;

      double rate =
          double.tryParse(Itemlist_Rate_ListController[index].text) ?? 0;

      double stockQty = ItemGetTableListdata[index].stockQty;
      double balQty = ItemGetTableListdata[index].balQty;

      if (transQty > stockQty) {
        if (!isToastDisplayed) {
          BaseUtitiles.showToast('Transfer qty is greater than stock qty');
          isToastDisplayed = true;
        }

        Itemlist_TransQty_ListController[index].text = "0.0";
        Itemlist_Amt_ListController[index].text = "0.0";
        continue;
      }
      if (type.value != "Direct") {
        if (transQty > balQty) {
          if (!isToastDisplayed) {
            BaseUtitiles.showToast('Transfer qty is greater than balance qty');
            isToastDisplayed = true;
          }

          Itemlist_TransQty_ListController[index].text = "0.0";
          Itemlist_Amt_ListController[index].text = "0.0";
          continue;
        }
      }

      double amount = rate * transQty;

      Itemlist_Amt_ListController[index].text = amount.toStringAsFixed(2);

      totalItemAmount += amount;
    }

    double finalAmount = totalItemAmount + transportCost;

    totAmtText = finalAmount;

    updateItemlistTable();
  }

  popupChaneEdit(String value) {
    int i = 0;
    mainlist.forEach((element) {
      itemlist_textControllersInitiate();
      if (double.parse(Show_Itemlist_TransQtyController[i].text) <=
          element.stockQty) {
        Show_Itemlist_AmtController[i].text =
            ((double.parse(Show_Itemlist_RateController[i].text) *
                    double.parse(Show_Itemlist_TransQtyController[i].text))
                .toString());
      } else {
        Show_Itemlist_TransQtyController[i].text = "0.0";
        Show_Itemlist_AmtController[i].text = "0.0";
      }
      i++;
    });
  }

  void transportAmtCalculation() {
    double transCost = double.tryParse(transportCostText.text) ?? 0;
    double totalItemAmount = 0;

    for (int index = 0; index < ItemGetTableListdata.length; index++) {
      double transQty =
          double.tryParse(Itemlist_TransQty_ListController[index].text) ?? 0;

      double rate =
          double.tryParse(Itemlist_Rate_ListController[index].text) ?? 0;

      double rateAmount = transQty * rate;

      Itemlist_Amt_ListController[index].text = rateAmount.toStringAsFixed(1);

      if (rateAmount != 0) {
        totalItemAmount += rateAmount;
      }
    }
    double transAmount = transCost + totalItemAmount;

    transportAmtText.text = transAmount.toStringAsFixed(1);
  }

  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      itemlist_textControllersInitiate();
      ItemListTableModel = new TransferBetItemListTableModel();
      ItemListTableModel.id = element.id;
      ItemListTableModel.materialId = element.materialId;
      ItemListTableModel.materialName = element.materialName.toString();
      ItemListTableModel.balQty = element.balQty;
      ItemListTableModel.scale = element.scale;
      ItemListTableModel.scaleId = element.scaleId;
      ItemListTableModel.stockQty = element.stockQty;
      ItemListTableModel.reqDetId = element.reqDetId;
      ItemListTableModel.transReqDetId = element.transReqDetId;
      ItemListTableModel.Qty = double.parse(
          Itemlist_TransQty_ListController[i].text == ""
              ? "0"
              : Itemlist_TransQty_ListController[i].text);
      ItemListTableModel.reqDetId = element.reqDetId;
      ItemListTableModel.rate =
          double.parse(Itemlist_Rate_ListController[i].text);
      ItemListTableModel.amount =
          double.parse(Itemlist_Amt_ListController[i].text);
      itemListUpdateModelList.add(ItemListTableModel);
      i++;
    });
    await transfer_ItemlistService.Transferbet_ItemlistTable_Update(
        itemListUpdateModelList);
  }

  Future Save_EntryScreen(BuildContext context, int id, int matReqMasId,
      int matTransReqMasId) async {
    getTransfferbetDetList.value = [];
    await Future.delayed(const Duration(seconds: 0));
    String body = transferbetSaveApiReqToJson(TransferbetSaveApiReq(
      id: id != 0 ? id : 0,
      transferNo: autoyrwiseText.text,
      fromProjectId: fromprojectController.selectedProjectId.value,
      toProjectId: projectController.selectedProjectIdAll.value,
      fromSiteid: fromsiteController.selectedsiteId.value,
      matReqMasId: type.value == "Against Mrn Approval" ? matReqMasId : 0,
      matTransReqMasId:
          type.value == "Against Transfer Request" ? matTransReqMasId : 0,
      remarks: remarksText.text,
      vehicleName: vechicleNoText.text,
      totalAmount: double.tryParse(transportAmtText.text),
      transportAmount: double.tryParse(transportCostText.text),
      entryType: type.value == "Direct"
          ? "D"
          : type.value == "Against Transfer Request"
              ? "R"
              : "A",
      entryDate: entryDateText.text,
      dcNo: dcNoText.text,
      reqOrdNo: appNoText.text,
      createdBy: int.parse(loginController.EmpId()),
      createdDt: BaseUtitiles().convertToUtcIso(entryDateText.text),
      materialTransLinks: getTransfferbetDetList.value.isEmpty
          ? getDetDetails(id)
          : getTransfferbetDetList.value,
    ));

    final list = await TransferBetweenProject_provider.transferbet_SaveApi(
        body, context);

    if (list != null) {
      if (list["success"] == true) {
        BaseUtitiles.showToast(list["message"]);
        await clearDatas();
        itemlistTable_Delete();
        ItemGetTableListdata.clear();
        if (type.value != "Direct" &&
            saveButton.value == RequestConstant.SUBMIT) {
          await pendingListController.getPendingList();
          BaseUtitiles.popMultiple(context, count: 4);
        } else {
          await getTransproject_EntryList();
          BaseUtitiles.popMultiple(context, count: 3);
        }
      } else {
        BaseUtitiles.showToast(list?["message"] ?? "Something went wrong..");
        BaseUtitiles.popMultiple(context, count: 2);
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  List<MaterialTransLink>? getDetDetails(id) {
    for (int index = 0; index < ItemGetTableListdata.length; index++) {
      if (ItemGetTableListdata[index].Qty > 0) {
        var list = MaterialTransLink(
          id: saveButton.value == RequestConstant.RESUBMIT
              ? ItemGetTableListdata[index].reqDetId
              : 0,
          materialTransferMasId: id != 0 ? id : 0,
          materialId: ItemGetTableListdata[index].materialId,
          qty: ItemGetTableListdata[index].Qty,
          reqMasDetId: type.value == "Against Mrn Approval"
              ? ItemGetTableListdata[index].reqDetId
              : 0,
          transReqDetId: type.value == "Against Transfer Request"
              ? ItemGetTableListdata[index].transReqDetId
              : 0,
          rate: ItemGetTableListdata[index].rate,
          amount: ItemGetTableListdata[index].amount,
        );
        getTransfferbetDetList.add(list);
      }
    }
    return getTransfferbetDetList.value;
  }

  Future EntryList_EditApi(int workid, BuildContext context) async {
    final value =
        await TransferBetweenProject_provider.entryList_editAPI(workid);
    if (value != null) {
      if (value.success == true) {
        type.value = value.result!.entryType == "D"
            ? "Direct"
            : value.result!.entryType == "R"
                ? "Against Transfer Request"
                : "Against Mrn Approval";
        editListApiDatas.value = [value.result!];
        saveButton.value = RequestConstant.RESUBMIT;
        EditTable_SaveTable();
        getItemlistTablesDatas();
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TrasferBetweenProjects_Entry()));
      } else {
        BaseUtitiles.showToast(value.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  EditTable_SaveTable() async {
    ItemListTableModelList.clear();
    editListApiDatas.value.forEach((element) {
      element.materialTransLinks?.forEach((value) {
        ItemListTableModel = TransferBetItemListTableModel();
        ItemListTableModel.materialId = value.materialId;
        ItemListTableModel.reqDetId = value.reqDetId;
        ItemListTableModel.materialName = value.materialName.toString();
        ItemListTableModel.stockQty = value.stockQty;
        ItemListTableModel.balQty = value.balQty;
        ItemListTableModel.scale = value.scale;
        ItemListTableModel.scaleId = value.scaleId;
        ItemListTableModel.Qty = value.qty;
        ItemListTableModel.amount = value.amount;
        ItemListTableModel.rate = value.rate;
        ItemListTableModel.reqMasDetId = value.reqMasDetId;
        ItemListTableModel.transReqDetId = value.transReqDetId;
        ItemListTableModelList.add(ItemListTableModel);
      });
    });
    var savedatas =
        await transfer_ItemlistService.Transferbet_ItemlistTable_Save(
            ItemListTableModelList);
    return savedatas;
  }

  Future<bool> EntryList_DeleteApi(int inwId) {
    return TransferBetweenProject_provider.entryList_deleteAPI(inwId);
  }

  itemlistpopupInitiatevalue() {
    int i = 0;
    mainlist.value.forEach((element) {
      itemlist_textControllersInitiate();
      Show_Itemlist_stockQtyControllers[i].text = element.stockQty.toString();
      Show_Itemlist_TransQtyController[i].text = "0.0";
      Show_Itemlist_RateController[i].text = "0.0";
      Show_Itemlist_AmtController[i].text = "0.0";
      i++;
    });
  }

  itemlistPopup_saveLabTableDatas(BuildContext context) async {
    int j = 0;

    ItemListTableModelList.clear();
    transferItemListdatas.value.forEach((element) {
      if (element.check == true) {
        ItemListTableModel = new TransferBetItemListTableModel();
        ItemListTableModel.materialId = element.materialId;
        ItemListTableModel.materialName = element.material.toString();
        ItemListTableModel.scale = element.scale.toString();
        ItemListTableModel.scaleId = element.scaleId;
        ItemListTableModel.stockQty = element.stockQty;
        ItemListTableModel.balQty = element.balQty;
        ItemListTableModel.Qty = 0.0;
        ItemListTableModel.reqDetId = 0;
        ItemListTableModel.rate = 0.0;
        ItemListTableModel.amount = 0.0;
        ItemGetTableListdata.value.forEach((element) {
          if (element.materialId == ItemListTableModel.materialId) {
            j = 1;
            BaseUtitiles.showToast("Entries already exist");
          }
        });
        if (j == 0) {
          ItemListTableModelList.add(ItemListTableModel);
        } else {
          j = 0;
        }
      }
    });
    var savedatas =
        await transfer_ItemlistService.Transferbet_ItemlistTable_Save(
            ItemListTableModelList);
    return Navigator.pop(context, savedatas);
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
                              TRPEtyList[index].transferId);
                          if (result) {
                            itemlistTable_Delete();
                            ItemGetTableListdata.clear();
                            TRPEtyList.removeAt(index);
                            update();
                            await getTransproject_EntryList();
                            Navigator.of(context).pop();
                          }
                          else{
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

  setCheck(int id, bool value) {
    transferItemListdatas.value.forEach((element) {
      if (element.materialId == id) {
        element.check = value;
      }
    });
  }

  serachsetCheck(int id, bool value) {
    mainlist.forEach((element) {
      if (element.materialId == id) {
        element.check = value;
      }
    });
  }
}
