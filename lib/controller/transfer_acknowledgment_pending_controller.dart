import 'dart:ffi';

import '../app_theme/app_colors.dart';
import '../controller/logincontroller.dart';
import '../controller/pendinglistcontroller.dart';
import '../db_services/transfer_ackdet_service.dart';
import '../home/pending_list/transferacknowledgement_pendinglist/transferacknow_entrylistscreen.dart';
import '../home/pending_list/transferacknowledgement_pendinglist/transferacknow_entryscreen.dart';
import '../provider/pendinglist_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db_model/transfer_ackdet_tablemodel.dart';
import '../models/transfer_ackentryscreen_savereqapi.dart';
import '../provider/common_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'fromsite_controller.dart';

class TransferAcknowledgmentPendingController extends GetxController{
  final entryDateController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final aknowldge_numberController = TextEditingController();
  final fromProjectController = TextEditingController();
  final toprojectController = TextEditingController();
  final transNoController = TextEditingController();

  final entrylist_fromDate = TextEditingController();
  final entrylist_toDate = TextEditingController();

  LoginController loginController=Get.put(LoginController());
  PendingListController pendingListController=Get.put(PendingListController());
  FromSiteController fromsiteController = Get.put(FromSiteController());

  List<TextEditingController> transferQtyListController = [];
  List<TextEditingController> ackQtyListController = [];
  List<TextEditingController> detremarksListController = [];

  RxInt frProjectID =0.obs;
  RxInt transferId =0.obs;
  int toProjectId=0;
  int ackno=0;
  RxString saveButton=RequestConstant.SUBMIT.obs;

  RxList transferAlldatas=[].obs;
  RxList entrylistDatas=[].obs;
  RxList mainentrylist=[].obs;
  RxList editlistDatas=[].obs;
  RxList<MaterialtransferDetDto> getTransferDetList = <MaterialtransferDetDto>[].obs;


  List transferAckDetReadList = <TransferAckDetTableModel>[];
  RxList readListdata = [].obs;
  late List<TransferAckDetTableModel> deleteModelList = <TransferAckDetTableModel>[];
  late List<TransferAckDetTableModel> transferDetModelList = <TransferAckDetTableModel>[];
  late List<TransferAckDetTableModel> UpdateModelList = <TransferAckDetTableModel>[];
  var transferAckDetService = TransferAck_DetService();
  var transferAckDetModel = TransferAckDetTableModel();

  //--------------Ack site Name------------

  final searchcontroller = TextEditingController();


