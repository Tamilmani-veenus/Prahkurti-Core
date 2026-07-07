import 'dart:convert';

import 'package:prahkurticore/controller/pendinglistcontroller.dart';

import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../home/menu/main_menu/boq_revised/boq_additems.dart';
import '../home/menu/main_menu/boq_revised/boq_approval_det.dart';
import '../home/menu/main_menu/boq_revised/boq_revised_entry.dart';
import '../home/menu/main_menu/boq_revised/boq_revised_entrylist.dart';
import '../provider/boq_revised_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db_model/boqreviseditemlist_model.dart';
import '../db_services/boqreviseditemlist_service.dart';
import '../models/boqrevisedsaverequest_model.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';
import '../models/boqrevised_itemlist_model.dart';

class Boq_Revised_Controller extends GetxController {
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  LoginController loginController = Get.put(LoginController());
  PendingListController pendingListController = Get.put(PendingListController());
  final boq_autoYearWiseNoController = TextEditingController();
  final boq_dateController = TextEditingController();
  final boq_remarksController = TextEditingController();
  final boq_preparedbyController = TextEditingController();
  final entryList_frdateController = TextEditingController();
  final entryList_todateController = TextEditingController();
  RxList Boq_entryList = [].obs;
  RxList main_entryList = [].obs;
  RxList approvalGetByIdList = [].obs;
  RxList<Result> Boq_ItemList = <Result>[].obs;
  RxList<Result> Boq_MainItemList = <Result>[].obs;
  TextEditingController qtyController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  late List<bool> isChecked;

  var itemTableModel = BoqItemlist();
  var boqItemlistService = BoqItemlistService();
  RxList BoqRevised_EditListApiValue = [].obs;
  RxString saveButton = RequestConstant.SUBMIT.obs;

  List<TextEditingController> Itemlist_qtyControllers = [];
  List<TextEditingController> Itemlist_AmountControllers = [];
  List<TextEditingController> Itemlist_rateControllers = [];

  List<TextEditingController> Addwork_qtyControllers = [];
  List<TextEditingController> Addwork_rateControllers = [];
  List<TextEditingController> Addwork_AmountControllers = [];

  late List<BoqItemlist> boqitemTableList = <BoqItemlist>[];
  late List<BoqItemlist> updateListDatas = <BoqItemlist>[];
  late List<BoqItemlist> deleteModelList = <BoqItemlist>[];
  RxList<BoqReviseDet> getBoqDetList = <BoqReviseDet>[].obs;
  RxList<BoqReviseDet> getBoqApproveDetList = <BoqReviseDet>[].obs;
  RxList Boqitem_itemview_GetDbList = [].obs;
  int reviseId = 0;

  clearDatas() {
    reviseId = 0;
    saveButton.value = RequestConstant.SUBMIT;
    delete_BoqRevised_itemlist_Table();
    Boqitem_itemview_GetDbList.clear();
    projectController.projectname.text = RequestConstant.SELECT;
    projectController.selectedProjectId.value = 0;
    siteController.selectedsiteId.value = 0;
    siteController.Sitename.text = RequestConstant.SELECT;
    siteController.headNameController.text = RequestConstant.SELECT;
    siteController.selectedHeadId.value=0;
    boq_preparedbyController.text = loginController.UserName();
    boq_dateController.text = BaseUtitiles.initiateCurrentDateFormat();
    boq_remarksController.text = "-";
  }

  Item_itemlist_textControllersInitiate() {
    Itemlist_qtyControllers.add(TextEditingController());
    Itemlist_AmountControllers.add(TextEditingController());
    Addwork_qtyControllers.add(TextEditingController());
    Addwork_AmountControllers.add(TextEditingController());
  }

