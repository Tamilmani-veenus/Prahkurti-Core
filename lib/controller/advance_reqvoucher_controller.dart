import '../controller/commonvoucher_controller.dart';
import '../controller/logincontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../db_model/advReqvoucher_itemlistTable_model.dart';
import '../db_services/advReqvoucher_itemlist_service.dart';
import '../home/menu/daily_entries/advance_requs_voucher/advance_req_entry.dart';
import '../home/menu/daily_entries/advance_requs_voucher/advance_req_entrylist.dart';
import '../models/AdvanceReqDeleteModel.dart';
import '../models/advancereqvouche_saveapi_reqmodel.dart';
import '../provider/advancereqvoucher_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvanceReqVoucherController extends GetxController {

  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
  SiteController siteController = Get.put(SiteController());
  final autoYearWiseNoController = TextEditingController();
  final entryDateController = TextEditingController();
  LoginController loginController=Get.put(LoginController());
  ProjectController projectController=Get.put(ProjectController());


  final itemlistDetAmount = TextEditingController();
  final itemlistTds_Percent = TextEditingController();
  final itemlistTdsamount = TextEditingController();
  final itemlistNetAmount = TextEditingController();
  final remarksController = TextEditingController();
  final entry_amount = TextEditingController();


  final entrlistFdateController = TextEditingController();
  final entrlistTdateController = TextEditingController();

  List<TextEditingController> Itemlist_siteName_ListController = [];
  List<TextEditingController> Itemlist_paymentType_ListController = [];
  List<TextEditingController> Itemlist_amount_ListControllers = [];
  List<TextEditingController> Itemlist_netAmount_ListController = [];


  RxList<VocDet> getDetList = <VocDet>[].obs;
  RxList entryList=[].obs;
  RxList mainlist=[].obs;
  RxList editListApiDatas=[].obs;
  RxString radioType = "".obs;
  int vocId=0;
  int checkColor=0;


  RxString saveButton=RequestConstant.SUBMIT.obs;

  late List<AdvReqVoucherItemListTableModel> ItemListTableModelList =
  <AdvReqVoucherItemListTableModel>[];
  var ItemListTableModel = new AdvReqVoucherItemListTableModel();
  var advreqVoucher_ItemlistService = AdvreqVoucher_ItemlistService();
  List ItemListTableModelReadList = <AdvReqVoucherItemListTableModel>[];
  late List<AdvReqVoucherItemListTableModel> itemListUpdateModelList =
  <AdvReqVoucherItemListTableModel>[];
  RxList ItemGetTableListdata = [].obs;
  List<AdvReqVoucherItemListTableModel> deleteTableModelList =
  <AdvReqVoucherItemListTableModel>[];
  int entrycheck=0;
  int editcheck=0;



  calculation(double? amt, double? tds) {
    itemlistTdsamount.text = (amt! * tds! / 100).toString();
    itemlistNetAmount.text =
        (amt - double.parse(itemlistTdsamount.text)).toString();
  }



  Future getEntryList() async {
    mainlist.value.clear();
    entryList.value.clear();
    await AdvanceReqVoucherProvider.getEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        entrlistFdateController.text,
        entrlistTdateController.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        mainlist.value = value;
        entryList.value =mainlist.value;
        return mainlist.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  itemlistTable_Delete() async {
    await advreqVoucher_ItemlistService.AdvreqVoucher_ItemlistTable_delete();
  }

  itemlistPopup_saveLabTableDatas(BuildContext context) async {
    int j = 0;
    ItemListTableModelList.clear();
    ItemListTableModel = new AdvReqVoucherItemListTableModel();
    ItemListTableModel.siteId = siteController.selectedsiteId.value;
    ItemListTableModel.siteName = siteController.selectedsitedropdownName.value;
    ItemListTableModel.paymentType = commonVoucherController.detVocType;
    ItemListTableModel.amount = double.parse(itemlistDetAmount.value.text);
    ItemListTableModel.tds_percent = double.parse(itemlistTds_Percent.value.text);
    ItemListTableModel.tds_amount = double.parse(itemlistTdsamount.value.text);
    ItemListTableModel.netAmount = double.parse(itemlistNetAmount.value.text);
    ItemGetTableListdata.value.forEach((element) {
      if (element.siteId == ItemListTableModel.siteId) {
        j = 1;
      }
    });
    if (j == 0) {
      ItemListTableModelList.add(ItemListTableModel);
    } else {
      j = 0;
    }

    var savedatas =
    await advreqVoucher_ItemlistService.AdvreqVoucher_ItemlistTable_Save(ItemListTableModelList);
    return Navigator.pop(context, savedatas);
  }

  Future getItemlistTablesDatas() async {
    var datas = await advreqVoucher_ItemlistService
        .AdvreqVoucher_ItemlistTable_readAll();
    ItemListTableModelReadList = <AdvReqVoucherItemListTableModel>[];
    ItemListTableModelReadList.clear();
    ItemGetTableListdata.value.clear();
    datas.forEach((value) {
      ItemListTableModel = new AdvReqVoucherItemListTableModel();
      ItemListTableModel.id = value['id'];
      ItemListTableModel.siteId = value['siteId'];
      ItemListTableModel.siteName = value['siteName'];
      ItemListTableModel.paymentType = value['paymentType'];
      ItemListTableModel.amount = value['amount'];
      ItemListTableModel.tds_percent = value['tds_percent'];
      ItemListTableModel.tds_amount = value['tds_amount'];
      ItemListTableModel.netAmount = value['netAmount'];
      ItemListTableModelReadList.add(ItemListTableModel);
      ItemGetTableListdata.value = ItemListTableModelReadList;

    });
  }

  itemlist_textControllersInitiate() {
    Itemlist_siteName_ListController.add(new TextEditingController());
    Itemlist_paymentType_ListController.add(new TextEditingController());
    Itemlist_amount_ListControllers.add(new TextEditingController());
    Itemlist_netAmount_ListController.add(new TextEditingController());
  }

  Future deleteParticularList(AdvReqVoucherItemListTableModel data) async {
    deleteTableModelList.clear();
    ItemListTableModel = new AdvReqVoucherItemListTableModel();

    ItemListTableModel.siteId = data.siteId;
    deleteTableModelList.add(ItemListTableModel);
    await advreqVoucher_ItemlistService.AdvreqVoucher_ItemlistTable_deleteById(deleteTableModelList);
  }

  Future SaveApi_ItemlistScreen(BuildContext context,int id) async {
    getDetList.value.clear();
    await Future.delayed(const Duration(seconds:0));
    String body = advanceReqvoucherSaveApiReqToJson(AdvanceReqvoucherSaveApiReq(
      vocId:id!=0?id.toString(): "0",
      vocNo:autoYearWiseNoController.text,
      vocDate:entryDateController.text,
      vocType:commonVoucherController.VocType.value,
      projectId:projectController.selectedProjectId.value.toString(),
      accTypeId:commonVoucherController.selectedAccId.value.toString(),
      accNameId:commonVoucherController.selectedAccnameId.value.toString(),
      payFor:commonVoucherController.selectedAccPayId.value.toString(),
      payMode:commonVoucherController.selectedPaymodeId.value.toString(),
      payType:"SP",
      vocAmt:itemlistNetAmount.text,
      companyId:"0",
      bankId:"0",
      chqNo:"0",
      chqDate:"",
      nameThrough:commonVoucherController.Accountname.text,
      remarks:remarksController.text,
      preparedby:loginController.EmpId(),
      userId:loginController.UserId(),
      deviceName:BaseUtitiles.deviceName,
      entryMode:saveButton.value=="Submit"?"ADD":saveButton.value=="Re-Submit"?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
      vocDet:getDetList.value.length==0 ? getDetDetails(): getDetList.value,
    ));
    final list = await AdvanceReqVoucherProvider.SaveApi(body,id, 0,context);
    if(list != null) {
      if (id != 0) {
        BaseUtitiles.showToast(list);
        Navigator.pop(context);
        return Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                new Advance_req_EntryListScreen()));
      }
      else {
        if (list == RequestConstant.DUPLICATE_OCCURED) {
          Navigator.pop(context);
          Navigator.pop(context);
          return BaseUtitiles.showToast(list!);
        } else {
          BaseUtitiles.showToast(list!);
          Navigator.pop(context);
          return Navigator.pushReplacement(context, new MaterialPageRoute(
              builder: (
                  BuildContext context) => new Advance_req_EntryListScreen()));
        }
      }
    }
  }

  List<VocDet>? getDetDetails() {
    for (int index = 0; index < ItemGetTableListdata.length; index++) {
      var list = new VocDet(
        siteId:ItemGetTableListdata[index].siteId.toString(),
        payType:ItemGetTableListdata[index].paymentType.toString(),
        amt:ItemGetTableListdata[index].amount.toString(),
        tdsPer:ItemGetTableListdata[index].tds_percent.toString(),
        tdsAmt:ItemGetTableListdata[index].tds_amount.toString(),
        netAmt:ItemGetTableListdata[index].netAmount.toString(),
      );
      getDetList.add(list);
    }
    return getDetList.value;
  }





  Future EntryList_EditApi(int vocId, int acctypId,int accnameId, int prjId,BuildContext context) async {
    await AdvanceReqVoucherProvider.entryList_editAPI(vocId,acctypId,accnameId,prjId).then((value) async {
      if (value != null && value.length > 0) {
        editcheck = 1;
        editListApiDatas.value = value;
        EditTable_SaveTable();
        await getItemlistTablesDatas();
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Advance_Req_Voucher_EntryScreen()),
        );
      }
    });
  }

  EditTable_SaveTable() async {
    ItemListTableModelList.clear();
    editListApiDatas.value.forEach((element) {
      element.vocEditDet.forEach((value) {
        ItemListTableModel = new AdvReqVoucherItemListTableModel();
        ItemListTableModel.siteId = value.siteId;
        ItemListTableModel.siteName = value.siteName.toString();
        ItemListTableModel.paymentType = value.payType.toString();
        ItemListTableModel.amount = value.amt;
        ItemListTableModel.tds_percent =value.tdsPer;
        ItemListTableModel.tds_amount = value.tdsAmt;
        ItemListTableModel.netAmount = value.netAmt;
        ItemListTableModelList.add(ItemListTableModel);
      });
    });
    var savedatas = await advreqVoucher_ItemlistService.AdvreqVoucher_ItemlistTable_Save(ItemListTableModelList);
    return savedatas;
  }

  String ButtonChanges(int id){
    if(id!=0)
      return saveButton.value=RequestConstant.RESUBMIT;
    else
      return saveButton.value=RequestConstant.SUBMIT;
  }

  netamountCalculation(){
    entry_amount.text="0.0";
    if(ItemGetTableListdata.value.isNotEmpty){
      ItemGetTableListdata.value.forEach((element) {
        entry_amount.text=(double.parse(entry_amount.text)+element.netAmount).toString();
      });
    }
    else{
      entry_amount.text="0.0";
    }
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
              entrycheck=0;
              editcheck=0;

              // EntryList_DeleteApi(entryList[index].vocId,entryList[index].vocNo);
              entryList.removeAt(index);
              Navigator.of(context).pop();
            },
            child:Text('Yes'),
          ),


        ],
      ),
    );
  }

}
