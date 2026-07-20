

import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';

import '../app_theme/app_colors.dart';
import '../controller/logincontroller.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/dprItemListTable_model.dart';
import '../db_services/dprItemlist_service.dart';

import '../home/menu/daily_entries/daily_wrk_done_dpr/addwrk_click_popup.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr/daily_work_done_dpr.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr/daily_wrkdone_dpr_entry.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr/daily_wrkdone_dpr_entrylist.dart';
import '../home/pending_list/pending_list.dart';
import '../models/dailywrk_done_dpr_itemlist_save_model.dart';
import '../provider/daily_wrkdone_dpr_provider.dart';
import '../provider/inward_pending_provider.dart';
import '../provider/subcont_attendance_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dailywrk_done_dprnew_controller.dart';

int? WorkId;

class DailyWrkDone_DPR_Controller extends GetxController {
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  LoginController loginController = Get.put(LoginController());
  PendingListController pendingListController=Get.put(PendingListController());

  // DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller = Get.put(DailyWrkDone_DPRNEW_Controller());

  final dpr_autoYearWiseNoController = TextEditingController();
  final dpr_dateController = TextEditingController();
  final dpr_referenceController = TextEditingController();
  final dpr_remarksController = TextEditingController();
  final entryTypeController = TextEditingController();
  final dpr_preparedbyController = TextEditingController();
  final TypeSubcontractorname = new TextEditingController();
  final entryList_frdateController = TextEditingController();
  final entryList_todateController = TextEditingController();
  final reportTypeController = TextEditingController();
  final totalNetAmount = TextEditingController();
  RxInt reportType=0.obs;

  final workType_DPR_Controller = TextEditingController();
  RxString wrktype_DPR ="".obs;

  List<TextEditingController> Itemlist_CurrentQtyControllers = [];
  List<TextEditingController> Itemlist_RateControllers = [];
  List<TextEditingController> Itemlist_AmntControllers = [];
  List<TextEditingController> Itemlist_HeadNameControllers = [];

  List<TextEditingController> Addwrk_CurrentQtyControllers = [];
  List<TextEditingController> Addwrk_RateControllers = [];
  List<TextEditingController> Addwrk_AmntControllers = [];
  List<TextEditingController> Addwrk_HeadNameControllers = [];

  int check = 0;
  int checklist = 0;
  int workId=0;
  RxString saveButton=RequestConstant.SUBMIT.obs;

  RxList dpr_mainitemList = [].obs;
  RxList dpr_itemview_DbList = [].obs;
  RxList list=[].obs;
  late List<bool> isChecked;

  RxList dpr_entryList = [].obs;
  RxList searchentryList = [].obs;
  RxList dpr_EditListApiValue = [].obs;

  RxList dpr_subcontractorList = [].obs;

  final searchcontroller = TextEditingController();

  String entryType = "";
  RxInt TypeSubcontId = 0.obs;
  RxString TypeSubconttName = "".obs;

  var dprItemlistService = DprItemlistService();
  var dprItemListTableModel = DprItemListTableModel();

  late List<DprItemListTableModel> deleteModelList = <DprItemListTableModel>[];

  late List<DprItemListTableModel> dprItemListTableList =
  <DprItemListTableModel>[];
  late List<DprItemListTableModel> dprlistTablevalues =
  <DprItemListTableModel>[];
  late List<DprItemListTableModel> updateListDatas = <DprItemListTableModel>[];
  RxList<SubContractDailyWorkDets> getDprDetList = <SubContractDailyWorkDets>[].obs;

  var imageFiles = <File>[].obs;
  var gettingNetworkImages = <String>[].obs;
  List<int> imageIds = [];
  RxInt pickedImageCount = 0.obs;


