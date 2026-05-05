import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:prahkurticore/controller/punch_in_controller.dart';
import '../db_model/inwardpending_itemlist_table_model.dart';
import '../db_services/inwardpending_itemlist_service.dart';
import '../home/menu/materials/inward/inward_Entry.dart';
import '../home/menu/materials/inward/inward_itemlist.dart';
import '../home/menu/materials/inward/inward_list.dart';
import '../models/getting_image_response.dart';
import '../models/image_delete_response.dart';
import '../models/image_payload.dart';
import '../models/inward_pending_alldatasres_model.dart';
import '../models/inward_pending_entrylist_model.dart';
import '../models/inwardimageres_model.dart';
import '../models/inwardpending_save_apireq_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/poamdapproveres_model.dart';
import '../provider/inward_pending_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';
import 'pendinglistcontroller.dart';

int? inwardId;

class ImageState {
  ImageState();
}

class InwardPending_Controller extends GetxController
    with StateMixin<ImageState> {
  PunchInController punchInController = Get.put(PunchInController());

  final InwardAutoyearText = TextEditingController();
  final InwardEntryDateText = TextEditingController();
  final InwardSupplierNameText = TextEditingController();
  final InwardProjectNameText = TextEditingController();
  final InwardSiteNameText = TextEditingController();
  final InwardInvoiceNoText = TextEditingController();
  final InwardInvoiceDateText = TextEditingController();
  final InwardDCNoText = TextEditingController();
  final InwardDCDateText = TextEditingController();
  final InwardManualNoText = TextEditingController();
  final InwardTypeText = TextEditingController();
  final InwardNoText = TextEditingController();
  final InwardVechileNoText = TextEditingController();
  final InwardDriverNameText = TextEditingController();
  final InwardFreightChargesText = TextEditingController();
  final InwardLabourChargesText = TextEditingController();
  final InwardRoundoffText = TextEditingController();
  final InwardNetAmtText = TextEditingController();
  final InwardRemarksText = TextEditingController();

  List<TextEditingController> Itemlist_Inward_QtyListController = [];
  List<TextEditingController> Itemlist_Qty_PlusListController = [];
  List<TextEditingController> Itemlist_Qty_MinusListController = [];
  RxList<InwardDet> getInwardDetList = <InwardDet>[].obs;
  RxList<InwardAmdsaveDetLink> getInwardDetAmedmentList =
      <InwardAmdsaveDetLink>[].obs;

  RxList editListApiDatas = [].obs;

  final InwardEntrylistFrDate = TextEditingController();
  final InwardEntrylistToDate = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  PendingListController pendingListController =
  Get.put(PendingListController());

  late List<InwardPendingItemListTableModel> ItemListTableModelList =
  <InwardPendingItemListTableModel>[];
  var ItemListTableModel = InwardPendingItemListTableModel();
  var inwardPending_ItemlistService = InwardPending_ItemlistService();
  List ItemListTableModelReadList = <InwardPendingItemListTableModel>[];
  late List<InwardPendingItemListTableModel> itemListUpdateModelList =
  <InwardPendingItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  RxList<InwardPendingItemListTableModel> add_PoAmdaprovalListvalue =
      <InwardPendingItemListTableModel>[].obs;

  RxList inwardEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList PoAmdList = [].obs;
  RxList poAmd_mainList = [].obs;
  RxList validatecheck = [].obs;
  RxList<getByIdResult> inwardAllDatasList = <getByIdResult>[].obs;
  RxList<getByIdResult> inwardItemListdatas = <getByIdResult>[].obs;
  RxString base64TypeImage = "".obs;

  List<bool>? ischecked;
  bool save_checked = false;
  RxList<String> gettingNetworkImageList = <String>[].obs;
  RxList<int> imageId = <int>[].obs;
  var imageFiles = <File>[].obs;
  RxBool checkImgList = false.obs;

  RxInt netWorkImageCount = 0.obs;
  RxInt pickedImageCount = 0.obs;
  RxInt count = 0.obs;

  int projectId = 0;
  int siteId = 0;
  int supId = 0;
  int inwardID = 0;

  RxString saveButton = RequestConstant.SUBMIT.obs;

  clearDatas() {
    InwardSupplierNameText.text = "--Select--";
    InwardProjectNameText.text = "--Select--";
    InwardSiteNameText.text = "--Select--";
    projectId = 0;
    siteId = 0;
    supId = 0;
    InwardNoText.text = "";
    InwardInvoiceNoText.text = "";
    InwardDCNoText.text = "";
    InwardManualNoText.text = "";
    InwardVechileNoText.text = "";
    InwardDriverNameText.text = "";
    InwardRemarksText.text = "";
    count.value = 0;
    pickedImageCount.value = 0;
    imageFiles.value = [];
    Zerovalueset(ItemGetTableListdata);
    itemlistTable_Delete();
    ItemGetTableListdata.value.clear();
  }

  Future getInward_EntryList() async {
    inwardEtyList.value.clear();
    mainEtyList.value.clear();
    var response = await Inward_Pending_provider.getInwardEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        InwardEntrylistFrDate.text,
        InwardEntrylistToDate.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          mainEtyList.assignAll(response.result!);
          inwardEtyList.assignAll(response.result!);
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

  // Future getInward_EntryList(BuildContext context) async {
  //   inwardEtyList.value = await Inward_Pending_provider.getInwardEntry_List(loginController.user.value.userId, loginController.UserType(), InwardEntrylistFrDate.text, InwardEntrylistToDate.text);
  //   return inwardEtyList.value;
  // }

  /// ----- Po Amendment List -----

  Future getPo_AmendmentList(BuildContext context, int purOrdId) async {
    PoAmdList.value.clear();
    poAmd_mainList.value.clear();
    var response = await Inward_Pending_provider.getPoAmendment(purOrdId);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          poAmd_mainList.assignAll(response.result!);
          PoAmdList.assignAll(response.result!);
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

  Future getInward_Alldatas(int poId, BuildContext context) async {
    inwardAllDatasList.value = [];
    inwardItemListdatas.value = [];
    final response = await Inward_Pending_provider.getInward_ALLDatas(poId);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          inwardAllDatasList.value = response.result!;
          inwardItemListdatas.addAll(inwardAllDatasList);
          saveButton.value = RequestConstant.SUBMIT;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Inward_entry()));
          FocusScope.of(context).unfocus();
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

  Zerovalueset(List list) {
    int index = 0;
    Itemlist_Inward_QtyListController = [];
    list.forEach((element) {
      itemlist_textControllersInitiate();
      Itemlist_Inward_QtyListController[index].text = "0.0";
      Itemlist_Qty_PlusListController[index].text = "0.0";
      Itemlist_Qty_MinusListController[index].text = "0.0";
      index++;
    });
  }

  editClick(int id) {
    int i = 0;
    ItemGetTableListdata.value.forEach((element) {
      itemlist_textControllersInitiate();
      if (Itemlist_Inward_QtyListController[i].value.text == "" ||
          Itemlist_Inward_QtyListController[i].value.text == "0.0" ||
          Itemlist_Inward_QtyListController[i].value.text == "0") {
        Itemlist_Qty_PlusListController[i].text = "0.0";
        Itemlist_Qty_MinusListController[i].text = "0.0";
      } else {
        Itemlist_Qty_PlusListController[i].text = ItemGetTableListdata[i]
            .balQty <=
            double.parse(
                Itemlist_Inward_QtyListController[i].value.text.toString())
            ? (double.parse(Itemlist_Inward_QtyListController[i]
            .value
            .text
            .toString()) -
            ItemGetTableListdata[i].balQty)
            .toString()
            : Itemlist_Qty_PlusListController[i].text = "0.0";
        Itemlist_Qty_MinusListController[i].text = ItemGetTableListdata[i]
            .balQty >=
            double.parse(
                Itemlist_Inward_QtyListController[i].value.text.toString())
            ? (ItemGetTableListdata[i].balQty -
            double.parse(Itemlist_Inward_QtyListController[i]
                .value
                .text
                .toString()))
            .toString()
            : Itemlist_Qty_MinusListController[i].text = "0.0";
        if (id == element.id) {
          if (ItemGetTableListdata[i].balQty <
              double.parse(
                  Itemlist_Inward_QtyListController[i].value.text.toString())) {
            // ischecked?[i] = true;
          } else if (ItemGetTableListdata[i].balQty >
              double.parse(
                  Itemlist_Inward_QtyListController[i].value.text.toString())) {
            // ischecked?[i] = false;
          }
        }

        // ischecked![i] = ItemGetTableListdata[i].balQty < double.parse(Itemlist_Inward_QtyListController[i].value.text.toString()) ? true : false || ItemGetTableListdata[i].balQty > double.parse(Itemlist_Inward_QtyListController[i].value.text.toString()) ? false : false;

        InwardNetAmtText.text =
            (double.parse(Itemlist_Inward_QtyListController[i].value.text) *
                ItemGetTableListdata[i].rate)
                .toString();
      }
      i++;
    });
    updateItemlistTable();
  }

  itemlist_textControllersInitiate() {
    Itemlist_Inward_QtyListController.add(TextEditingController());
    Itemlist_Qty_PlusListController.add(TextEditingController());
    Itemlist_Qty_MinusListController.add(TextEditingController());
  }

  itemlistTable_Delete() async {
    await inwardPending_ItemlistService.InwardPending_ItemlistTable_delete();
  }

  inwardpending_itemlist_SaveTable() async {
    ItemListTableModelList.clear();
    inwardItemListdatas.value.forEach((element) {
      ItemListTableModel = new InwardPendingItemListTableModel();
      ItemListTableModel.poDetId = element.poDetId;
      ItemListTableModel.materialId = element.materialId;
      ItemListTableModel.scaleId = element.scaleId;
      ItemListTableModel.materialName = element.materialName;
      ItemListTableModel.unit = element.unit;
      ItemListTableModel.poQty = element.poQty;
      ItemListTableModel.balQty = element.balQty;
      ItemListTableModel.rate = element.rate;
      ItemListTableModel.inwQty = 0.0;
      ItemListTableModel.addQty = element.addQty;
      ItemListTableModel.lessQty = element.lessQty;
      ItemListTableModelList.add(ItemListTableModel);
    });
    var savedatas =
    await inwardPending_ItemlistService.InwardPending_ItemlistTable_Save(
        ItemListTableModelList);
    return savedatas;
  }

  Future getItemlistTablesDatas() async {
    var datas = await inwardPending_ItemlistService
        .InwardPending_ItemlistTable_readAll();
    ItemListTableModelReadList = <InwardPendingItemListTableModel>[];
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    datas.forEach((value) {
      ItemListTableModel = new InwardPendingItemListTableModel();
      itemlist_textControllersInitiate();
      ItemListTableModel.id = value['id'];
      ItemListTableModel.poDetId = value['poDetId'];
      ItemListTableModel.materialId = value['materialId'];
      ItemListTableModel.scaleId = value['scaleId'];
      ItemListTableModel.materialName = value['materialName'];
      ItemListTableModel.unit = value['unit'];
      ItemListTableModel.poQty = value['poQty'];
      ItemListTableModel.balQty = value['balQty'];
      ItemListTableModel.rate = value['rate'];
      ItemListTableModel.inwQty = value['inwQty'];
      ItemListTableModel.addQty = value['addQty'];
      ItemListTableModel.lessQty = value['lessQty'];
      ItemListTableModelReadList.add(ItemListTableModel);
      ItemGetTableListdata.value = ItemListTableModelReadList;
    });
    setItemListListTextValue(ItemGetTableListdata.value);
  }

  setItemListListTextValue(vale) {
    int i = 0;
    vale.forEach((datas) {
      itemlist_textControllersInitiate();
      Itemlist_Inward_QtyListController[i].text = datas.inwQty.toString();
      Itemlist_Qty_PlusListController[i].text = datas.addQty.toString();
      Itemlist_Qty_MinusListController[i].text = datas.lessQty.toString();
      i++;
    });
  }

  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      itemlist_textControllersInitiate();
      ItemListTableModel = new InwardPendingItemListTableModel();
      ItemListTableModel.id = element.id;
      ItemListTableModel.poDetId = element.poDetId;
      ItemListTableModel.materialId = element.materialId;
      ItemListTableModel.scaleId = element.scaleId;
      ItemListTableModel.materialName = element.materialName.toString();
      ItemListTableModel.unit = element.unit.toString();
      ItemListTableModel.poQty = element.poQty;
      ItemListTableModel.balQty = element.balQty;
      ItemListTableModel.rate = element.rate;
      ItemListTableModel.inwQty = double.parse(
          Itemlist_Inward_QtyListController[i].text != ""
              ? Itemlist_Inward_QtyListController[i].text
              : "0");
      ItemListTableModel.addQty =
          double.parse(Itemlist_Qty_PlusListController[i].text);
      ItemListTableModel.lessQty =
          double.parse(Itemlist_Qty_MinusListController[i].text);
      itemListUpdateModelList.add(ItemListTableModel);
      i++;
    });
    await inwardPending_ItemlistService.InwardPending_ItemlistTable_Update(
        itemListUpdateModelList);
  }

  // Future Check_InvoiceNoAndDCNo(BuildContext context)async{
  //     Inward_Pending_provider.invoice_DcNoCheck(
  //         InwardAutoyearText.text.trim(),
  //         InwardInvoiceNoText.text.trim(),
  //         InwardDCNoText.text.trim(),
  //         supId.toString(),
  //         inwardID.toString(),).then((value)  {
  //       if (jsonDecode(value.toString())=="0") {
  //         // Navigator.push(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //         builder: (BuildContext context) =>
  //         //             const Inward_Itemlist()));
  //       }
  //       else {
  //         BaseUtitiles.showToast(jsonDecode(value.toString()));
  //       }
  //     });
  // }

  Future Save_EntryScreen(BuildContext context, int id) async {
    await Future.delayed(const Duration(seconds: 0));
    InwardPendingSaveReq formdata = InwardPendingSaveReq(
      id: id != 0 ? id : 0,
      inwardNo: InwardAutoyearText.text,
      entryDate: InwardEntryDateText.text,
      inwType: "P",
      projectID: projectId,
      siteID: siteId,
      supplierID: supId,
      purType: saveButton.value == RequestConstant.RESUBMIT
          ? editListApiDatas[0].purType
          : inwardAllDatasList[0].purchaseType,
      dcNo: InwardDCNoText.text==""?"-":InwardDCNoText.text,
      dcDate: InwardDCDateText.text,
      invoiceNo: InwardInvoiceNoText.text==""?"-":InwardInvoiceNoText.text,
      invoiceDate: InwardInvoiceDateText.text,
      purOrdMasId: saveButton.value == RequestConstant.RESUBMIT
          ? editListApiDatas[0].purOrdMasId
          : inwardAllDatasList[0].purOrdMasId,
      vechileName: InwardVechileNoText.text,
      driverName: InwardDriverNameText.text,
      remarks: InwardRemarksText.text,
      createdBy: int.tryParse(loginController.EmpId()),
      createdDt: BaseUtitiles().convertToUtcIso(InwardEntryDateText.text),
      selectedNo: saveButton.value == RequestConstant.RESUBMIT
          ? editListApiDatas[0].selectedNo
          : inwardAllDatasList[0].purchaseOrdNo,
      inwardDet: getDetDetails(id, context),
    );

    print(jsonEncode(formdata.toJson()));
    final list = await Inward_Pending_provider.inward_Save(formdata, imageFiles, saveButton.value, id);
    if (list != null) {
      if (list["success"] == true) {
        if (id != 0) {
          BaseUtitiles.showToast(list["message"]);
          await getInward_EntryList();
          clearDatas();
          BaseUtitiles.popMultiple(context, count: 3);
        } else {
          BaseUtitiles.showToast(list["message"]);
          await pendingListController.getPendingList();
          clearDatas();
          BaseUtitiles.popMultiple(context, count: 4);
        }
      } else {
        BaseUtitiles.popMultiple(context, count: 1);
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 1);
    }
  }

  List<InwardDet>? getDetDetails(id, context) {
    getInwardDetList.value = [];

    for (int i = 0; i < ItemGetTableListdata.length; i++) {
      final element = ItemGetTableListdata[i];

      if (element.inwQty > 0) {
        var list = InwardDet(
            id: saveButton.value == RequestConstant.RESUBMIT
                ? (i < editListApiDatas.length
                ? editListApiDatas[i].inwardDetId
                : 0)
                : 0,
            materialInwardMasID: id != 0 ? id : 0,
            purOrdDetId: element.poDetId,
            materialID: element.materialId,
            scaleID: element.scaleId,
            qty: element.inwQty,
            rate: element.rate,
            amount: 0,
            balQty: element.balQty,
            addQty: element.addQty,
            lessQty: element.lessQty,
            AMDCheck: element.addQty > 0.0
                ? "Y".toString().trim()
                : "N".toString().trim());

        getInwardDetList.add(list);
      }
    }

    return getInwardDetList;
  }

  /// ------PoApproval Approval API--------------

  Future PoAmendment_ApprovalButtonsave(
      BuildContext context, purOrdMasId, projectId, siteId, inwType) async {
    await Future.delayed(const Duration(seconds: 0));
    String body = poAmendmentApproveResModelToJson(PoAmendmentApproveResModel(
      purOrdOId: purOrdMasId,
      woOrdId: 0,
      amdDate: punchInController.currentDates,
      projectId: projectId,
      siteId: siteId,
      amdType: "Q",
      inwardType: inwType,
      inwardAmdsaveDetLink: getDetDetailsAmendment(),
    ));
    var list =
    await Inward_Pending_provider.inward_PoAmendment_ApprovalAPI(body);
    if (list != null) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      BaseUtitiles.showToast(list);
    }
  }

  //--------Po Amendment InwardDet List-----------

  List<InwardAmdsaveDetLink>? getDetDetailsAmendment() {
    getInwardDetAmedmentList.value = [];
    PoAmdList.value.forEach((element) {
      if (element.isCheck == true) {
        var list = new InwardAmdsaveDetLink(
          purDetId: element.purOrdDetId,
          workOrdDetId: 0,
          materialid: element.MaterialId,
          scaleid: element.UnitId,
          addQty: 0,
          lessQty: element.balqty,
        );
        getInwardDetAmedmentList.add(list);
      }
    });
    return getInwardDetAmedmentList.value;
  }

  setCheck(int id, bool value) {
    PoAmdList.forEach((element) {
      if (element.MaterialId == id) {
        element.isCheck = value;
      }
    });
  }

  Future EntryList_EditApi(
      int workid, String type, BuildContext context) async {
    editListApiDatas.value = [];
    await Inward_Pending_provider.entryList_editAPI(workid, type)
        .then((value) async {
      if (value != null) {
        if (value.success == true) {
          editListApiDatas.value = value.result!;
          saveButton.value = RequestConstant.RESUBMIT;
          EditTable_SaveTable();
          getItemlistTablesDatas();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Inward_entry()));
        } else {
          BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
        }
      } else {
        BaseUtitiles.showToast('Something went wrong..');
      }
    });
  }

  Future<bool> InwardStatusCheckApi(int? inwardId) async {
    final value = await Inward_Pending_provider.InwardStatusCheckApi(inwardId!);
    if (value != null) {
      if (value["success"] == false) {
        BaseUtitiles.showToast(value["message"]);
        return false;
      } else {
        return true;
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
      return false;
    }
  }

  EditTable_SaveTable() async {
    ItemListTableModelList.clear();
    editListApiDatas.value.forEach((value) {
      ItemListTableModel = new InwardPendingItemListTableModel();
      ItemListTableModel.materialId = value.materialId;
      ItemListTableModel.scaleId = value.scaleId;
      ItemListTableModel.materialName = value.materialName.toString();
      ItemListTableModel.poDetId = value.id;
      ItemListTableModel.unit = value.unit.toString();
      ItemListTableModel.poQty = value.poQty;
      ItemListTableModel.balQty = value.balqty;
      ItemListTableModel.rate = value.rate;
      ItemListTableModel.inwQty = value.inwardQty;
      ItemListTableModel.addQty = value.inwardADDQty;
      ItemListTableModel.lessQty = value.inwardLessQty;
      ItemListTableModelList.add(ItemListTableModel);
    });
    var savedatas =
    await inwardPending_ItemlistService.InwardPending_ItemlistTable_Save(
        ItemListTableModelList);
    return savedatas;
  }

  Future<bool> EntryList_DeleteApi(int InwId) async {
    return Inward_Pending_provider.entryList_deleteAPI(InwId);
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
                    color: Colors.grey.shade400,
                    //color of divider
                    width: 5,
                    //width space of divider
                    thickness: 2,
                    //thickness of divier line
                    indent: 15,
                    //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        bool result = await EntryList_DeleteApi(inwardEtyList.value[index].id);
                        if (result) {
                          itemlistTable_Delete();
                          ItemGetTableListdata.value=[];
                          inwardEtyList.value.removeAt(index);
                          update();
                          await getInward_EntryList();
                          Navigator.of(context).pop();
                        }else{
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Delete",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Getting image.....

  Future<void> gettingImage() async {
    netWorkImageCount.value = 0;
    gettingNetworkImageList.clear();
    imageId.clear();
    final value = await Inward_Pending_provider.gettingImageProvider(inwardId!,"inward");
    if (value != null) {
      checkImgList.value = true;
      netWorkImageCount.value = value.length;
      for (int i = 0; i < value!.length; i++) {
        gettingNetworkImageList.add(value[i].url.toString());
        imageId.add(value[i].id);
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  /// Delete image.....

  Future<bool> deletingImage(int imageId) async {
    return await Inward_Pending_provider.deleteImageProvider(imageId,"inward");
  }
}
