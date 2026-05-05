import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../commonpopup/mrnfinalApprovalfrmproject_alert.dart';
import '../db_model/materialapprlist_model.dart';
import '../db_services/materialapprlist_service.dart';
import '../home/pending_list/mrnfinal_aproval/mrnfinal_entryscreen.dart';
import '../models/materialintentsave_model.dart';
import '../models/mrnfinalapproval_aproveapiresmodel.dart';
import '../models/project_name_response.dart';
import '../provider/common_provider.dart';
import '../provider/mrn_request_indent_provider.dart';
import '../provider/mrnfinalapproval_provider.dart';
import '../provider/pendinglist_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';
import 'mrn_request_indent_controller.dart';

class MrnFinalApprovalController extends GetxController{


  final RequestNoText = TextEditingController();
  final RequestDateText = TextEditingController();
  final DueDateText = TextEditingController();
  final ApprovalNoText = TextEditingController();
  final ApprovalDateText = TextEditingController();
  final ReqremarksText = TextEditingController();
  final ApprovalremarksText = TextEditingController();
  final ApprovedbyText = TextEditingController();
  final VerifiedbyText = TextEditingController();
  final PreparedbyText = TextEditingController();

  int preparedById = 0;
  int entrycheck=0;
  int reqId=0;
  int checkColor=0;
  String screenCheck="";
  RxList mrngetdropDownvalue=[].obs;
  List mainlist = [];
  RxList mrnProjectDropdownName=[].obs;

  LoginController loginController=Get.put(LoginController());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  PendingListController pendingListController=Get.put(PendingListController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());


  List<TextEditingController> BalQty_ListController = [];
  List<TextEditingController> ReqQty_ListController = [];
  List<TextEditingController> ApprQty_ListController = [];
  List<TextEditingController> Approval_ListController = [];
  List<TextEditingController> TransfrProject_ListController = [];
  List<TextEditingController> Description_ListController = [];
  List<TextEditingController> Remarks_ListController = [];
  List<TextEditingController> projectId = [];

  RxList<MMatReqMasLink> getsaveDetList = <MMatReqMasLink>[].obs;
  RxList mrnfinalAppDetList = [].obs;
  String? approvalType;
  List projectName = [];


  /// ----- Getting project name -----

  late List<Materialapprlist> materialFinalApprTableList = <Materialapprlist>[];
  late List<Materialapprlist> finalapprupdateTableListDatas = <Materialapprlist>[];
  var materialFinalapprlistTableModel = Materialapprlist();
  var materialFinalapprlistService = MaterialapprlistService();
  RxList MaterialFinalAppr_itemview_GetDbList = [].obs;


  Future gettingProjectName(int reqMasId,int matId,int proId,BuildContext context) async {
    final value = await MrnFinalApprovalProvider.projectNameProvider("MRN Final Approve",proId);
    if (value != null) {
      if(value.success == true)
      {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MrnFinalAprFrProjectAlert(list:value.result!,data: reqMasId);
            });
      }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  itemlist_textControllersInitiate() {
    BalQty_ListController.add(TextEditingController());
    ReqQty_ListController.add(TextEditingController());
    ApprQty_ListController.add(TextEditingController());
    Approval_ListController.add(TextEditingController());
    TransfrProject_ListController.add(TextEditingController());
    Description_ListController.add(TextEditingController());
    Remarks_ListController.add(TextEditingController());
    projectId.add(TextEditingController());
  }


  //-------------Itemlist save in DB----------------

  finalapp_malerialitemlist_save_DB(BuildContext context){
    materialFinalApprTableList.clear();
    var result = mrnfinalAppDetList.value.first;
    result.mMatReqMasLink?.forEach((element) {
      itemlist_textControllersInitiate();
      materialFinalapprlistTableModel =  Materialapprlist();
      materialFinalapprlistTableModel.reqDetId = element.reqMasDetId;
      materialFinalapprlistTableModel.materialid = element.materialid;
      materialFinalapprlistTableModel.tranfromprjid = element.refProjectId.toString();
      materialFinalapprlistTableModel.materialname = element.material.toString();
      materialFinalapprlistTableModel.tranfromprjname =element.refProjectName=="_"? "--SELECT--":element.refProjectName;
      materialFinalapprlistTableModel.scale = element.scale.toString();
      materialFinalapprlistTableModel.scaleId = element.scaleId;
      materialFinalapprlistTableModel.balqty = element.balQty;
      materialFinalapprlistTableModel.appqty = element.qty;
      materialFinalapprlistTableModel.reqqty = element.reqQty;
      materialFinalapprlistTableModel.apptype = element.apptype.toString()=="N"||element.apptype.toString()=="null"?"P":element.apptype;
      materialFinalapprlistTableModel.remarks = element.remarks;
      materialFinalapprlistTableModel.desc = element.description;
      materialFinalApprTableList.add(materialFinalapprlistTableModel);
    });
    var saveData =  materialFinalapprlistService.MaterialApproval_table_Save(materialFinalApprTableList);
    // Navigator.pop(context, saveData);
    return saveData ;//
  }


