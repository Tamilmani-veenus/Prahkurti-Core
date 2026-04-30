import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/controller/pendinglistcontroller.dart';
import 'package:prahkurticore/controller/projectcontroller.dart';
import 'package:prahkurticore/controller/sitecontroller.dart';
import '../db_model/materiallist_model.dart';
import '../db_services/materiallist_service.dart';
import '../home/menu/materials/mrn_request(indent)/mrnrequest_entry.dart';
import '../home/menu/materials/mrn_request(indent)/mrnrequest_list.dart';
import '../home/menu/materials/mrn_request(preIndent)/mrnreq_preindent_entry.dart';
import '../home/menu/materials/mrn_request(preIndent)/mrnreq_preindent_list.dart';
import '../home/menu/materials/mrn_request(preIndent)/mrnreq_preindent_materialsadd.dart';
import '../home/pending_list/pending_list.dart';
import '../models/materialintentsave_model.dart';
import '../models/materialreqpreindentsave_model.dart';
import '../models/mrnrq_addmat_resmodel.dart';
import '../provider/common_provider.dart';
import '../provider/mrnreq_preindent_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class MRNRequest_PreIndent_Controller extends GetxController{

  final MrnReqPreIndent_FrDate = TextEditingController();
  final MrnReqPreIndent_ToDate = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final RequestDateController = TextEditingController();
  final DuedateController=TextEditingController();
  final preparedbyController=TextEditingController();
  final RemarksController=TextEditingController();
  final ReqTypeController = TextEditingController();


  RxList MrnReqPreIndentList = [].obs;
  RxList mainEtyList = [].obs;
  RxList getmaterialvalue=[].obs;
  RxList list=[].obs;
  RxList Material_itemview_GetDbList = [].obs;
  RxList Material_EditListApiValue=[].obs;
  RxList pendingAllDatasList = [].obs;

  int reqId=0;
  int entrycheck = 0;

  int editCheck = 0;
  int checkColor = 0;
  int addMaterialControl = 0;


  RxString ReqType = "".obs;
  String screenCheck="";
  RxString selectedMaterialName = "".obs;
  RxString saveButton=RequestConstant.SUBMIT.obs;
  var materialTableModel = Materiallist();
  var materiallistService = MateriallistService();


  bool get isSubmit => saveButton.value == RequestConstant.SUBMIT;
  bool get isVerify => saveButton.value == RequestConstant.VERIFY;
  bool get isResubmit => saveButton.value == RequestConstant.RESUBMIT;
  bool get isApprove => saveButton.value == RequestConstant.APPROVAL;

  late List<bool> isChecked;
  late List<Materiallist> materialTableList = <Materiallist>[];
  late List<Materiallist> updateListDatas = <Materiallist>[];
  late List<Materiallist> deleteModelList = <Materiallist>[];
  RxList<MMatReqMasLink> getRequestDetList = <MMatReqMasLink>[].obs;
  RxList<MrnReqAddMaterialResmodel> addmaterialQtylist = <MrnReqAddMaterialResmodel>[].obs;

  List<TextEditingController> Itemlist_qtyControllers = [];

  List<TextEditingController> Addwork_materialidControllers = [];
  List<TextEditingController> Addwork_materialnameControllers = [];
  List<TextEditingController> Addwork_scaleControllers = [];
  List<TextEditingController> Addwork_qtyControllers = [];
  List<TextEditingController> Addwork_descControllers = [];
  List<TextEditingController> Addwork_remarksControllers = [];

  LoginController loginController = Get.put(LoginController());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  PendingListController pendingListController=Get.put(PendingListController());


  //------MRNReq PreIndent List-----------------

  Future getMrnReq_PreIndent_EntryList() async {
    mainEtyList.value.clear();
    MrnReqPreIndentList.value.clear();
    var response = await MRNRequest_PreIndent_Provider.getMRNReqPreIndent_EntryList(
        MrnReqPreIndent_FrDate.text, MrnReqPreIndent_ToDate.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          mainEtyList.assignAll(response.result!);
          MrnReqPreIndentList.assignAll(response.result!);
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



  Future getPendingList_Alldatas(int reqId, context, Url) async {
    pendingAllDatasList.value = [];
    final value =
     await MRNRequest_PreIndent_Provider.Material_PreIntentList_editAPI(reqId);
    if (value != null) {
      if (value.success == true) {
        pendingAllDatasList.value = [value.result];
        if (pendingAllDatasList.value.isNotEmpty) {
          pendingIntentAlldatas_SaveDetTable();
          getMaterialTablesDatas();
          if(Url == "Verify")
          {
            saveButton.value = RequestConstant.VERIFY;
          }
          else
          {
            saveButton.value = RequestConstant.APPROVAL;
          }
          FocusScope.of(context).unfocus();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MRNRequest_PreIndent_EntryScreen()));
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


  //-------------Add Items--------

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
                  builder: (context) => MRNRequest_PreIndent_MAterialsAdd(
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

  // Future getMaterialList(BuildContext context, int pId, int sId,requestType,type) async {
  //   getmaterialvalue.value.clear();
  //   return Navigator.push(context, MaterialPageRoute(builder: (context) => MRNRequest_PreIndent_MAterialsAdd(list:  getmaterialvalue.value,)));
  // }

  setCheck(int id,bool value){
    addMaterialControl=1;
    getmaterialvalue.forEach((element) {
      if(element.materialId==id){
        element.isCheck = value;
      }
    });
  }

  serachsetCheck(int id,bool value){
    list.forEach((element) {
      if(element.materialId==id){
        element.isCheck = value;
      }
    });
  }
  setSelectedMaterialListName(int? id) {
    if (getmaterialvalue.value != null) {
      getmaterialvalue.value.forEach((element) {
        if (id == element.materialName) {
          selectedMaterialName(element.materialName.toString());
        }
      });
    }
  }

  Material_itemlist_textControllersInitiate() {
    Itemlist_qtyControllers.add(new TextEditingController());
    Addwork_qtyControllers.add(new TextEditingController());
    Addwork_descControllers.add(new TextEditingController());
    Addwork_remarksControllers.add(new TextEditingController());
  }

  // ----Material add in db
  materiallist_Save_DB(BuildContext context) async {
    materialTableList.clear();
    int i = 0;
    int j =0;
    int itemcount = 0;
    getmaterialvalue.forEach((element) {
      Material_itemlist_textControllersInitiate();
      if(element.isCheck==true){
        if (Itemlist_qtyControllers[j].value.text == "0.0" ||
            Itemlist_qtyControllers[j].value.text == "0" ||
            Itemlist_qtyControllers[j].value.text == "") {
        }
        if(double.parse(Itemlist_qtyControllers[j].value.text)< 0){
        }
        else if(ReqType.value == "PO")
        {
          if(element.balqty<=0.0){
            itemcount = itemcount+1;
          }
          else {
            materialTableModel = Materiallist();
            materialTableModel.materialid = element.materialId!;
            materialTableModel.material = element.material!;
            materialTableModel.scale = element.scale!;
            materialTableModel.scaleId = element.scaleId;
            materialTableModel.reqDetId = 0;
            materialTableModel.qty = double.parse(Itemlist_qtyControllers[j].value.text);
            materialTableModel.balqty = element.balqty;
            materialTableModel.remarks = "";
            materialTableModel.desc = "";

            Material_itemview_GetDbList.forEach((element2) {
              if (element2.materialid == materialTableModel.materialid) {
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

        else {
          materialTableModel =new Materiallist();
          materialTableModel.materialid = element.materialId!;
          materialTableModel.material = element.material!;
          materialTableModel.scale = element.scale!;
          materialTableModel.scaleId = element.scaleId;
          materialTableModel.qty = double.parse("0");
          materialTableModel.reqDetId = 0;
          materialTableModel.balqty = element.balqty;
          materialTableModel.remarks="";
          materialTableModel.desc="";
          Material_itemview_GetDbList.forEach((element) {
            if (element.materialid == materialTableModel.materialid) {
              i = 1;
              BaseUtitiles.showToast("Entries already exist");
            }
          });
          if (i == 0) {
            materialTableList.add(materialTableModel);
          }
          else{
            i=0;
          }
        }
      }
      j++;
    });
    var savedatas = await materiallistService.Material_table_Save(materialTableList);
    if(itemcount>0){
      BaseUtitiles.showToast(itemcount.toString() + " Materials doesn't have a balqty");
    }
    return Navigator.pop(context, savedatas);
  }

  //Get Values
  Future getMaterialTablesDatas() async {
    Material_itemview_GetDbList.clear();
    var Matlist = await materiallistService.MaterialItemlist_table_readAll();
    Matlist.forEach((user) {
      var materiallist =Materiallist();
      materiallist.materialid = user['materialid'];
      materiallist.material = user['material'];
      materiallist.scale = user['scale'];
      materiallist.scaleId = user['scaleId'];
      materiallist.reqDetId = user['reqDetId'];
      materiallist.qty = user['qty'];
      materiallist.balqty = user['balqty'];
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
      Addwork_qtyControllers[index].text = Material_itemview_GetDbList.value[index].qty.toString();
      Addwork_remarksControllers[index].text=Material_itemview_GetDbList.value[index].remarks.toString();
      Addwork_descControllers[index].text=Material_itemview_GetDbList.value[index].desc.toString();
    }
  }

  // qty edit
  // MaterialItemlist_clickEdit() {
  //   for (var index = 0; index < Material_itemview_GetDbList.value.length; index++) {
  //     if (Addwork_qtyControllers[index].value.text == "0" ||Addwork_qtyControllers[index].value.text == "0.0") {
  //       // Addwork_qtyControllers[index].text=Material_itemview_GetDbList.value[index].qty.toString();
  //       BaseUtitiles.showToast("Zero value is not allowed");
  //     } else {
  //       updateConsumTables();
  //     }
  //   }
  // }

  MaterialItemlist_clickEdits() {
    for (var index = 0; index < Material_itemview_GetDbList.value.length; index++) {
      double balQty = double.parse(Material_itemview_GetDbList.value[index].balqty.toString());
      double enteredQty = 0;
      if(Addwork_qtyControllers[index].value.text == ""){
        enteredQty = 0;
      }
      else{
        enteredQty = double.parse(Addwork_qtyControllers[index].value.text);
      }
      if(ReqType.value == "PO")
      {
        if (balQty < enteredQty) {
          // Display a message and clear the text if balQty is less than enteredQty
          BaseUtitiles.showToast("More than Bal Qty, Not Allowed");
          enteredQty = 0;
          Addwork_qtyControllers[index].text = "0";
        }
      }

      else {
        // If none of the above conditions are met, call updateConsumTables()
        updateConsumTables();
      }
    }
  }

  MaterialItemlist_clickEdit() {

    bool isValid = true;

    for (int index = 0; index < Material_itemview_GetDbList.value.length; index++) {

      double balQty = double.parse(
          Material_itemview_GetDbList.value[index].balqty.toString());

      double enteredQty = Addwork_qtyControllers[index].value.text.isEmpty
          ? 0
          : double.parse(Addwork_qtyControllers[index].value.text);

      if (ReqType.value == "PO") {

        if (enteredQty > balQty) {

          BaseUtitiles.showToast("Entered qty greater than Balance qty");

          Addwork_qtyControllers[index].text = "0";

          isValid = false;
          break;
        }
      }
    }

    /// will execute if all qty are valid OR ReqType is not PO
    if (isValid) {
      updateConsumTables();
    }
  }



  // qty Update to db
  updateConsumTables() async {
    int i = 0;
    updateListDatas.clear();
    Material_itemview_GetDbList.forEach((element) {
      if(Addwork_qtyControllers[i].value.text == ""){
        materialTableModel =new Materiallist();
        materialTableModel.materialid = element.materialid!;
        materialTableModel.material = element.material!;
        materialTableModel.scale = element.scale!;
        materialTableModel.scaleId = element.scaleId;
        materialTableModel.reqDetId = element.reqDetId;
        materialTableModel.qty = 0;
        materialTableModel.balqty = element.balqty;
        materialTableModel.desc=Addwork_descControllers[i].value.text;
        materialTableModel.remarks=Addwork_remarksControllers[i].value.text;
        updateListDatas.add(materialTableModel);
        i++;
      }
      else{
        materialTableModel =new Materiallist();
        materialTableModel.materialid = element.materialid!;
        materialTableModel.material = element.material!;
        materialTableModel.scale = element.scale!;
        materialTableModel.scaleId = element.scaleId!;
        materialTableModel.reqDetId = element.reqDetId!;
        materialTableModel.qty = double.parse(Addwork_qtyControllers[i].value.text);
        // materialTableModel.balqty = element.balqty;
        materialTableModel.desc=Addwork_descControllers[i].value.text;
        materialTableModel.remarks=Addwork_remarksControllers[i].value.text;
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
  Future SaveButton_MaterialIntentScreen(BuildContext context, int id ) async {
    getRequestDetList.value.clear();
    await Future.delayed(const Duration(seconds:0));
    String body = materiasaveResponseToJson(MateriasaveResponse(
      id: id != 0 ? id : 0,
      reqOrdNo: autoYearWiseNoController.text.trim(),
      reqOrdDate: RequestDateController.text,
      reqdueDate: DuedateController.text,
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      reqRemarks: RemarksController.text,
      //SAVE
      createdBy: isSubmit ? int.parse(loginController.EmpId()) : null,
      createdDt: isSubmit
          ? BaseUtitiles().convertToUtcIso(RequestDateController.text)
          : null,
      //EDIT
      updatedBy: isResubmit ? int.parse(loginController.EmpId()) : null,
      updatedDate: isResubmit
          ? BaseUtitiles().convertToUtcIso(RequestDateController.text)
          : null,
      isEdit: isResubmit ? true : isVerify ? false : isApprove ? false : null,

      //VERIFICATION
      verifyBy: isVerify ? int.parse(loginController.EmpId()) : null,
      verifyDate: isVerify
          ? BaseUtitiles().convertToUtcIso(RequestDateController.text)
          : null,
      verifyStatus: isVerify ? "Y" : null,
      preApproveBy: isApprove ? int.parse(loginController.EmpId()) : null,
      preApproveDate: isApprove ? BaseUtitiles().convertToUtcIso(RequestDateController.text) : null,
      preApproveStatus: isApprove ? "Y" : null,
      approveStatus: isApprove ? "Y" : null,

      requestType: ReqType.value.toString(),

      mMatReqMasLink: getRequestDetList.value.isEmpty
          ? getRequestDet(id)
          : getRequestDetList.value,
    ));
    final list = await MRNRequest_PreIndent_Provider.SaveMaterialPreIndentEntryAPII(body, id, saveButton.value, context);
    if (list != null) {
      if (list["success"] == true) {
        if (saveButton.value == RequestConstant.VERIFY) {
          BaseUtitiles.showToast(list["message"]);
          await pendingListController.getPendingList();
          BaseUtitiles.popMultiple(context, count: 4);
        } else {
          BaseUtitiles.showToast(list["message"]);
          await getMrnReq_PreIndent_EntryList();
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
          materialReqOrdMasid: materialReqOrdMasid != 0 ? materialReqOrdMasid : 0,
          materialId: element.materialid,
          qty: element.qty,
          scaleId: element.scaleId,
          siteId: siteController.selectedsiteId.value,
          reqQty: element.qty,
          remarks: element.remarks,
          reqDescription: element.desc,
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
        materialTableModel =new Materiallist();
        materialTableModel.materialid = val.matId!;
        materialTableModel.material = val.matName!;
        materialTableModel.scale = val.scale!;
        materialTableModel.scaleId = val.scaleId;
        materialTableModel.reqDetId = val.reqDetId;
        materialTableModel.qty = val.qty!;
        materialTableModel.balqty = val.balqty!;
        materialTableModel.remarks = val.detRemarks!;
        materialTableModel.desc = val.detDescription;
        materialTableList.add(materialTableModel);
      });
    });
    var savedatas = await materiallistService.Material_table_Save(materialTableList);
    return  savedatas;
  }

  Future MaterialPreIntentList_EditApi(
      int reqId, int pId, int sId, BuildContext context) async {
    final value =
    await MRNRequest_PreIndent_Provider.Material_PreIntentList_editAPI(reqId);
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
                  builder: (context) => const MRNRequest_PreIndent_EntryScreen()));
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
    return  MRNRequest_PreIndent_Provider.Material_entryList_deleteAPI(reqId);
  }

  Future pendingIntentAlldatas_SaveDetTable() async {
    materialTableList.clear();
    pendingAllDatasList.value.forEach((element) {
      element.requestDet.forEach((val) {
        materialTableModel =new Materiallist();
        materialTableModel.materialid = val.matId!;
        materialTableModel.material = val.matName!;
        materialTableModel.scale = val.scale!;
        materialTableModel.scaleId = val.scaleId!;
        materialTableModel.reqDetId = val.reqDetId!;
        materialTableModel.qty = val.qty!;
        materialTableModel.balqty = val.balqty!;
        materialTableModel.remarks = val.detRemarks!;
        materialTableModel.desc = val.detDescription;
        materialTableList.add(materialTableModel);
      });
    });
    var savedatas = await materiallistService.Material_table_Save(materialTableList);
    return  savedatas;
  }

  Future DeleteAlert(BuildContext context,int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.white,
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
                          entrycheck=0;
                          editCheck=0;
                          bool request = await Material_EntryList_DeleteApi(MrnReqPreIndentList.value[index].reqMasId);
                          if (request) {
                            MrnReqPreIndentList.removeAt(index);
                            Navigator.of(context).pop();
                          }else{
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