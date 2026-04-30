import 'package:fluttertoast/fluttertoast.dart';
import 'package:prahkurticore/controller/pendinglistcontroller.dart';
import '../app_theme/app_colors.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/materiallist_model.dart';
import '../db_model/transferbet_sitewise_itemlistTable_model.dart';
import '../db_services/transferbet_sitewise_itemlist_service.dart';
import '../home/menu/materials/transfer_between_sites/transferbetween_sites_additems.dart';
import '../home/menu/materials/transfer_between_sites/transferbetween_sites_entry.dart';
import '../home/menu/materials/transfer_between_sites/transferbetween_sites_list.dart';
import '../models/transferbet_site_saveapi_req_model.dart';
import '../provider/common_provider.dart';
import '../provider/consumption_provider.dart';
import '../provider/transferbetween_site_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fromsite_controller.dart';
import 'logincontroller.dart';

class TransferBt_Site_Controller extends GetxController {
  final TRPEntrylistFrDate = TextEditingController();
  final TRPEntrylistToDate = TextEditingController();
  final autoyrwiseText = TextEditingController();
  final entryDateText = TextEditingController();
  final prearedbyText = TextEditingController();
  final remarksText = TextEditingController();
  final ReqNoText = TextEditingController();


  LoginController loginController = Get.put(LoginController());
  PendingListController pendingListController =
  Get.put(PendingListController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  FromSiteController fromsiteController = Get.put(FromSiteController());

  List<TextEditingController> Itemlist_stockQty_ListController = [];
  List<TextEditingController> Itemlist_TransQty_ListController = [];

  List<TextEditingController> Show_Itemlist_stockQtyControllers = [];
  List<TextEditingController> Show_Itemlist_TransQtyController = [];

  int transId = 0;

  RxString type = "".obs;
  RxString saveButton = RequestConstant.SUBMIT.obs;
  RxList transferItemListdatas = [].obs;
  RxList transferAllDatasList = [].obs;
  RxList mainlist = [].obs;
  RxList entryList = [].obs;
  RxList mainentryList = [].obs;

  RxList getSiteDropdownvalue = [].obs;
  RxList siteDropdownName = [].obs;
  RxList editListApiDatas = [].obs;
  RxString from_selectedsitedropdownName = "".obs;
  final searchcontroller = TextEditingController();
  var radioValue = ''.obs;
  bool get isSubmit => saveButton.value == RequestConstant.SUBMIT;
  bool get isResubmit => saveButton.value == RequestConstant.RESUBMIT;
  bool get isPending => saveButton.value == RequestConstant.PENDINGLIST;


  late List<TransferBet_Site_ItemListTableModel> ItemListTableModelList =
      <TransferBet_Site_ItemListTableModel>[];
  late List<TransferBet_Site_ItemListTableModel> detTransReqItemListTableList =
  <TransferBet_Site_ItemListTableModel>[];
  var ItemListTableModel = TransferBet_Site_ItemListTableModel();
  var transferSite_ItemlistService = Transferbet_Site_ItemlistService();
  List ItemListTableModelReadList = <TransferBet_Site_ItemListTableModel>[];
  late List<TransferBet_Site_ItemListTableModel> itemListUpdateModelList =
      <TransferBet_Site_ItemListTableModel>[];
  late List<TransferBet_Site_ItemListTableModel> deleteModelList =
      <TransferBet_Site_ItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  RxList<MaterialSiteLink> getTransfferbetDetList = <MaterialSiteLink>[].obs;

  Future getItemList(int prid, int siteId, context) async {
    transferItemListdatas.value = [];
    final value = await Consumption_provider.getStockmaterial(prid, siteId);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          transferItemListdatas.value = value.result ?? [];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Transferbetween_sites_additems()));
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

  itemlist_textControllersInitiate() {
    Itemlist_stockQty_ListController.add(new TextEditingController());
    Itemlist_TransQty_ListController.add(new TextEditingController());
    Show_Itemlist_stockQtyControllers.add(new TextEditingController());
    Show_Itemlist_TransQtyController.add(new TextEditingController());
  }

  itemlistTable_Delete() async {
    await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_delete();
  }

