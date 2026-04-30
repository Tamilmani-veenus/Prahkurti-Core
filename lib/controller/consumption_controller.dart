import '../commonpopup/expense_type_alert.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../db_model/consumptionitemlist_model.dart';
import '../db_services/consumptionitemlist_service.dart';
import '../home/menu/materials/consumption/consumption_additems.dart';
import '../home/menu/materials/consumption/consumption_entryscreen.dart';
import '../home/menu/materials/consumption/consumption_list.dart';
import '../models/consumption_edit_model.dart';
import '../models/consumption_edit_model.dart';
import '../models/consumption_edit_model.dart';
import '../models/consumption_save_model.dart';
import '../provider/consumption_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class Consumption_Controller extends GetxController {
  final ConsumEntrylistFrDate = TextEditingController();
  final ConsumEntrylistToDate = TextEditingController();
  final ConsumDate = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final Consum_preparedbyController = TextEditingController();
  final Consum_RemarksController = TextEditingController();
  final expenseTypeController = TextEditingController();
  final UsageqtyController = TextEditingController();

  RxString saveButton = RequestConstant.SUBMIT.obs;
  String expenseType = "";

  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());

  RxList<ConsumptionDet> getusageDetList = <ConsumptionDet>[].obs;

  List<TextEditingController> Itemlist_materialControllers = [];
  List<TextEditingController> Itemlist_scaleControllers = [];
  List<TextEditingController> Itemlist_stockqtyControllers = [];
  List<TextEditingController> Itemlist_UsageqtyControllers = [];

  List<TextEditingController> Addwork_materialControllers = [];
  List<TextEditingController> Addwork_scaleControllers = [];
  List<TextEditingController> Addwork_stockqtyControllers = [];
  List<TextEditingController> Addwork_UsageqtyControllers = [];

  late List<ConsumptionItemlist> consumItemListTableList =
      <ConsumptionItemlist>[];
  late List<ConsumptionItemlist> updateListDatas = <ConsumptionItemlist>[];
  late List<ConsumptionItemlist> deleteModelList = <ConsumptionItemlist>[];
  var conumptionItemListTableModel = ConsumptionItemlist();
  var consumptionItemlistService = ConsumptionItemlistService();

  RxList ConsumEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList Stock_List = [].obs;
  RxList mainlist = [].obs;
  RxList Consum_itemview_GetDbList = [].obs;
  RxList<ConsumEditResult> Consum_EditListApiValue = <ConsumEditResult>[].obs;
  RxList Consum_TypeListApiValue = [].obs;

  int UsageId = 0;

  bool get isSubmit => saveButton.value == RequestConstant.SUBMIT;
  bool get isResubmit => saveButton.value == RequestConstant.RESUBMIT;

