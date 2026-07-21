import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../db_model/manpower_det_model.dart';
import '../db_services/man_power_det_service.dart';
import '../home/menu/daily_entries/subcontractor_attendance_VCPL/subcontractor_site_category.dart';
import '../provider/man_power_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class ManPowerController extends GetxController {
  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();
  final ManPowerDateController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final RemarksController = TextEditingController();
  final preparedbyController = TextEditingController();

  List<TextEditingController> NosControllers = [];
  List<TextEditingController> RemarksControllers = [];

  RxList main_entryList = [].obs;
  RxList manpower_entryList = [].obs;
  RxList manpowerCategoryList = [].obs;
  RxString saveButton=RequestConstant.SUBMIT.obs;

  late List<ManPowerDetModel> deleteModelList = <ManPowerDetModel>[];
  late List<ManPowerDetModel> manPowerModelList = <ManPowerDetModel>[];
  late List<ManPowerDetModel> UpdateModelList = <ManPowerDetModel>[];
  var manPowerDetService = ManPowerDetService();
  var manPowerDetModel = ManPowerDetModel();
  RxList readListdata = [].obs;
  List manPowerDetReadList = <ManPowerDetModel>[];


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
                  builder: (context) => Subcontractor_Site_Category(type: 'manPower',)));
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

  textControllersInitiate() {
    NosControllers.add(TextEditingController());
    RemarksControllers.add(TextEditingController());
  }

  nosAndothrsZerovalueset(List list) {
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
        readListdata.value.forEach((element) {
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
      manPowerDetModel.nos = NosControllers[n].value.text.toString();
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
      manPowerDetModel.remarks = user['remarks'];
      manPowerDetReadList.add(manPowerDetModel);
      readListdata.value = manPowerDetReadList;
    });
    setTextControllersValue();
  }

  setTextControllersValue() async {
    for (var index = 0; index < readListdata.length; index++) {
      textControllersInitiate();
      NosControllers[index].text = readListdata[index].nos;
      RemarksControllers[index].text = readListdata[index].remarks.toString();
    }
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