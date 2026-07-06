import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/controller/subcontcontroller.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';

import '../db_model/cmpnmr_savereq_model.dart';
import '../db_model/companynmr_atd_labourlist_dbmodel.dart';
import '../db_services/companynmr_services.dart';
import '../home/menu/daily_entries/company_nmr_attendance/company_nmr_entrylist.dart';
import '../home/menu/daily_entries/company_nmr_attendance/company_nmr_entryscreen.dart';
import '../home/menu/daily_entries/company_nmr_attendance/company_nmr_main.dart';
import '../home/menu/daily_entries/company_nmr_attendance/listpopup_alert.dart';
import '../home/pending_list/pending_list.dart';
import '../models/cmpnmr_edit_resmodel.dart';
import '../provider/companynmr_atdprovider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'companycontroller.dart';
import 'dailyentries_controller.dart';
import 'logincontroller.dart';

class CompanyNmrAttendanceController extends GetxController{

  LoginController loginController=Get.put(LoginController());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  CompanyController companyController=Get.put(CompanyController());
  PendingListController pendingListController=Get.put(PendingListController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());

  final Company_EntryNo = TextEditingController();
  final Company_EntryDate = TextEditingController();
  final Company_EntryRemarks = TextEditingController();
  final Company_EntrylistFrdate = TextEditingController();
  final Company_EntrylistTodate = TextEditingController();

  RxList AlldataList = [].obs;
  RxList list=[].obs;
  RxList CompanyEntrylist=[].obs;
  RxList labourStatusList=[].obs;
  RxList EditListApiValue=[].obs;
  RxString saveButton=RequestConstant.SUBMIT.obs;
  RxList Entrylist=[].obs;
  RxList pendingAllDatasList = [].obs;

  late List<bool> isChecked;

  int attendId=0;
  late List<CompanyNMRDetTableModel> cmpnmrTableList = <CompanyNMRDetTableModel>[];
  late List<CompanyNMRDetTableModel> updateListDatas = <CompanyNMRDetTableModel>[];
  late List<CompanyNMRDetTableModel> deleteModelList = <CompanyNMRDetTableModel>[];
  RxList<NmrLbrattendDetLink> getsaveDetList = <NmrLbrattendDetLink>[].obs;

  var companyNMRTableModel = CompanyNMRDetTableModel();
  var companyNMR_DetService = CompanyNMR_DetService();
  RxList cmpNmr_getDbDetList = [].obs;

  List<TextEditingController> oThrsText = [];
  List<TextEditingController> busfareText = [];
  List<TextEditingController> advanceText = [];
  List<TextEditingController> statusText = [];
  List<TextEditingController> remarksText = [];
  List<TextEditingController> statusKeyText = [];


 textControllersInitiate() {
   oThrsText.add(new TextEditingController());
   // busfareText.add(new TextEditingController());
   // advanceText.add(new TextEditingController());
   statusText.add(new TextEditingController());
   statusKeyText.add(new TextEditingController());
   remarksText.add(new TextEditingController());
  }