  Future dpr_getItemList(int prid,int siteid,int subcontid,BuildContext context) async {
    dpr_mainitemList.value.clear();
    var response = await  DPRProvider.get_Dpr_ItemList(
        prid,siteid,subcontid);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          dpr_mainitemList.assignAll(response.result!);
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddwrkClickPopup(list: dpr_mainitemList.value,)));
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

  Future dpr_getEntryList() async {
    dpr_entryList.value=[];
    searchentryList.value=[];
    var response = await DPRProvider.get_dpr_EntryList(entryList_frdateController.text, entryList_todateController.text);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          dpr_entryList.assignAll(response.result!);
          searchentryList.assignAll(response.result!);
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


  clearDatas(){
    workId=0;
    saveButton.value = RequestConstant.SUBMIT;
    projectController.projectname.text = "--Select--";
    projectController.selectedProjectId.value=0;
    siteController.Sitename.text="--Select--";
    siteController.selectedsiteId.value=0;
    subcontractorController.selectedSubcontId.value=0;
    delete_dpr_itemlist_Table();
    dpr_itemview_DbList.value.clear();
    TypeSubcontractorname.text=RequestConstant.SELECT;
    entryTypeController.text="";
    dpr_preparedbyController.text=loginController.UserName();
    dpr_EditListApiValue.value.clear();
    dpr_dateController.text=BaseUtitiles.initiateCurrentDateFormat();
    dpr_referenceController.clear();
    TypeSubcontId.value=0;
    dpr_remarksController.text="-";
  }


  Future DprEntryList_EditApi(int workid, String MenuName, BuildContext context, int checkdata) async {
    final value = await DPRProvider.dpr_entryList_editAPI(workid);
    if (value != null) {
      if(value.success == true) {
        dpr_EditListApiValue.value = [value.result!];
        if (dpr_EditListApiValue.isNotEmpty) {
          checkdata == 1 ? saveButton.value = RequestConstant.APPROVAL : saveButton.value = RequestConstant.RESUBMIT;
          dpr_entrylist_editSaveDetTable();
          getDprTablesDatas();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DailyWork_done_DPR_Entry(heading:MenuName,)),
          );
        }
        else {
          BaseUtitiles.showToast("No Data Found");
        }
      }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }else {
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    }
  }

  Future<bool> Dpr_EntryList_DeleteApi(int reqId) async {
    return DPRProvider.dpr_entryList_deleteAPI(reqId);
  }


  Future dpr_getSubcotType({String? type,String? entryType}) async {
    dpr_subcontractorList.value.clear();
    var response = await DPRProvider.Dpr_getTypeSubcont(
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,type,entryType);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          dpr_subcontractorList.assignAll(response.result!);
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

  SubcontractorName(context, list){
    showModalBottomSheet(context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),),
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 50),
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: TextField(
                    controller: searchcontroller,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search,
                        color: Colors.black,
                      ),
                      hintText: "search..",
                      hintStyle: TextStyle(color: Colors.black),
                      isDense: true,
                      fillColor: Setmybackground,
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      // if (onSearch != null) onSearch!(searchcontroller.text);
                    },
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      // dailyWrkDone_DPR_Controller.dpr_subcontractorList.value=BaseUtitiles.subcontPopupAlert(value,dailyWrkDone_DPR_Controller.submainList.value);
                      list=BaseUtitiles.subcontPopupAlert(value,dpr_subcontractorList.value);
                    },

                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text("Subcontractors", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                  ),
                ),
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      searchcontroller.text = "";
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.expand_circle_down, color: Theme.of(context).primaryColor))),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(list[index].subContName
                              .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),),
                        ),
                        onTap: ()async {
                          TypeSubcontractorname.text = list[index].subContName.toString();
                          TypeSubcontId.value = list[index].subContId;
                          await subcontractorController.getInvoiceNoList(projectController.selectedProjectId.value,TypeSubcontId.value);


                          //----------DRR Det list------------
                          delete_dpr_itemlist_Table();
                          dpr_itemview_DbList.value.clear();
                          getDprTablesDatas();
                          searchcontroller.text = "";
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                    ],
                  );
                }, ),
            )
          ],
        );
      },);
  }


  dpr_itemlist_textControllersInitiate() {
    Itemlist_CurrentQtyControllers.add(TextEditingController());
    Itemlist_RateControllers.add(TextEditingController());
    Itemlist_AmntControllers.add(TextEditingController());
    Itemlist_HeadNameControllers.add(TextEditingController());
    Addwrk_CurrentQtyControllers.add(TextEditingController());
    Addwrk_RateControllers.add(TextEditingController());
    Addwrk_AmntControllers.add(TextEditingController());
    Addwrk_HeadNameControllers.add(TextEditingController());
  }

  currQtyAndAmntZerovalueset(list) {
    int index = 0;
    list.forEach((element) {
      dpr_itemlist_textControllersInitiate();
      Addwrk_RateControllers[index].text = element.rate!.toString();
      Addwrk_CurrentQtyControllers[index].text = element.qty!.toString();
      Addwrk_AmntControllers[index].text = element.amt!.toString();
      index++;
    });
  }

  // dprItemlist_addwrk_clickEdit() {
  //   for (var index = 0; index < dpr_itemList.length; index++) {
  //     dpr_itemlist_textControllersInitiate();
  //     if (Addwrk_CurrentQtyControllers[index].value.text == "0" ||Addwrk_CurrentQtyControllers[index].value.text == "0.0") {
  //       Addwrk_AmntControllers[index].text = "0.0";
  //     }
  //     else if(double.parse(Addwrk_CurrentQtyControllers[index].value.text)>dpr_itemList[index].balQty){
  //       Addwrk_CurrentQtyControllers[index].text = "0.0";
  //       BaseUtitiles.showToast("Your Balance Qty is"+dpr_itemList[index].balQty.toString());
  //     }
  //     else {
  //
  //       Addwrk_AmntControllers[index].text = ((dpr_itemList[index].rate! * (double.parse(Addwrk_CurrentQtyControllers[index].value.text))).toStringAsFixed(2));
  //
  //     }
  //   }
  // }

  dprItemlist_clickEdit() {
    double netAmount = 0.0;
    for (var index = 0; index < dpr_itemview_DbList.value.length; index++) {
      dpr_itemlist_textControllersInitiate();
      if (Itemlist_CurrentQtyControllers[index].value.text == "0" ||Itemlist_CurrentQtyControllers[index].value.text == "0.0") {
        Itemlist_CurrentQtyControllers[index].text = dpr_itemview_DbList.value[index].qty.toString();
        Itemlist_AmntControllers[index].text = ((dpr_itemview_DbList.value[index].rate! * (double.parse(Itemlist_CurrentQtyControllers[index].value.text))).toString());
        BaseUtitiles.showToast("Zero is not allowed please change the value");
      }
      else if(double.parse(Itemlist_CurrentQtyControllers[index].value.text != "" ? Itemlist_CurrentQtyControllers[index].value.text : "0")>dpr_itemview_DbList.value[index].balQty!){
        Itemlist_CurrentQtyControllers[index].text = dpr_itemview_DbList.value[index].qty.toString();
        Itemlist_AmntControllers[index].text = ((dpr_itemview_DbList.value[index].rate! *
            (double.parse(Itemlist_CurrentQtyControllers[index].value.text))).toString());
        BaseUtitiles.showToast("Should not allow the excess qty");
      }
      else {
        double amount =
            dpr_itemview_DbList.value[index].rate! * double.parse(
                Itemlist_CurrentQtyControllers[index].value.text != ""
                    ? Itemlist_CurrentQtyControllers[index].value.text : "0");

        Itemlist_AmntControllers[index].text = amount.toStringAsFixed(2);
        netAmount += amount;

      }
    }
    totalNetAmount.text = netAmount.toStringAsFixed(2);
    updateDprTables();
  }

  void dprItemlist_clickEdits(int index) {
    if (Itemlist_CurrentQtyControllers[index].text == "0" ||
        Itemlist_CurrentQtyControllers[index].text == "0.0") {

      Itemlist_CurrentQtyControllers[index].text =
          dpr_itemview_DbList.value[index].qty.toString();

      BaseUtitiles.showToast("Zero is not allowed please change the value");
    }
    else if (
    double.parse(
      Itemlist_CurrentQtyControllers[index].text.isNotEmpty
          ? Itemlist_CurrentQtyControllers[index].text
          : "0",
    ) >
        dpr_itemview_DbList.value[index].balQty!) {

      Itemlist_CurrentQtyControllers[index].text =
          dpr_itemview_DbList.value[index].qty.toString();

      BaseUtitiles.showToast("Should not allow the excess qty");
    }

    double netAmount = 0.0;

    for (var i = 0; i < dpr_itemview_DbList.value.length; i++) {
      double amount =
          dpr_itemview_DbList.value[i].rate! *
              double.parse(
                Itemlist_CurrentQtyControllers[i].text.isNotEmpty
                    ? Itemlist_CurrentQtyControllers[i].text
                    : "0",
              );

      Itemlist_AmntControllers[i].text = amount.toStringAsFixed(2);
      netAmount += amount;
    }

    totalNetAmount.text = netAmount.toStringAsFixed(2);
    updateDprTables();
  }



  Future deleteParticularList(DprItemListTableModel data) async {
    deleteModelList.clear();
    dprItemListTableModel = new DprItemListTableModel();
    dprItemListTableModel.headItemId = data.headItemId!;
    dprItemListTableModel.subItemId = data.subItemId!;
    dprItemListTableModel.level3ItemId = data.level3ItemId!;
    dprItemListTableModel.woDetId = data.woDetId!;
    deleteModelList.add(dprItemListTableModel);
    await dprItemlistService.DprItemlist_table_deleteById(deleteModelList);
  }



  dpr_itemlist_Save_DB(BuildContext context) async {
    dprItemListTableList.clear();
    int i = 0;
    int j = 0;
    dpr_mainitemList.forEach((element) {
      dpr_itemlist_textControllersInitiate();
      if(element.isCheck==true){
        if (Addwrk_CurrentQtyControllers[i].value.text == "0.0" ||
            Addwrk_CurrentQtyControllers[i].value.text == "0" ||
            Addwrk_CurrentQtyControllers[i].value.text == "") {
        }
        else {
          dprItemListTableModel = new DprItemListTableModel();
          dprItemListTableModel.headItemId = element.headItemId!;
          dprItemListTableModel.reqDetId = 0;
          dprItemListTableModel.subItemId = element.subItemId!;
          dprItemListTableModel.level3ItemId = element.level3ItemId!;
          dprItemListTableModel.woDetId = element.woDetId!;
          dprItemListTableModel.boqCode = element.boqCode!;
          dprItemListTableModel.itemDesc = element.itemDesc!;
          dprItemListTableModel.unit = element.unit!;
          dprItemListTableModel.rate = element.rate!;
          dprItemListTableModel.qty = double.parse('1');
          dprItemListTableModel.amt = (dprItemListTableModel.rate! * dprItemListTableModel.qty!);
          dprItemListTableModel.balQty = element.balQty!;
          dprItemListTableModel.scaleId = element.scaleId!;
          dprItemListTableModel.siteId = element.siteId!;
          dpr_itemview_DbList.forEach((element) {
            if (element.level3ItemId == dprItemListTableModel.level3ItemId) {
              j = 1;
            }
          });
          if (j == 0) {
            dprItemListTableList.add(dprItemListTableModel);
          }
          else{
            j=0;
          }
        }
      }
      i++;
    });
    var savedatas = await dprItemlistService.DprItemlist_table_Save(dprItemListTableList);
    return Navigator.pop(context, savedatas);
  }



  Future dpr_entrylist_editSaveDetTable() async {
    dprItemListTableList=[];
    dpr_EditListApiValue.forEach((element) {
      element.subContractDailyWorkDets.forEach((val) {
        dprItemListTableModel = new DprItemListTableModel();
        dprItemListTableModel.reqDetId = val.id!;
        dprItemListTableModel.headItemId = val.headItemId!;
        dprItemListTableModel.subItemId = val.subItemId!;
        dprItemListTableModel.level3ItemId = val.level3ItemId!;
        dprItemListTableModel.woDetId = val.woDetId!;
        // dprItemListTableModel.subContractDailyWorkMasId = val.subContractDailyWorkMasId!;
        dprItemListTableModel.boqCode = val.boqCode!;
        dprItemListTableModel.itemDesc = val.itemDesc!;
        dprItemListTableModel.unit = val.scaleName!;
        dprItemListTableModel.rate = val.rate!;
        dprItemListTableModel.qty = val.qty;
        dprItemListTableModel.amt = val.amt;
        dprItemListTableModel.scaleId = val.scaleId;
        dprItemListTableModel.siteId = val.siteId;
        dprItemListTableModel.balQty = val.balQty!;
        dprItemListTableList.add(dprItemListTableModel);
      });
    });
    var savedatas = await dprItemlistService.DprItemlist_table_Save(dprItemListTableList);
    return  savedatas;
  }


  Future getDprTablesDatas() async {
    dpr_itemview_DbList.value = [];
    var dprItem = await dprItemlistService.DprItemlist_table_readAll();
    dprItem.forEach((user) {
      var dprItemListModel = DprItemListTableModel();
      dprItemListModel.reqDetId = user['reqDetId'];
      dprItemListModel.headItemId = user['headItemId'];
      dprItemListModel.subItemId = user['subItemId'];
      dprItemListModel.level3ItemId = user['level3ItemId'];
      dprItemListModel.woDetId = user['woDetId'];
      // dprItemListModel.subContractDailyWorkMasId = user['subContractDailyWorkMasId'];
      dprItemListModel.boqCode = user['boqCode'].toString();
      dprItemListModel.itemDesc = user['itemDesc'];
      dprItemListModel.unit = user['unit'];
      dprItemListModel.rate = user['rate'];
      dprItemListModel.qty = user['qty'];
      dprItemListModel.amt = user['amt'];
      dprItemListModel.balQty = user['balQty'];
      dprItemListModel.scaleId = user['scaleId'];
      dprItemListModel.siteId = user['siteId'];
      dpr_itemview_DbList.add(dprItemListModel);
    });
    setTextControllersValue();
  }

  updateDprTables() async {
    int i = 0;
    updateListDatas.clear();
    dpr_itemview_DbList.forEach((element) {
      dpr_itemlist_textControllersInitiate();
      dprItemListTableModel = DprItemListTableModel();
      dprItemListTableModel.reqDetId = element.reqDetId;
      dprItemListTableModel.headItemId = element.headItemId!;
      dprItemListTableModel.subItemId = element.subItemId!;
      dprItemListTableModel.level3ItemId = element.level3ItemId!;
      dprItemListTableModel.woDetId = element.woDetId!;
      // dprItemListTableModel.subContractDailyWorkMasId = element.subContractDailyWorkMasId!;
      dprItemListTableModel.boqCode = element.boqCode!;
      dprItemListTableModel.itemDesc = element.itemDesc!;
      dprItemListTableModel.unit = element.unit!;
      dprItemListTableModel.rate = element.rate!;
      dprItemListTableModel.qty = double.parse(Itemlist_CurrentQtyControllers[i].text != "" ? Itemlist_CurrentQtyControllers[i].text : "0").toPrecision(2);
      dprItemListTableModel.amt = double.parse(Itemlist_AmntControllers[i].text);
      dprItemListTableModel.balQty = element.balQty!;
      dprItemListTableModel.scaleId = element.scaleId!;
      dprItemListTableModel.siteId = element.siteId!;
      updateListDatas.add(dprItemListTableModel);
      i++;
    });
    await dprItemlistService.DprItemlist_table_Update(updateListDatas);
  }

  delete_dpr_itemlist_Table() async {
    await dprItemlistService.DprItemlist_table_delete();
  }

  setTextControllersValue() async {
    for (var index = 0; index < dpr_itemview_DbList.length; index++) {
      dpr_itemlist_textControllersInitiate();
      Itemlist_CurrentQtyControllers[index].text = dpr_itemview_DbList.value[index].qty.toString();
      Itemlist_RateControllers[index].text =
          dpr_itemview_DbList.value[index].rate.toString();
      Itemlist_AmntControllers[index].text =
          dpr_itemview_DbList.value[index].amt.toString();
    }
  }

  Future SaveButton_EntryScreen_Save(BuildContext context, int id) async {
    getDprDetList.value.clear();
    await Future.delayed(const Duration(seconds:0));
    DailywrkDoneDprItemlistSaveModel formdata = DailywrkDoneDprItemlistSaveModel(
        Id: id != 0 ? id : 0,
        workNo: dpr_autoYearWiseNoController.text,
        workDate: dpr_dateController.text,
        workType: "RAT",
        projectId: projectController.selectedProjectId.value,
        siteId: siteController.selectedsiteId.value,
        subContId: TypeSubcontId.value,
        entryType: entryType,
        dprType: 2,
        billStatus:"N",
        refNo: dpr_referenceController.text.isEmpty ? "0" : dpr_referenceController.text,
        totalamt: totalNetAmount.text,
        remarks: dpr_remarksController.text.isEmpty ? "-" : dpr_remarksController.text,
        createdBy: int.tryParse(loginController.EmpId()),
        createdDate: BaseUtitiles().convertToUtcIso(dpr_dateController.text),
        approveStatus: saveButton.value == RequestConstant.APPROVAL ? "Y" : "N",
        verifyStatus: saveButton.value == RequestConstant.APPROVAL ? "Y" : "N",
        subContractDailyWorkDets: getDprListDet(id)
    );
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(formdata.toJson());
    debugPrint(prettyJson, wrapWidth: 1024);
    if(checklist == 0) {
      final list = await DPRProvider.SaveIemListScreenEntryAPI(formdata,imageFiles,saveButton,id);
      if (list != null) {
        if (list["success"] == true) {
          if (saveButton.value == RequestConstant.SUBMIT ||
              saveButton.value == RequestConstant.RESUBMIT) {
            BaseUtitiles.showToast(list["message"]);
            await dpr_getEntryList();
            BaseUtitiles.popMultiple(context, count: 3);
          } else if (saveButton.value == RequestConstant.APPROVAL) {
            BaseUtitiles.showToast(list["message"]);
            await pendingListController.getPendingList();
            BaseUtitiles.popMultiple(context, count: 3);
          }
        } else {
          BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
          BaseUtitiles.popMultiple(context, count: 2);
        }
      } else {
        BaseUtitiles.showToast("Something went wrong..");
        BaseUtitiles.popMultiple(context, count: 3);
      }}
    else {
      Get.back();
      Get.back();
      Fluttertoast.showToast(msg: "DPR Work Done Not Saved With Empty List....");
    }
  }


  List<SubContractDailyWorkDets>? getDprListDet(int iid) {
    checklist = 0;
    dpr_itemview_DbList.value.forEach((element) {
      if(element.amt > 0){
        var list = SubContractDailyWorkDets(
          id: saveButton.value == RequestConstant.RESUBMIT || saveButton.value == RequestConstant.APPROVAL ? element.reqDetId : 0,
          subContractDailyWorkMasId: saveButton.value == RequestConstant.RESUBMIT || saveButton.value == RequestConstant.APPROVAL ? iid : 0,
          subContarctWorkdetid: element.woDetId,
          headItemId: element.headItemId,
          subItemId: element.subItemId,
          level3ItemId: element.level3ItemId,
          cement: 0,
          itemDescription: element.itemDesc,
          workType: "RAT",
          boqCode: element.boqCode,
          scaleId: element.scaleId,
          siteId: element.siteId,
          billStatus: "N",
          avgLabRate: 0,
          qty: element.qty,
          rate: element.rate,
          amount: element.amt,
        );
        getDprDetList.value.add(list);
      } else {
        checklist = 1;
      }
    });
    return getDprDetList.value;
  }

  String ButtonChanges(int id,int aproval){

    if(id!=0){
      if(aproval!=0) {

        return saveButton.value = RequestConstant.APPROVAL;
      }
      else {

        return saveButton.value = RequestConstant.RESUBMIT;
      }
    }
    else{
      return saveButton.value=RequestConstant.SUBMIT;
    }


  }

  Future DeleteAlert(BuildContext context,int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
        actions:[
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          bool result = await Dpr_EntryList_DeleteApi(searchentryList.value[index].id);
                          if (result) {
                            dpr_entryList.removeAt(index);
                            searchentryList.removeAt(index);
                            Navigator.of(context).pop();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  setCheck(int id,bool value){
    dpr_mainitemList.forEach((element) {
      if(element.level3ItemId==id){
        element.isCheck = value;
      }
    });
  }

  serachsetCheck(int id,bool value){
    list.forEach((element) {
      if(element.level3ItemId==id){
        element.isCheck = value;
      }
    });
  }

  /// Getting image.....

  Future<void> gettingImage() async {
    gettingNetworkImages.clear();
    imageIds.clear();
    imageFiles.clear();
    final value =
    await Inward_Pending_provider.gettingImageProvider(WorkId!, "DPR");
    if (value != null) {
      for (int i = 0; i < value!.length; i++) {
        gettingNetworkImages.add(value[i].url.toString());
        imageIds.add(value[i].id);
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  Future<bool> deletingImage(int imageId) async {
    return await Inward_Pending_provider.deleteImageProvider(imageId,"DPR");
  }

}
