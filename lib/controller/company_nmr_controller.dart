import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';

import '../db_model/cmpnmr_savereq_model.dart';
import '../db_model/companynmr_atd_labourlist_dbmodel.dart';
import '../db_services/companynmr_services.dart';
import '../home/menu/daily_entries/company_nmr_attendance/company_nmr_main.dart';
import '../home/menu/daily_entries/company_nmr_attendance/listpopup_alert.dart';
import '../home/pending_list/pending_list.dart';
import '../provider/companynmr_atdprovider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'companycontroller.dart';
import 'logincontroller.dart';

class CompanyNmrAttendanceController extends GetxController{

  LoginController loginController=Get.put(LoginController());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  CompanyController companyController=Get.put(CompanyController());
  PendingListController pendingListController=Get.put(PendingListController());
  final Company_EntryNo = TextEditingController();
  final Company_EntryDate = TextEditingController();
  final Company_EntryRemarks = TextEditingController();
  final Company_EntryPreparedby = TextEditingController();
  final Company_EntrylistFrdate = TextEditingController();
  final Company_EntrylistTodate = TextEditingController();

  RxList AlldataList = [].obs;
  RxList list=[].obs;
  RxList CompanyEntrylist=[].obs;
  RxList EditListApiValue=[].obs;
  RxString saveButton=RequestConstant.SAVE.obs;
  RxList Entrylist=[].obs;
  RxList pendingAllDatasList = [].obs;
  late List<bool> isChecked;

  int entrycheck=0;
  int edicheck=0;
  RxString screencheck="".obs;
  int atId=0;

  late List<CompanyNMRDetTableModel> cmpnmrTableList = <CompanyNMRDetTableModel>[];
  late List<CompanyNMRDetTableModel> updateListDatas = <CompanyNMRDetTableModel>[];
  late List<CompanyNMRDetTableModel> deleteModelList = <CompanyNMRDetTableModel>[];
  RxList<AttendanceDet> getsaveDetList = <AttendanceDet>[].obs;

  var companyNMRTableModel = CompanyNMRDetTableModel();
  var companyNMR_DetService = CompanyNMR_DetService();
  RxList cmpNmr_getDbDetList = [].obs;

  List<TextEditingController> oThrsText = [];
  List<TextEditingController> busfareText = [];
  List<TextEditingController> advanceText = [];
  List<TextEditingController> statusText = [];
  List<TextEditingController> remarksText = [];


 textControllersInitiate() {
   oThrsText.add(new TextEditingController());
   busfareText.add(new TextEditingController());
   advanceText.add(new TextEditingController());
   statusText.add(new TextEditingController());
   remarksText.add(new TextEditingController());
  }


  getCompanyEntryList(String Frdate, String Todate){
    CompanyEntrylist.value.clear();
    Entrylist.value.clear();
    CompanyNmrAttendance_Provider.Company_NmrEntryListAPI(
        loginController.user.value.userId!,
        loginController.user.value.userType!,
        Company_EntrylistFrdate.text,
        Company_EntrylistTodate.text
    ).then((value){
      if(value!=null){
        CompanyEntrylist.value = value;
        Entrylist.value = CompanyEntrylist.value;
      }
    });
  }