  /// ------------ Get itemlist from local DB ---------------

  getFinalApp_MaterialsItemlist_TableDatas() async {
    MaterialFinalAppr_itemview_GetDbList.value = [];
    var MatAppList = await materialFinalapprlistService.Material_ApprovalItemlist_table_readAll();
    MatAppList.forEach((getdatas){
      var materialapprlist =  Materialapprlist();
      materialapprlist.reqDetId = getdatas['reqDetId'];
      materialapprlist.materialid = getdatas['materialid'];
      materialapprlist.tranfromprjid = getdatas['tranfromprjid'];
      materialapprlist.materialname = getdatas['materialname'];
      materialapprlist.tranfromprjname = getdatas['tranfromprjname'];
      materialapprlist.scale =  getdatas['scale'];
      materialapprlist.scaleId = getdatas['scaleId'];
      materialapprlist.balqty = getdatas['balqty'];
      materialapprlist.appqty = getdatas['appqty'];
      materialapprlist.reqqty = getdatas['reqqty'];
      materialapprlist.apptype = getdatas['apptype'];
      materialapprlist.remarks = getdatas['remarks'];
      materialapprlist.desc = getdatas['desc'];
      MaterialFinalAppr_itemview_GetDbList.add(materialapprlist);
    });
    setTextControllersValue();
  }


  /// -----  Set Value -----

  setTextControllersValue() async {
    for (var index = 0; index < MaterialFinalAppr_itemview_GetDbList.length; index++) {
      itemlist_textControllersInitiate();
      BalQty_ListController[index].text = MaterialFinalAppr_itemview_GetDbList.value[index].balqty.toString();
      ReqQty_ListController[index].text = MaterialFinalAppr_itemview_GetDbList.value[index].reqqty.toString();
      ApprQty_ListController[index].text = MaterialFinalAppr_itemview_GetDbList.value[index].appqty.toString();
      Approval_ListController[index].text = MaterialFinalAppr_itemview_GetDbList.value[index].apptype;
      TransfrProject_ListController[index].text = MaterialFinalAppr_itemview_GetDbList.value[index].tranfromprjname =="_"?"--SELECT--":MaterialFinalAppr_itemview_GetDbList.value[index].tranfromprjname;
      projectId[index].text = MaterialFinalAppr_itemview_GetDbList.value[index].tranfromprjid.toString();
      Description_ListController[index].text=MaterialFinalAppr_itemview_GetDbList.value[index].desc.toString();
      Remarks_ListController[index].text=MaterialFinalAppr_itemview_GetDbList.value[index].remarks.toString();
    }
  }

  MaterialItemlistBal_clickEdit(int index) {
    double balQty = double.parse(
        MaterialFinalAppr_itemview_GetDbList.value[index].balqty.toString());

    double enteredQty = ApprQty_ListController[index].value.text.isEmpty
        ? 0
        : double.parse(ApprQty_ListController[index].value.text);
    if(mrn_request_controller.ReqType.value == "PO")
    {
      if (enteredQty > balQty) {
        enteredQty = 0;
        ApprQty_ListController[index].text = "0.0";
        BaseUtitiles.showToast("More than Bal Qty, Not Allowed");
      }
      else {
        // If none of the above conditions are met, call updateConsumTables()
        finalApproval_updateConsumTables();
      }
    }
    else {
      finalApproval_updateConsumTables();
    }
  }


