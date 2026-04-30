import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/controller/fromproject_ccontroller.dart';
import 'package:prahkurticore/controller/fromsite_controller.dart';
import 'package:prahkurticore/controller/logincontroller.dart';
import 'package:prahkurticore/controller/pendinglistcontroller.dart';
import 'package:prahkurticore/controller/projectcontroller.dart';
import '../db_model/mattransreqdet_model.dart';
import '../db_services/materialtransreq_services.dart';
import '../home/menu/materials/materialTransferRequest/materialTransReq_Entry.dart';
import '../home/menu/materials/materialTransferRequest/materialTransReq_addItems.dart';
import '../home/menu/materials/materialTransferRequest/materialTransReq_list.dart';
import '../models/materialtransreqsave_model.dart';
import '../provider/consumption_provider.dart';
import '../provider/materialTransReq_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class MaterialTransferReqController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  MaterialTransReqProvider materialTransReqProvider =
      Get.put(MaterialTransReqProvider());
  FromProjectController fromprojectController =
      Get.put(FromProjectController());
  FromSiteController fromsiteController = Get.put(FromSiteController());
  ProjectController projectController = Get.put(ProjectController());
  PendingListController pendingListController =
      Get.put(PendingListController());

  final matTransReqListFrDate = TextEditingController();
  final matTransReqListToDate = TextEditingController();
  final autoyrwiseText = TextEditingController();
  final entryDateText = TextEditingController();
  final prearedbyText = TextEditingController();
  final remarksText = TextEditingController();

  int matTansReqId = 0;
  int zeroTransferQtyCount = 0;

  RxString saveButton = RequestConstant.SUBMIT.obs;

  bool get isVerify => saveButton.value == RequestConstant.VERIFY;
  bool get isApprove => saveButton.value == RequestConstant.APPROVAL;

  RxList matTransReqList = [].obs;
  RxList mainmatTransReqList = [].obs;
  RxList mattransreqItemList = [].obs;
  RxList mainListAddItems = [].obs;
  RxList mainItemList = [].obs;
  RxList mattranReqEditListValue = [].obs;

  ///------MatTransReq GetList--------
  Future getListMatTransReq() async {
    mainmatTransReqList.value.clear();
    matTransReqList.value.clear();
    var response = await MaterialTransReqProvider.getMatTransReqListApi(
        loginController.user.value.userId,
        loginController.UserType(),
        matTransReqListFrDate.text,
        matTransReqListToDate.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          mainmatTransReqList.assignAll(response.result!);
          matTransReqList.assignAll(response.result!);
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

  ///-----------Add ItemsList--------
  Future getItemList(int prid, int siteId, BuildContext context) async {
    mainItemList.value.clear();
    mattransreqItemList.value.clear();
    final value = await Consumption_provider.getStockmaterial(prid, siteId);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          mainListAddItems.value = value.result!;
          mattransreqItemList.value = mainListAddItems.value;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const MatTransReqAddItems()));
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

  setCheck(int id, bool value) {
    mattransreqItemList.value.forEach((element) {
      if (element.materialId == id) {
        element.check = value;
      }
    });
  }

  serachsetCheck(int id, bool value) {
    mainListAddItems.forEach((element) {
      if (element.materialId == id) {
        element.check = value;
      }
    });
  }

  clearDatas() {
    matTansReqId = 0;
    entryDateText.text = BaseUtitiles.initiateCurrentDateFormat();
    prearedbyText.text = loginController.UserName();
    projectController.projectnameAll.text = "";
    projectController.selectedProjectIdAll.value = 0;
    fromprojectController.fromprojectname.text = "";
    fromprojectController.selectedProjectId = 0.obs;
    fromsiteController.selectedsiteId = 0.obs;
    fromsiteController.FromSitename.text = "";
    remarksText.text = "";
  }

  ///--------Local DB----------

  late List<MatTransDetItemListTableModel> ItemListTableModelList =
      <MatTransDetItemListTableModel>[];
  late List<MatTransDetItemListTableModel> itemListUpdateModelList =
      <MatTransDetItemListTableModel>[];
  late List<MatTransDetItemListTableModel> deleteModelList =
      <MatTransDetItemListTableModel>[];
  var ItemListTableModel = MatTransDetItemListTableModel();
  var mattransreq_ItemlistService = MatTransReqDetService();
  RxList ItemGetTableListdata = [].obs;
  RxList<MaterialTransferRequestDet> getTransfferbetDetList =
      <MaterialTransferRequestDet>[].obs;
  List ItemListTableModelReadList = <MatTransDetItemListTableModel>[];

  List<MatTransDetItemListTableModel> matTransReqDetTable =
      <MatTransDetItemListTableModel>[];

  List<TextEditingController> Show_Itemlist_stockQtyControllers = [];
  List<TextEditingController> Show_Itemlist_TransQtyController = [];
  List<TextEditingController> Show_Itemlist_DetRemarksController = [];

  itemlistSaveTable(BuildContext context) async {
    ItemListTableModelList.clear();
    int i = 0;
    int j = 0;
    mattransreqItemList.forEach((element) {
      itemlist_textControllersInitiate();
      if (element.check == true) {
        ItemListTableModel = MatTransDetItemListTableModel();
        ItemListTableModel.reqDetId = 0;
        ItemListTableModel.materialId = element.materialId;
        ItemListTableModel.materialName = element.material.toString();
        ItemListTableModel.scale = element.scale.toString();
        ItemListTableModel.stockQty = element.stockQty;
        ItemListTableModel.Qty = 0.0;
        ItemListTableModel.detRemarks = "-";
        ItemGetTableListdata.forEach((element) {
          if (element.materialId == ItemListTableModel.materialId) {
            i = 1;
            BaseUtitiles.showToast("Entries already exist");
          }
        });
        if (i == 0) {
          ItemListTableModelList.add(ItemListTableModel);
        } else {
          i = 0;
        }
      }
      j++;
    });
    var savedatas = await mattransreq_ItemlistService.MatTransReqDet_Save(
        ItemListTableModelList);
    return Navigator.pop(context, savedatas);
  }

  Future getItemlistTablesDatas() async {
    ItemGetTableListdata.value.clear();
    for (final c in Show_Itemlist_TransQtyController) {
      c.dispose();
    }
    Show_Itemlist_TransQtyController.clear();
    var datas = await mattransreq_ItemlistService.MatTransReqDet_readAll();
    datas.forEach((value) {
      ItemListTableModel = MatTransDetItemListTableModel();
      ItemListTableModel.reqDetId = value['reqDetId'];
      ItemListTableModel.materialId = value['materialId'];
      ItemListTableModel.materialName = value['materialName'];
      ItemListTableModel.scale = value['scale'];
      ItemListTableModel.stockQty = value['stockQty'];
      ItemListTableModel.Qty = value['Qty'];
      ItemListTableModel.detRemarks = value['detRemarks'];
      ItemGetTableListdata.add(ItemListTableModel);
    });
    setTextControllersValue();
  }

  itemlist_textControllersInitiate() {
    Show_Itemlist_stockQtyControllers.add(TextEditingController());
    Show_Itemlist_TransQtyController.add(TextEditingController());
    Show_Itemlist_DetRemarksController.add(TextEditingController());
  }

  //Set Value
  setTextControllersValue() async {
    for (var index = 0; index < ItemGetTableListdata.length; index++) {
      itemlist_textControllersInitiate();
      Show_Itemlist_stockQtyControllers[index].text =
          ItemGetTableListdata.value[index].stockQty.toString();
      Show_Itemlist_TransQtyController[index].text =
          ItemGetTableListdata.value[index].Qty.toString();
      Show_Itemlist_DetRemarksController[index].text =
          ItemGetTableListdata.value[index].detRemarks.toString();
    }
  }

  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      itemlist_textControllersInitiate();
      ItemListTableModel = MatTransDetItemListTableModel();
      ItemListTableModel.reqDetId = element.reqDetId;
      ItemListTableModel.materialId = element.materialId;
      ItemListTableModel.materialName = element.materialName.toString();
      ItemListTableModel.scale = element.scale;
      ItemListTableModel.stockQty = element.stockQty;
      ItemListTableModel.Qty =
          double.parse(Show_Itemlist_TransQtyController[i].text);
      ItemListTableModel.detRemarks =
          Show_Itemlist_DetRemarksController[i].text;
      itemListUpdateModelList.add(ItemListTableModel);
      i++;
    });
    await mattransreq_ItemlistService.MatTransReqDet_Update(
        itemListUpdateModelList);
  }

  itemlistTable_Delete() async {
    await mattransreq_ItemlistService.MatTransReqDet_delete();
  }

  //Particular delete
  Future deleteParticularList(MatTransDetItemListTableModel data) async {
    deleteModelList.clear();
    ItemListTableModel = MatTransDetItemListTableModel();
    ItemListTableModel.materialId = data.materialId;
    deleteModelList.add(ItemListTableModel);
    await mattransreq_ItemlistService.MatTransReqDet_deleteById(
        deleteModelList);
  }

  ItemListclickEdit() {
    for (var index = 0; index < ItemGetTableListdata.length; index++) {
      if (double.parse(Show_Itemlist_TransQtyController[index].text) >
          ItemGetTableListdata[index].stockQty) {
        Show_Itemlist_TransQtyController[index].text = "0.0";
        BaseUtitiles.showToast(
            "More than of stock qty not allow to transfer qty");
      }
    }
    updateItemlistTable();
  }

  Future SaveEntryScreen(BuildContext context, int id) async {
    getTransfferbetDetList.value = [];
    await Future.delayed(const Duration(seconds: 0));
    String body = materialTransReqsaveToJson(MaterialTransReqsave(
      id: id != 0 ? id : 0,
      transferNo: autoyrwiseText.text,
      transferEntryDate: entryDateText.text,
      fromProjectId: fromprojectController.selectedProjectId.value,
      fromSiteId: fromsiteController.selectedsiteId.value,
      toProjectId: projectController.selectedProjectIdAll.value,
      remarks: remarksText.text,
      createdBy: int.tryParse(loginController.EmpId()),
      createdDate: BaseUtitiles().convertToUtcIso(entryDateText.text),
      verifyStatus: isVerify ? true : null,
      verifyBy: isVerify ? int.tryParse(loginController.EmpId()) : null,
      verifyDate:
          isVerify ? BaseUtitiles().convertToUtcIso(entryDateText.text) : null,
      approveStatus: isApprove ? true : null,
      approvedBy: isApprove ? int.tryParse(loginController.EmpId()) : null,
      approveDate:
          isApprove ? BaseUtitiles().convertToUtcIso(entryDateText.text) : null,
      materialTransferRequestDets: getTransfferbetDetList.value.length == 0
          ? getDetDetails(id)
          : getTransfferbetDetList.value,
    ));
    final list = await MaterialTransReqProvider.matTransReqSaveApi(
        body, saveButton.value, context);

    if (list != null) {
      if (list["success"] == true) {
        if (saveButton.value == RequestConstant.VERIFY ||
            saveButton.value == RequestConstant.APPROVAL) {
          BaseUtitiles.showToast(list["message"]);
          await pendingListController.getPendingList();
          BaseUtitiles.popMultiple(context, count: 3);
        } else {
          BaseUtitiles.showToast(list["message"]);
          await getListMatTransReq();
          BaseUtitiles.popMultiple(context, count: 3);
        }
      } else {
        BaseUtitiles.showToast(list["message"] ?? "Something went wrong..");
        BaseUtitiles.popMultiple(context, count: 2);
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  List<MaterialTransferRequestDet>? getDetDetails(id) {
    for (int index = 0; index < ItemGetTableListdata.length; index++) {
      var list = MaterialTransferRequestDet(
          id: ItemGetTableListdata[index].reqDetId,
          materialTransferRequestMasId: id != 0 ? id : 0,
          materialId: ItemGetTableListdata[index].materialId,
          qty: ItemGetTableListdata[index].Qty,
          trQty: ItemGetTableListdata[index].Qty,
          remarks: "");
      getTransfferbetDetList.add(list);
    }
    return getTransfferbetDetList.value;
  }

  Future matTransReqEdit(int transId, BuildContext context) async {
    final value = await MaterialTransReqProvider.matTransReqeditAPI(transId);
    if (value != null) {
      if (value.success == true) {
        itemlistTable_Delete();
        mattranReqEditListValue.value = [value.result];
        if (mattranReqEditListValue.isNotEmpty) {
          matTransReqeditSaveDetTable();
          getItemlistTablesDatas();
          return Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MaterialTransReqEntry()));
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

  ///----------Det Table Edit-----------
  Future matTransReqeditSaveDetTable() async {
    matTransReqDetTable.clear();
    mattranReqEditListValue.forEach((element) {
      element.materialTransferRequestDets.forEach((value) {
        ItemListTableModel = MatTransDetItemListTableModel();
        ItemListTableModel.reqDetId = value.id;
        ItemListTableModel.materialId = value.materialId;
        ItemListTableModel.materialName = value.materialName;
        ItemListTableModel.scale = value.scaleName;
        ItemListTableModel.stockQty = value.stockQty;
        ItemListTableModel.Qty = value.qty;
        ItemListTableModel.detRemarks = value.remarks;
        matTransReqDetTable.add(ItemListTableModel);
      });
    });
    var savedatas = await mattransreq_ItemlistService.MatTransReqDet_Save(
        matTransReqDetTable);
    return savedatas;
  }

  ///--------Delete List Record-----

  Future<bool> matTransDeleteList(int transId) async {
    return MaterialTransReqProvider.MatTransReqdeleteAPI(transId);
  }

  ///----------Delete List----------
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
                          Future.delayed(Duration(seconds: 0), () async {
                            bool result = await matTransDeleteList(mainmatTransReqList[index].id);
                            if (result) {
                              itemlistTable_Delete();
                              ItemGetTableListdata.value = [];
                              matTransReqList.removeAt(index);
                              await getListMatTransReq();
                              Navigator.of(context).pop();
                            }
                            else{
                              Navigator.of(context).pop();
                            }
                          });
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
}