  Future getEntryList() async {
    mainentrylist.value.clear();
    entrylistDatas.value.clear();
    await PendingListProvider.gettransferACk_Entry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        entrylist_fromDate.text,
        entrylist_toDate.text).then((value) async {
      if (value != null && value.length > 0) {
        mainentrylist.value = value;
        entrylistDatas.value = mainentrylist.value;
        return mainentrylist.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }



  Future tranAckAlldatasApi(int transferId, BuildContext context) async {
    var value = await PendingListProvider.TransferAcknowPendingAPI(transferId);

    if (value != null ) {
      if(value.success == true ){
        if(value.result!.isNotEmpty){
      transferAlldatas.value = value.result!;
      saveButton.value = RequestConstant.SUBMIT;

      await SaveDetTable();
      await getDetTablesDatas();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TransferAcknow_EntryScreen(),
        ),
      );
        }else{
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  deleteDetTableDatas() async {
    await transferAckDetService.TransferAck_Dettable_delete();
  }

  Future SaveDetTable() async {
    transferDetModelList.clear();
    transferAlldatas.forEach((val) {
        transferAckDetModel = TransferAckDetTableModel();
        //  subContDetModel.id = val.lbrCatId;
        transferAckDetModel.transferDetId = val.detid;
        transferAckDetModel.materialId = val.materialId;
        transferAckDetModel.materialName = val.materialName.toString();
        transferAckDetModel.scale = val.scaleName;
        transferAckDetModel.transQty = val.transQty;
        transferAckDetModel.ackQty = 0.0;
        transferAckDetModel.detRemarks=val.ackRemarks.toString();
        transferDetModelList.add(transferAckDetModel);
    });
    var savedatas = await transferAckDetService.TransferAck_DetTable_Save(transferDetModelList);
    return  savedatas;
  }

  Future getDetTablesDatas() async {
    for (final c in ackQtyListController) {
      c.dispose();
    }
    ackQtyListController.clear();
    transferAckDetReadList=[];
    readListdata.value=[];
    var datas = await transferAckDetService.TransferAck_DetTable_readAll();
    transferAckDetReadList = <TransferAckDetTableModel>[];
    datas.forEach((user) {
      transferAckDetModel = TransferAckDetTableModel();
     transferAckDetModel.transferDetId = user['transferDetId'];
     transferAckDetModel.materialId = user['materialId'];
     transferAckDetModel.materialName = user['materialName'];
     transferAckDetModel.scale = user['scale'];
     transferAckDetModel.transQty = user['transQty'];
     transferAckDetModel.ackQty = user['ackQty'];
     transferAckDetModel.detRemarks = user['detRemarks'];
      transferAckDetReadList.add(transferAckDetModel);
      readListdata.value = transferAckDetReadList;
    });
    setTextControllersValue();

  }

  setTextControllersValue() async {
    for (var index = 0; index < readListdata.length; index++) {
      textControllersInitiate();
      transferQtyListController[index].text = readListdata[index].transQty.toString();
      ackQtyListController[index].text = readListdata[index].ackQty.toString();
      detremarksListController[index].text = readListdata[index].detRemarks.toString();
    }
  }

  clickEdit() {
    int i=0;
    readListdata.value.forEach((element) {
      textControllersInitiate();
      if(element.transQty >= double.parse(ackQtyListController[i].text)) {

      } else{
        ackQtyListController[i].text='0.0';
        BaseUtitiles.showToast("Can't accept more than of transfer qty");
      }
      i++;
    });
    updateDetTable();
  }

  updateDetTable() async {
    UpdateModelList.clear();
    for (var n = 0; n < readListdata.length; n++) {
      textControllersInitiate();
      transferAckDetModel = TransferAckDetTableModel();
      transferAckDetModel.transferDetId = readListdata[n].transferDetId;
      transferAckDetModel.materialId = readListdata[n].materialId;
      transferAckDetModel.materialName = readListdata[n].materialName.toString();
      transferAckDetModel.scale = readListdata[n].scale.toString();
      transferAckDetModel.transQty = readListdata[n].transQty;
      transferAckDetModel.ackQty = double.parse(ackQtyListController[n].text != "" ? ackQtyListController[n].text : "0");
      transferAckDetModel.detRemarks=detremarksListController[n].text;
      UpdateModelList.add(transferAckDetModel);
    }
    await transferAckDetService.TransferAck_DetTable_Update(UpdateModelList);

  }

  textControllersInitiate() {
    transferQtyListController.add(TextEditingController());
    ackQtyListController.add(TextEditingController());
    detremarksListController.add(TextEditingController());
  }

  Future Save_EntryScreen(BuildContext context,int transferId) async {
    getTransferDetList.value.clear();
    await Future.delayed(const Duration(seconds:0));
    String body = transferAckSaveReqToJson(TransferAckSaveReq(
      id: 0,
      acknowledgeNo: autoYearWiseNoController.text,
      entryDate: entryDateController.text,
      transferId: transferId,
      fromProjectId: frProjectID.value,
      toProjectId: toProjectId,
      toSiteId: fromsiteController.selectedsiteId.value,
      createdBy: int.tryParse(loginController.EmpId()),
      createdDt: BaseUtitiles().convertToUtcIso(entryDateController.text),
      transferNo: transNoController.text,
      remarks: "",
      materialtransferDetDto: getTransferDetList.value.isEmpty ? getDetDetails(transferId): getTransferDetList.value,
    ));
     final list = await PendingListProvider.transferACk_SaveApi(body);
    if (list != null) {
      if(list["success"] == true){
      BaseUtitiles.showToast(list["message"]);
      BaseUtitiles.popMultiple(context, count: 3);
      await pendingListController.getPendingList();
   }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 3);
    }
  }

  List<MaterialtransferDetDto>? getDetDetails(transferId) {
    for (int index = 0; index < readListdata.length; index++) {
        var list = MaterialtransferDetDto(
          id: readListdata[index].transferDetId,
          materialTransferMasId: transferId,
          materialId: readListdata[index].materialId,
          qty: readListdata[index].ackQty,
          ackRemarks: readListdata[index].detRemarks,
          ackQty: readListdata[index].ackQty,
          ackDiffStatus: ""
        );
        getTransferDetList.add(list);
    }
    return getTransferDetList.value;
  }


  // Future EntryList_EditApi(int ackId,int transferID,BuildContext context) async {
  //   await PendingListProvider.entryList_editAPI(ackId,transferID).then((value) async {
  //     if (value != null && value.length > 0) {
  //       editlistDatas.value = value;
  //       EditTable_SaveTable();
  //       getDetTablesDatas();
  //       return Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => TransferacknowEntryList()),
  //       );
  //     }
  //   });
  // }

  Future EntryList_DeleteApi(int transId,String ackNo,String transNo) async {
    await PendingListProvider.entryList_deleteAPI(transId,ackNo,transNo,loginController.UserId(),BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  EditTable_SaveTable() async {
    transferDetModelList.clear();
    editlistDatas.forEach((element) {
      element.transferAckEditDet.forEach((val) {
        transferAckDetModel = new TransferAckDetTableModel();
        //  subContDetModel.id = val.lbrCatId;
        transferAckDetModel.transferDetId = val.transferDetId;
        transferAckDetModel.materialId = val.materialId;
        transferAckDetModel.materialName = val.materialName.toString();
        transferAckDetModel.scale = val.scale.toString().toString();
        transferAckDetModel.transQty = val.transQty;
        transferAckDetModel.ackQty=val.ackQty.toDouble();
        transferDetModelList.add(transferAckDetModel);
      });
    });
    var savedatas = await transferAckDetService.TransferAck_DetTable_Save(transferDetModelList);
    return  savedatas;
  }


  String ButtonChanges(int id){
    if(id!=0)
        return saveButton.value=RequestConstant.RESUBMIT;
    else
      return saveButton.value=RequestConstant.SUBMIT;
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
                          EntryList_DeleteApi(entrylistDatas[index].transferId,entrylistDatas[index].ackNo,entrylistDatas[index].transferNo);
                          entrylistDatas.removeAt(index);
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),


          // ElevatedButton(
          //   onPressed: () => Navigator.of(context).pop(),
          //   child:Text('No'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     entrycheck=0;
          //     editcheck=0;
          //    EntryList_DeleteApi(entrylistDatas[index].transferId,entrylistDatas[index].ackNo,entrylistDatas[index].transferNo);
          //    entrylistDatas.removeAt(index);
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),
        ],
      ),
    );
  }


}