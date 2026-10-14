import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../controller/logincontroller.dart';
import '../controller/pendinglistcontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/subcont_attendance_det_model.dart';
import '../db_services/subcont_attendance_det_service.dart';
import '../home/menu/daily_entries/subcontractor_attendance_VCPL/subattendance_site_entry.dart';
// import '../home/menu/daily_entries/subcontractor_attendance_site_New/subattendance_site_entry.dart';
import '../home/menu/daily_entries/subcontractor_attendance_VCPL/subcontractor_site_category.dart';
import '../home/pending_list/pending_list.dart';
import '../models/get_atten_image.dart';
import '../models/labr_atten_response.dart';
import '../models/subcont_entryscreen_save_model.dart';
import '../provider/inward_pending_provider.dart';
import '../provider/subcont_attendance_provider.dart';
import '../utilities/apiconstant.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int? DLRId;

class DailyEntriesController extends GetxController {
  ProjectController projectController = Get.put(ProjectController());
  PendingListController pendingListController =
  Get.put(PendingListController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController =
  Get.put(SubcontractorController());
  LoginController loginController = Get.put(LoginController());

  final AttendDateController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final RemarksController = TextEditingController();
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  final WorkTypeTextController = TextEditingController();
  final shiftTextController = TextEditingController();

  List<TextEditingController> NosControllers = [];
  List<TextEditingController> OtHrsController = [];
  List<TextEditingController> EntrySCreenNosControllers = [];
  List<TextEditingController> ExtrasControllers = [];
  List<TextEditingController> EvgOtHrsControllers = [];
  List<TextEditingController> EvgOtAmtControllers = [];
  List<TextEditingController> MrngOtHrsControllers = [];
  List<TextEditingController> MrngOtAmtControllers = [];
  List<TextEditingController> EvgExtraAmtControllers = [];
  List<TextEditingController> hrsControllers = [];
  List<TextEditingController> NetAmtController = [];
  List<TextEditingController> RemarksControllers = [];

  RxList store_ShowList = [].obs;
  RxList<SubContLabourAttendDetS> getAttendanceDetailsDto =
      <SubContLabourAttendDetS>[].obs;
  RxList AttenEtyList = [].obs;
  RxList Entrylist = [].obs;

  RxString shiftType = "D".obs;

  RxList EditListResDatas = [].obs;
  RxList readListdata = [].obs;
  List subContDetReadList = <SubContDetModel>[];

  late List<SubContDetModel> deleteModelList = <SubContDetModel>[];
  late List<SubContDetModel> subcontModelList = <SubContDetModel>[];
  late List<SubContDetModel> UpdateModelList = <SubContDetModel>[];
  var subContAttendatanceDetService = SubContAttendatanceDetService();
  var subContDetModel = SubContDetModel();

  int attendId = 0;
  var total_Amount = 0.0;
  var total_Nos = 0.0;
  RxInt createdById = 0.obs;

  RxString saveButton = RequestConstant.SUBMIT.obs;
  RxString Nmr_Rate = RequestConstant.N.obs;

  Future getShowClickPopList(BuildContext context) async {
    store_ShowList.value = [];
    await ClickUtils.run(() async {
    final value = await SubContAttendanceProvider.getSubcontAttenDetList(
        projectController.selectedProjectId.value,
        subcontractorController.selectedSubcontId.value);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          store_ShowList.value = value.result!;
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Subcontractor_Site_Category(type: 'subcontAttendance',)));
        } else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    }
    });
  }

  saveSubContDetTableDatas(BuildContext context) async {
    subcontModelList = [];
    int i = 0;
    int j = 0;
    store_ShowList.forEach((element) {
      if ((NosControllers[i].text.isEmpty ||
          double.parse(NosControllers[i].text) == 0) &&
          (OtHrsController[i].text.isEmpty ||
              double.parse(OtHrsController[i].text) == 0)) {
      } else {
        subContDetModel = SubContDetModel();
        subContDetModel.catId = element.categoryId;
        subContDetModel.catName = element.categoryName;
        subContDetModel.wages = element.wages;
        subContDetModel.nos = NosControllers[i].value.text.isEmpty
            ? "0.0"
            : NosControllers[i].value.text;
        subContDetModel.remarks = "-";
        subContDetModel.siteId = siteController.selectedsiteId.value;
        subContDetModel.siteName = siteController.Sitename.text;
        subContDetModel.Extra = 0.0;
        subContDetModel.MrgOtHrs = double.parse(
            OtHrsController[i].value.text.isEmpty
                ? "0"
                : OtHrsController[i].value.text);
        subContDetModel.MrgOtAmt = OtHrsController[i].value.text != ""
            ? double.parse(
            (((element.wages / 8) * subContDetModel.MrgOtHrs!)
                .toStringAsFixed(2)))
            : 0.0;
        subContDetModel.EvgOtHrs = 0.0;
        subContDetModel.EvgOtAmt = 0.0;
        subContDetModel.EvgExtrsAmt = 0.0;
        subContDetModel.hrs = 0.0;
        if (AppClient.isVrindhavana) {
          subContDetModel.netAmt = double.parse(
            (
                (double.tryParse(NosControllers[i].text) ?? 0) *
                    (element.wages / 8) *
                    0 +
                    subContDetModel.MrgOtAmt!
            ).toStringAsFixed(2),
          );
        } else {
          subContDetModel.netAmt =
              double.parse(
                  ((element.wages *
                      (double.tryParse(NosControllers[i].text) ?? 0) +
                      subContDetModel.MrgOtAmt!)
                      .toStringAsFixed(2)));
        }
        readListdata.value.forEach((element) {
          if (element.siteId == subContDetModel.siteId &&
              element.catId == subContDetModel.catId) {
            j = 1;
          }
        });
        if (AppClient.isVrindhavana) {
          subcontModelList.add(subContDetModel);
        }else{
          if (j == 0) {
            subcontModelList.add(subContDetModel);
          } else {
            BaseUtitiles.showToast("Entry already exist");
            j = 0;
          }
        }
      }
      i++;
    });
    var savedatas =
    await subContAttendatanceDetService.SubContDetSave(subcontModelList);
    return Navigator.pop(context, savedatas);
  }

  deleteSubcontDetTableDatas() async {
    await subContAttendatanceDetService.SubContDetdelete();
  }
  void clearControllers() {
    // Entry Screen Nos
    for (final c in EntrySCreenNosControllers) {
      c.dispose();
    }
    EntrySCreenNosControllers.clear();

    // Net Amount
    for (final c in NetAmtController) {
      c.dispose();
    }
    NetAmtController.clear();

    // Nos
    for (final c in NosControllers) {
      c.dispose();
    }
    NosControllers.clear();

    // OT Hours
    for (final c in OtHrsController) {
      c.dispose();
    }
    OtHrsController.clear();

    // Extras
    for (final c in ExtrasControllers) {
      c.dispose();
    }
    ExtrasControllers.clear();

    // Evening OT Hours
    for (final c in EvgOtHrsControllers) {
      c.dispose();
    }
    EvgOtHrsControllers.clear();

    // Evening OT Amount
    for (final c in EvgOtAmtControllers) {
      c.dispose();
    }
    EvgOtAmtControllers.clear();

    // Morning OT Hours
    for (final c in MrngOtHrsControllers) {
      c.dispose();
    }
    MrngOtHrsControllers.clear();

    // Morning OT Amount
    for (final c in MrngOtAmtControllers) {
      c.dispose();
    }
    MrngOtAmtControllers.clear();

    // Evening Extra Amount
    for (final c in EvgExtraAmtControllers) {
      c.dispose();
    }
    EvgExtraAmtControllers.clear();

    // Hours
    for (final c in hrsControllers) {
      c.dispose();
    }
    hrsControllers.clear();

    // Remarks
    for (final c in RemarksControllers) {
      c.dispose();
    }
    RemarksControllers.clear();
  }

  void createControllers() {
    clearControllers();

    for (int i = 0; i < readListdata.length; i++) {
      textControllersInitiate();
    }
  }

  Future getDetTablesDatas() async {
    var subCont = await subContAttendatanceDetService.SubContDetreadAll();
    subContDetReadList = <SubContDetModel>[];
    readListdata.value.clear();
    subCont.forEach((user) {
      var subContDetModel = SubContDetModel();
      if (AppClient.isVrindhavana) {
        subContDetModel.id = user['id'];
      }
      subContDetModel.reqDetId = user['reqDetId'];
      subContDetModel.catId = user['catId'];
      subContDetModel.catName = user['catName'];
      subContDetModel.wages = user['wages'];
      subContDetModel.nos = user['nos'];
      subContDetModel.MrgOtHrs = user['MrgOtHrs'];
      subContDetModel.MrgOtAmt = user['MrgOtAmt'];
      subContDetModel.EvgOtHrs = user['EvgOtHrs'];
      subContDetModel.EvgOtAmt = user['EvgOtAmt'];
      subContDetModel.EvgExtrsAmt = user['EvgExtrsAmt'];
      subContDetModel.Extra = user['Extra'];
      subContDetModel.netAmt = user['netAmt'];
      subContDetModel.remarks = user['remarks'];
      subContDetModel.siteId = user['siteId'];
      subContDetModel.siteName = user['siteName'];
      subContDetModel.hrs = user['hrs'];
      subContDetReadList.add(subContDetModel);
      readListdata.value = subContDetReadList;
    });
    createControllers();          // <-- Add this
    setTextControllersValue();    // <-- Then set values
    getTotalamntAndTotalNos();

    print("object..${readListdata.value.length}");
  }

  Future<void> setTextControllersValue() async {
    clearControllers();

    for (var index = 0; index < readListdata.length; index++) {
      textControllersInitiate();

      EntrySCreenNosControllers[index].text =
          readListdata[index].nos.toString();

      MrngOtHrsControllers[index].text =
          readListdata[index].MrgOtHrs.toString();

      MrngOtAmtControllers[index].text =
          readListdata[index].MrgOtAmt.toString();

      EvgOtHrsControllers[index].text =
          readListdata[index].EvgOtHrs.toString();

      EvgOtAmtControllers[index].text =
          readListdata[index].EvgOtAmt.toString();

      EvgExtraAmtControllers[index].text =
          readListdata[index].EvgExtrsAmt.toString();

      hrsControllers[index].text =
          readListdata[index].hrs.toString();

      ExtrasControllers[index].text =
          readListdata[index].Extra.toString();

      NetAmtController[index].text =
          readListdata[index].netAmt.toString();

      RemarksControllers[index].text =
          readListdata[index].remarks.toString();
    }
  }

  updateSubcontDetValue() async {
    UpdateModelList.clear();
    for (var n = 0; n < readListdata.length; n++) {
      // textControllersInitiate();
      subContDetModel = SubContDetModel();
      if (AppClient.isVrindhavana) {
        subContDetModel.id = readListdata[n].id;
      }
      subContDetModel.reqDetId = readListdata[n].reqDetId;
      subContDetModel.catId = readListdata[n].catId;
      subContDetModel.catName = readListdata[n].catName;
      subContDetModel.wages = readListdata[n].wages;
      subContDetModel.nos = EntrySCreenNosControllers[n].value.text.toString();
      subContDetModel.MrgOtHrs = double.parse(
          MrngOtHrsControllers[n].value.text != ""
              ? MrngOtHrsControllers[n].value.text
              : "0");
      subContDetModel.MrgOtAmt = double.parse(
          MrngOtAmtControllers[n].value.text != ""
              ? MrngOtAmtControllers[n].value.text
              : "0");
      subContDetModel.EvgOtHrs = double.parse(
          EvgOtHrsControllers[n].value.text != ""
              ? EvgOtHrsControllers[n].value.text
              : "0");
      subContDetModel.EvgOtAmt = double.parse(
          EvgOtAmtControllers[n].value.text != ""
              ? EvgOtAmtControllers[n].value.text
              : "0");
      subContDetModel.Extra = double.parse(ExtrasControllers[n].value.text != ""
          ? ExtrasControllers[n].value.text
          : "0");
      subContDetModel.EvgExtrsAmt = double.parse(
          EvgExtraAmtControllers[n].value.text != ""
              ? EvgExtraAmtControllers[n].value.text
              : "0");
      subContDetModel.hrs = double.parse(
          hrsControllers[n].value.text != ""
              ? hrsControllers[n].value.text
              : "0");
      subContDetModel.netAmt = double.parse(NetAmtController[n].value.text != ""
          ? NetAmtController[n].value.text
          : "0");
      subContDetModel.siteId = readListdata[n].siteId;
      subContDetModel.siteName = readListdata[n].siteName.toString();
      subContDetModel.remarks = RemarksControllers[n].value.text;
      UpdateModelList.add(subContDetModel);
    }
    await subContAttendatanceDetService.SubContDetUpdate(UpdateModelList);
  }

  void clickEdit() {
    // textControllersInitiate();

    for (var index = 0; index < readListdata.length; index++) {
      final wages = readListdata[index].wages;

      final mrngOtHrs =
          double.tryParse(MrngOtHrsControllers[index].text) ?? 0;

      final evgOtHrs =
          double.tryParse(EvgOtHrsControllers[index].text) ?? 0;

      final nos =
          double.tryParse(EntrySCreenNosControllers[index].text) ?? 0;

      final extras =
          double.tryParse(ExtrasControllers[index].text) ?? 0;

      final evgExtraAmt =
          double.tryParse(EvgExtraAmtControllers[index].text) ?? 0;

      final hrs =
          double.tryParse(hrsControllers[index].text) ?? 0;

      final mrngOtAmt = (wages / 8) * mrngOtHrs;
      final evgOtAmt = (wages / 8) * evgOtHrs;

      MrngOtAmtControllers[index].text = mrngOtAmt.toStringAsFixed(2);
      EvgOtAmtControllers[index].text = evgOtAmt.toStringAsFixed(2);

      double netAmt;

      if (AppClient.isVrindhavana) {
        netAmt = (nos * wages / 8 * hrs) +
            (extras * nos) +
            evgExtraAmt +
            mrngOtAmt +
            evgOtAmt;
      } else {
        netAmt = (nos * wages ) +
            (extras * nos) +
            evgExtraAmt +
            mrngOtAmt +
            evgOtAmt;
      }

      NetAmtController[index].text = netAmt.toStringAsFixed(2);
    }

    updateSubcontDetValue();
  }

  clearDatas() {
    deleteSubcontDetTableDatas();
    readListdata.value.clear();
    siteController.selectedsiteId.value = 0;
    subcontractorController.selectedSubcontId.value = 0;
    siteController.selectedsitedropdownName = "--SELECT--".obs;
    siteController.getSiteDropdownvalue.value.clear();
    attendId = 0;
    projectController.selectedProjectId = 0.obs;
    AttendDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    // autoYearWiseNoController.text=autoYearWiseNoController.SubcontAttendance_autoYrsWise.value;
    RemarksController.text = "";
    projectController.projectname.text = RequestConstant.SELECT;
    subcontractorController.Subcontractorname.text = RequestConstant.SELECT;
    subcontractorController.selectedSubcontId.value = 0;
    siteController.Sitename.text = RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
    WorkTypeTextController.text = "NMR";
    Nmr_Rate.value = RequestConstant.N;
    shiftTextController.text = "--SELECT--";
    shiftType.value = RequestConstant.D;
  }

  Future SaveEntryScreen(BuildContext context, int id) async {
    await Future.delayed(const Duration(seconds: 0));
    SubcontEntryScreenSaveRequest formdata = SubcontEntryScreenSaveRequest(
      Id: id != 0 ? id : 0,
      attenNo: autoYearWiseNoController.text,
      attenDate: AttendDateController.text,
      totNos: total_Nos,
      totAmt: total_Amount,
      remarks: RemarksController.text,
      createdBy: saveButton.value == RequestConstant.SUBMIT?int.tryParse(loginController.EmpId()):createdById.value,
      // createdDt: BaseUtitiles().convertToUtcIso(AttendDateController.text),
      workType: Nmr_Rate.value.trim(),
      projectId: projectController.selectedProjectId.value,
      subContId: subcontractorController.selectedSubcontId.value,
      siteId: siteController.selectedsiteId.value,
      approveStatus: saveButton.value == RequestConstant.APPROVAL?"Y":"N",
      approvedBy: saveButton.value == RequestConstant.APPROVAL?int.tryParse(loginController.EmpId()):null,
      approvedDt: saveButton.value == RequestConstant.APPROVAL?BaseUtitiles().convertToUtcIso(AttendDateController.text):null,
      subContLabourAttendDetS: getAttendanceDetails(id),
    );
    print(jsonEncode(formdata.toJson()));

    final list = await SubContAttendanceProvider.saveSubContScreenEntryAPI(
        formdata, imageFiles);

    if (list != null) {
      if (list["success"] == true) {
        if (saveButton.value == RequestConstant.SUBMIT ||
            saveButton.value == RequestConstant.RESUBMIT) {
          BaseUtitiles.showToast(list["message"]);
          await getAttenEntryList();
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
    }
  }

  List<SubContLabourAttendDetS>? getAttendanceDetails(id) {
    getAttendanceDetailsDto.value = [];
    for (int index = 0; index < readListdata.length; index++) {
      if (readListdata[index].netAmt > 0) {
        var list = SubContLabourAttendDetS(
            id: saveButton.value == RequestConstant.RESUBMIT
                ? readListdata[index].reqDetId
                : 0,
            rate: readListdata[index].wages,
            siteId: readListdata[index].siteId,
            otHrs: 0,
            subContLabourMasId: id != 0 ? id : 0,
            otNos: 0,
            eveotAmt: readListdata[index].EvgOtAmt,
            eveotHrs: readListdata[index].EvgOtHrs,
            nos: double.tryParse(readListdata[index].nos),
            morotAmt: readListdata[index].MrgOtAmt,
            morotHrs: readListdata[index].MrgOtHrs,
            remarks: readListdata[index].remarks,
            lbrCatId: readListdata[index].catId,
            extra: readListdata[index].Extra,
            extraAmt: readListdata[index].EvgExtrsAmt,
            labourId: subcontractorController.selectedSubcontId.value,
            hrs: readListdata[index].hrs,
            totalAmount: readListdata[index].netAmt);
        getAttendanceDetailsDto.add(list);
      }
    }
    return getAttendanceDetailsDto;
  }

  getTotalamntAndTotalNos() {
    total_Amount = 0.0;
    total_Nos = 0.0;
    for (int val = 0; val < readListdata.length; val++) {
      total_Amount += double.parse(readListdata[val].netAmt!.toString());
      total_Nos += double.parse(readListdata[val].nos!.toString() != ""
          ? readListdata[val].nos!.toString()
          : "0");
    }
    print(total_Amount.toString());
    print(total_Nos.toString());
  }

  Future getAttenEntryList() async {
    AttenEtyList.value = [];
    Entrylist.value = [];
    var response = await SubContAttendanceProvider.getSubcontAttenEntry_List(
        FromdateController.text, TodateController.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          AttenEtyList.assignAll(response.result!);
          Entrylist.assignAll(response.result!);
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

  Future deleteParticularList(SubContDetModel data) async {
    deleteModelList.clear();
    subContDetModel = SubContDetModel();
    if (AppClient.isVrindhavana) {
      subContDetModel.id = data.id; // Delete by SQLite ID
    } else {
      subContDetModel.catId = data.catId;
      subContDetModel.siteId = siteController.selectedsiteId.value;
    }
    deleteModelList.add(subContDetModel);
    await subContAttendatanceDetService.SubContDetdeleteById(deleteModelList);
  }

  Future<bool> subContEntryList_DeleteApi(int attendId) async {
    return await SubContAttendanceProvider.subcont_entryList_deleteAPI(
        attendId);
  }

  Future subContEntryList_EditApi(int attendId, status,String MenuName, BuildContext context,
      {String? type}) async {
    await ClickUtils.run(() async {
    var response =
    await SubContAttendanceProvider.subcont_entryList_editAPI(attendId,status);
    if (response != null) {
      if (response.success == true) {
        EditListResDatas.value = [response.result];
        if (EditListResDatas.isNotEmpty) {
          saveButton.value = type=="approve"?RequestConstant.APPROVAL:RequestConstant.RESUBMIT;
          await editSaveDetTable();
          await getDetTablesDatas();
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SubattendanceSiteEntry(heading: MenuName,)));
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
    });
  }

  Future editSaveDetTable() async {
    subcontModelList.clear();
    for (var element in EditListResDatas) {
      element.subContLabourAttendDetS.forEach((val) {
        subContDetModel = SubContDetModel();
        subContDetModel.reqDetId = val.id;
        subContDetModel.catId = val.labourCategoryId;
        subContDetModel.catName = val.labourCategoryName;
        subContDetModel.wages = val.rate;
        subContDetModel.nos = val.nos.toString();
        subContDetModel.MrgOtHrs = val.morotHrs!;
        subContDetModel.MrgOtAmt = val.morotAmt!;
        subContDetModel.EvgOtHrs = val.eveotHrs!;
        subContDetModel.EvgOtAmt = val.eveotAmt!;
        subContDetModel.Extra = val.extra!;
        subContDetModel.hrs = val.hrs!;
        subContDetModel.EvgExtrsAmt = val.extraAmt!;
        subContDetModel.netAmt = val.totalAmount!;
        subContDetModel.remarks = val.remarks;
        subContDetModel.siteId = val.siteId;
        subContDetModel.siteName = val.siteName;
        subcontModelList.add(subContDetModel);
      });
    }
    var savedatas =
    await subContAttendatanceDetService.SubContDetSave(subcontModelList);
    return savedatas;
  }

  textControllersInitiate() {
    EntrySCreenNosControllers.add(TextEditingController());
    NetAmtController.add(TextEditingController());
    NosControllers.add(TextEditingController());
    OtHrsController.add(TextEditingController());
    ExtrasControllers.add(TextEditingController());
    EvgOtHrsControllers.add(TextEditingController());
    EvgOtAmtControllers.add(TextEditingController());
    MrngOtHrsControllers.add(TextEditingController());
    MrngOtAmtControllers.add(TextEditingController());
    EvgExtraAmtControllers.add(TextEditingController());
    hrsControllers.add(TextEditingController());
    RemarksControllers.add(TextEditingController());
  }

  nosAndothrsZerovalueset(List list) {
    int index = 0;
    list.forEach((element) {
      textControllersInitiate();
      NosControllers[index].text = "0";
      OtHrsController[index].text = "0";
      index++;
    });
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
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          bool result = await subContEntryList_DeleteApi(
                              Entrylist.value[index].id);
                          if (result) {
                            deleteSubcontDetTableDatas();
                            readListdata.value.clear();
                            Entrylist.removeAt(index);
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

  /// --------- Subcontractor image Controller -------------

  var imageFiles = <File>[].obs;
  var gettingNetworkImages = <String>[].obs;
  List<int> imageIds = []; // store IDs for delete

  RxInt pickedImageCount = 0.obs;

  /// Getting image.....

  Future<void> gettingImage() async {
    gettingNetworkImages.clear();
    imageIds.clear();
    imageFiles.clear();
    final value =
    await Inward_Pending_provider.gettingImageProvider(DLRId!, "DLR");
    if (value != null) {
      for (int i = 0; i < value!.length; i++) {
        gettingNetworkImages.add(value[i].url.toString());
        imageIds.add(value[i].id);
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  /// Delete image.....

  Future<bool> deletingImage(int imageId) async {
    return await Inward_Pending_provider.deleteImageProvider(imageId, "DLR");
  }
}