//---Entry List Call---
  Future getConsum_EntryList() async {
    mainEtyList.value=[];
    ConsumEtyList.value=[];
    var response = await Consumption_provider.getConsumEntry_List(
        ConsumEntrylistFrDate.text,
        ConsumEntrylistToDate.text);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          mainEtyList.assignAll(response.result!);
          ConsumEtyList.assignAll(response.result!);
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

//---------StockMaterial List--------
  Future getStock_Material(context) async {
    Stock_List.value.clear();
    final value = await Consumption_provider.getStockmaterial(
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value);
    if (value != null ) {
      if( value.success == true){
      if (value.result!.isNotEmpty) {
        Stock_List.value = value.result!;
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Consumption_AddItems(list: Stock_List.value)));
        return Stock_List.value;
      }
      else {
        BaseUtitiles.showToast("No Data Found");
      }
    }
      else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
      }
    else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }


  Future getCons_Type(context) async {
    Consum_TypeListApiValue.value = [];
    final value = await Consumption_provider.getConsTypeList();
    if (value != null ) {
      if(value.success == true) {
        Consum_TypeListApiValue.value = value.result!;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ExpenseTypeAlert();
            });
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast('Something went wrong..');
    }
  }

  Consumption_itemlist_textControllersInitiate() {
    Itemlist_materialControllers.add(new TextEditingController());
    Itemlist_scaleControllers.add(new TextEditingController());
    Itemlist_stockqtyControllers.add(new TextEditingController());
    Itemlist_UsageqtyControllers.add(new TextEditingController());
    Addwork_materialControllers.add(new TextEditingController());
    Addwork_scaleControllers.add(new TextEditingController());
    Addwork_stockqtyControllers.add(new TextEditingController());
    Addwork_UsageqtyControllers.add(new TextEditingController());
  }

  currQtyAndAmntZerovalueset(list) {
    int index = 0;
    list.forEach((element) {
      Consumption_itemlist_textControllersInitiate();
      Addwork_materialControllers[index].text = element.material!.toString();
      Addwork_scaleControllers[index].text = element.scale!.toString();
      Addwork_stockqtyControllers[index].text = element.stockQty!.toString();
      Addwork_UsageqtyControllers[index].text = "0.0";
      index++;
    });
  }

  popupChaneEdit(String value) {
    int i = 0;
    mainlist.value.forEach((element) {
      Consumption_itemlist_textControllersInitiate();
      if (element.stockQty <
          double.parse(Addwork_UsageqtyControllers[i].text)) {
        //BaseUtitiles.showToast("True");
        Addwork_UsageqtyControllers[i].text = "0.0";
      }
      i++;
    });
  }

