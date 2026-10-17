import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/controller/pendinglistcontroller.dart';
import 'package:prahkurticore/controller/projectcontroller.dart';
import 'package:prahkurticore/controller/sitecontroller.dart';

import '../db_model/manpower_det_model.dart';
import '../db_services/man_power_det_service.dart';
import '../home/menu/daily_entries/man_power_screens/man_power_entry_screen.dart';
import '../home/menu/daily_entries/man_power_screens/manpower_addboq_list.dart';
import '../home/menu/daily_entries/subcontractor_attendance_VCPL/subcontractor_site_category.dart';
import '../models/man_power_edit_model.dart';
import '../models/manpower_save_model.dart';
import '../models/manpowerlevel3_model.dart';
import '../provider/man_power_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class ManPowerController extends GetxController {
  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();
  final ManPowerEntryDateController = TextEditingController();
  final ManPowerReqDateController = TextEditingController();
  final ManPowerDueDateController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final RemarksController = TextEditingController();
  final AppRemarksController = TextEditingController();
  final preparedbyController = TextEditingController();
  SiteController siteController = Get.put(SiteController());
  ProjectController projectController = Get.put(ProjectController());
  TextEditingController editingController = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  PendingListController pendingListController = Get.put(PendingListController());

  List<TextEditingController> NosControllers = [];
  List<TextEditingController> EntrySCreenNosControllers = [];
  List<TextEditingController> RemarksControllers = [];
  RxList<ManPowerDet> getManPowerDetList = <ManPowerDet>[].obs;
  RxInt createdById = 0.obs;

  RxList main_entryList = [].obs;
  RxList manpower_entryList = [].obs;
  RxList manpowerCategoryList = [].obs;
  RxString saveButton=RequestConstant.SUBMIT.obs;
  RxList<Level3Result> list = <Level3Result>[].obs;
  RxList<int> selectedIds = <int>[].obs;
  List manPowerDetReadList = <ManPowerDetModel>[];
  RxList<Level3Result> manpowerLevel3ItemList = <Level3Result>[].obs;
  RxList<ManPowerEditResult> manpowerEditApiValue = <ManPowerEditResult>[].obs;
  List<Level3Result> originalList = [];
  RxBool hasShownSelectedHint = false.obs;
  late List<ManPowerDetModel> deleteModelList = <ManPowerDetModel>[];
  late List<ManPowerDetModel> manPowerModelList = <ManPowerDetModel>[];
  late List<ManPowerDetModel> UpdateModelList = <ManPowerDetModel>[];
  var manPowerDetService = ManPowerDetService();
  var manPowerDetModel = ManPowerDetModel();
  RxList readListdata = [].obs;


  Future ManPower_EntryList() async {
    manpower_entryList.value=[];
    main_entryList.value=[];
    final value = await ManPowerProvider.getManPowerEntry_List(
        EntrylistFrDate.text,
        EntrylistToDate.text);
    if (value != null) {
      if(value.success==true){
        if(value.result!.isNotEmpty){
          manpower_entryList.value = value.result!;
          main_entryList.value = value.result!;
        }
        else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future manPowerEditApi( id,type, menuName, BuildContext context) async {
    manpowerEditApiValue.value=[];
    await ClickUtils.run(() async {
    final value = await ManPowerProvider.manPowerEditAPI(id,type=="Edit"?true:false);
    if (value != null) {
      if(value.success == true){
        saveButton.value = type=="Edit"?RequestConstant.RESUBMIT:RequestConstant.APPROVAL;
        selectedIds.clear();
        manpowerEditApiValue.value = [value.result!];
        if (manpowerEditApiValue.isNotEmpty) {
          final level3Ids = manpowerEditApiValue[0].level3ItemId!;

          if (level3Ids.isNotEmpty && level3Ids != "0") {
            selectedIds.assignAll(
              level3Ids
                  .split(',')
                  .map((e) => int.parse(e.trim())),
            );
          }
        }

        await manPowerEditDetTable();
        await getDetTablesDatas();
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ManPowerEntrySreen(heading: menuName)),
        );
      }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
    });
  }

  Future getShowClickPopList(BuildContext context) async {
    manpowerCategoryList.value = [];
    final value = await ManPowerProvider.getManPowerCategoryList();
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          manpowerCategoryList.value = value.result!;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Subcontractor_Site_Category(type: 'manPower')));
        } else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast(RequestConstant.SOMETHINGWENT_WRONG);
    }
  }

  Future getLevel3ItemList(context) async {
    manpowerLevel3ItemList.clear();
    originalList.clear();
    await ClickUtils.run(() async {
    final value = await ManPowerProvider.getManPowerLevel3ItemList(
        siteController.selectedHeadId.value);

    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {

          manpowerLevel3ItemList.assignAll(value.result!);
          originalList = List<Level3Result>.from(value.result!);
          // Restore previous selections
          for (var item in manpowerLevel3ItemList) {
            item.isCheck = selectedIds.contains(item.id);
          }

          // Move selected items to top
          sortSelectedItems();

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ManPowerAddBOQList(
                list: manpowerLevel3ItemList,
              ),
            ),
          );
        } else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
    });
  }

  void reorderList() {
    // Selected items in selection order
    List<Level3Result> selected = [];

    for (int id in selectedIds) {
      final item = originalList.firstWhere((e) => e.id == id);
      selected.add(item);
    }

    // Remaining items
    List<Level3Result> unSelected = originalList
        .where((e) => !selectedIds.contains(e.id))
        .toList();

    // Main list
    manpowerLevel3ItemList.assignAll([
      ...selected,
      ...unSelected,
    ]);

    // If searching, reorder the filtered list also
    if (editingController.text.isNotEmpty) {
      final search = editingController.text.toLowerCase();

      list.assignAll(
        manpowerLevel3ItemList.where((item) {
          return item.level3Item.toString().toLowerCase().contains(search) ||
              item.headandSubName.toString().toLowerCase().contains(search) ||
              item.scaleName.toString().toLowerCase().contains(search) ||
              item.qty.toString().contains(search);
        }).toList(),
      );
    }
  }

  void setCheck(int id, bool value) {
    final item = originalList.firstWhere((e) => e.id == id);
    item.isCheck = value;

    if (value) {
      if (!selectedIds.contains(id)) {
        selectedIds.add(id);   // Adds to the end
      }
    } else {
      selectedIds.remove(id);
    }

    reorderList();
  }

  void sortSelectedItems() {
    manpowerLevel3ItemList.sort((a, b) {
      final aSelected = selectedIds.contains(a.id);
      final bSelected = selectedIds.contains(b.id);

      if (aSelected && bSelected) {
        return selectedIds.indexOf(a.id!).compareTo(selectedIds.indexOf(b.id!));
      }

      if (aSelected) return -1;
      if (bSelected) return 1;

      return 0;
    });

    manpowerLevel3ItemList.refresh();
  }

  textControllersInitiate() {
    EntrySCreenNosControllers.add(TextEditingController());
    NosControllers.add(TextEditingController());
    RemarksControllers.add(TextEditingController());
  }

  nosZerovalueset(List list) {
    int index = 0;
    list.forEach((element) {
      textControllersInitiate();
      NosControllers[index].text = "0";
      RemarksControllers[index].text = "";
      index++;
    });
  }

  saveManPowerDetTableDatas(BuildContext context) async {
    manPowerModelList = [];
    int i = 0;
    int j = 0;
    manpowerCategoryList.forEach((element) {
      if ((NosControllers[i].text.isEmpty ||
          double.parse(NosControllers[i].text) == 0) &&
          (RemarksControllers[i].text.isEmpty)) {
      } else {
        manPowerDetModel = ManPowerDetModel();
        manPowerDetModel.reqDetId = 0;
        manPowerDetModel.catId = element.id;
        manPowerDetModel.catName = element.labourCategoryName;
        manPowerDetModel.nos = NosControllers[i].value.text.isEmpty
            ? "0.0"
            : NosControllers[i].value.text;
        manPowerDetModel.remarks = RemarksControllers[i].value.text;
        manPowerDetModel.savedNos = "0";
        readListdata.forEach((element) {
          if (element.catId == manPowerDetModel.catId) {
            j = 1;
          }
        });
        if (j == 0) {
          manPowerModelList.add(manPowerDetModel);
        } else {
          BaseUtitiles.showToast("Entry already exist");
          j = 0;
        }
      }
      i++;
    });
    var savedatas = await manPowerDetService.ManPowerDetSave(manPowerModelList);
    return Navigator.pop(context, savedatas);
  }

  updateManPowerDetValue() async {
    UpdateModelList.clear();
    for (var n = 0; n < readListdata.length; n++) {
      textControllersInitiate();
      manPowerDetModel = ManPowerDetModel();
      manPowerDetModel.reqDetId = readListdata[n].reqDetId;
      manPowerDetModel.catId = readListdata[n].catId;
      manPowerDetModel.catName = readListdata[n].catName;
      manPowerDetModel.nos = EntrySCreenNosControllers[n].value.text.toString();
      manPowerDetModel.savedNos = readListdata[n].savedNos;
      manPowerDetModel.remarks = RemarksControllers[n].value.text;
      UpdateModelList.add(manPowerDetModel);
    }
    await manPowerDetService.ManPowerDetUpdate(UpdateModelList);
  }

  deleteSubcontDetTableDatas() async {
    await manPowerDetService.ManPowerDetdelete();
  }

  Future deleteParticularList(ManPowerDetModel data) async {
    deleteModelList.clear();
    manPowerDetModel = ManPowerDetModel();
    manPowerDetModel.catId = data.catId;
    deleteModelList.add(manPowerDetModel);
    await manPowerDetService.ManPowerDetdeleteById(deleteModelList);
  }

  Future getDetTablesDatas() async {
    var manPower = await manPowerDetService.ManPowerDetreadAll();
    manPowerDetReadList = <ManPowerDetModel>[];
    readListdata.value.clear();
    manPower.forEach((user) {
      var manPowerDetModel = ManPowerDetModel();
      manPowerDetModel.reqDetId = user['reqDetId'];
      manPowerDetModel.catId = user['catId'];
      manPowerDetModel.catName = user['catName'];
      manPowerDetModel.nos = user['nos'];
      manPowerDetModel.savedNos = user['savedNos'];
      manPowerDetModel.remarks = user['remarks'];
      manPowerDetReadList.add(manPowerDetModel);
      readListdata.value = manPowerDetReadList;
    });
    setTextControllersValue();
  }

  Future manPowerEditDetTable() async {
    manPowerModelList.clear();
    for (var element in manpowerEditApiValue) {
      for (var val in element.manPowerDets!) {
        manPowerDetModel = ManPowerDetModel();
        manPowerDetModel.reqDetId = val.id;
        manPowerDetModel.catId = val.categoryId;
        manPowerDetModel.catName = val.categoryName;
        manPowerDetModel.nos = val.nos.toString();
        manPowerDetModel.savedNos = val.nos.toString();
        manPowerDetModel.remarks = val.remarks;
        manPowerModelList.add(manPowerDetModel);
      }
    }
    var savedatas = await manPowerDetService.ManPowerDetSave(manPowerModelList);
    return savedatas;
  }

  setTextControllersValue() async {
    for (var index = 0; index < readListdata.length; index++) {
      textControllersInitiate();
      EntrySCreenNosControllers[index].text = readListdata[index].nos;
      RemarksControllers[index].text = readListdata[index].remarks.toString();
    }
  }

  Future SaveEntryScreen(BuildContext context, int id) async {
    await Future.delayed(const Duration(seconds: 0));
    String body = manPowerSaveModelToJson(ManPowerSaveModel(
      id: id,
      manPowerNo: autoYearWiseNoController.text,
      entryDate: ManPowerEntryDateController.text,
      reqDate: ManPowerReqDateController.text,
      dueDate: ManPowerDueDateController.text,
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      headItemId: siteController.selectedHeadId.value,
      remarks: RemarksController.text==""?"-":RemarksController.text,
      approveRemarks: AppRemarksController.text==""?"-":AppRemarksController.text,
      level3ItemId: selectedIds.isEmpty?"0": selectedIds.join(','),
      createdBy: saveButton.value==RequestConstant.SUBMIT ? int.parse(loginController.EmpId()) : createdById.value,
      approveStatus: saveButton.value==RequestConstant.APPROVAL ?"Y" : "N",
      manPowerDets: getManPowerDet(id),
    ));

    final list = await ManPowerProvider.SaveEntryScreenAPI(body, id, context);

    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        if(saveButton.value==RequestConstant.APPROVAL){
          await pendingListController.getPendingList();
        }
        else {
          await ManPower_EntryList();
        }
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

  List<ManPowerDet>? getManPowerDet(int? id) {
    getManPowerDetList.value=[];
    for (var element in readListdata) {
      var list = ManPowerDet(
        id : element.reqDetId,
        manPowerAllocationMasId: id,
        categoryId: element.catId,
        // level3ItemId: selectedIds.isEmpty?"0": selectedIds.join(','),
        nos: saveButton.value==RequestConstant.APPROVAL ?int.tryParse(element.savedNos):int.tryParse(element.nos),
        appNos: saveButton.value==RequestConstant.APPROVAL ?int.tryParse(element.nos):0,
        // remarks: element.remarks
      );
      getManPowerDetList.add(list);
    }
    return getManPowerDetList;
  }

  Future<bool> EntryList_DeleteApi(int Id) async {
    return ManPowerProvider.entryList_deleteAPI(Id);
  }

  Future DeleteAlert(BuildContext context, int index ) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
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
                          bool result = await EntryList_DeleteApi(
                              manpower_entryList[index].id);
                          if (result) {
                            manpower_entryList.removeAt(index);
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Delete",
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

}