  getCompanyaddList(int cId,BuildContext context) async {
    await CompanyNmrAttendance_Provider.Material_IntentList_editAPI(cId).then((value) {
      if(value!=null){
        AlldataList.value = value;
        AlldataList.value;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CompanyNmr_ListAlert();
            });
      }
      else{
        AlldataList.value.clear();
        BaseUtitiles.showToast("No Labour Record!");
      }

    });
  }


  Future deleteParticularList(CompanyNMRDetTableModel data) async {
    deleteModelList.clear();
    companyNMRTableModel =new CompanyNMRDetTableModel();
    companyNMRTableModel.labourId = data.labourId!;
    deleteModelList.add(companyNMRTableModel);
    await companyNMR_DetService.CompanyNMR_Det_deleteById(deleteModelList);
  }

  delete_cmpNmrdetTable() async {
    await companyNMR_DetService.CompanyNMR_Dettable_delete();
  }

  cmpNmr_Det_Save_DB(BuildContext context) async {
    cmpnmrTableList.clear();
    int i = 0;
    AlldataList.forEach((element) {
      if(element.ischeck==true){
        companyNMRTableModel =new CompanyNMRDetTableModel();
        companyNMRTableModel.labourId = element.labourId!;
        companyNMRTableModel.labourName = element.labourName!;
        companyNMRTableModel.Labour_No = element.Labour_No!;
        companyNMRTableModel.categaryName = element.categaryName!;
        companyNMRTableModel.wages = double.parse(element.wages!.toString());
        companyNMRTableModel.shift = "Day";
        companyNMRTableModel.status = "Present";
        companyNMRTableModel.busfare = 0.0;
        companyNMRTableModel.othrs = 0.0;
        companyNMRTableModel.advance = 0.0;
        companyNMRTableModel.detRemarks="-";
          cmpNmr_getDbDetList.forEach((element) {
            if (element.labourId == companyNMRTableModel.labourId) {
              i = 1;
              BaseUtitiles.showToast("Entries already exist");
            }
          });
          if (i == 0) {
            cmpnmrTableList.add(companyNMRTableModel);
          }
          else{
            i=0;
          }
        }
    });
    var savedatas = await companyNMR_DetService.CompanyNMR_DetTable_Save(cmpnmrTableList);
    return Navigator.pop(context, savedatas);
  }



  Future getcmpNMRTablesDatas() async {
    cmpNmr_getDbDetList.clear();
    var Matlist = await companyNMR_DetService.CompanyNMR_DetTable_readAll();
    Matlist.forEach((user) {
      companyNMRTableModel =new CompanyNMRDetTableModel();
      companyNMRTableModel.labourId = user['labourId'];
      companyNMRTableModel.labourName = user['labourName'];
      companyNMRTableModel.Labour_No = user['Labour_No'];
      companyNMRTableModel.categaryName = user['categaryName'];
      companyNMRTableModel.wages = user['wages'];
      companyNMRTableModel.shift = user['shift'];
      companyNMRTableModel.status = user['status'];
      companyNMRTableModel.busfare = user['busfare'];
      companyNMRTableModel.othrs = user['othrs'];
      companyNMRTableModel.advance = user['advance'];
      companyNMRTableModel.detRemarks=user['detRemarks'];
      cmpNmr_getDbDetList.add(companyNMRTableModel);
    });
    setTextControllersValue();
  }

  setTextControllersValue() async {
    for (var index = 0; index < cmpNmr_getDbDetList.length; index++) {
      textControllersInitiate();
      statusText[index].text = cmpNmr_getDbDetList.value[index].status.toString();
      busfareText[index].text=cmpNmr_getDbDetList.value[index].busfare.toString();
      oThrsText[index].text=cmpNmr_getDbDetList.value[index].othrs.toString();
      advanceText[index].text=cmpNmr_getDbDetList.value[index].advance.toString();
      remarksText[index].text=cmpNmr_getDbDetList.value[index].detRemarks.toString();
    }
  }

  updateDBTables() async {
    int i = 0;
    updateListDatas.clear();
    cmpNmr_getDbDetList.forEach((element) {
      textControllersInitiate();
      companyNMRTableModel =new CompanyNMRDetTableModel();
      companyNMRTableModel.labourId = element.labourId!;
      companyNMRTableModel.labourName = element.labourName!;
      companyNMRTableModel.Labour_No = element.Labour_No!;
      companyNMRTableModel.categaryName = element.categaryName!;
      companyNMRTableModel.wages = element.wages!;
      companyNMRTableModel.shift = "Day";
      companyNMRTableModel.status = statusText[i].text.toString();
      companyNMRTableModel.busfare = double.parse(busfareText[i].text.toString());
      companyNMRTableModel.othrs = double.parse(oThrsText[i].text.toString());
      companyNMRTableModel.advance = double.parse(advanceText[i].text.toString());
      companyNMRTableModel.detRemarks=remarksText[i].text.toString();
      updateListDatas.add(companyNMRTableModel);
      i++;
    });
    await companyNMR_DetService.CompanyNMR_DetTable_Update(updateListDatas);

  }


  setCheck(int id,bool value){
    AlldataList.forEach((element) {
      if(element.labourId==id){
        element.ischeck = value;
      }
    });
  }

  serachsetCheck(int id,bool value){
    list.forEach((element) {
      if(element.labourId==id){
        element.ischeck = value;
      }
    });
  }


  Future editSaveDetTable() async {
    cmpnmrTableList.clear();
    EditListApiValue.forEach((element) {
      element.attendanceDet.forEach((val) {
        companyNMRTableModel =new CompanyNMRDetTableModel();
        companyNMRTableModel.labourId = val.nmrLbrId!;
        companyNMRTableModel.labourName = val.labourName!;
        companyNMRTableModel.Labour_No = element.attenNo!;
        companyNMRTableModel.categaryName = val.categoryName!;
        companyNMRTableModel.wages = val.wages!;
        companyNMRTableModel.shift = val.shiftName!;
        companyNMRTableModel.status = val.statusName!;
        companyNMRTableModel.busfare = val.busfare!;
        companyNMRTableModel.othrs =val.otHrs!;
        companyNMRTableModel.advance = val.Advance!;
        companyNMRTableModel.detRemarks=val.detRemarks!;
        cmpnmrTableList.add(companyNMRTableModel);
      });
    });
    var savedatas = await companyNMR_DetService.CompanyNMR_DetTable_Save(cmpnmrTableList);
    return  savedatas;
  }

  Future entryList_EditApi(int reqId, BuildContext context) async {
    await CompanyNmrAttendance_Provider.Company_NmrList_EditAPI(reqId).then((value) async {
      if (value != null && value.length > 0) {
        delete_cmpNmrdetTable();
        edicheck = 1;
        screencheck.value="";
        EditListApiValue.value = value;
        editSaveDetTable();
        getcmpNMRTablesDatas();
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CompanyNmrMain(0)),
        );
      }
    });
  }


  //----- SAVE AND UPDATE Button----
  Future SaveAPI(BuildContext context, int id) async {
    await Future.delayed(const Duration(seconds:0));
    String body = cmpNmrSaveReqModelToJson(CmpNmrSaveReqModel(
      attenId: id != 0 ? id.toString() : "0",
      attenNo: Company_EntryNo.text,
      attenDate: Company_EntryDate.text,
      projectId: projectController.selectedProjectId.value.toString(),
      siteId: siteController.selectedsiteId.value.toString(),
      remarks: Company_EntryRemarks.text,
      preparedby: loginController.EmpId(),
      approvedby: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      entryMode:saveButton.value=="Save"?"ADD":saveButton.value=="Update"?"UPDATE":saveButton.value=="Approval"?"APPROVE":saveButton.value=="Approve"?"APPROVE":"",
      attendanceDet: attendanceListDet(),
    ));
    final list = await CompanyNmrAttendance_Provider.SaveEntryscreenAPI(body, id,screencheck.value,context);
    if (list != null && id != 0) {
      print(list);
      if(screencheck.value=="Aproval"){
        BaseUtitiles.showToast(list);
        print(list);
        if(list=="Record Approved Successfully..."){
          Navigator.pop(context);
          Navigator.pop(context);
          // Navigator.pushReplacement(
          //     context,
          //     new MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //         new PendingList()));
          await pendingListController.getPendingList();
          return  Navigator.pop(context);
        }
        Navigator.pop(context);

      }
      else{
        BaseUtitiles.showToast(list);
        if(list=="Record Updated Successfully..."){
          cleasrDatas();
          Navigator.pop(context);
          return Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new CompanyNmrMain(1)));
        }
        Navigator.pop(context);
        }
    }
    else {
      if (list == RequestConstant.DUPLICATE_OCCURED) {
        BaseUtitiles.showToast(list!);
        Navigator.pop(context);
        return Navigator.pop(context);
      } else {
        BaseUtitiles.showToast(list!);
        print(list);
        if(list=="Record Saved Successfully..."){
          cleasrDatas();
          Navigator.pop(context);
          return Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new CompanyNmrMain(1)));
        }
        Navigator.pop(context);
      }
    }
  }


  cleasrDatas(){
    entrycheck=0;
    edicheck=0;
    atId=0;
    screencheck.value="";
    delete_cmpNmrdetTable();
    cmpNmr_getDbDetList.clear();
    EditListApiValue.value.clear();
    Company_EntryDate.text=BaseUtitiles.initiateCurrentDateFormat();
    projectController.selectedProjectId.value=0;
    projectController.projectname.text="";
    siteController.selectedsiteId.value=0;
    siteController.Sitename.text="";
    companyController.selectedCompanyId.value=0;
    companyController.CompanyName.text="";
    Company_EntryRemarks.text="";
    Company_EntryPreparedby.text=loginController.EmpName();
  }

  List<AttendanceDet>? attendanceListDet() {
    getsaveDetList.value.clear();
    cmpNmr_getDbDetList.value.forEach((element) {
      var list = new AttendanceDet(
        nmrLbrId: element.labourId.toString(),
        nmrLbrName: element.labourName.toString(),
        shift: 'D',
        status: element.status.toString()=="Present"?"P":element.status.toString()=="Absent"?"A":element.status.toString()=="Half-Day"?"H":"J",
        wages: element.wages.toString(),
        otHrs: element.othrs.toString(),
        busfare: element.busfare.toString(),
        Advance: element.advance.toString(),
        detRemarks: element.detRemarks.toString(),
      );
      getsaveDetList.value.add(list);
    });
    return getsaveDetList.value;
  }


  Future EntryList_DeleteApi(int atId, String atNo) async {
    await CompanyNmrAttendance_Provider.entryList_deleteAPI(atId,atNo, loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }
  Future DeleteAlert(BuildContext context,int index) async {
    return await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Alert!'),
            content: Text('Do you want to delete?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  entrycheck = 0;
                  edicheck = 0;
                  EntryList_DeleteApi(Entrylist.value[index].nmrLbrAttnId, Entrylist.value[index].nmrLbrAttnNo);
                  Entrylist.removeAt(index);
                  Navigator.of(context).pop();
                },
                child: Text('Yes'),
              ),
            ],
          ),
    );
  }

  Future getPendingList_Alldatas(int reqId,BuildContext context) async {
    pendingAllDatasList.clear();
    await CompanyNmrAttendance_Provider.Company_NmrList_EditAPI(reqId).then((value) async {
      if (value != null && value.length > 0) {
        pendingAllDatasList.value = value;
         edicheck=0;
         entrycheck=1;
        screencheck.value="Aproval";
        pendingIntentAlldatas_SaveDetTable();
        getcmpNMRTablesDatas();
        FocusScope.of(context).unfocus();
        Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyNmrMain(0)));
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future pendingIntentAlldatas_SaveDetTable() async {
    cmpnmrTableList.clear();
    pendingAllDatasList.value.forEach((element) {
      element.attendanceDet.forEach((val) {
        companyNMRTableModel =new CompanyNMRDetTableModel();
        companyNMRTableModel.labourId = val.nmrLbrId!;
        companyNMRTableModel.labourName = val.labourName!;
        companyNMRTableModel.Labour_No = element.attenNo!;
        companyNMRTableModel.categaryName = val.categoryName!;
        companyNMRTableModel.wages = val.wages!;
        companyNMRTableModel.shift = val.shiftName!;
        companyNMRTableModel.status = val.statusName!;
        companyNMRTableModel.busfare = val.busfare!;
        companyNMRTableModel.othrs =val.otHrs!;
        companyNMRTableModel.advance = val.Advance!;
        companyNMRTableModel.detRemarks=val.detRemarks!;
        cmpnmrTableList.add(companyNMRTableModel);
      });
    });
    var savedatas = await companyNMR_DetService.CompanyNMR_DetTable_Save(cmpnmrTableList);
    return  savedatas;
  }
}