

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
import '../provider/subcont_attendance_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dailywrk_done_dprnew_controller.dart';

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

  int editCheck=0;
  int entrycheck=0;
  int check = 0;
  int checklist = 0;
  RxInt screenchek = 0.obs;


  int checkColor=0;


  int addwrkCheck=0;
  int aprovedButton=0;
  int workId=0;
  int buttonControl = 0;
  RxString saveButton=RequestConstant.SUBMIT.obs;

  RxList dpr_itemList = [].obs;
  RxList dpr_mainitemList = [].obs;
  RxList dpr_itemview_DbList = [].obs;
  RxList list=[].obs;
  late List<bool> isChecked;

  RxList dpr_entryList = [].obs;
  RxList searchentryList = [].obs;
  RxList dpr_EditListApiValue = [].obs;

  RxList dpr_subcontractorList = [].obs;
  RxList submainList = [].obs;

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
  RxList<DprDet> getDprDetList = <DprDet>[].obs;

  var imageFiles = <File>[].obs;
  var gettingNetworkImages = <String>[].obs;
  // String? gettingNetworkImage;
  // int? imageId;

  List<int> imageIds = [];


  Future dpr_getItemList(int prid,int siteid,int subcontid,String entrytype,BuildContext context) async {
    dpr_itemList.value.clear();
    dpr_mainitemList.value.clear();
    await DPRProvider.get_Dpr_ItemList(prid,siteid,subcontid,entrytype)
        .then((value) async {
      if (value != null && value.length > 0) {
        dpr_itemList.value = value;
        dpr_mainitemList.value = dpr_itemList.value;
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddwrkClickPopup(list: dpr_mainitemList.value,)));

        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return  AddwrkClickPopup(list: dpr_mainitemList.value,);
        //     });
      } else {
        BaseUtitiles.showToast("No Item Lists");
      }
    });

    // await DPRProvider.get_Dpr_ItemList(projectController.selectedProjectId.value, siteController.selectedsiteId.value, TypeSubcontId.value, entryType)
    //     .then((value) async {
    //   if (value != null && value.length > 0) {
    //     dpr_itemList.value = value;
    //     return dpr_itemList.value;
    //   } else {
    //     BaseUtitiles.showToast("No Item Lists");
    //   }
    // });

  }


  Future dpr_getEntryList() async {
    dpr_entryList.value.clear();
    searchentryList.value.clear();
    await DPRProvider.get_dpr_EntryList(loginController.user.value.userId, loginController.UserType(), entryList_frdateController.text, entryList_todateController.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        dpr_entryList.value = value;
        searchentryList.value = dpr_entryList.value;
        return dpr_entryList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
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
    entryTypeController.text="TYPE";
    dpr_preparedbyController.text=loginController.UserName();
    dpr_EditListApiValue.value.clear();
    dpr_dateController.text=BaseUtitiles.initiateCurrentDateFormat();
    dpr_referenceController.clear();
    TypeSubcontId.value=0;
    dpr_remarksController.text="-";
  }


  Future DprEntryList_EditApi(int workid, BuildContext context, int checkdata) async {
    checkdata != 0 ? aprovedButton = 1 : aprovedButton = 0;
    await DPRProvider.dpr_entryList_editAPI(workid).then((value) async {
      if (value != null && value.length > 0) {
        delete_dpr_itemlist_Table();
        editCheck = 1;
        entrycheck=1;
        dpr_EditListApiValue.value = value;
        dpr_entrylist_editSaveDetTable();
        getDprTablesDatas();
        await gettingImage(workid,"DPR");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DailyWork_done_DPR_Entry()),
        );
      }
    });
  }

  Future Dpr_EntryList_DeleteApi(int WorkId, String WorkNo) async {
    await DPRProvider.dpr_entryList_deleteAPI(WorkId,WorkNo, loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  Future dpr_getSubcotType() async {
    dpr_subcontractorList.value.clear();
    submainList.value.clear();
    await DPRProvider.Dpr_getTypeSubcont(
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,
        entryType,
    ).then((value) async {
      if (value != null && value.length > 0) {
        submainList.value = value;
        dpr_subcontractorList.value = submainList.value;
        return dpr_subcontractorList.value;
      }
    });
  }


  SelectedTypeSubcontID(String value) {
    if (dpr_subcontractorList.value.length > 0) {
      dpr_subcontractorList.forEach((element) {
        if (value == element.subContName) {
          TypeSubcontId(element.subContId);
        }
      });
    }
    setSelectedTypeSubcontListName(TypeSubcontId.value);
  }

  setSelectedTypeSubcontListName(int? id) {
    if (dpr_subcontractorList.value != null) {
      dpr_subcontractorList.value.forEach((element) {
        if (id == element.subContId) {
          TypeSubconttName(element.subContName.toString());
        }
      });
    }
    TypeSubcontractorname.text = TypeSubconttName.value;
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
                        onTap: () {
                          TypeSubcontractorname.text = list[index].subContName.toString();
                          TypeSubcontId.value = list[index].subContId;

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
  //
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
    for (var index = 0; index < dpr_itemview_DbList.value.length; index++) {
      dpr_itemlist_textControllersInitiate();
      if (Itemlist_CurrentQtyControllers[index].value.text == "0" ||Itemlist_CurrentQtyControllers[index].value.text == "0.0") {
        Itemlist_CurrentQtyControllers[index].text = dpr_itemview_DbList.value[index].qty.toString();
        Itemlist_AmntControllers[index].text = ((dpr_itemview_DbList.value[index].rate! * (double.parse(Itemlist_CurrentQtyControllers[index].value.text))).toString());
        BaseUtitiles.showToast("Zero is not allowed please change the value");
      }
      else if(double.parse(Itemlist_CurrentQtyControllers[index].value.text != "" ? Itemlist_CurrentQtyControllers[index].value.text : "0")>dpr_itemview_DbList.value[index].balQty!){
        Itemlist_CurrentQtyControllers[index].text = dpr_itemview_DbList.value[index].qty.toString();
        Itemlist_AmntControllers[index].text = ((dpr_itemview_DbList.value[index].rate! * (double.parse(Itemlist_CurrentQtyControllers[index].value.text))).toString());
        // BaseUtitiles.showToast("Your Balance Qty is ${dpr_itemview_DbList.value[index].balQty}");
        BaseUtitiles.showToast("Should not allow the excess qty");
      }
      else {
        Itemlist_AmntControllers[index].text = ((dpr_itemview_DbList.value[index].rate! * (double.parse(Itemlist_CurrentQtyControllers[index].value.text != "" ? Itemlist_CurrentQtyControllers[index].value.text : "0"))).toStringAsFixed(2));
      }
    }
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

  // dpr_itemlist_Save_DB(BuildContext context) async {
  //   dprItemListTableList.clear();
  //   int i = 0;
  //   int j = 0;
  //   dpr_mainitemList.forEach((element) {
  //     dpr_itemlist_textControllersInitiate();
  //     if (Addwrk_CurrentQtyControllers[i].value.text == "0.0" ||
  //         Addwrk_CurrentQtyControllers[i].value.text == "0" ||
  //         Addwrk_CurrentQtyControllers[i].value.text == "") {
  //     } else {
  //       dprItemListTableModel = new DprItemListTableModel();
  //       dprItemListTableModel.headItemId = element.headItemId!;
  //       dprItemListTableModel.subItemId = element.subItemId!;
  //       dprItemListTableModel.level3ItemId = element.level3ItemId!;
  //       dprItemListTableModel.woDetId = element.woDetId!;
  //       dprItemListTableModel.boqCode = element.boqCode!;
  //       dprItemListTableModel.itemDesc = element.itemDesc!;
  //       dprItemListTableModel.unit = element.unit!;
  //       dprItemListTableModel.rate = element.rate!;
  //       dprItemListTableModel.qty = double.parse(Addwrk_CurrentQtyControllers[i].text).toPrecision(2);
  //       dprItemListTableModel.amt =
  //           double.parse(Addwrk_AmntControllers[i].text);
  //       dprItemListTableModel.balQty = element.balQty!;
  //       dpr_itemview_DbList.forEach((element) {
  //         if (element.level3ItemId == dprItemListTableModel.level3ItemId) {
  //           j = 1;
  //         }
  //       });
  //       if (j == 0) {
  //         dprItemListTableList.add(dprItemListTableModel);
  //       }
  //       else{
  //         j=0;
  //       }
  //     }
  //     i++;
  //   });
  //   var savedatas = await dprItemlistService.DprItemlist_table_Save(dprItemListTableList);
  //   return Navigator.pop(context, savedatas);
  // }

  Future dpr_entrylist_editSaveDetTable() async {
    dprItemListTableList.clear();
    dpr_EditListApiValue.forEach((element) {
      element.dprEditDet.forEach((val) {
        dprItemListTableModel = new DprItemListTableModel();
        dprItemListTableModel.headItemId = val.headItemId!;
        dprItemListTableModel.subItemId = val.subItemId!;
        dprItemListTableModel.level3ItemId = val.level3ItemId!;
        dprItemListTableModel.woDetId = val.woDetId!;
        dprItemListTableModel.boqCode = val.boqCode!;
        dprItemListTableModel.itemDesc = val.itemDesc!;
        dprItemListTableModel.unit = val.unit!;
        dprItemListTableModel.rate = val.rate!;
        dprItemListTableModel.qty = val.qty;
        dprItemListTableModel.amt = val.amt;
        dprItemListTableModel.balQty = val.balQty!;
        dprItemListTableList.add(dprItemListTableModel);
      });
    });
    var savedatas = await dprItemlistService.DprItemlist_table_Save(dprItemListTableList);
    return  savedatas;
  }


  Future getDprTablesDatas() async {
    dpr_itemview_DbList.clear();
    var dprItem = await dprItemlistService.DprItemlist_table_readAll();
    dprItem.forEach((user) {
      var dprItemListModel = DprItemListTableModel();
      dprItemListModel.headItemId = user['headItemId'];
      dprItemListModel.subItemId = user['subItemId'];
      dprItemListModel.level3ItemId = user['level3ItemId'];
      dprItemListModel.woDetId = user['woDetId'];
      dprItemListModel.boqCode = user['boqCode'];
      dprItemListModel.itemDesc = user['itemDesc'];
      dprItemListModel.unit = user['unit'];
      dprItemListModel.rate = user['rate'];
      dprItemListModel.qty = user['qty'];
      dprItemListModel.amt = user['amt'];
      dprItemListModel.balQty = user['balQty'];
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
      dprItemListTableModel.headItemId = element.headItemId!;
      dprItemListTableModel.subItemId = element.subItemId!;
      dprItemListTableModel.level3ItemId = element.level3ItemId!;
      dprItemListTableModel.woDetId = element.woDetId!;
      dprItemListTableModel.boqCode = element.boqCode!;
      dprItemListTableModel.itemDesc = element.itemDesc!;
      dprItemListTableModel.unit = element.unit!;
      dprItemListTableModel.rate = element.rate!;
      dprItemListTableModel.qty = double.parse(Itemlist_CurrentQtyControllers[i].text != "" ? Itemlist_CurrentQtyControllers[i].text : "0").toPrecision(2);
      dprItemListTableModel.amt = double.parse(Itemlist_AmntControllers[i].text);
      dprItemListTableModel.balQty = element.balQty!;
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
      workId: id != 0 ? id.toString() : "0",
      workNo: dpr_autoYearWiseNoController.text,
      workDate: dpr_dateController.text,
      projectId: projectController.selectedProjectId.value.toString(),
      siteId: siteController.selectedsiteId.toString(),
      subContId: TypeSubcontId.toString(),
      refNo: dpr_referenceController.text,
      entryType: entryType,
      remarks: dpr_remarksController.text,
      preparedby: loginController.EmpId(),
      approvedby: aprovedButton!=0?loginController.EmpId():"0",
      userId: loginController.UserId(),
      empId: loginController.EmpId(),
      entryMode:screenchek ==0?"ADD":screenchek==2?"UPDATE":screenchek==1?"APPROVE":"",
      deviceName: BaseUtitiles.deviceName,
      files: imageFiles,
      dprDet: getDprDetList.value.isEmpty
          ? getDprListDet(id)
          : getDprDetList.value,
    );
    if(checklist == 0) {
    final list = await DPRProvider.SaveIemListScreenEntryAPI(formdata,id,aprovedButton, buttonControl,context,imageFiles);
      if (list != null) {
        if(id!=0){
          if(aprovedButton!=0){
            clearDatas();
            // appEnb = 0;
            BaseUtitiles.showToast(list);
            await pendingListController.getPendingList();
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => PendingList()));
            // pendingListController.getSubcontractor_ExpensesList(loginController.UserId(), loginController.UserType(),"SUBCONTRACTOR DPR APPROVAL",context);
          }
          else{
            entrycheck=2;
            editCheck=0;
            clearDatas();
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            await dpr_getEntryList();
            BaseUtitiles.showToast(list);
          }
        }
        else{
          if (list == RequestConstant.DUPLICATE_OCCURED) {
            Navigator.pop(context);
            Navigator.pop(context);
            return BaseUtitiles.showToast(list);
          } else {
            entrycheck=2;
            editCheck=0;
            // appEnb=0;
            clearDatas();
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            await dpr_getEntryList();
            BaseUtitiles.showToast(list);
          }
        }
      }
    }
    else {
      Get.back();
      Get.back();
      Fluttertoast.showToast(msg: "DPR Work Done Not Saved With Empty List....");
    }
  }

  List<DprDet>? getDprListDet(int id) {
    checklist = 0;
    dpr_itemview_DbList.value.forEach((element) {
      if(element.amt > 0){
        var list = DprDet(
          headItemId: element.headItemId.toString(),
          subItemId: element.subItemId.toString(),
          level3ItemId: element.level3ItemId.toString(),
          woDetId: element.woDetId.toString(),
          unit: element.unit.toString(),
          qty: element.qty.toString(),
          rate: element.rate.toString(),
          amount: element.amt.toString(),
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
                          entrycheck=0;
                          editCheck=0;
                          Dpr_EntryList_DeleteApi(searchentryList.value[index].workId,searchentryList.value[index].workNo);
                          searchentryList.removeAt(index);
                          dpr_itemview_DbList.value.clear();
                          delete_dpr_itemlist_Table();
                          await dpr_getEntryList();
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => DailyWork_done_DPR_EntryList()));
                        },
                        child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
          //     editCheck=0;
          //     Dpr_EntryList_DeleteApi(searchentryList.value[index].workId,searchentryList.value[index].workNo);
          //     searchentryList.removeAt(index);
          //     dpr_itemview_DbList.value.clear();
          //     delete_dpr_itemlist_Table();
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),
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

  Future<void> gettingImage(int? DprId,from) async {
    try {
      final getAttenImage =
      await SubContAttendanceProvider().gettingImageProvider(0,DprId,from);

      // clear previous images
      gettingNetworkImages.clear();
      imageIds.clear();

      if (getAttenImage.imageView != null &&
          getAttenImage.imageView!.isNotEmpty) {
        for (var img in getAttenImage.imageView!) {
          if (img.imageUrl != null && img.imageUrl!.isNotEmpty) {
            gettingNetworkImages.add(img.imageUrl!);
            imageIds.add(img.imageId!);
          }
        }
      }

      print("✅ Network Images: $gettingNetworkImages");
      print("✅ Image IDs: $imageIds");
    } catch (e) {
      print("❌ Error fetching images: $e");
      gettingNetworkImages.clear();
      imageIds.clear();
    }
  }


}