  Future getBOQEntryList() async {
    main_entryList.value=[];
    Boq_entryList.value=[];
    var response = await BoqRevised_Provider.get_boq_EntryList(
        entryList_frdateController.text,
        entryList_todateController.text);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          main_entryList.assignAll(response.result!);
          Boq_entryList.assignAll(response.result!);
        }
        else {
          BaseUtitiles.showToast("No Data Found");
        }
      }  else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future getApprovedGetByIdList(id,context) async {
    approvalGetByIdList.value=[];
    var response = await BoqRevised_Provider.getApprovalDetList(id);
    if (response != null) {
      if (response.success == true) {
        approvalGetByIdList.value = [response.result];
        if(approvalGetByIdList.isNotEmpty) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> BOQ_Approve_Det_List(
            entryNo: approvalGetByIdList[0].reviseNo,
            entryDate: approvalGetByIdList[0].reviseDate,
            projectName: approvalGetByIdList[0].projectName,
            siteName: approvalGetByIdList[0].siteName,
          )));
        }
        else {
          BaseUtitiles.showToast("No Data Found");
        }
      }  else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  //---------Item List--------

  Future getItemList(BuildContext context) async {
    Boq_MainItemList.value = [];
    Boq_ItemList.value = [];

    var response = await BoqRevised_Provider.getRevisedItemlist(
      reviseId,
      projectController.selectedProjectId.value,
      siteController.selectedsiteId.value,
      siteController.selectedHeadId.value,
    );

    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {

          bool hasLevel3Items = response.result!.any(
                (headItem) => headItem.subItems?.any(
                  (subItem) => subItem.level3Items?.isNotEmpty == true,
            ) == true,
          );

          if (!hasLevel3Items) {
            BaseUtitiles.showToast("No Record Found");
            return;
          }

          Boq_ItemList.value = response.result!;
          Boq_MainItemList.value = response.result!;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Boq_AddItems(),
            ),
          );
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

  calculatelist() {
    for (var index = 0; index < Boqitem_itemview_GetDbList.length; index++) {
      if (Addwork_qtyControllers[index].value.text == "0") {
        Addwork_qtyControllers[index].text = "1.0";
        BaseUtitiles.showToast("Zero is not allowed please change the value");
      } else {
        Addwork_AmountControllers[index].text =
            (
                Boqitem_itemview_GetDbList[index].rate *
                    double.parse(
                        Addwork_qtyControllers[index].text.isNotEmpty
                            ? Addwork_qtyControllers[index].text
                            : "0"
                    )
            ).toStringAsFixed(2);
        updateConsumTables();
      }
    }
  }

  // ----Itemlist add in db
  boqitemlist_Save_DB(BuildContext context) async {
    boqitemTableList.clear();
    int j = 0;
    for (var mainItem in Boq_MainItemList) {
      for (var subItem in mainItem.subItems ?? []) {
        for (var level3 in subItem.level3Items ?? []) {
          if (level3.isCheck == true) {
            if (Itemlist_qtyControllers[j].text == "0.0" ||
                Itemlist_qtyControllers[j].text == "0" ||
                Itemlist_qtyControllers[j].text.isEmpty) {
            } else {
              itemTableModel = new BoqItemlist();
              itemTableModel.reqDetId = 0;
              itemTableModel.measureHeadItemId = mainItem.measureHeadItemId;
              itemTableModel.measureSubItemId = subItem.measureSubItemId;
              itemTableModel.measureLevel3ItemId = level3.level3ItemId;
              itemTableModel.level3ItemName = level3.name;
              itemTableModel.scaleId = level3.unit;
              itemTableModel.scaleName = level3.scaleName;
              itemTableModel.rate = level3.rate;
              itemTableModel.qty = 1.0;
              itemTableModel.reviseQty = level3.qty;
              itemTableModel.amt = itemTableModel.rate! * itemTableModel.qty!;
              int i = 0;
              Boqitem_itemview_GetDbList.forEach((element) {
                if (element.measureLevel3ItemId == itemTableModel.measureLevel3ItemId) {
                  i = 1;
                }
              });

              if (i == 0) {
                boqitemTableList.add(itemTableModel);
              }
              else{
                BaseUtitiles.showToast("Entry already exist");
              }
            }
          }
          j++;
        }
      }
    }
    var savedatas = await boqItemlistService.BoqItem_table_Save(boqitemTableList);
    return Navigator.pop(context, savedatas);
  }

  //qty Update to db
  updateConsumTables() async {
    int i = 0;
    updateListDatas.clear();
    Boqitem_itemview_GetDbList.forEach((element) {
      itemTableModel = new BoqItemlist();
      itemTableModel.reqDetId = element.reqDetId;
      itemTableModel.measureHeadItemId = element.measureHeadItemId;
      itemTableModel.measureSubItemId = element.measureSubItemId;
      itemTableModel.measureLevel3ItemId = element.measureLevel3ItemId;
      itemTableModel.level3ItemName = element.level3ItemName;
      itemTableModel.scaleId = element.scaleId;
      itemTableModel.scaleName = element.scaleName;
      itemTableModel.rate = element.rate;
      itemTableModel.qty = double.tryParse(Addwork_qtyControllers[i].text)??0;
      itemTableModel.reviseQty = element.reviseQty;
      itemTableModel.amt = double.tryParse(Addwork_AmountControllers[i].text)??0;
      updateListDatas.add(itemTableModel);
      i++;
    });
    await boqItemlistService.BoqItemlist_table_Update(updateListDatas);
  }

  //Get Values

  Future getItemTablesDatas() async {
    Boqitem_itemview_GetDbList.clear();
    var Itemlist = await boqItemlistService.BoqItemlist_table_readAll();

    Itemlist.forEach((user) {
      var boqitemlist = BoqItemlist();
      boqitemlist.reqDetId = user['reqDetId'];
      boqitemlist.measureHeadItemId = user['measureHeadItemId'];
      boqitemlist.measureSubItemId = user['measureSubItemId'];
      boqitemlist.measureLevel3ItemId = user['measureLevel3ItemId'];
      boqitemlist.level3ItemName = user['level3ItemName'];
      boqitemlist.scaleId = user['scaleId'];
      boqitemlist.scaleName = user['scaleName'];
      boqitemlist.rate = user['rate'];
      boqitemlist.qty = user['qty'];
      boqitemlist.reviseQty = user['reviseQty'];
      boqitemlist.amt = user['amt'];
      Boqitem_itemview_GetDbList.add(boqitemlist);
    });
    setTextControllersValue();
  }

  //Set Value
  setTextControllersValue() async {
    for (var index = 0; index < Boqitem_itemview_GetDbList.length; index++) {
      Item_itemlist_textControllersInitiate();

      Addwork_qtyControllers[index].text =
          Boqitem_itemview_GetDbList.value[index].qty.toString();

      Addwork_AmountControllers[index].text =
          Boqitem_itemview_GetDbList.value[index].amt.toString();
    }
  }

  //Particular delete
  Future deleteParticularList(BoqItemlist data) async {
    deleteModelList.clear();
    itemTableModel = new BoqItemlist();
    itemTableModel.measureLevel3ItemId = data.measureLevel3ItemId;
    deleteModelList.add(itemTableModel);
    await boqItemlistService.itemdeleteById(deleteModelList);
  }

  delete_BoqRevised_itemlist_Table() async {
    await boqItemlistService.BoqItemlist_table_delete();
  }

  Future SaveButton_BoqRevisedScreen(BuildContext context, int id) async {
    String body = boqRevisedSaveRequestToJson(BoqRevisedSaveRequest(
      id: id,
      reviseNo: boq_autoYearWiseNoController.text,
      reviseDate: boq_dateController.text,
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      remarks: boq_remarksController.text,
      measureHeadItemId: siteController.selectedHeadId.value,
      createdBy: int.tryParse(loginController.EmpId()),
      createdDt: BaseUtitiles().convertToUtcIso(boq_dateController.text),
      boqReviseDets: getBoqDet(id),
    ));

    final list = await BoqRevised_Provider.SaveBoqRevisedScreenEntryAPI(body, id, saveButton.value);
    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        await getBOQEntryList();
        clearDatas();
        BaseUtitiles.popMultiple(context, count: 3);
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

  List<BoqReviseDet>? getBoqDet(id) {
    getBoqDetList.value=[];
    for (var element in Boqitem_itemview_GetDbList) {
      getBoqDetList.add(BoqReviseDet(
        id: element.reqDetId,
        boqReviseMasId: id,
        measureHeadItemId: element.measureHeadItemId,
        measureSubItemId: element.measureSubItemId,
        measureLevel3ItemId: element.measureLevel3ItemId,
        scaleId: element.scaleId,
        rate: element.rate,
        qty: element.qty,
        remarks: "-",
        reviseQty: element.reviseQty,
          approveStatus: "N",
          approvedBy: int.tryParse(loginController.EmpId()),
          boQcode: "0"
      )
      );
    }
    return getBoqDetList;
  }

  Future ApproveBoqRevisedScreen(BuildContext context, data) async {
    String body = boqRevisedSaveRequestToJson(BoqRevisedSaveRequest(
      id: data.id,
      reviseNo: data.reviseNo,
      reviseDate: data.reviseDate,
      projectId: data.projectId,
      siteId: data.siteId,
      remarks: data.remarks,
      measureHeadItemId: data.measureHeadItemId,
      createdBy: data.createdBy,
      createdDt: data.createdDt,
      boqReviseDets: getBoqApproveDet(data.boqReviseDets),
    ));
    final decodedJson = jsonDecode(body);

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(decodedJson);

    debugPrint(prettyJson, wrapWidth: 1024);

    final list = await BoqRevised_Provider.SaveBoqRevisedScreenEntryAPI(body, data.id, "Approve");
    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        await pendingListController.getPendingList();
        clearDatas();
        BaseUtitiles.popMultiple(context, count: 3);
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

  List<BoqReviseDet>? getBoqApproveDet(data) {
    getBoqApproveDetList.value=[];
    for (var element in data) {
      if (element.isCheck == true) {
        getBoqApproveDetList.add(BoqReviseDet(
            id: element.id,
            boqReviseMasId: element.boqReviseMasId,
            measureHeadItemId: element.measureHeadItemId,
            measureSubItemId: element.measureSubItemId,
            measureLevel3ItemId: element.measureLevel3ItemId,
            scaleId: element.scaleId,
            rate: element.rate,
            qty: double.tryParse(element.qtyController.text),
            remarks: element.remarksController.text ==""? "-" : element.remarksController.text,
            reviseQty: element.reviseQty,
            approveStatus: "Y",
            approvedBy: int.tryParse(loginController.EmpId()),
            boQcode: element.boQcode
        )
        );
      }
    }
    return getBoqApproveDetList;
  }


  // ---------Edit Call API----------

  Future BoqRevised_list_editSaveDetTable() async {
    boqitemTableList.clear();
    BoqRevised_EditListApiValue.forEach((element) {
      element.boqReviseDets.forEach((val) {
        itemTableModel = new BoqItemlist();
        itemTableModel.reqDetId = val.id;
        itemTableModel.measureHeadItemId = val.measureHeadItemId;
        itemTableModel.measureSubItemId = val.measureSubItemId;
        itemTableModel.measureLevel3ItemId = val.measureLevel3ItemId;
        itemTableModel.level3ItemName = val.itemDescription;
        itemTableModel.scaleId = val.scaleId;
        itemTableModel.scaleName = val.scaleName;
        itemTableModel.rate = val.rate;
        itemTableModel.qty = val.qty;
        itemTableModel.reviseQty = val.reviseQty;
        itemTableModel.amt = val.rate * val.qty;
        boqitemTableList.add(itemTableModel);
      });
    });
    var savedatas =
        await boqItemlistService.BoqItem_table_Save(boqitemTableList);
    return savedatas;
  }

  Future BoqrevisedList_EditApi(int reviseId,String MenuName, BuildContext context,status) async {
    BoqRevised_EditListApiValue.value=[];
    var response = await BoqRevised_Provider.Boq_RevisedList_editAPI(reviseId,status);
    if (response != null) {
      if (response.success == true) {
          BoqRevised_EditListApiValue.value = [response.result!];
          if(BoqRevised_EditListApiValue.isNotEmpty) {
          saveButton.value = RequestConstant.RESUBMIT;
          BoqRevised_list_editSaveDetTable();
          getItemTablesDatas();
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Boq_Revised_EntryScreen(heading: MenuName,)),
          );
        }
        else {
          BaseUtitiles.showToast("No Data Found");
        }
      }  else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  //--Entrylist Delete--
  Future Boq_EntryList_DeleteApi(int Revise_Id) async {
    return BoqRevised_Provider.BoqRevised_entryList_deleteAPI(Revise_Id);
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
                          bool result = await Boq_EntryList_DeleteApi(Boq_entryList[index].id);
                          if (result) {
                            Boq_entryList.removeAt(index);
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

  setCheck(int mainIndex, int subIndex, int id, bool value,) {
    Boq_MainItemList[mainIndex]
        .subItems?[subIndex]
        .level3Items
        ?.forEach((element) {

      if (element.level3ItemId == id) {
        element.isCheck = value;
      }
    });
  }

  setCheckApproval(int id, bool value) {
    approvalGetByIdList[0].boqReviseDets.forEach((element) {
      if (element.id == id) {
        element.isCheck = value;
      }
    });
  }

}
