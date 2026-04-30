import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../home/menu/main_menu/boq_revised/boq_additems.dart';
import '../home/menu/main_menu/boq_revised/boq_revised_entry.dart';
import '../home/menu/main_menu/boq_revised/boq_revised_entrylist.dart';
import '../provider/boq_revised_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db_model/boqreviseditemlist_model.dart';
import '../db_services/boqreviseditemlist_service.dart';
import '../models/boqrevisedsaverequest_model.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class Boq_Revised_Controller extends GetxController {
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  LoginController loginController = Get.put(LoginController());

  final boq_autoYearWiseNoController = TextEditingController();
  final boq_dateController = TextEditingController();
  final boq_remarksController = TextEditingController();
  final boq_preparedbyController = TextEditingController();
  final entryList_frdateController = TextEditingController();
  final entryList_todateController = TextEditingController();
  RxList Boq_entryList = [].obs;
  RxList main_entryList = [].obs;
  RxList Boq_ItemList = [].obs;
  RxList Boq_MainItemList = [].obs;
  RxList list = [].obs;

  late List<bool> isChecked;

  int checkColor = 0;

  var itemTableModel = BoqItemlist();
  var boqItemlistService = BoqItemlistService();
  RxList BoqRevised_EditListApiValue = [].obs;
  RxString saveButton = RequestConstant.SUBMIT.obs;

  List<TextEditingController> Itemlist_qtyControllers = [];
  List<TextEditingController> Itemlist_AmountControllers = [];
  List<TextEditingController> Itemlist_rateControllers = [];

  List<TextEditingController> Addwork_qtyControllers = [];
  List<TextEditingController> Addwork_rateControllers = [];
  List<TextEditingController> Addwork_AmountControllers = [];

  late List<BoqItemlist> boqitemTableList = <BoqItemlist>[];
  late List<BoqItemlist> updateListDatas = <BoqItemlist>[];
  late List<BoqItemlist> deleteModelList = <BoqItemlist>[];
  RxList<DprDet> getBoqDetList = <DprDet>[].obs;
  RxList Boqitem_itemview_GetDbList = [].obs;
  int reviseId = 0;

  int editCheck = 0;
  int itemCheck = 0;
  int buttonControl = 0;

  clearDatas() {
    reviseId = 0;
    saveButton.value = RequestConstant.SUBMIT;
    delete_BoqRevised_itemlist_Table();
    Boqitem_itemview_GetDbList.clear();
    projectController.projectname.text = RequestConstant.SELECT;
    projectController.selectedProjectId.value = 0;
    siteController.selectedsiteId.value = 0;
    siteController.Sitename.text = RequestConstant.SELECT;
    boq_preparedbyController.text = loginController.UserName();

    boq_dateController.text = BaseUtitiles.initiateCurrentDateFormat();
    boq_remarksController.text = "-";
  }

  Item_itemlist_textControllersInitiate() {
    Itemlist_qtyControllers.add(TextEditingController());
    Itemlist_AmountControllers.add(TextEditingController());
    Addwork_qtyControllers.add(TextEditingController());
    Addwork_AmountControllers.add(TextEditingController());
  }

  Future Boq_getEntryList() async {
    main_entryList.value.clear();
    Boq_entryList.value.clear();
    await BoqRevised_Provider.get_boq_EntryList(
            loginController.user.value.userId,
            loginController.UserType(),
            entryList_frdateController.text,
            entryList_todateController.text).then((value) async {
      if (value != null && value.length > 0) {
        main_entryList.value = value;
        Boq_entryList.value = main_entryList.value;
        return main_entryList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  //---------Item List--------
  Future getItemList(BuildContext context) async {
    Boq_MainItemList.value.clear();
    Boq_ItemList.value.clear();
    await BoqRevised_Provider.getRevisedItemlist(
            projectController.selectedProjectId.value,
            siteController.selectedsiteId.value)
        .then((value) async {
      if (value != null && value.isNotEmpty) {
        Boq_ItemList.value = value;
        Boq_MainItemList.value = value;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Boq_AddItems(
                      list: Boq_MainItemList.value,
                    )));

        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return Boq_ItemlistShowPopup(list:Boq_MainItemList.value);
        //     });

      }
      else{
        BaseUtitiles.showToast("No Record Found");
      }
    });
  }

  calculate(String value) {
    for (var index = 0; index < Boq_ItemList.length; index++) {
      if (Itemlist_qtyControllers[index].value.text == "") {
      } else {
        Itemlist_AmountControllers[index].text = (Boq_MainItemList[index].rate *
                double.parse(
                    Itemlist_qtyControllers[index].value.text.toString()))
            .toStringAsFixed(2);
      }
    }
  }

  calculatelist() {
    for (var index = 0; index < Boqitem_itemview_GetDbList.length; index++) {
      if (Addwork_qtyControllers[index].value.text == "0") {
        Addwork_qtyControllers[index].text = "1.0";
        BaseUtitiles.showToast("Zero is not allowed please change the value");
      } else {
        Addwork_AmountControllers[index].text = (Boqitem_itemview_GetDbList[index].Rate * double.parse(Addwork_qtyControllers[index].value.text != "" ? Addwork_qtyControllers[index].value.text : "0")).toStringAsFixed(2);
        updateConsumTables();
      }
    }
  }

  // ----Itemlist add in db
  boqitemlist_Save_DB(BuildContext context) async {
    boqitemTableList.clear();
    int i = 0;
    int j = 0;
    Boq_MainItemList.value.forEach((element) {
      Item_itemlist_textControllersInitiate();
      if (element.isCheck == true) {
        if (Itemlist_qtyControllers[j].value.text == "0.0" ||
            Itemlist_qtyControllers[j].value.text == "0" ||
            Itemlist_qtyControllers[j].value.text == "") {
        } else {
          itemTableModel = new BoqItemlist();
          itemTableModel.HdNme_Id = element.headItemId!;
          itemTableModel.SbNme_Id = element.subItemId!;
          itemTableModel.Level3item_id = element.level3ItemId!;
          itemTableModel.itemdesc = element.itemDesc;
          itemTableModel.Unit = element.unit;
          itemTableModel.Rate = element.rate;
          itemTableModel.Qty = 1.0;
          itemTableModel.Amt = itemTableModel.Rate! * itemTableModel.Qty!;
          Boqitem_itemview_GetDbList.forEach((element) {
            if (element.Level3item_id == itemTableModel.Level3item_id) {
              i = 1;
            }
          });

          if (i == 0) {
            boqitemTableList.add(itemTableModel);
          } else {
            i = 0;
          }
        }
      }
      j++;
    });

    var savedatas =
        await boqItemlistService.BoqItem_table_Save(boqitemTableList);
    return Navigator.pop(context, savedatas);
  }

  //qty Update to db
  updateConsumTables() async {
    int i = 0;
    updateListDatas.clear();
    Boqitem_itemview_GetDbList.forEach((element) {
      itemTableModel = new BoqItemlist();
      itemTableModel.HdNme_Id = element.HdNme_Id!;
      itemTableModel.SbNme_Id = element.SbNme_Id!;
      itemTableModel.Level3item_id = element.Level3item_id!;
      itemTableModel.itemdesc = element.itemdesc;
      itemTableModel.Unit = element.Unit;
      itemTableModel.Rate = element.Rate;
      itemTableModel.Qty = double.parse(Addwork_qtyControllers[i].value.text);
      itemTableModel.Amt =
          double.parse(Addwork_AmountControllers[i].value.text);

      updateListDatas.add(itemTableModel);
      i++;
    });
    await boqItemlistService.BoqItemlist_table_Update(updateListDatas);
  }

  //Get Values

  Future getItemTablesDatas() async {
    Boqitem_itemview_GetDbList.clear();
    var Itemlist = await boqItemlistService.BoqItemlist_table_readAll();

    Itemlist.forEach((user) {
      var boqitemlist = BoqItemlist();
      boqitemlist.HdNme_Id = user['HdNme_Id'];
      boqitemlist.SbNme_Id = user['SbNme_Id'];
      boqitemlist.Level3item_id = user['Level3item_id'];
      boqitemlist.itemdesc = user['itemdesc'];
      boqitemlist.Unit = user['Unit'];
      boqitemlist.Rate = user['Rate'];
      boqitemlist.Qty = user['Qty'];
      boqitemlist.Amt = user['Amt'];

      Boqitem_itemview_GetDbList.add(boqitemlist);
    });
    setTextControllersValue();
  }

  //Set Value
  setTextControllersValue() async {
    for (var index = 0; index < Boqitem_itemview_GetDbList.length; index++) {
      Item_itemlist_textControllersInitiate();

      Addwork_qtyControllers[index].text =
          Boqitem_itemview_GetDbList.value[index].Qty.toString();

      Addwork_AmountControllers[index].text =
          Boqitem_itemview_GetDbList.value[index].Amt.toString();
    }
  }

  //Particular delete
  Future deleteParticularList(BoqItemlist data) async {
    deleteModelList.clear();
    itemTableModel = new BoqItemlist();

    itemTableModel.Level3item_id = data.Level3item_id;

    deleteModelList.add(itemTableModel);
    await boqItemlistService.itemdeleteById(deleteModelList);
  }

  delete_BoqRevised_itemlist_Table() async {
    await boqItemlistService.BoqItemlist_table_delete();
  }

  //-------------------------------------API call part-------------------------------------

  //----- POST and PUT JSON Values----
  Future SaveButton_BoqRevisedScreen(BuildContext context, int id) async {
    buttonControl=1;
    getBoqDetList.value.clear();
    await getItemTablesDatas();
    String body = boqRevisedRequestToJson(BoqRevisedRequest(
      revise_Id: id != 0 ? id : 0,
      reviseNo: boq_autoYearWiseNoController.text,
      reviseDate: boq_dateController.text,
      projectId: projectController.selectedProjectId.value.toString(),
      siteId: siteController.selectedsiteId.value.toString(),
      remarks: boq_remarksController.text,
      preparedBy: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      entryMode: saveButton.value == "Submit"
          ? "ADD"
          : saveButton.value == "Re-Submit"
              ? "UPDATE"
              : saveButton.value == "Verify"
                  ? "VERIFY"
                  : saveButton.value == "Approve"
                      ? "APPROVE"
                      : "",
      dprDet: getBoqDetList.value.length == 0 ? getBoqDet() : getBoqDetList.value,
    ));
    final list = await BoqRevised_Provider.SaveBoqRevisedScreenEntryAPI(body, id, buttonControl,context);
    if (list != null && id != 0) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new Boq_Revised_EntryList()));
      buttonControl=0;
      BaseUtitiles.showToast(list);
      itemCheck = 2;
      clearDatas();
      delete_BoqRevised_itemlist_Table();
      Boqitem_itemview_GetDbList.clear();
      return Navigator.pop(context);
    } else {
      if (list == RequestConstant.DUPLICATE_OCCURED) {
        Navigator.pop(context);
        Navigator.pop(context);
        buttonControl=0;
        return BaseUtitiles.showToast(list);
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, new MaterialPageRoute(builder: (BuildContext context) => new Boq_Revised_EntryList()));
        buttonControl=0;
        itemCheck =2;
        clearDatas();
        BaseUtitiles.showToast(list);
        delete_BoqRevised_itemlist_Table();
        Boqitem_itemview_GetDbList.clear();
        return Navigator.of(context).pop;
      }
    }
  }

  List<DprDet>? getBoqDet() {
    int i = 0;
    Boqitem_itemview_GetDbList.value.forEach((element) {
      Item_itemlist_textControllersInitiate();
      var list = new DprDet(
        hdNmeId: element.HdNme_Id.toString(),
        sbNmeId: element.SbNme_Id.toString(),
        level3ItemId: element.Level3item_id.toString(),
        unit: element.Unit.toString(),
        rate: element.Rate.toString(),
        qty: element.Qty.toString(),
        detRemarks: "",
      );
      getBoqDetList.value.add(list);
      i++;
    });
    return getBoqDetList.value;
  }

  // ---------Edit Call API----------

  Future BoqRevised_list_editSaveDetTable() async {
    boqitemTableList.clear();
    BoqRevised_EditListApiValue.forEach((element) {
      element.dprEditDet.forEach((val) {
        itemTableModel = new BoqItemlist();
        itemTableModel.HdNme_Id = val.hdNmeId!;
        itemTableModel.SbNme_Id = val.sbNmeId!;
        itemTableModel.Level3item_id = val.level3ItemId!;
        itemTableModel.Rate = val.rate;
        itemTableModel.Qty = val.qty;
        itemTableModel.itemdesc = val.itemDesc;
        itemTableModel.Unit = val.unit;
        itemTableModel.Amt = val.rate * val.qty;

        boqitemTableList.add(itemTableModel);
      });
    });
    var savedatas =
        await boqItemlistService.BoqItem_table_Save(boqitemTableList);
    return savedatas;
  }

  Future BoqrevisedList_EditApi(int reviseId, BuildContext context) async {
    BoqRevised_EditListApiValue.clear();
    await BoqRevised_Provider.Boq_RevisedList_editAPI(reviseId)
        .then((value) async {
      if (value != null && value.length > 0) {
        delete_BoqRevised_itemlist_Table();
        editCheck = 1;
        itemCheck = 1;
        BoqRevised_EditListApiValue.value = value;
        BoqRevised_list_editSaveDetTable();
        getItemTablesDatas();
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Boq_Revised_EntryScreen()),
        );
      }
    });
  }

  //--Entrylist Delete--
  Future Boq_EntryList_DeleteApi(int Revise_Id, String Revise_No) async {
    await BoqRevised_Provider.BoqRevised_entryList_deleteAPI(Revise_Id,
            Revise_No, loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  Future DeleteAlert(BuildContext context, int index) async {
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
                    color: Colors.grey.shade400,
                    //color of divider
                    width: 5,
                    //width space of divider
                    thickness: 2,
                    //thickness of divier line
                    indent: 15,
                    //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          itemCheck = 0;
                          editCheck = 0;
                          delete_BoqRevised_itemlist_Table();
                          Boqitem_itemview_GetDbList.value.clear();
                          Boq_EntryList_DeleteApi(
                              Boq_entryList.value[index].reviseId,
                              Boq_entryList.value[index].reviseNo);
                          Boq_entryList.removeAt(index);
                          Navigator.of(context).pop();
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

          // ElevatedButton(
          //   onPressed: () => Navigator.of(context).pop(),
          //   child:Text('No'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     itemCheck=0;
          //     editCheck=0;
          //     delete_BoqRevised_itemlist_Table();
          //     Boqitem_itemview_GetDbList.value.clear();
          //     Boq_EntryList_DeleteApi(Boq_entryList.value[index].reviseId,Boq_entryList.value[index].reviseNo);
          //     Boq_entryList.removeAt(index);
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),
        ],
      ),
    );
  }

  setCheck(int id, bool value) {
    Boq_MainItemList.forEach((element) {
      if (element.level3ItemId == id) {
        element.isCheck = value;
      }
    });
  }

  serachsetCheck(int id, bool value) {
    list.forEach((element) {
      if (element.level3ItemId == id) {
        element.isCheck = value;
      }
    });
  }
}