  finalApproval_updateConsumTables() async {
    int i = 0;
    finalapprupdateTableListDatas.clear();
    MaterialFinalAppr_itemview_GetDbList.forEach((element) {
      if(ApprQty_ListController[i].value.text == ""){
        materialFinalapprlistTableModel = new Materialapprlist();
        materialFinalapprlistTableModel.reqDetId = element.reqDetId;
        materialFinalapprlistTableModel.materialid = element.materialid;
        materialFinalapprlistTableModel.tranfromprjid = projectId[i].text;
        materialFinalapprlistTableModel.materialname = element.materialname.toString();
        materialFinalapprlistTableModel.tranfromprjname = TransfrProject_ListController[i].text;
        materialFinalapprlistTableModel.scale =  element.scale;
        materialFinalapprlistTableModel.scaleId = element.scaleId;
        materialFinalapprlistTableModel.balqty = element.balqty;
        materialFinalapprlistTableModel.appqty = 0;
        materialFinalapprlistTableModel.reqqty = element.reqqty;
        materialFinalapprlistTableModel.apptype = Approval_ListController[i].text;
        materialFinalapprlistTableModel.remarks = Remarks_ListController[i].text;
        materialFinalapprlistTableModel.desc = Description_ListController[i].text;
        finalapprupdateTableListDatas.add(materialFinalapprlistTableModel);
        i++;
      }
      else{
        materialFinalapprlistTableModel = Materialapprlist();
        materialFinalapprlistTableModel.reqDetId = element.reqDetId;
        materialFinalapprlistTableModel.materialid = element.materialid;
        materialFinalapprlistTableModel.tranfromprjid = projectId[i].text;
        materialFinalapprlistTableModel.materialname = element.materialname.toString();
        materialFinalapprlistTableModel.tranfromprjname = TransfrProject_ListController[i].text;
        materialFinalapprlistTableModel.scale =  element.scale;
        materialFinalapprlistTableModel.scaleId = element.scaleId;
        materialFinalapprlistTableModel.balqty = element.balqty;
        materialFinalapprlistTableModel.reqqty = element.reqqty;
        materialFinalapprlistTableModel.appqty = double.parse(ApprQty_ListController[i].value.text);
        materialFinalapprlistTableModel.apptype = Approval_ListController[i].text;
        materialFinalapprlistTableModel.remarks = Remarks_ListController[i].text;
        materialFinalapprlistTableModel.desc = Description_ListController[i].text;
        finalapprupdateTableListDatas.add(materialFinalapprlistTableModel);

        i++;
      }
    });
    await materialFinalapprlistService.Material_ApprovalItemlist_table_Update(finalapprupdateTableListDatas);
  }


  //----delete Table data------

  deleteMaterial_FinalApprvalTable() async {
    await materialFinalapprlistService.Material_ApprovalItemlist_table_delete();
  }



  //------------MRN Final Approval List--------------
  Future mrnFinalapprovalDetListApi(int ReqMasId, BuildContext context) async {
    mrnfinalAppDetList.value.clear();
    final value = await PendingListProvider.getMrnFinalApproval(ReqMasId);
    if (value != null ) {
      if(value.success == true)
      {
        mrnfinalAppDetList.value = [value.result];
        if(mrnfinalAppDetList.value.isNotEmpty)
        {
          await finalapp_malerialitemlist_save_DB(context);
          await getFinalApp_MaterialsItemlist_TableDatas();
          await mrn_request_controller.getCheckApprovalLevel();
          mrn_request_controller.saveButton.value = RequestConstant.APPROVAL;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MrnfinalEntryScreen()));
        }
        else {
          BaseUtitiles.showToast("No Data Found");
        }
      }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else{
      BaseUtitiles.showToast("Something went wrong..");
    }
  }


  Future ApproveAPI(BuildContext context) async {
    getsaveDetList.value=[];
    await Future.delayed(const Duration(seconds:0));
    String body = materiasaveResponseToJson(MateriasaveResponse(
        id:reqId,
        reqOrdNo:RequestNoText.text,
        reqOrdDate:RequestDateText.text,
        reqdueDate:DueDateText.text,
        projectId:projectController.selectedProjectId.value,
        siteId:siteController.selectedsiteId.value,
        reqRemarks:ReqremarksText.text,
        requestType: mrn_request_controller.ReqType.value.toString(),
        approvedBy: int.parse(loginController.EmpId()),
        verifyStatus: "Y",
        preApproveStatus: "Y",
        approveStatus: "Y",
        approveDate: BaseUtitiles().convertToUtcIso(RequestDateText.text) ,
        approveRemarks: ApprovalremarksText.text,
        mMatReqMasLink: attendanceListDet(reqId)
    ));
    final list = await Mrn_Req_provider.SaveMaterialScreenEntryAPI(
        body, reqId, mrn_request_controller.saveButton.value, context);
    if (list != null) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        await pendingListController.getPendingList();
        BaseUtitiles.popMultiple(context, count: 4);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    }else{
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }



  List<MMatReqMasLink>? attendanceListDet(reqId) {
    getsaveDetList.value=[];
    MaterialFinalAppr_itemview_GetDbList.value.forEach((element) {
      itemlist_textControllersInitiate();
      if (element.reqqty > 0) {
        var list = MMatReqMasLink(
          id: element.reqDetId,
          materialReqOrdMasid: reqId,
          materialId: element.materialid,
          qty: element.appqty,
          scaleId: element.scaleId,
          siteId: siteController.selectedsiteId.value,
          reqQty: element.reqqty,
          remarks: element.remarks,
          reqDescription: element.desc,
          refProjectId:int.tryParse(element.tranfromprjid),
          approveType:element.apptype,
          preApproveStatus: "Y",
          approveStatus: "Y",
        );
        getsaveDetList.value.add(list);
      }
    });
    return getsaveDetList.value;
  }
}