  Future deleteParticularList(TransferBet_Site_ItemListTableModel data) async {
    deleteModelList = [];
    ItemListTableModel = new TransferBet_Site_ItemListTableModel();
    ItemListTableModel.materialId = data.materialId;
    deleteModelList.add(ItemListTableModel);
    await transferSite_ItemlistService
        .Transferbet_Site_ItemlistTable_deleteById(deleteModelList);
  }

  itemlistPopup_saveLabTableDatas(BuildContext context) async {
    int i = 0;
    int j = 0;
    ItemListTableModelList.clear();
    transferItemListdatas.value.forEach((element) {
      if (element.check == true) {
        ItemListTableModel = new TransferBet_Site_ItemListTableModel();
        ItemListTableModel.materialId = element.materialId;
        ItemListTableModel.materialName = element.material.toString();
        ItemListTableModel.scale = element.scale.toString();
        ItemListTableModel.stockQty = element.stockQty;
        ItemListTableModel.balQty = element.balQty;
        // ItemListTableModel.Qty = 1.0;
        ItemListTableModel.Qty = double.parse("0");
        ItemListTableModel.reqDetId = 0;
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
      i++;
    });
    var savedatas =
        await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_Save(
            ItemListTableModelList);
    return Navigator.pop(context, savedatas);
  }

  Future getItemlistTablesDatas() async {
    var datas = await transferSite_ItemlistService
        .Transferbet_Site_ItemlistTable_readAll();
    ItemListTableModelReadList = <TransferBet_Site_ItemListTableModel>[];
    for (final c in Itemlist_TransQty_ListController) {
      c.dispose();
    }
    Itemlist_TransQty_ListController.clear();
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    datas.forEach((value) {
      ItemListTableModel = new TransferBet_Site_ItemListTableModel();
      itemlist_textControllersInitiate();
      ItemListTableModel.id = value['id'];
      ItemListTableModel.materialId = value['materialId'];
      ItemListTableModel.StSDetId = value['StSDetId'];
      ItemListTableModel.materialName = value['materialName'];
      ItemListTableModel.scale = value['scale'];
      ItemListTableModel.stockQty = value['stockQty'];
      ItemListTableModel.balQty = value['balQty'];
      ItemListTableModel.Qty = value['Qty'];
      ItemListTableModel.reqDetId = value['reqDetId'];
      ItemListTableModel.rate = value['rate'];
      ItemListTableModel.amount = value['amount'];
      ItemListTableModelReadList.add(ItemListTableModel);
      ItemGetTableListdata.value = ItemListTableModelReadList;
    });
    setItemListListTextValue(ItemGetTableListdata.value);
  }

  setItemListListTextValue(vale) {
    int i = 0;
    vale.forEach((datas) {
      itemlist_textControllersInitiate();
      Itemlist_stockQty_ListController[i].text = datas.stockQty.toString();
      Itemlist_TransQty_ListController[i].text = datas.Qty.toString();
      i++;
    });
  }

  updateItemlistTable() async {
    itemListUpdateModelList = [];
    bool hasInvalidQty = false;

    // ✅ initialize controllers only once before loop
    itemlist_textControllersInitiate();

    for (int i = 0; i < ItemGetTableListdata.length; i++) {
      var element = ItemGetTableListdata[i];

      double transQty =
          double.tryParse(Itemlist_TransQty_ListController[i].text) ?? 0.0;
      double stockQty =
          double.tryParse(Itemlist_stockQty_ListController[i].text) ?? 0.0;

      if (transQty > stockQty) {
        // reset invalid qty
        Itemlist_TransQty_ListController[i].text = "0.0";
        hasInvalidQty = true;
        continue; // skip adding invalid item
      }

      var itemModel = TransferBet_Site_ItemListTableModel();
      itemModel.id = element.id;
      itemModel.materialId = element.materialId;
      itemModel.materialName = element.materialName.toString();
      itemModel.balQty = element.balQty;
      itemModel.scale = element.scale;
      itemModel.stockQty = element.stockQty;
      itemModel.Qty = transQty;
      itemModel.reqDetId = element.reqDetId;

      itemListUpdateModelList.add(itemModel);
    }

    if (hasInvalidQty) {
      BaseUtitiles.showToast("Invalid quantity, check stock limit");
    }

    await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_Update(
        itemListUpdateModelList);
  }

  storeUpdateItemlistTable() async {
    itemListUpdateModelList = [];
    bool hasInvalidQty = false;

    // initialize controllers only once
    itemlist_textControllersInitiate();

    for (int i = 0; i < ItemGetTableListdata.length; i++) {
      var element = ItemGetTableListdata[i];

      double transQty =
          double.tryParse(Itemlist_TransQty_ListController[i].text) ?? 0.0;

      double stockQty =
          double.tryParse(Itemlist_stockQty_ListController[i].text) ?? 0.0;

      double balQty = double.tryParse(element.balQty.toString()) ?? 0.0;

      // ✅ validation
      if (transQty > stockQty || transQty > balQty) {
        Itemlist_TransQty_ListController[i].text = "0.0";
        hasInvalidQty = true;

        continue; // skip invalid row
      }

      var itemModel = TransferBet_Site_ItemListTableModel();

      itemModel.id = element.id;
      itemModel.materialId = element.materialId;
      itemModel.materialName = element.materialName.toString();
      itemModel.balQty = balQty;
      itemModel.scale = element.scale;
      itemModel.stockQty = stockQty;
      itemModel.Qty = transQty;
      itemModel.reqDetId = element.reqDetId;

      itemListUpdateModelList.add(itemModel);
    }

    if (hasInvalidQty) {
      BaseUtitiles.showToast(
          "Transfer Qty should not exceed Stock Qty or Balance Qty");
    }

    await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_Update(
        itemListUpdateModelList);
  }

  Future Save_EntryScreen(BuildContext context, int id) async {
    await getItemlistTablesDatas();
    getTransfferbetDetList.value.clear();
    String body = transferbetSiteSaveApiReqToJson(TransferbetSiteSaveApiReq(
      id: id != 0 ? id : 0,
      transferNo: autoyrwiseText.text,
      entryDt: entryDateText.text,
      fromSiteid: fromsiteController.selectedsiteId.value,
      toSiteId: siteController.selectedsiteId.value,
      remarks: remarksText.text,
      fromProjectId: projectController.selectedProjectId.value,
      subContractId: subcontractorController.selectedSubcontId.value,
      transferType: radioValue.value == "transfer_usage" ? 1 : isPending ? 0 : 0,
      reqOrdMasId: isPending ? transferAllDatasList[0].reqMasid : isResubmit ? editListApiDatas[0].reqOrdMasId : null,


      //add
      createdBy: isSubmit ? int.parse(loginController.EmpId()) : null,
      createdDt:
          isSubmit ? BaseUtitiles().convertToUtcIso(entryDateText.text) : null,

      //update
      updatedBy: isResubmit ? int.parse(loginController.EmpId()) : null,
      updatedDate: isResubmit
          ? BaseUtitiles().convertToUtcIso(entryDateText.text)
          : null,

      materialSiteLink: getTransfferbetDetList.isEmpty
          ? getDetDetails(id)
          : getTransfferbetDetList,
    ));

    final list =
        await TransferBetSiteProvider.transferbet_Site_SaveApi(body, id);

    if (list != null) {
      if (list["success"] == true) {
        if (saveButton.value == RequestConstant.PENDINGLIST) {
          BaseUtitiles.showToast(list["message"]);
          await pendingListController.getPendingList();
          BaseUtitiles.popMultiple(context, count: 4);
        }
        else {
          BaseUtitiles.showToast(list["message"]);
          print("Message....${list["message"]}");
          await getEntryList();
          BaseUtitiles.popMultiple(context, count: 3);
        }} else {
        BaseUtitiles.showToast(list?["message"] ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  List<MaterialSiteLink>? getDetDetails(id) {
    getTransfferbetDetList.value = [];
    for (int index = 0; index < ItemGetTableListdata.length; index++) {
      var list = MaterialSiteLink(
        id:  isResubmit ? ItemGetTableListdata[index].StSDetId : 0,
        transferSiteId: id != 0 ? id : 0,
        materialId: ItemGetTableListdata[index].materialId,
        reqOrdDetId: isPending ? ItemGetTableListdata[index].reqDetId : isResubmit ? ItemGetTableListdata[index].reqDetId : null,
        qty: ItemGetTableListdata[index].Qty,
        rate: 0,
        amount: 0,
      );
      getTransfferbetDetList.add(list);
    }
    return getTransfferbetDetList.value;
  }

  itemlistpopupInitiatevalue() {
    int i = 0;
    transferItemListdatas.value.forEach((element) {
      itemlist_textControllersInitiate();
      Show_Itemlist_stockQtyControllers[i].text = element.stockQty.toString();
      Show_Itemlist_TransQtyController[i].text = "0.0";
      i++;
    });
  }

  Future getEntryList() async {
    mainentryList.value.clear();
    entryList.value.clear();
    var response = await TransferBetSiteProvider.get_Entry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        TRPEntrylistFrDate.text,
        TRPEntrylistToDate.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          mainentryList.assignAll(response.result!);
          entryList.assignAll(response.result!);
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


  Future getStoreTransPendingView(trId,frSiteId, BuildContext context) async {
    transferAllDatasList.value = [];
    transferItemListdatas.value = [];
    final value =
    await TransferBetSiteProvider.getStoreTransPendingViewAPI(trId,frSiteId);
    if (value != null) {
      if (value.success == true) {
          transferAllDatasList.value = [value.result!];
          if (transferAllDatasList!.isNotEmpty) {
            saveButton.value = RequestConstant.PENDINGLIST;
            await detTransReqPendingViewTable();
            await getItemlistTablesDatas();
            FocusScope.of(context).unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransferBetweenSites_Entry()));
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

  detTransReqPendingViewTable() async {
    detTransReqItemListTableList.clear();
    transferAllDatasList.value.forEach((element) {
      element.mReqDetList.forEach((value) {
        ItemListTableModel = TransferBet_Site_ItemListTableModel();
        ItemListTableModel.materialId = value.materialid;
        ItemListTableModel.materialName = value.materialName.toString();
        ItemListTableModel.stockQty = value.stockQty;
        ItemListTableModel.balQty = value.balqty;
        ItemListTableModel.scale = value.scalename;
        ItemListTableModel.Qty = value.qty;
        // ItemListTableModel.amount = value.amount;
        // ItemListTableModel.rate = value.rate;
        ItemListTableModel.reqDetId = value.reqdetid;
        detTransReqItemListTableList.add(ItemListTableModel);
      });
    });
    var savedatas =
    await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_Save(
        detTransReqItemListTableList);
    return savedatas;
  }



  Future EntryList_EditApi(pId,sId,frsId,int workid, BuildContext context) async {
    final value = await TransferBetSiteProvider.entryList_editAPI(pId,sId,frsId,workid);
    if (value != null) {
      if (value.success == true) {
        editListApiDatas.value = value.result!;
        saveButton.value = RequestConstant.RESUBMIT;
        EditTable_SaveTable();
        getItemlistTablesDatas();
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TransferBetweenSites_Entry()));
      } else {
        BaseUtitiles.showToast(value?.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }

  }

  EditTable_SaveTable() async {
    ItemListTableModelList.clear();
    editListApiDatas.value.forEach((value) {
      // value.materialSiteLink.forEach((element) {
        ItemListTableModel = new TransferBet_Site_ItemListTableModel();
        ItemListTableModel.materialId = value.materialid;
        ItemListTableModel.StSDetId = value.StSDetId;

        ItemListTableModel.reqDetId = value.reqDetId;
        ItemListTableModel.materialName = value.materialName.toString();
        ItemListTableModel.stockQty = value.stockQty;
        ItemListTableModel.scale = value.scale;
        // ItemListTableModel.balQty = element.balQty;
        ItemListTableModel.Qty = value.qty;
        ItemListTableModelList.add(ItemListTableModel);
      });
    // });
    var savedatas =
        await transferSite_ItemlistService.Transferbet_Site_ItemlistTable_Save(
            ItemListTableModelList);
    return savedatas;
  }

  Future<bool> EntryList_DeleteApi(int TransferId) async {
    return TransferBetSiteProvider.entryList_deleteAPI(TransferId);
  }

  String ButtonChanges(int id) {
    if (id != 0)
      return saveButton.value = RequestConstant.RESUBMIT;
    else
      return saveButton.value = RequestConstant.SUBMIT;
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
                          bool result = await EntryList_DeleteApi(entryList[index].id);
                          if (result) {
                            entryList.removeAt(index);
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