//---ItemList DB Save ----
  consum_itemlist_Save_DB(BuildContext context) async {
    consumItemListTableList.clear();
    int i = 0;
    int j = 0;
    Stock_List.forEach((element) {
      Consumption_itemlist_textControllersInitiate();
      if (element.check == true) {
        conumptionItemListTableModel = new ConsumptionItemlist();
        conumptionItemListTableModel.materialid = element.materialId!;
        conumptionItemListTableModel.reqDetId = 0;
        conumptionItemListTableModel.material = element.material!;
        conumptionItemListTableModel.scale = element.scale!;
        conumptionItemListTableModel.scaleId = element.scaleId!;
        conumptionItemListTableModel.Stockqty = element.stockQty!;
        conumptionItemListTableModel.Usageqty = double.parse("0");
        Consum_itemview_GetDbList.forEach((element) {
          if (element.materialid == conumptionItemListTableModel.materialid) {
            j = 1;
            BaseUtitiles.showToast("Entries already exist");
          }
        });
        if (j == 0) {
          consumItemListTableList.add(conumptionItemListTableModel);
        } else {
          j = 0;
        }
      }
      i++;
    });
    var savedatas = await consumptionItemlistService.ConsumItemlist_table_Save(
        consumItemListTableList);
    return Navigator.pop(context, savedatas);
  }

  //Get Values

  Future getConumTablesDatas() async {
    for (final c in Itemlist_UsageqtyControllers) {
      c.dispose();
    }
    Itemlist_UsageqtyControllers.clear();
    Consum_itemview_GetDbList.clear();
    var ConumItem =
        await consumptionItemlistService.ConumItemlist_table_readAll();
    ConumItem.forEach((user) {
      var consumptionItemlist = ConsumptionItemlist();
      consumptionItemlist.materialid = user['materialid'];
      consumptionItemlist.reqDetId = user['reqDetId'];
      consumptionItemlist.material = user['material'];
      consumptionItemlist.scale = user['scale'];
      consumptionItemlist.scaleId = user['scaleId'];
      consumptionItemlist.Stockqty = user['stockqty'];
      consumptionItemlist.Usageqty = user['usageqty'];
      Consum_itemview_GetDbList.add(consumptionItemlist);
    });
    setTextControllersValue();
  }

  double usageQty() {
    double value = 0;
    List data = [];
    data.clear();
    Consum_itemview_GetDbList.forEach((element) {
      if (element.Usageqty == 0) {
        data.add(element);
      }
    });
    if (data.isEmpty) {
      value = 1;
    } else {
      value = 0;
    }
    return value;
  }

  /// ----- Set Value -----

  setTextControllersValue() async {
    for (var index = 0; index < Consum_itemview_GetDbList.length; index++) {
      Consumption_itemlist_textControllersInitiate();
      Itemlist_materialControllers[index].text =
          Consum_itemview_GetDbList.value[index].material.toString();
      Itemlist_scaleControllers[index].text =
          Consum_itemview_GetDbList.value[index].scale.toString();
      Itemlist_stockqtyControllers[index].text =
          Consum_itemview_GetDbList.value[index].Stockqty.toString();
      Itemlist_UsageqtyControllers[index].text =
          Consum_itemview_GetDbList.value[index].Usageqty.toString();
    }
  }

  //Usageqty edit

  ConsumItemlist_clickEdit() {
    for (var index = 0;
        index < Consum_itemview_GetDbList.value.length;
        index++) {
      if (Consum_itemview_GetDbList.value[index].Stockqty <
          double.parse(Itemlist_UsageqtyControllers[index].text != ""
              ? Itemlist_UsageqtyControllers[index].text
              : "0")) {
        Itemlist_UsageqtyControllers[index].text = "0.0";
        BaseUtitiles.showToast("Usage qty is higher than the Stock qty");
      } else {
        updateConsumTables();
      }
    }
  }

  //Usage Update to db

  updateConsumTables() async {
    int i = 0;
    updateListDatas.clear();
    Consum_itemview_GetDbList.forEach((element) {
      conumptionItemListTableModel = ConsumptionItemlist();
      conumptionItemListTableModel.materialid = element.materialid!;
      conumptionItemListTableModel.reqDetId = element.reqDetId!;
      conumptionItemListTableModel.material = element.material!;
      conumptionItemListTableModel.scale = element.scale!;
      conumptionItemListTableModel.scaleId = element.scaleId!;
      conumptionItemListTableModel.Stockqty = element.Stockqty!;
      conumptionItemListTableModel.Usageqty = double.parse(
          Itemlist_UsageqtyControllers[i].value.text != ""
              ? Itemlist_UsageqtyControllers[i].value.text
              : "0");
      updateListDatas.add(conumptionItemListTableModel);
      i++;
    });
    await consumptionItemlistService.ConumItemlist_table_Update(
        updateListDatas);
  }

  //Particular delete
  Future deleteParticularList(ConsumptionItemlist data) async {
    deleteModelList.clear();
    conumptionItemListTableModel = ConsumptionItemlist();

    conumptionItemListTableModel.materialid = data.materialid;

    deleteModelList.add(conumptionItemListTableModel);
    await consumptionItemlistService.consumdeleteById(deleteModelList);
  }

  delete_Consum_itemlist_Table() async {
    await consumptionItemlistService.ConsumItemlist_table_delete();
  }

  clearDatas() {
    UsageId = 0;
    saveButton.value = RequestConstant.SUBMIT;
    projectController.projectname.text = "--Select--";
    projectController.selectedProjectId.value = 0;
    subcontractorController.selectedSubcontId.value = 0;
    subcontractorController.Subcontractorname.text = "--Select--";
    ConsumDate.text = BaseUtitiles.initiateCurrentDateFormat();
    Consum_preparedbyController.text = loginController.EmpName();
    siteController.selectedsiteId = 0.obs;
    siteController.selectedsitedropdownName = "--Select--".obs;
    siteController.getSiteDropdownvalue.value.clear();
    siteController.Sitename.text = RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
    expenseTypeController.text = "--Select--";
    expenseType = "EXP";
    Consum_RemarksController.text = "";
    saveButton.value = RequestConstant.SUBMIT;
    Consum_EditListApiValue.value.clear();
    delete_Consum_itemlist_Table();
    Consum_itemview_GetDbList.clear();
  }