  Future getCompanyEntryList() async {
    CompanyEntrylist.value=[];
    Entrylist.value=[];
    var response = await CompanyNmrAttendance_Provider.Company_NmrEntryListAPI(
        Company_EntrylistFrdate.text, Company_EntrylistTodate.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          CompanyEntrylist.assignAll(response.result!);
          Entrylist.assignAll(response.result!);
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

  Future getLabourList(BuildContext context, SubcontId) async {
    AlldataList.value=[];
    final value = await CompanyNmrAttendance_Provider.getLabourListAPI(SubcontId);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          AlldataList.value=value.result!;
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CompanyNmr_ListAlert(list: AlldataList.value);
              });
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

  Future getLabourStatusList() async {
    labourStatusList.value.clear();
    var response = await CompanyNmrAttendance_Provider.getLabourStatusListAPI();
    if (response != null) {
      if (response["success"] == true) {
        if (response["result"].isNotEmpty) {
          labourStatusList.value=response["result"]!;
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response["message"] ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
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
        companyNMRTableModel.reqDetId = 0;
        companyNMRTableModel.labourId = element.labourId!;
        companyNMRTableModel.categaryId = element.categoryId!;
        companyNMRTableModel.labourName = element.labourName!;
        companyNMRTableModel.labourNo = element.labourNo!;
        companyNMRTableModel.categaryName = element.categoryName!;
        companyNMRTableModel.wages = double.parse(element.wages!.toString());
        companyNMRTableModel.status = "Present";
        companyNMRTableModel.statusKeyText = "P";
        companyNMRTableModel.othrs = 0.0;
        companyNMRTableModel.detRemarks= "";
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
      companyNMRTableModel.reqDetId = user['reqDetId'];
      companyNMRTableModel.labourId = user['labourId'];
      companyNMRTableModel.categaryId = user['categaryId'];
      companyNMRTableModel.labourName = user['labourName'];
      companyNMRTableModel.labourNo = user['labourNo'];
      companyNMRTableModel.categaryName = user['categaryName'];
      companyNMRTableModel.wages = user['wages'];
      companyNMRTableModel.status = user['status'];
      companyNMRTableModel.statusKeyText = user['statusKeyText'];
      companyNMRTableModel.othrs = user['othrs'];
      companyNMRTableModel.detRemarks=user['detRemarks'];
      cmpNmr_getDbDetList.add(companyNMRTableModel);
    });
    setTextControllersValue();
  }

  setTextControllersValue() async {
    for (var index = 0; index < cmpNmr_getDbDetList.length; index++) {
      textControllersInitiate();
      statusText[index].text = cmpNmr_getDbDetList.value[index].status.toString();
      statusKeyText[index].text = cmpNmr_getDbDetList.value[index].statusKeyText.toString();
      oThrsText[index].text=cmpNmr_getDbDetList.value[index].othrs.toString();
      remarksText[index].text=cmpNmr_getDbDetList.value[index].detRemarks.toString();
    }
  }

  updateDBTables() async {
    int i = 0;
    updateListDatas.clear();
    cmpNmr_getDbDetList.forEach((element) {
      textControllersInitiate();
      companyNMRTableModel =new CompanyNMRDetTableModel();
      companyNMRTableModel.reqDetId = element.reqDetId!;
      companyNMRTableModel.labourId = element.labourId!;
      companyNMRTableModel.labourName = element.labourName!;
      companyNMRTableModel.labourNo = element.labourNo!;
      companyNMRTableModel.categaryName = element.categaryName!;
      companyNMRTableModel.categaryId = element.categaryId!;
      companyNMRTableModel.wages = element.wages!;
      companyNMRTableModel.status = statusText[i].text.toString();
      companyNMRTableModel.statusKeyText = statusKeyText[i].text.toString();
      companyNMRTableModel.othrs = double.parse(oThrsText[i].text.toString());
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

  Future entryList_EditApi(int reqId,status,type,String MenuName, BuildContext context) async {
    EditListApiValue.value=[];
    var response = await CompanyNmrAttendance_Provider.Company_NmrList_EditAPI(reqId,status);
    if (response != null) {
      if (response.success == true) {
        EditListApiValue.value=[response.result];
        if (EditListApiValue.isNotEmpty) {
          saveButton.value = type=="Edit"?RequestConstant.RESUBMIT : RequestConstant.APPROVAL;
          delete_cmpNmrdetTable();
          editSaveDetTable();
          getcmpNMRTablesDatas();
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Company_nmr_entryscreen(heading: MenuName,)),
          );
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

  Future editSaveDetTable() async {
    cmpnmrTableList.clear();
    EditListApiValue.forEach((element) {
      element.nmrLbrattendDetLink.forEach((val) {
        companyNMRTableModel =new CompanyNMRDetTableModel();
        companyNMRTableModel.reqDetId = val.id!;
        companyNMRTableModel.labourId = val.nmrLabourInfoId!;
        companyNMRTableModel.labourName = val.labourName!;
        companyNMRTableModel.labourNo = "-";
        companyNMRTableModel.categaryName = val.labourCategoryName;
        companyNMRTableModel.categaryId = val.nmrLabourCategoryId;
        companyNMRTableModel.wages = val.wages!;
        companyNMRTableModel.status =val.statusDesc;
        companyNMRTableModel.statusKeyText = val.status!;
        companyNMRTableModel.othrs =val.otHrs!;
        companyNMRTableModel.detRemarks=val.remarks!;
        cmpnmrTableList.add(companyNMRTableModel);
      });
    });
    var savedatas = await companyNMR_DetService.CompanyNMR_DetTable_Save(cmpnmrTableList);
    return  savedatas;
  }

  //----- SAVE AND UPDATE Button----
  Future SaveAPI(BuildContext context, int id) async {
    await Future.delayed(const Duration(seconds:0));
    String body = cmpNmrSaveReqModelToJson(CmpNmrSaveReqModel(
      id: id,
      nmrLabourAttendanceNo: Company_EntryNo.text,
      nmrLabourAttendanceDate: Company_EntryDate.text,
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      subContractorId: subcontractorController.selectedSubcontId.value,
      billStatus: "N",
      workType: dailyEntriesController.Nmr_Rate.value,
      remarks: Company_EntryRemarks.text,
      createdBy: int.tryParse(loginController.EmpId()),
      createdDt: BaseUtitiles().convertToUtcIso(Company_EntryDate.text),
      approveStatus: saveButton.value == RequestConstant.APPROVAL ?"Y":"N",
      approvedBy: int.tryParse(loginController.EmpId()),
      approveDt: BaseUtitiles().convertToUtcIso(Company_EntryDate.text),
      nmrLbrattendDetLink: attendanceListDet(id),
    ));

    final decodedJson = jsonDecode(body);

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(decodedJson);

    debugPrint(prettyJson, wrapWidth: 1024);

    final list = await CompanyNmrAttendance_Provider.SaveEntryScreenAPI(body, id,context);
    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        clearDatas();
        await getCompanyEntryList();
        BaseUtitiles.popMultiple(context, count: 3);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }


  clearDatas(){
    attendId=0;
    delete_cmpNmrdetTable();
    cmpNmr_getDbDetList.clear();
    EditListApiValue.value.clear();
    Company_EntryDate.text=BaseUtitiles.initiateCurrentDateFormat();
    projectController.selectedProjectId.value=0;
    projectController.projectname.text="";
    siteController.selectedsiteId.value=0;
    siteController.Sitename.text="";
    subcontractorController.Subcontractorname.text = "--SELECT--";
    subcontractorController.selectedSubcontId.value = 0;
    dailyEntriesController.WorkTypeTextController.text = "NMR";
    dailyEntriesController.Nmr_Rate.value = RequestConstant.N;
    Company_EntryRemarks.text="";
  }

  List<NmrLbrattendDetLink>? attendanceListDet(id) {
    getsaveDetList.value=[];
    cmpNmr_getDbDetList.forEach((element) {
      var list = NmrLbrattendDetLink(
        id: saveButton.value == RequestConstant.RESUBMIT?element.reqDetId : 0,
        nmrLabourAttendanceMasId: saveButton.value == RequestConstant.RESUBMIT ? id : 0,
        nmrLabourInfoId: element.labourId,
        siteId: siteController.selectedsiteId.value,
        status: element.statusKeyText,
        wages: element.wages,
        otHrs: element.othrs,
        advance: 0,
        remarks: element.detRemarks,
        busFare: 0,
        shift: 'D',
        otAmount: 0,
        nmrLabourCategoryId: element.categaryId,
      );
      getsaveDetList.value.add(list);
    });
    return getsaveDetList.value;
  }


  Future<bool> EntryList_DeleteApi(int reqId) async {
    return CompanyNmrAttendance_Provider.entryList_deleteAPI(reqId);
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
                          bool result = await EntryList_DeleteApi(CompanyEntrylist.value[index].id);
                          if (result) {
                            CompanyEntrylist.removeAt(index);
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


  // Future getPendingList_Alldatas(int reqId,BuildContext context) async {
  //   pendingAllDatasList.clear();
  //   await CompanyNmrAttendance_Provider.Company_NmrList_EditAPI(reqId).then((value) async {
  //     if (value != null && value.length > 0) {
  //       pendingAllDatasList.value = value;
  //       pendingIntentAlldatas_SaveDetTable();
  //       getcmpNMRTablesDatas();
  //       FocusScope.of(context).unfocus();
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => Company_nmr_entrylist()));
  //     }
  //     else {
  //       BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
  //     }
  //   });
  // }

  Future pendingIntentAlldatas_SaveDetTable() async {
    cmpnmrTableList.clear();
    pendingAllDatasList.value.forEach((element) {
      element.attendanceDet.forEach((val) {
        companyNMRTableModel =new CompanyNMRDetTableModel();
        companyNMRTableModel.labourId = val.nmrLbrId!;
        companyNMRTableModel.labourName = val.labourName!;
        companyNMRTableModel.labourNo = element.attenNo!;
        companyNMRTableModel.categaryName = val.categoryName!;
        companyNMRTableModel.wages = val.wages!;
        companyNMRTableModel.status = val.statusName!;
        companyNMRTableModel.statusKeyText = val.statusKeyText!;
        companyNMRTableModel.othrs =val.otHrs!;
        companyNMRTableModel.detRemarks=val.detRemarks!;
        cmpnmrTableList.add(companyNMRTableModel);
      });
    });
    var savedatas = await companyNMR_DetService.CompanyNMR_DetTable_Save(cmpnmrTableList);
    return  savedatas;
  }
}