import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import '../commonpopup/material_addqty_alert.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db_model/materiallist_model.dart';
import '../db_services/materiallist_service.dart';
import '../home/menu/materials/mrn_request(indent)/materials_add.dart';
import '../home/menu/materials/mrn_request(indent)/mrnrequest_entry.dart';
import '../home/menu/materials/mrn_request(indent)/mrnrequest_list.dart';
import '../home/pending_list/pending_list.dart';
import '../models/materialintentsave_model.dart';
import '../models/mrnrq_addmat_resmodel.dart';
import '../provider/common_provider.dart';
import '../provider/mrn_request_indent_provider.dart';
import '../sample.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class MRN_Request_Controller extends GetxController {
  final MrnEntrylistFrDate = TextEditingController();
  final MrnEntrylistToDate = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final RemarksController = TextEditingController();
  final RequestDateController = TextEditingController();
  final DuedateController = TextEditingController();
  final preparedbyController = TextEditingController();
  final ReqTypeController = TextEditingController();

  RxString ReqType = "".obs;
  int checklist = 0;
  bool quaCheck = false;
  bool willPop = false;

  late List<Materiallist> materialTableList = <Materiallist>[];
  late List<Materiallist> updateListDatas = <Materiallist>[];
  late List<Materiallist> deleteModelList = <Materiallist>[];
  RxList<MMatReqMasLink> getRequestDetList = <MMatReqMasLink>[].obs;
  RxList<MrnReqAddMaterialResmodel> addmaterialQtylist =
      <MrnReqAddMaterialResmodel>[].obs;

  List<TextEditingController> Itemlist_qtyControllers = [];
  List<TextEditingController> Addwork_materialidControllers = [];
  List<TextEditingController> Addwork_materialnameControllers = [];
  List<TextEditingController> Addwork_scaleControllers = [];
  List<TextEditingController> Addwork_qtyControllers = [];
  List<TextEditingController> Addwork_descControllers = [];
  List<TextEditingController> Addwork_remarksControllers = [];

  RxList list = [].obs;

  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());

  PendingListController pendingListController =
      Get.put(PendingListController());
  SiteController siteController = Get.put(SiteController());
  RxInt selectedMaterialId = 0.obs;
  RxString selectedMaterialName = "".obs;
  RxList Material_itemview_GetDbList = [].obs;
  late List<bool> isChecked;
  RxString saveButton = RequestConstant.SUBMIT.obs;

  RxList getmaterialvalue = [].obs;
  RxList MrnReqEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList StoreList = [].obs;
  RxList Material_EditListApiValue = [].obs;
  RxList pendingAllDatasList = [].obs;
  RxList checkApprovalLevelData = [].obs;
  RxList appTypeList = [].obs;

  late List<bool> check;
  int reqId = 0;

  int checkColor = 0;

  RxBool activeType = false.obs;

  String screenCheck = "";
  var materialTableModel = Materiallist();
  var materiallistService = MateriallistService();

  bool get isSubmit => saveButton.value == RequestConstant.SUBMIT;
  bool get isVerify => saveButton.value == RequestConstant.VERIFY;
  bool get isResubmit => saveButton.value == RequestConstant.RESUBMIT;
  bool get isPreApprove => saveButton.value == RequestConstant.PREAPPROVAL;
  bool get isFinalApprove => saveButton.value == RequestConstant.APPROVAL;



  Future getMrn_Req_EntryList() async {
    mainEtyList.value.clear();
    MrnReqEtyList.value.clear();
    var response = await Mrn_Req_provider.getmrnreqEntry_List(
        MrnEntrylistFrDate.text, MrnEntrylistToDate.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          mainEtyList.assignAll(response.result!);
          MrnReqEtyList.assignAll(response.result!);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future getMaterialList(
      BuildContext context, String requestType, projectId, siteId) async {
    getmaterialvalue.value.clear();
    final value = await CommonProvider.getmaterial(
        requestType == "CP", projectId, siteId);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          getmaterialvalue.value = value.result!;
          return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Materials_Add(
                        list: getmaterialvalue.value,
                      )));
        } else {
          BaseUtitiles.showToast('No Data Found');
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  Future getCheckApprovalLevel() async {
    checkApprovalLevelData.value = [];
    var response = await Mrn_Req_provider.getCheckApprovalLevel();
    if (response != null) {
      if (response["success"] == true) {
        if (response["result"]!.isNotEmpty) {
          checkApprovalLevelData.value = response["result"];
        } else {
          BaseUtitiles.showToast('No Data Found');
        }
      } else {
        BaseUtitiles.showToast(response["message"] ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }


  Future<bool?> CheckmaterialBalQty() async {
    final value = await CommonProvider.checkMaterialBalqty();
    if (value != null) {
      if (value["success"] == true) {
        if (value["result"].isNotEmpty) {
          handleConfig(value["result"][0]);
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


  void handleConfig(Map<String, dynamic> data) {
    if (data["projectWise"] == true) {
      activeType.value = true;
    }
    else if (data["siteIWise"] == true) {
      activeType.value = true;
    }
    else if (data["materialWise"] == true) {
      activeType.value = true;
    }
    else if (data["materialHeadWise"] == true) {
      activeType.value = true;
    }
    else {
      activeType.value = false;
    }
  }

  MaterialItemlistBal_clickEdit(int index) {
    double balQty = double.parse(
        Material_itemview_GetDbList.value[index].balqty.toString());

    double enteredQty = Addwork_qtyControllers[index].value.text.isEmpty
        ? 0
        : double.parse(Addwork_qtyControllers[index].value.text);
    if(ReqType.value == "PO")
    {
      if (enteredQty > balQty) {
        enteredQty = 0;
        Addwork_qtyControllers[index].text = "0.0";
        BaseUtitiles.showToast("More than Bal Qty, Not Allowed");
      }
      else {
      // If none of the above conditions are met, call updateConsumTables()
        updateConsumTables();
      }
    }
    else {
      updateConsumTables();
    }
  }




    Future<void> getAppTypeList() async {
    appTypeList.clear();
    var response = await Mrn_Req_provider.getAppTypeListAPI();
    if (response != null) {
      if (response["success"] == true) {
        if (response["result"]!.isNotEmpty) {
          appTypeList.value.assignAll(response["result"]);
        } else {
          BaseUtitiles.showToast('No Data Found');
        }
      } else {
        BaseUtitiles.showToast(response["message"] ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  setCheck(int id, bool value) {
    getmaterialvalue.forEach((element) {
      if (element.materialId == id) {
        element.isCheck = value;
      }
    });
  }

  serachsetCheck(int id, bool value) {
    list.forEach((element) {
      if (element.materialId == id) {
        element.isCheck = value;
      }
    });
  }

  Material_itemlist_textControllersInitiate() {
    Itemlist_qtyControllers.add(TextEditingController());
    Addwork_qtyControllers.add(TextEditingController());
    Addwork_descControllers.add(TextEditingController());
    Addwork_remarksControllers.add(TextEditingController());
  }

  /// ----- Material add in db -----

  materiallist_Save_DB(BuildContext context) async {
    materialTableList.clear();
    int i = 0;
    int j = 0;
    getmaterialvalue.forEach((element) {
      Material_itemlist_textControllersInitiate();
      if (element.isCheck == true) {
        if (Itemlist_qtyControllers[j].value.text == "0.0" ||
            Itemlist_qtyControllers[j].value.text == "0" ||
            Itemlist_qtyControllers[j].value.text == "") {
        } else {
          materialTableModel = Materiallist();
          materialTableModel.materialid = element.materialId!;
          materialTableModel.material = element.material!;
          materialTableModel.scale = element.scale!;
          materialTableModel.qty = double.parse("0");
          materialTableModel.stockqty = element.stockQty;
          materialTableModel.scaleId = element.scaleId;
          materialTableModel.balqty = element.balqty;
          materialTableModel.reqDetId = 0;
          materialTableModel.remarks = "";
          materialTableModel.desc = "";
          Material_itemview_GetDbList.forEach((element) {
            if (element.materialid == materialTableModel.materialid) {
              i = 1;
              BaseUtitiles.showToast("Entries already exist");
            }
          });
          if (i == 0) {
            materialTableList.add(materialTableModel);
          } else {
            i = 0;
          }
        }
      }
      j++;
    });
    var savedatas =
        await materiallistService.Material_table_Save(materialTableList);
    return Navigator.pop(context, savedatas);
  }

  //Get Values
  Future getMaterialTablesDatas() async {
    Material_itemview_GetDbList.value = [];
    var Matlist = await materiallistService.MaterialItemlist_table_readAll();
    Matlist.forEach((user) {
      var materiallist = Materiallist();
      materiallist.materialid = user['materialid'];
      materiallist.material = user['material'];
      materiallist.scale = user['scale'];
      materiallist.stockqty = user['stockqty'];
      materiallist.qty = user['qty'];
      materiallist.reqQty = user["reqQty"];
      materiallist.balqty = user["balqty"];
      materiallist.scaleId = user['scaleId'];
      materiallist.reqDetId = user['reqDetId'];
      materiallist.remarks = user['remarks'];
      materiallist.desc = user['desc'];
      Material_itemview_GetDbList.add(materiallist);
    });
    setTextControllersValue();
  }

  //Set Value
  setTextControllersValue() async {
    for (var index = 0; index < Material_itemview_GetDbList.length; index++) {
      Material_itemlist_textControllersInitiate();
      Addwork_qtyControllers[index].text =
          Material_itemview_GetDbList.value[index].qty.toString();
      Addwork_remarksControllers[index].text =
          Material_itemview_GetDbList.value[index].remarks.toString();
      Addwork_descControllers[index].text =
          Material_itemview_GetDbList.value[index].desc.toString();
    }
  }

  // qty edit
  MaterialItemlist_clickEdit() {
    for (var index = 0;
        index < Material_itemview_GetDbList.value.length;
        index++) {
      updateConsumTables();
    }
  }

  // qty Update to db
  updateConsumTables() async {
    int i = 0;
    updateListDatas.clear();
    Material_itemview_GetDbList.forEach((element) {
      if (Addwork_qtyControllers[i].value.text == "") {
        materialTableModel = Materiallist();
        materialTableModel.materialid = element.materialid!;
        materialTableModel.material = element.material!;
        materialTableModel.scale = element.scale!;
        materialTableModel.qty = double.parse("0");
        materialTableModel.reqQty = element.reqQty;
        materialTableModel.stockqty = element.stockqty;
        materialTableModel.scaleId = element.scaleId;
        materialTableModel.reqDetId = element.reqDetId;
        materialTableModel.balqty = element.balqty;
        materialTableModel.desc = Addwork_descControllers[i].value.text;
        materialTableModel.remarks = Addwork_remarksControllers[i].value.text;
        updateListDatas.add(materialTableModel);
        i++;
      } else {
        materialTableModel = Materiallist();
        materialTableModel.materialid = element.materialid!;
        materialTableModel.material = element.material!;
        materialTableModel.scale = element.scale!;
        materialTableModel.scaleId = element.scaleId!;
        materialTableModel.reqDetId = element.reqDetId!;
        materialTableModel.qty =
            double.parse(Addwork_qtyControllers[i].value.text);
        materialTableModel.reqQty = element.reqQty;
        materialTableModel.balqty = element.balqty;
        materialTableModel.stockqty = element.stockqty;
        materialTableModel.desc = Addwork_descControllers[i].value.text;
        materialTableModel.remarks = Addwork_remarksControllers[i].value.text;
        updateListDatas.add(materialTableModel);
        i++;
      }
    });
    await materiallistService.MaterialItemlist_table_Update(updateListDatas);
  }

  //Particular delete
  Future deleteParticularList(Materiallist data) async {
    deleteModelList.clear();
    materialTableModel = new Materiallist();
    materialTableModel.materialid = data.materialid;
    deleteModelList.add(materialTableModel);
    await materiallistService.materialdeleteById(deleteModelList);
  }

  delete_MaterialIntent_itemlist_Table() async {
    await materiallistService.MaterialItemlist_table_delete();
  }

  //----- POST and PUT JSON Values----
  Future SaveButton_MaterialIntentScreen(BuildContext context, int id) async {
    getRequestDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = materiasaveResponseToJson(MateriasaveResponse(
      //common
      id: id != 0 ? id : 0,
      reqOrdNo: autoYearWiseNoController.text.trim(),
      reqOrdDate: RequestDateController.text,
      reqdueDate: DuedateController.text,
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      reqRemarks: RemarksController.text,
      requestType: ReqType.value.toString(),
      isEdit: isResubmit ? true :  false,

      //save
      createdBy: isSubmit ? int.parse(loginController.EmpId()) : null,
      createdDt: isSubmit
          ? BaseUtitiles().convertToUtcIso(RequestDateController.text)
          : null,

      //update
      updatedBy: isResubmit ? int.parse(loginController.EmpId()) : null,
      updatedDate: isResubmit
          ? BaseUtitiles().convertToUtcIso(RequestDateController.text)
          : null,

      //verify
      verifyBy: isVerify ? int.parse(loginController.EmpId()) : null,
      verifyDate: isVerify
          ? BaseUtitiles().convertToUtcIso(RequestDateController.text)
          : null,
      verifyStatus: isResubmit ?Material_EditListApiValue[0].verifyStatus:isVerify ? "Y" : "N",
      preApproveStatus: isResubmit ?Material_EditListApiValue[0].preApproveStatus:"N",
      approveStatus: isResubmit ?Material_EditListApiValue[0].approveStatus:"N",

      //det
      mMatReqMasLink: getRequestDetList.value.isEmpty
          ? getRequestDet(id)
          : getRequestDetList.value,
    ));

    final list = await Mrn_Req_provider.SaveMaterialScreenEntryAPI(
        body, id, saveButton.value, context);

    if (list != null) {
      if (list["success"] == true) {
        if (saveButton.value == RequestConstant.VERIFY) {
          BaseUtitiles.showToast(list["message"]);
          await pendingListController.getPendingList();
          BaseUtitiles.popMultiple(context, count: 4);
        } else {
          BaseUtitiles.showToast(list["message"]);
          await getMrn_Req_EntryList();
          delete_MaterialIntent_itemlist_Table();
          Material_itemview_GetDbList.clear();
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

  List<MMatReqMasLink>? getRequestDet(materialReqOrdMasid) {
    getRequestDetList.value.clear();
    Material_itemview_GetDbList.value.forEach((element) {
      if (element.qty > 0) {
        var list = MMatReqMasLink(
          id: element.reqDetId,
          materialReqOrdMasid:
              materialReqOrdMasid != 0 ? materialReqOrdMasid : 0,
          materialId: element.materialid,
          qty: element.qty,
          scaleId: element.scaleId,
          siteId: siteController.selectedsiteId.value,
          reqQty: isSubmit || isResubmit ? element.qty : isVerify ? element.reqQty : element.qty,
          remarks: element.remarks,
          reqDescription: element.desc,
          preApproveStatus: "N",
          approveStatus: "N"
        );
        getRequestDetList.value.add(list);
      }
    });
    return getRequestDetList.value;
  }

  // ---------Edit Call API----------

  Future Material_Intentlist_editSaveDetTable() async {
    materialTableList.clear();
    Material_EditListApiValue.forEach((element) {
      element.requestDet.forEach((val) {
        materialTableModel = Materiallist();
        materialTableModel.materialid = val.matId!;
        materialTableModel.material = val.matName!;
        materialTableModel.scale = val.scale!;
        materialTableModel.qty = val.qty;
        materialTableModel.reqQty = val.reqQty;
        materialTableModel.scaleId = val.scaleId;
        materialTableModel.reqDetId = val.reqDetId;
        materialTableModel.balqty = val.balqty!;
        materialTableModel.stockqty = val.stockqty;
        materialTableModel.remarks = val.detRemarks!;
        materialTableModel.desc = val.detDescription;
        materialTableList.add(materialTableModel);
      });
    });
    var savedatas =
        await materiallistService.Material_table_Save(materialTableList);
    return savedatas;
  }

  Future MaterialIntentList_EditApi(
      int reqId, int pId, int sId, BuildContext context) async {
    final value =
    await Mrn_Req_provider.Material_IntentList_editAPI(reqId);
    if (value != null) {
      if (value.success == true) {
        delete_MaterialIntent_itemlist_Table();
        Material_EditListApiValue.value = [value.result];
        if (Material_EditListApiValue.value.isNotEmpty) {
          Material_Intentlist_editSaveDetTable();
          getMaterialTablesDatas();
          saveButton.value = RequestConstant.RESUBMIT;
          return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MRNRequest_Indent_Entry()));
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

//--Entrylist Delete--

  Future<bool> Material_EntryList_DeleteApi(int reqId) async {
    return Mrn_Req_provider.Material_entryList_deleteAPI(reqId);
  }

  Future getPendingList_Alldatas(int reqId, context) async {
    pendingAllDatasList.value = [];
    final value =
         await Mrn_Req_provider.Material_IntentList_editAPI(reqId);
    if (value != null) {
      if (value.success == true) {
        pendingAllDatasList.value = [value.result];
        if (pendingAllDatasList.value.isNotEmpty) {
          pendingIntentAlldatas_SaveDetTable();
          getMaterialTablesDatas();
          saveButton.value = RequestConstant.VERIFY;
          FocusScope.of(context).unfocus();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MRNRequest_Indent_Entry()));
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

  Future pendingIntentAlldatas_SaveDetTable() async {
    materialTableList.clear();
    pendingAllDatasList.value.forEach((element) {
      element.requestDet.forEach((val) {
        materialTableModel = Materiallist();
        materialTableModel.materialid = val.matId!;
        materialTableModel.material = val.matName!;
        materialTableModel.scale = val.scale!;
        materialTableModel.qty = val.qty!;
        materialTableModel.reqQty = val.reqQty!;
        materialTableModel.scaleId = val.scaleId!;
        materialTableModel.reqDetId = val.reqDetId!;
        materialTableModel.balqty = val.balqty!;
        materialTableModel.remarks = val.detRemarks!;
        materialTableModel.stockqty = val.stockqty!;
        materialTableModel.desc = val.detDescription;
        materialTableList.add(materialTableModel);
      });
    });
    var savedatas =
        await materiallistService.Material_table_Save(materialTableList);
    return savedatas;
  }

  Future DeleteAlert(BuildContext context, int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
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
                          bool result = await Material_EntryList_DeleteApi(
                              MrnReqEtyList.value[index].reqMasId);
                          if (result) {
                            MrnReqEtyList.removeAt(index);
                            Navigator.of(context).pop();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Delete",
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

  addmaterialQty(BuildContext context) {
    Mrn_Req_provider.addmatGetQtyApi().then((value) {
      addmaterialQtylist.value = value;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MaterialAddQtyAlert(list: addmaterialQtylist.value);
          });
    });
  }
}