//----- POST and PUT JSON Values----
  Future SaveButton_ItemlistScreen(BuildContext context, int id) async {
    int i = 0;
    await getConumTablesDatas();
    getusageDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = conumSaveRequestToJson(ConumSaveRequest(
      id: id != 0 ? id : 0,
      entryDt: ConsumDate.text,
      expenseNo: autoYearWiseNoController.text,
      projectid: projectController.selectedProjectId.value,
      siteid: siteController.selectedsiteId.value,
      subContractId: subcontractorController.selectedSubcontId.value,
      remarks: Consum_RemarksController.text,
      expenseType: expenseType,
      createdBy: isSubmit ? int.parse(loginController.EmpId()) : null,
      createdDt:
          isSubmit ? BaseUtitiles().convertToUtcIso(ConsumDate.text) : null,
      updatedBy: isResubmit ? int.parse(loginController.EmpId()) : null,
      updatedDt:
          isResubmit ? BaseUtitiles().convertToUtcIso(ConsumDate.text) : null,
      consumptionDet: getusageDetList.value.length == 0
          ? getConumDet(id)
          : getusageDetList.value,
    ));

    final list = await Consumption_provider.SaveConumScreenEntryAPI(body, id, context);

    if (list != null ) {
      if(list["success"] == true){
      BaseUtitiles.showToast(list["message"]);
      await getConsum_EntryList();
      clearDatas();
      delete_Consum_itemlist_Table();
      Consum_itemview_GetDbList.clear();
      BaseUtitiles.popMultiple(context, count: 3);
    }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  List<ConsumptionDet>? getConumDet(int? id) {
    Consum_itemview_GetDbList.value.forEach((element) {
      var list = ConsumptionDet(
        id: element.reqDetId,
        expenseId: id != 0 ? id : 0,
        materialId: element.materialid,
        qty: element.Usageqty,
        rate: 0,
        remarks: "",
        unitId: element.scaleId,
        stockQty: element.Stockqty,
      );
      getusageDetList.value.add(list);
    });
    return getusageDetList.value;
  }
  // ---------Edit Call API----------

  Future Consum_entrylist_editSaveDetTable() async {
    consumItemListTableList.clear();
    Consum_EditListApiValue.forEach((element) {
      element.materialExpensesLink?.forEach((val) {
        conumptionItemListTableModel = new ConsumptionItemlist();
        conumptionItemListTableModel.materialid = val.materialId!;
        conumptionItemListTableModel.reqDetId = val.id!;
        conumptionItemListTableModel.material = val.materialName!;
        conumptionItemListTableModel.scale = val.unit!;
        conumptionItemListTableModel.scaleId = val.scaleId!;
        conumptionItemListTableModel.Stockqty = val.stockQty!;
        conumptionItemListTableModel.Usageqty = val.qty;
        consumItemListTableList.add(conumptionItemListTableModel);
      });
    });
    var savedatas = await consumptionItemlistService.ConsumItemlist_table_Save(
        consumItemListTableList);
    return savedatas;
  }

  Future ConsumEntryList_EditApi(int expenseId, BuildContext context) async {
    final value =
        await Consumption_provider.Consum_entryList_editAPI(expenseId);
    if (value != null) {
      if(value.success == true){
      delete_Consum_itemlist_Table();
      saveButton.value = RequestConstant.RESUBMIT;
      Consum_EditListApiValue.value = [value.result!];
      Consum_entrylist_editSaveDetTable();
      getConumTablesDatas();
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Consumption_Entry()),
      );
    }else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    }
      else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

// ----------Delete call API --------------
  Future<bool> Consum_EntryList_DeleteApi(int UsageId) async {
    return Consumption_provider.Consum_entryList_deleteAPI(UsageId);
  }

  //------Button Changes-----

  String ButtonChanges(int id, int aproval) {
    if (id != 0) {
      if (aproval != 0)
        return saveButton.value = RequestConstant.APPROVAL;
      else
        return saveButton.value = RequestConstant.RESUBMIT;
    } else
      return saveButton.value = RequestConstant.SUBMIT;
  }

  setCheck(int id, bool value) {
    Stock_List.value.forEach((element) {
      if (element.materialId == id) {
        element.check = value;
      }
    });
  }

  serachsetCheck(int id, bool value) {
    mainlist.forEach((element) {
      if (element.materialId == id) {
        element.check = value;
      }
    });
  }
}
