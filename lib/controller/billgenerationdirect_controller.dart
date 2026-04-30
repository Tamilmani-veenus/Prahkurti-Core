import 'package:image_picker/image_picker.dart';
import '../controller/logincontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/directbill_gen_itemlist_model.dart';
import '../db_services/direct_bill_itemlist_service.dart';
import '../home/menu/daily_entries/bill_generation_direct/bill_generation_entrylist.dart';
import '../home/menu/daily_entries/bill_generation_direct/bill_generationdirect_entry.dart';
import '../models/directbill_gener_saveapireq_model.dart';
import '../provider/directbill_generat_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillGenerationDirectController extends GetxController {
  final billentryDateController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  final RemarksController = TextEditingController();
  final itemDescController = TextEditingController();
  final itemUnitController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final itemRateController = TextEditingController();
  List<TextEditingController> itemlist_ListDescController = [];
  List<TextEditingController> itemlist_ListUnitsController = [];
  List<TextEditingController> itemlist_ListQtyController = [];
  List<TextEditingController> itemlist_ListRateController = [];
  List<TextEditingController> itemlist_ListAmtController = [];

  final billamount = TextEditingController();
  final Creditamt = TextEditingController();
  final CreditRemarksController = TextEditingController();
  final Debitamt = TextEditingController();
  final DebitRemarksController = TextEditingController();
  final tobededadv = TextEditingController();
  final Advded = TextEditingController();
  final Roundoff = TextEditingController();
  final netpayamt = TextEditingController();
  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  RxList main_entryList = [].obs;
  RxList bill_entryList = [].obs;
  RxList bill_itemList = [].obs;
  RxList bill_editListApiDatas = [].obs;

  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  String to_be_dection_advance = "0";
  int entrycheck = 0;
  int editCheck = 0;
  int workid = 0;
  int checkColor = 0;
  int buttonControl=0;
  RxString saveButton=RequestConstant.SUBMIT.obs;

  var directBillGen_ItemlistService = DirectBillGen_ItemlistService();

  var ItemListTableModel = DirectBillGenItemListTableModel();
  late List<DirectBillGenItemListTableModel> ItemListTableModelList = <DirectBillGenItemListTableModel>[];
  List ItemListTableModelReadList = <DirectBillGenItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  late List<DirectBillGenItemListTableModel> itemListUpdateModelList = <DirectBillGenItemListTableModel>[];
  late List<DirectBillGenItemListTableModel> deleteitemListModelList = <DirectBillGenItemListTableModel>[];
  RxList<BillDet> getDetList = <BillDet>[].obs;
  List<XFile> imageFiles = [];
  int pickedImageCount = 0;
  bool isSelected = false;
  bool isNetSelected = false;
  // String? gettingNetworkImage;
  // int? imageId;
  List<String> gettingNetworkImages = []; // store multiple URLs
  List<int> imageIds = [];

  Future DirectBill_EntryList() async {
    main_entryList.value.clear();
    bill_entryList.value.clear();
    await DirectBillGenerateProvider.getBillDirectEntry_List(
            loginController.user.value.userId,
            loginController.UserType(),
            EntrylistFrDate.text,
            EntrylistToDate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        main_entryList.value = value;
        bill_entryList.value = main_entryList.value;
        return main_entryList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  Future getNmrAdvance() async {
    to_be_dection_advance="0";
    await DirectBillGenerateProvider.billadv_balance(
            projectController.selectedProjectId.value,
            siteController.selectedsiteId.value,
            subcontractorController.selectedSubcontId.value)
        .then((value) async {
      if (value != null) {
        to_be_dection_advance = value;
        return to_be_dection_advance;
      }
    });
  }

  Future getWorkOrderList() async {
    await DirectBillGenerateProvider.getWorkOrderList(
        projectController.selectedProjectId.value,
        subcontractorController.selectedSubcontId.value,
        subcontractorController.selectedWorkOrderId.value).then((value) async {
      if (value != null && value.length > 0) {
        billgen_itemlistTable_Delete();
        ItemGetTableListdata.value=[];
        bill_editListApiDatas.value=[];
        bill_editListApiDatas.value = value;
        billgen_EditTable_SaveTable();
        getItemlistTablesDatas();
      }

    });
  }

  billgen_itemlistTable_Delete() async {
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_delete();
  }

  Future deleteByIditemlistTableable(DirectBillGenItemListTableModel data) async {
    deleteitemListModelList.clear();
    ItemListTableModel = new DirectBillGenItemListTableModel();
    ItemListTableModel.Id = data.Id;
    ItemListTableModel.Name = data.Name;
    deleteitemListModelList.add(ItemListTableModel);
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_deleteById(deleteitemListModelList);
  }

  billgen_itemlist_SaveTable() async {
    ItemListTableModelList.clear();
    ItemListTableModel = new DirectBillGenItemListTableModel();
    ItemListTableModel.Name = itemDescController.text;
    ItemListTableModel.unit = itemUnitController.text;
    ItemListTableModel.qty = double.parse(itemQuantityController.text);
    ItemListTableModel.rate = double.parse(itemRateController.text);
    ItemListTableModel.amount = (ItemListTableModel.qty!) * (ItemListTableModel.rate!);
    ItemListTableModelList.add(ItemListTableModel);
    var savedatas = await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_Save(ItemListTableModelList);
    return savedatas;
  }

  Future getItemlistTablesDatas() async {
    var datas = await directBillGen_ItemlistService
        .DirectBillGen_ItemlistTable_readAll();
    ItemListTableModelReadList = <DirectBillGenItemListTableModel>[];
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    datas.forEach((value) {
      ItemListTableModel = new DirectBillGenItemListTableModel();
      ItemListTextInitiate();
      ItemListTableModel.Id = value['id'];
      ItemListTableModel.Name = value['Name'];
      ItemListTableModel.unit = value['unit'];
      ItemListTableModel.qty = value['qty'];
      ItemListTableModel.rate = value['rate'];
      ItemListTableModel.amount = value['amount'];
      ItemListTableModelReadList.add(ItemListTableModel);
      ItemGetTableListdata.value = ItemListTableModelReadList;
    });
    setItemListListTextValue(ItemGetTableListdata.value);
  }

  ItemListTextInitiate() {
    itemlist_ListDescController.add(new TextEditingController());
    itemlist_ListUnitsController.add(new TextEditingController());
    itemlist_ListQtyController.add(new TextEditingController());
    itemlist_ListRateController.add(new TextEditingController());
    itemlist_ListAmtController.add(new TextEditingController());
  }

  setItemListListTextValue(vale) {
    int i = 0;
    vale.forEach((datas) {
      ItemListTextInitiate();
      itemlist_ListDescController[i].text = datas.Name.toString();
      itemlist_ListUnitsController[i].text = datas.unit.toString();
      itemlist_ListQtyController[i].text = datas.qty.toString();
      itemlist_ListRateController[i].text = datas.rate.toString();
      itemlist_ListAmtController[i].text = datas.amount.toString();
      i++;
    });
  }

  itemListclickChanged() {
    int i=0;
    ItemGetTableListdata.value.forEach((element) {
      ItemListTextInitiate();
        itemlist_ListAmtController[i].text = (double.parse(itemlist_ListQtyController[i].text != "" ? itemlist_ListQtyController[i].text : "0")* double.parse(itemlist_ListRateController[i].text != "" ? itemlist_ListRateController[i].text : "0")).toString();
      i++;
    });
    updateItemlistTable();
  }

  updateItemlistTable() async {
    int i = 0;
    itemListUpdateModelList.clear();
    ItemGetTableListdata.forEach((element) {
      ItemListTableModel = DirectBillGenItemListTableModel();
      ItemListTableModel.Id = element.Id;
      ItemListTableModel.Name = element.Name;
      ItemListTableModel.unit = itemlist_ListUnitsController[i].text;
      ItemListTableModel.qty = double.parse(itemlist_ListQtyController[i].text != "" ? itemlist_ListQtyController[i].text : "0");
      ItemListTableModel.rate = double.parse(itemlist_ListRateController[i].text != "" ? itemlist_ListRateController[i].text : "0");
      ItemListTableModel.amount = ItemListTableModel.qty! * ItemListTableModel.rate!;
      itemListUpdateModelList.add(ItemListTableModel);
      i++;
    });
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_Update(itemListUpdateModelList);
  }


  clearDatas(){
     to_be_dection_advance="0";
     saveButton.value=RequestConstant.SUBMIT;
     workid=0;
    projectController.projectname.text="--Select--";
    projectController.selectedProjectId.value=0;
    subcontractorController.Subcontractorname.text="--Select--";
    subcontractorController.selectedSubcontId.value=0;
     RemarksController.clear();
     billentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
     FromdateController.text=BaseUtitiles.initiateCurrentDateFormat();
     TodateController.text=BaseUtitiles.initiateCurrentDateFormat();
    siteController.selectedsiteId=0.obs;
    siteController.selectedsitedropdownName="--Select--".obs;
    siteController.getSiteDropdownvalue.value.clear();
    siteController.Sitename.text=RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
     billgen_itemlistTable_Delete();
     ItemGetTableListdata.value.clear();
     billamount.text="0.0";
     Creditamt.text="0.0";
     Debitamt.text="0.0";
     CreditRemarksController.text="-";
     DebitRemarksController.text="-";
     Advded.text="0.0";
     Roundoff.text="0";
     netpayamt.text="0.0";
     tobededadv.text= to_be_dection_advance;
  }


  Future SaveButton_DeductionScreen(BuildContext context, int id,int workOrderId) async {
    buttonControl = 1;
    getDetList.value.clear();
    await Future.delayed(const Duration(seconds: 0));
    String body = billDirectGenSaveApiReqToJson(BillDirectGenSaveApiReq(
      workId: id != 0 ? id.toString() : "0",
      workNo: autoYearWiseNoController.text,
      workDate: billentryDateController.text,
      entryType: "",
      projectId: projectController.selectedProjectId.value.toString(),
      siteId: siteController.selectedsiteId.toString(),
      subContId: subcontractorController.selectedSubcontId.value.toString(),
      fromDate: FromdateController.text,
      toDate: TodateController.text,
      remarks: RemarksController.text,
      rndOff: Roundoff.text,
      billAmt: billamount.text,
      actAdvAmt: tobededadv.text,
      advAmt: Advded.text,
      netPayAmt: netpayamt.text,
      debitAmt: Debitamt.text,
      creditAmt: Creditamt.text,
      debitRemarks: DebitRemarksController.text,
      creditRemarks: CreditRemarksController.text,
      preparedby: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      workOrderId: workOrderId.toString(),
      billno: subcontractorController.InvoiceNo.text,
      entryMode: saveButton.value == "Submit" ? "ADD" : saveButton.value ==
          "Re-Submit" ? "UPDATE" : saveButton.value == "Verify"
          ? "VERIFY"
          : saveButton.value == "Approve" ? "APPROVE" : "",
      billDet: getDetList.value.length == 0
          ? getNmrBillDet()
          : getDetList.value,
    ));
    final list = await DirectBillGenerateProvider.SaveSubContScreenEntryAPI(
        body, id, buttonControl, context);
    if (list != null) {
      if (id != 0) {
        entrycheck = 2;
        billgen_itemlistTable_Delete();
        ItemGetTableListdata.value.clear();
        BaseUtitiles.showToast(list);
        clearDatas();
        DirectBill_EntryList();
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        return;
      } else {
        if (list == RequestConstant.DUPLICATE_OCCURED) {
          //getNMRDetList.value.clear();
          Navigator.pop(context);
          Navigator.pop(context);
          buttonControl = 0;
          return BaseUtitiles.showToast(list!);
        }
        else {
          entrycheck = 2;
          buttonControl = 0;
          billgen_itemlistTable_Delete();
          ItemGetTableListdata.value.clear();
          BaseUtitiles.showToast(list!);
          clearDatas();
          await DirectBill_EntryList();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          return;

        }
      }
    }
  }

  List<BillDet>? getNmrBillDet() {
    getDetList.value.clear();
    ItemGetTableListdata.value.forEach((element) {
      var list = new BillDet(
          sno:element.Id.toString(),
          itemDes:element.Name.toString(),
          unit:element.unit.toString(),
          qty:element.qty.toString(),
          rate:element.rate.toString(),
          amount:element.amount.toString(),
      );
      getDetList.value.add(list);
    });
    return getDetList.value;
  }

  bool advance(String textAmount) {
    bool value = true;
    double amt = double.parse(textAmount);
    if (amt > 0.0) {
      value = false;
      return value;
    } else
      return value;
  }

  deductionPaymentCalculation() async {
    if (double.parse(to_be_dection_advance) < double.parse(Advded.text)) {
      BaseUtitiles.showToast("Please change the adv deduction amount");
      Advded.text = "0.0";
    } else {
      await getItemlistTablesDatas();
      var totNetAmount = 0.0;
      var netAmount;
      int roundOff;

      if (ItemGetTableListdata.value.isNotEmpty) {
        ItemGetTableListdata.value.forEach((element) {
          totNetAmount += element.amount;
        });

        billamount.text = totNetAmount.toString();
        netAmount = double.parse(billamount.text) +
            double.parse(Creditamt.text != "" ? Creditamt.text : "0") -
            double.parse(Debitamt.text != "" ? Debitamt.text : "0") -
            double.parse(Advded.text != "" ? Advded.text : "0") +
            double.parse(Roundoff.text != "" ? Roundoff.text : "0");
        roundOff = netAmount.round();
        netpayamt.text = roundOff.toString();
      }
    }
  }


  // deduction_paymentCalculation() async{
  //   if(double.parse(to_be_dection_advance) < double.parse(Advded.text)){
  //     BaseUtitiles.showToast("Please change the adv deduction amount");
  //     Advded.text="0.0";
  //   }
  //   else{
  //     await getItemlistTablesDatas();
  //     var tot_netamnt = 0.0;
  //     var netamount;
  //     int roundoff;
  //     if (ItemGetTableListdata.value.isNotEmpty) {
  //       ItemGetTableListdata.value.forEach((element) {
  //         tot_netamnt = tot_netamnt + element.amount;
  //       });
  //       billamount.text = tot_netamnt.toString();
  //       netamount = double.parse(billamount.text) + double.parse(Creditamt.text) - double.parse(Debitamt.text) - double.parse(Advded.text) + double.parse(Roundoff.text);
  //       roundoff = netamount.round();
  //       netpayamt.text = roundoff.toString();
  //     }
  //   }
  // }

  Future directBillEntryList_EditApi(int workid, BuildContext context) async {
    await DirectBillGenerateProvider.directBill_entryList_editAPI(workid).then((value) async {
      if (value != null && value.length > 0) {
        editCheck = 1;
        bill_editListApiDatas.value = value;
        billgen_EditTable_SaveTable();
        getItemlistTablesDatas();
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Bill_Generation_EntryScreen()),
        );

      }
    });
  }

  Future EntryList_DeleteApi(int WorkId,int subId,String WorkNo) async {
    await DirectBillGenerateProvider.entryList_deleteAPI(WorkId,subId,WorkNo,loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  billgen_EditTable_SaveTable() async {
    ItemListTableModelList.clear();
    bill_editListApiDatas.value.forEach((element) {
      element.billEditDet!.forEach((value) {
        ItemListTableModel = new DirectBillGenItemListTableModel();
        ItemListTableModel.Name = value.itemDesc.toString();
        ItemListTableModel.unit = value.unit.toString();
        ItemListTableModel.qty = value.qty;
        ItemListTableModel.rate = value.rate;
        ItemListTableModel.amount =value.amount;
        ItemListTableModelList.add(ItemListTableModel);
      });
    });
    var savedatas = await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_Save(ItemListTableModelList);
    return savedatas;
  }

  String ButtonChanges(int id){
    if(id!=0)
        return saveButton.value=RequestConstant.RESUBMIT;
    else
      return saveButton.value=RequestConstant.SUBMIT;
  }

  Future DeleteAlert(BuildContext context,int index) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,  //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          editCheck=0;
                          entrycheck=0;
                          billgen_itemlistTable_Delete();
                          ItemGetTableListdata.value.clear();
                          EntryList_DeleteApi(bill_entryList[index].workId,bill_entryList[index].subContId,bill_entryList[index].workNo);
                          bill_entryList.removeAt(index);
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
          //    editCheck=0;
          //    entrycheck=0;
          //    billgen_itemlistTable_Delete();
          //    ItemGetTableListdata.value.clear();
          //    EntryList_DeleteApi(bill_entryList[index].workId,bill_entryList[index].subContId,bill_entryList[index].workNo);
          //    bill_entryList.removeAt(index);
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),
        ],
      ),
    );
  }






}
