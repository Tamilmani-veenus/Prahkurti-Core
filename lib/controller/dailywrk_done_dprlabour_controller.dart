import '../controller/dailywrk_done_dpr_controller.dart';
import '../controller/headname_controller.dart';
import '../controller/logincontroller.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../db_model/dpr_labour_detTable_model.dart';
import '../db_model/dpr_labour_labscreen_Table_model.dart';
import '../db_services/dpr_labour_detService.dart';
import '../db_services/dpr_labour_labscreen_service.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(labour)/daily_wrkdone_dpr_labour.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(labour)/labShowpopup.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(labour)/labour_add_boqpopup.dart';
import '../models/dailywrk_don_dpr_labour_saveapireq.dart';
import '../provider/daily_wrkdone_dprLabour_provider.dart';
import '../provider/daily_wrkdone_dprNew_provider.dart';
import '../provider/subcont_attendance_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyWrkDone_DPRLabour_Controller extends GetxController{

  int screencheck=0;
  final dprlabor_autoYearWiseNoController = TextEditingController();
  final dprlabor_dateController = TextEditingController();
  final dprlabor_referenceController = TextEditingController();
  final dprlabor_remarksController = TextEditingController();
  final dprlabor_preparedbyController = TextEditingController();
  final dpr_lab_descripionController = TextEditingController();
  final dpr_lab_rateController = TextEditingController();
  final dpr_lab_unitsController = TextEditingController();
  final dpr_lab_boqQtyController = TextEditingController();
  final dpr_lab_currQtyController = TextEditingController();

  final dprlabor_entryList_frdateController = TextEditingController();
  final dprlabor_entryList_todateController = TextEditingController();

  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  LoginController loginController=Get.put(LoginController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  PendingListController pendingListController=Get.put(PendingListController());
  HeadNameController headNameController=Get.put(HeadNameController());

  var dprLabour_LabScreenService =new DprLabour_LabScreenService();
  var dprLabour_DetService = DprLabour_DetService();

  var dprLabourDetmodel = DprLabour_DetTable();
  late List<DprLabour_DetTable> dprLabourDetModelList = <DprLabour_DetTable>[];
  late List<DprLabour_DetTable> dprUpdateDetModelList = <DprLabour_DetTable>[];
  List dprLabour_DetReadList = <DprLabour_DetTable>[];
  RxList dprlabour_EntryDetlist = [].obs;

  RxList<DprDet>getDetList = <DprDet>[].obs;
  RxList<DprLab>getLablist = <DprLab>[].obs;

  var dprLabour_Ok_saveModel = DprLabour_LabTableModel();
  late List<DprLabour_LabTableModel> dprLabour_saveModelList = <DprLabour_LabTableModel>[];
  late List<DprLabour_LabTableModel> deleteLabModelList = <DprLabour_LabTableModel>[];
  late List<DprLabour_LabTableModel> UpdateLabourModelList = <DprLabour_LabTableModel>[];
  List dprLabourReadList = <DprLabour_LabTableModel>[];
  RxList dprLabourlist = [].obs;


  var total_Amount = 0.0;
  var total_Nos = 0.0;

int workid=0;
  int aprovedButton=0;
  RxString saveButton=RequestConstant.SAVE.obs;
  int editCheck=0;
  RxList dprLabour_itemList = [].obs;
  RxList dprLabour_EntryList = [].obs;
  RxList main_EntryList = [].obs;
  RxList dpr_EditListApiValue = [].obs;
  RxList dprLabour_BoqDetailsList = [].obs;
  RxList dprLabour_ShowList = [].obs;



  List<TextEditingController> ShowNosControllers = [];
  List<TextEditingController> ShowOtHrsController = [];
  List<TextEditingController> ShowOtAmtController = [];
  List<TextEditingController> ShowNetAmtController = [];

  List<TextEditingController> ListNosControllers = [];
  List<TextEditingController> ListOtHrsController = [];

  Future getAddBoqDetails(BuildContext context) async {
    await DPR_New_Provider.dprNew_getBoqDetails(
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,
        headNameController.selectedHeadId.value,
        dailyWrkDone_DPR_Controller.TypeSubcontId.value,
        dailyWrkDone_DPR_Controller.entryType)
        .then((value) async {
      if (value != null && value.length > 0) {
        dprLabour_BoqDetailsList.value = value;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return LabourAddBoqPopup(list: dprLabour_BoqDetailsList.value);
            });
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future getLab_ShowClickPopList(BuildContext context) async {
    await SubContAttendanceProvider.getShowPopupList(dailyWrkDone_DPR_Controller.TypeSubcontId.value,projectController.selectedProjectId.value).then((value) async {
      if (value != null && value.length > 0) {
        dprLabour_ShowList.value = value;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return LabourShowPopup(list: dprLabour_ShowList.value);
            });
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future dprLabour_getItemList(int prid,int siteid,int subcontid,String entrytype) async {
    if(editCheck==1){
      await DPRLabourProvider.get_DprLabour_ItemList(prid,siteid,subcontid,entrytype)
          .then((value) async {
        if (value != null && value.length > 0) {
          dprLabour_itemList.value = value;
          return dprLabour_itemList.value;
        } else {
          BaseUtitiles.showToast("No Item Lists");
        }
      });
    }
    else{
      await DPRLabourProvider.get_DprLabour_ItemList(projectController.selectedProjectId.value, siteController.selectedsiteId.value, dailyWrkDone_DPR_Controller.TypeSubcontId.value, dailyWrkDone_DPR_Controller.entryType)
          .then((value) async {
        if (value != null && value.length > 0) {
          dprLabour_itemList.value = value;
          return dprLabour_itemList.value;
        } else {
          BaseUtitiles.showToast("No Item Lists");
        }
      });
    }
  }


  String ButtonChanges(int id,int aproval){
    if(id!=0){
      if(aproval!=0)
        return saveButton.value=RequestConstant.APPROVAL;
      else
        return saveButton.value=RequestConstant.UPDATE;
    }
    else
      return saveButton.value=RequestConstant.SAVE;
  }

  textControllersInitiate(){
    ListNosControllers.add(new TextEditingController());
    ListOtHrsController.add(new TextEditingController());
    ShowOtAmtController.add(new TextEditingController());
    ShowNetAmtController.add(new TextEditingController());
    ShowNosControllers.add(new TextEditingController());
    ShowOtHrsController.add(new TextEditingController());
  }

  nosAndothrsZerovalueset(List list){
    int index=0;
    list.forEach((element) {
      textControllersInitiate();
      ShowNosControllers[index].text="0";
      ShowOtHrsController[index].text="0";
      index++;
    });
  }

  dprLabour_DetTable_Delete() async {
    await dprLabour_DetService.DprLabour_Dettable_delete();
  }

  dprLabour_DetTableSave(var element) async {
    dprLabourDetModelList.clear();
    dprLabourDetmodel = new DprLabour_DetTable();
    dprLabourDetmodel.headItemId = element.headItemId;
    dprLabourDetmodel.subItemId = element.subItemId;
    dprLabourDetmodel.level3ItemId = element.level3ItemId;
    dprLabourDetmodel.woDetId = element.woDetId;
    dprLabourDetmodel.itemDesc = element.itemDesc.toString();
    dprLabourDetmodel.rate = element.rate;
    dprLabourDetmodel.unit = element.unit;
    dprLabourDetmodel.balQty = element.balQty;
    dprLabourDetmodel.qty = element.qty;
    dprLabourDetmodel.boqCode = element.boqCode.toString();
    dprLabourDetModelList.add(dprLabourDetmodel);
    var savedatas =
    await dprLabour_DetService.DprLabour_DetTable_Save(dprLabourDetModelList);
    return savedatas;
  }

  Future getDetTablesDatas() async {
    var datas = await dprLabour_DetService.DprLabour_DetTable_readAll();
     dprLabour_DetReadList = <DprLabour_DetTable>[];
    dprLabour_DetReadList.clear();
    dprlabour_EntryDetlist.clear();
    datas.forEach((value) {
      dprLabourDetmodel = new DprLabour_DetTable();
      dprLabourDetmodel.headItemId = value['headItemId'];
      dprLabourDetmodel.subItemId = value['subItemId'];
      dprLabourDetmodel.level3ItemId = value['level3ItemId'];
      dprLabourDetmodel.woDetId = value['woDetId'];
      dprLabourDetmodel.itemDesc = value['itemDesc'];
      dprLabourDetmodel.rate = value['rate'];
      dprLabourDetmodel.unit = value['units'];
      dprLabourDetmodel.balQty = value['balQty'];
      dprLabourDetmodel.qty = value['qty'];
      dprLabourDetmodel.boqCode = value['boqCode'];
      dprLabour_DetReadList.add(dprLabourDetmodel);
      dprlabour_EntryDetlist.value=dprLabour_DetReadList;
    });
    setTextValue(dprlabour_EntryDetlist);
  }

  setTextValue(vale) {
    vale.forEach((datas) {
      dpr_lab_rateController.text = datas.rate.toString();
      dpr_lab_unitsController.text = datas.unit.toString();
      dpr_lab_boqQtyController.text = datas.balQty.toString();
      dpr_lab_currQtyController.text = datas.qty.toString();
      dpr_lab_descripionController.text = datas.itemDesc.toString();
    });
  }

  currQtyclickEdit(String value) {
      if (dpr_lab_currQtyController.value.text == "0" ||
          dpr_lab_currQtyController.value.text == "0.0" ||
          dpr_lab_currQtyController.value.text == "") {
      }
      else {
        updateDetTable();
    }

  }

  updateDetTable() async {
    dprUpdateDetModelList.clear();
    for (var n = 0; n < dprlabour_EntryDetlist.length; n++) {
      dprLabourDetmodel = new DprLabour_DetTable();
      dprLabourDetmodel.headItemId = dprlabour_EntryDetlist[n].headItemId;
      dprLabourDetmodel.subItemId = dprlabour_EntryDetlist[n].subItemId;
      dprLabourDetmodel.level3ItemId = dprlabour_EntryDetlist[n].level3ItemId;
      dprLabourDetmodel.woDetId=dprlabour_EntryDetlist[n].woDetId;
      dprLabourDetmodel.itemDesc = dprlabour_EntryDetlist[n].itemDesc;
      dprLabourDetmodel.unit = dprlabour_EntryDetlist[n].unit;
      dprLabourDetmodel.rate = dprlabour_EntryDetlist[n].rate;
      dprLabourDetmodel.qty =double.parse(dpr_lab_currQtyController.value.text);
      dprLabourDetmodel.amt = dprlabour_EntryDetlist[n].amt;
      dprLabourDetmodel.balQty = dprlabour_EntryDetlist[n].balQty;
      dprLabourDetmodel.boqCode = dprlabour_EntryDetlist[n].boqCode;
      dprUpdateDetModelList.add(dprLabourDetmodel);
    }
    await dprLabour_DetService.DprLabour_DetTable_Update(dprUpdateDetModelList);

  }



  Future deleteParticularLabourList(DprLabour_LabTableModel data) async {
    deleteLabModelList.clear();
    dprLabour_Ok_saveModel = new DprLabour_LabTableModel();
    dprLabour_Ok_saveModel.catId = data.catId;
    dprLabour_Ok_saveModel.subId = data.subId;
    deleteLabModelList.add(dprLabour_Ok_saveModel);
    await dprLabour_LabScreenService.DprLabour_LabScreenTable_deleteById(deleteLabModelList);
  }

  dprLabour_Labourtable_Delete() async {
    await dprLabour_LabScreenService.DprLabour_LabScreenTable_delete();
  }

  saveLabTableDatas(BuildContext context) async {
    dprLabour_saveModelList.clear();
   int i = 0;
   int j=0;
   dprLabour_ShowList.forEach((element) {
      if (ShowNosControllers[i].value.text == "0" ||
          ShowNosControllers[i].value.text == "") {
      } else {
        dprLabour_Ok_saveModel = new DprLabour_LabTableModel();
        dprLabour_Ok_saveModel.catId = element.categoryId;
        dprLabour_Ok_saveModel.catName = element.categoryName;
        dprLabour_Ok_saveModel.subId = dailyWrkDone_DPR_Controller.TypeSubcontId.value;
        dprLabour_Ok_saveModel.subName=dailyWrkDone_DPR_Controller.TypeSubconttName.toString();
        dprLabour_Ok_saveModel.wages = element.wages;
        dprLabour_Ok_saveModel.nos = ShowNosControllers[i].value.text.toString();
        dprLabour_Ok_saveModel.otHrs = ShowOtHrsController[i].value.text.toString();
        dprLabour_Ok_saveModel.otAmt = ShowOtHrsController[i].value.text != "" ? ((element.wages / 8) * double.parse(ShowOtHrsController[i].value.text.toString())) : ShowOtHrsController[i].text = "0";
        dprLabour_Ok_saveModel.netAmt = ((element.wages * double.parse(ShowNosControllers[i].value.text.toString())) + dprLabour_Ok_saveModel.otAmt);
        dprLabour_Ok_saveModel.remarks="-";
        dprLabourlist.value.forEach((element) {
          if(element.catId ==dprLabour_Ok_saveModel.catId && element.subId==dprLabour_Ok_saveModel.subId){
            j=1;
          }
        });
        if(j==0){
          dprLabour_saveModelList.add(dprLabour_Ok_saveModel);
        }
        else{
          j=0;
        }
      }
      i++;
    });
    var savedatas = await dprLabour_LabScreenService.DprLabour_LabScreenTable_Save(dprLabour_saveModelList);
    return Navigator.pop(context, savedatas);
  }

  Future getLabourTablesDatas() async {
    var labour = await dprLabour_LabScreenService.DprLabour_LabScreenTable_readAll();
    dprLabourReadList = <DprLabour_LabTableModel>[];
    dprLabourReadList.clear();
    labour.forEach((user) {
      dprLabour_Ok_saveModel = new DprLabour_LabTableModel();
      dprLabour_Ok_saveModel.catId = user['catId'];
      dprLabour_Ok_saveModel.catName = user['catName'];
      dprLabour_Ok_saveModel.subId = user['subId'];
      dprLabour_Ok_saveModel.subName=user['subName'];
      dprLabour_Ok_saveModel.wages = user['wages'];
      dprLabour_Ok_saveModel.nos = user['nos'];
      dprLabour_Ok_saveModel.otHrs = user['otHrs'];
      dprLabour_Ok_saveModel.otAmt = user['otAmt'];
      dprLabour_Ok_saveModel.netAmt = user['netAmt'];
      dprLabour_Ok_saveModel.remarks = user['remarks'];
      dprLabourReadList.add(dprLabour_Ok_saveModel);
      dprLabourlist.value = dprLabourReadList;
    });
    getTotalamntAndTotalNos();
    setTextControllersValue();
  }

  getTotalamntAndTotalNos() {
    total_Amount = 0.0;
    total_Nos = 0.0;
    for (int val = 0; val < dprLabourlist.length; val++) {
      total_Amount += double.parse(dprLabourlist[val].netAmt!.toString());
      total_Nos += double.parse(dprLabourlist[val].nos!);
    }
  }

  setTextControllersValue() async {
    for (var index = 0; index < dprLabourlist.length; index++) {
      textControllersInitiate();
      ListNosControllers[index].text = dprLabourlist[index].nos;
      ListOtHrsController[index].text = dprLabourlist[index].otHrs;
      ShowOtAmtController[index].text = dprLabourlist[index].otAmt.toString();
      ShowNetAmtController[index].text = dprLabourlist[index].netAmt.toString();
    }
  }

  LabourclickEdit(String value) {
    for (var index = 0; index < dprLabourlist.length; index++) {
      if (ListNosControllers[index].value.text == "0" ||
          ListNosControllers[index].value.text == "" ||
          ListOtHrsController[index].value.text == "") {
      }
      else {
        ShowOtAmtController[index].text = ((dprLabourlist[index].wages / 8) * double.parse(ListOtHrsController[index].value.text.toString())).toString();
        ShowNetAmtController[index].text = ((dprLabourlist[index].wages * double.parse(ListNosControllers[index].value.text.toString())) + ((dprLabourlist[index].wages / 8) * double.parse(ListOtHrsController[index].value.text.toString()))).toString();
      }
    }
    updateLabTable();
  }

  updateLabTable() async {
    UpdateLabourModelList.clear();
    for (var n = 0; n < dprLabourlist.length; n++) {
      dprLabour_Ok_saveModel = new DprLabour_LabTableModel();
      dprLabour_Ok_saveModel.catId = dprLabourlist[n].catId;
      dprLabour_Ok_saveModel.catName = dprLabourlist[n].catName;
      dprLabour_Ok_saveModel.subId = dprLabourlist[n].subId;
      dprLabour_Ok_saveModel.subName=dprLabourlist[n].subName;
      dprLabour_Ok_saveModel.wages = dprLabourlist[n].wages;
      dprLabour_Ok_saveModel.nos = ListNosControllers[n].value.text.toString();
      dprLabour_Ok_saveModel.otHrs = ListOtHrsController[n].value.text.toString();
      dprLabour_Ok_saveModel.otAmt = double.parse(ShowOtAmtController[n].value.text.toString());
      dprLabour_Ok_saveModel.netAmt = double.parse(ShowNetAmtController[n].value.text.toString());
      UpdateLabourModelList.add(dprLabour_Ok_saveModel);
    }
    await dprLabour_LabScreenService.DprLabour_LabScreenTable_Update(UpdateLabourModelList);

  }

  Future SaveButton_dprLabour_SaveAPI(BuildContext context, int id) async {
    getDetList.value.clear();
    await Future.delayed(const Duration(seconds:0));
    String body = dailywrkDoneDprlabourSaveApiReqToJson(DailywrkDoneDprlabourSaveApiReq(
      workId: id != 0 ? id.toString() : "0",
      workNo: dprlabor_autoYearWiseNoController.text,
      workDate: dprlabor_dateController.text,
      projectId: projectController.selectedProjectId.value.toString(),
      siteId: siteController.selectedsiteId.toString(),
      subContId: dailyWrkDone_DPR_Controller.TypeSubcontId.toString(),
      refNo: dprlabor_referenceController.text,
      entryType: dailyWrkDone_DPR_Controller.entryType,
      remarks: dprlabor_remarksController.text,
      preparedby: loginController.EmpId(),
      approvedby: "0",
      userId: loginController.UserId(),
      empId: loginController.EmpId(),
      entryMode:saveButton.value=="Save"?"ADD":saveButton.value=="Update"?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
      deviceName: BaseUtitiles.deviceName,
        dprLab: getLablist.value.length == 0
            ? getDprLbour_lab()
            : getLablist.value,
      dprDet: getDetList.value.length == 0
          ? getLabourDprListDet()
          : getDetList.value,
    ));
    final list = await DPRLabourProvider.DPR_Labour_SaveAPI(body,id,aprovedButton,context);
    if(list!=null&&id!=0){
      if(list!=null&&id!=0&&aprovedButton!=0){
        await pendingListController.getPendingList();
        BaseUtitiles.showToast(list);
        Navigator.pop(context);
        return  Navigator.pop(context);
      }
      else{
        screencheck=2;
        BaseUtitiles.showToast(list);
        Navigator.pop(context);
        return Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                new DailyWrk_Done_DPR_Labour(2)));
      }
    }
    else{
      if (list == RequestConstant.DUPLICATE_OCCURED) {
        Navigator.pop(context);
        Navigator.pop(context);
        return BaseUtitiles.showToast(list!);
      } else {
        Navigator.pop(context);
        screencheck=2;
        BaseUtitiles.showToast(list!);
        return Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                new DailyWrk_Done_DPR_Labour(2)));
      }
    }
  }

  List<DprDet>? getLabourDprListDet() {
    dprlabour_EntryDetlist.forEach((element) {
      var list = new DprDet(
        headItemId: element.headItemId.toString(),
        subItemId: element.subItemId.toString(),
        level3ItemId: element.level3ItemId.toString(),
        woDetId: element.woDetId.toString(),
        unit: element.unit.toString(),
        qty: element.qty.toString(),
        rate: element.rate.toString(),
        amount: element.amt.toString(),
      );
      getDetList.value.add(list);
    });
    return getDetList.value;
  }

  List<DprLab>? getDprLbour_lab() {
    dprLabourlist.forEach((element) {
      var list = new DprLab(
        categoryId: element.catId.toString(),
        subId: element.subId.toString(),
        subcontName: element.subName.toString(),
        nos: element.nos.toString(),
        wages: element.wages.toString(),
        otHrs: element.otHrs.toString(),
        otAmt: element.otAmt.toString(),
        amount: element.netAmt.toString(),
        labRemark: element.remarks.toString(),
      );
      getLablist.value.add(list);
    });
    return getLablist.value;
  }



Future dprLabour_getEntryList() async {
  main_EntryList.value.clear();
  dprLabour_EntryList.value.clear();
  await DPRLabourProvider.getLabour_dpr_EntryList(loginController.user.value.userId, loginController.UserType(), dprlabor_entryList_frdateController.text, dprlabor_entryList_todateController.text)
      .then((value) async {
    if (value != null && value.length > 0) {
      main_EntryList.value = value;
      dprLabour_EntryList.value = main_EntryList.value;
      return main_EntryList.value;
    } else {
      BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
    }
  });
}

Future DprLabourEntryList_EditApi(int workid, BuildContext context, int checkdata) async {
  checkdata != 0 ? aprovedButton = 1 : aprovedButton = 0;
  await DPRLabourProvider.dprLabour_entryList_editAPI(workid).then((value) async {
    if (value != null && value.length > 0) {
      editCheck = 1;
      screencheck=1;
      dpr_EditListApiValue.value = value;
      dprLabour_EditDetTableSave();
      getDetTablesDatas();
      dprLabour_EditLabTableDatas();
      getLabourTablesDatas();
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DailyWrk_Done_DPR_Labour(0)),
      );
    }
  });
}

  Future EntryList_DeleteApi(int WorkId,String WorkNo) async {
    await DPRLabourProvider.entryList_deleteAPI(WorkId,WorkNo,loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  dprLabour_EditDetTableSave() async {
    dprLabourDetModelList.clear();
    dpr_EditListApiValue.forEach((datas) {
      datas.dprEditDet.forEach((element) {
        dprLabourDetmodel = new DprLabour_DetTable();
        dprLabourDetmodel.headItemId = element.headItemId;
        dprLabourDetmodel.subItemId = element.subItemId;
        dprLabourDetmodel.level3ItemId = element.level3ItemId;
        dprLabourDetmodel.woDetId = element.woDetId;
        dprLabourDetmodel.itemDesc = element.itemDesc.toString();
        dprLabourDetmodel.rate = element.rate;
        dprLabourDetmodel.unit = element.unit;
        dprLabourDetmodel.balQty = element.balQty;
        dprLabourDetmodel.qty = element.qty;
        dprLabourDetmodel.boqCode = element.boqCode.toString();
        dprLabourDetModelList.add(dprLabourDetmodel);
      });
      });
    var savedatas =
    await dprLabour_DetService.DprLabour_DetTable_Save(dprLabourDetModelList);
    return savedatas;
  }

  dprLabour_EditLabTableDatas() async {
    dprLabour_saveModelList.clear();
    dpr_EditListApiValue.forEach((datas) {
      datas.dprEditLab.forEach((element) {
        dprLabour_Ok_saveModel = new DprLabour_LabTableModel();
        dprLabour_Ok_saveModel.catId = element.categoryId;
        dprLabour_Ok_saveModel.catName = element.categoryName.toString();
        dprLabour_Ok_saveModel.subId = element.SubContId;
        dprLabour_Ok_saveModel.subName = element.SubContName.toString();
        dprLabour_Ok_saveModel.wages = element.wages;
        dprLabour_Ok_saveModel.nos = element.nos.toString();
        dprLabour_Ok_saveModel.otHrs = element.otHrs.toString();
        dprLabour_Ok_saveModel.otAmt = element.otAmt;
        dprLabour_Ok_saveModel.netAmt = element.amount;
        dprLabour_saveModelList.add(dprLabour_Ok_saveModel);
      });
    });
    var savedatas = await dprLabour_LabScreenService.DprLabour_LabScreenTable_Save(dprLabour_saveModelList);
  }

  Future DeleteAlert(BuildContext context,int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to delete?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child:Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
             editCheck=0;
             screencheck=0;
             EntryList_DeleteApi(dprLabour_EntryList[index].workId,dprLabour_EntryList[index].workNo);
             dprLabour_EntryList.removeAt(index);
              Navigator.of(context).pop();
            },
            child:Text('Yes'),
          ),
        ],
      ),
    );
  }

}