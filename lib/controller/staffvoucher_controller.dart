import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/staffcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../db_model/staffvoucherdetsite_model.dart';
import '../db_services/staffvouchersitelist_service.dart';
import '../home/menu/accounts/staff_voucher/staff_voucher_entry.dart';
import '../home/menu/accounts/staff_voucher/staff_voucher_entrylist.dart';
import '../models/staffvouchersiterequest_model.dart';
import '../provider/staffvoucher_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'commonvoucher_controller.dart';
import 'logincontroller.dart';

class StaffVoucher_Controller extends GetxController {
  final StaffVocEntrylistFrDate = TextEditingController();
  final StaffVocEntrylistToDate = TextEditingController();
  final AutoYearwisestaffVoc = new TextEditingController();
  final staffvocDate = new TextEditingController();
  final DetAmount = TextEditingController();
  final Tds = TextEditingController();
  final Tdsamount = TextEditingController();
  final NetAmount = TextEditingController();
  final TotalAmount = TextEditingController();
  final Remarks = TextEditingController();
  final BankName = TextEditingController();
  final ChequeDate = TextEditingController();
  final ChequeNo = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());

  RxList StaffVocEtyList = [].obs;
  RxList getbankNameList = [].obs;
  RxList SearchBar_bankNameList = [].obs;
  RxInt selectedbankId = 0.obs;
  RxString selectedbankdropdownName = "".obs;

  SiteController siteController = Get.put(SiteController());
  CommonVoucherController commonVoucherController =
      Get.put(CommonVoucherController());
  StaffController staffController = Get.put(StaffController());

  var staffvouchersiteItemListTableModel = StaffvouchersiteDetlist();
  late List<StaffvouchersiteDetlist> staffvouchersiteTableList =
      <StaffvouchersiteDetlist>[];
  late List<StaffvouchersiteDetlist> deleteModelList =
      <StaffvouchersiteDetlist>[];
  RxList<AccStaffVocSWpayment> getSiteDetList = <AccStaffVocSWpayment>[].obs;
  var staffvouchersitelistService = StaffvouchersitelistService();

  RxList Staffvoucher_itemview_GetDbList = [].obs;
  RxList Sitevoucher_EditListApiValue = [].obs;

  RxString type = "Direct Payment/Office".obs;
  RxBool payeeType = false.obs;
  RxString SaveButton = RequestConstant.SUBMIT.obs;

  clearDatas() {
    SaveButton.value = RequestConstant.SUBMIT;
    type.value = "SiteWise Payment";
    delete_Sitevoucher_itemlist_Table();
    Staffvoucher_itemview_GetDbList.clear();
    TotalAmount.text = "0.00";
    staffvocDate.text = BaseUtitiles.initiateCurrentDateFormat();

    staffController.Staffname.text = "--Select--";
    commonVoucherController.VoucherTypeController.text = "Payment";
    commonVoucherController.VocType.value = "P";
    commonVoucherController.AccountTypename.text = "--Select--";
    commonVoucherController.Accountname.text = "--Select--";
    commonVoucherController.selectedAccnameId = 0.obs;
    commonVoucherController.Paymodename.text = "--Select--";
    commonVoucherController.AccPayforname.text = "--Select--";
    Remarks.text = "";
  }

  Future getStaffVoc_EntryList() async {
    StaffVocEtyList.value = [];
    final value = await StaffVoucher_provider.getStaffVouc_Entry_List(
        StaffVocEntrylistFrDate.text, StaffVocEntrylistToDate.text);
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          StaffVocEtyList.value = value.result!;
        } else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  calculation(double? amt, double? tds) {
    Tdsamount.text = (amt! * tds! / 100).toString();
    NetAmount.text = (amt - double.parse(Tdsamount.text)).toString();
  }

//---Save to Db
  Sitevoucher_Save_DB(BuildContext context) async {
    staffvouchersiteTableList.clear();
    int j = 0;
    int amt = 0;
    int netAmount = 0;
    if (NetAmount.text == "0.0" ||
        NetAmount.text == "0.00" ||
        NetAmount.text == "0") {
    } else {
      staffvouchersiteItemListTableModel = new StaffvouchersiteDetlist();
      staffvouchersiteItemListTableModel.reqDetId = 0;
      staffvouchersiteItemListTableModel.siteid =
          siteController.selectedsiteId.value;
      staffvouchersiteItemListTableModel.projectid =
          projectController.selectedProjectId.value;
      staffvouchersiteItemListTableModel.sitename =
          siteController.Sitename.text;
      staffvouchersiteItemListTableModel.projectname =
          projectController.projectname.text;
      staffvouchersiteItemListTableModel.paytype =
          commonVoucherController.detVocType;
      amt = double.parse(DetAmount.text).round();
      staffvouchersiteItemListTableModel.amt = amt.toDouble();
      staffvouchersiteItemListTableModel.TdsPer = double.parse(Tds.text);
      staffvouchersiteItemListTableModel.TdsAmt = double.parse(Tdsamount.text);
      netAmount = double.parse(NetAmount.text).round();
      staffvouchersiteItemListTableModel.NetAmt = netAmount.toDouble();
      for (var element in Staffvoucher_itemview_GetDbList.value) {
        if (element.siteid == staffvouchersiteItemListTableModel.siteid &&
            element.paytype == staffvouchersiteItemListTableModel.paytype) {
          j = 1;
          BaseUtitiles.showToast("Entry already exist");
        }
      }
      if (j == 0) {
        staffvouchersiteTableList.add(staffvouchersiteItemListTableModel);
      } else {
        j = 0;
      }
    }

    var savedatas =
        await staffvouchersitelistService.StaffvoucherSiteItemlist_table_Save(
            staffvouchersiteTableList);
    return Navigator.pop(context, savedatas);
  }

  //Get Values

  Future getstaffvouchersiteTablesDatas() async {
    Staffvoucher_itemview_GetDbList.clear();
    var siteItem = await staffvouchersitelistService
        .StaffvoucherSiteItemlist_table_readAll();
    siteItem.forEach((user) {
      var StaffvouchersiteItemlist = StaffvouchersiteDetlist();
      StaffvouchersiteItemlist.reqDetId = user['reqDetId'];
      StaffvouchersiteItemlist.siteid = user['siteid'];
      StaffvouchersiteItemlist.projectid = user['projectid'];
      StaffvouchersiteItemlist.sitename = user['sitename'];
      StaffvouchersiteItemlist.projectname = user['projectname'];
      StaffvouchersiteItemlist.paytype = user['paytype'];
      StaffvouchersiteItemlist.amt = user['amt'];
      StaffvouchersiteItemlist.TdsPer = user['TdsPer'];
      StaffvouchersiteItemlist.TdsAmt = user['TdsAmt'];
      StaffvouchersiteItemlist.NetAmt = user['NetAmt'];
      Staffvoucher_itemview_GetDbList.add(StaffvouchersiteItemlist);
    });
  }

  netamountCalculation() {
    TotalAmount.text = "0.0";
    int count = 0;
    if (Staffvoucher_itemview_GetDbList.value.isNotEmpty) {
      Staffvoucher_itemview_GetDbList.forEach((element) {
        count = (double.parse(TotalAmount.text) + element.NetAmt).round();
        TotalAmount.text = count.toString();
      });
    } else {
      TotalAmount.text = "0.0";
    }
  }

  //Particular delete
  Future deleteParticularList(StaffvouchersiteDetlist data) async {
    deleteModelList.clear();
    staffvouchersiteItemListTableModel = new StaffvouchersiteDetlist();
    staffvouchersiteItemListTableModel.siteid = data.siteid;
    deleteModelList.add(staffvouchersiteItemListTableModel);
    await staffvouchersitelistService.StaffvoucherSitedeleteById(
        deleteModelList);
  }

  delete_Sitevoucher_itemlist_Table() async {
    await staffvouchersitelistService.StaffvoucherSiteItemlist_table_delete();
  }

  Future getBankName_List() async {
    getbankNameList.value = [];
    final value = await StaffVoucher_provider.getBankName_List();
    if (value != null) {
      if (value.success == true) {
        if (value.result!.isNotEmpty) {
          getbankNameList.value = value.result!;
        } else {
          BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
        }
      } else {
        BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  //----- POST and PUT JSON Values----
  Future SaveButtonSitevoucher_ItemlistScreen(
      BuildContext context, int id) async {
    String body = staffvouchersiteRequestToJson(StaffvouchersiteRequest(
      id: SaveButton.value == RequestConstant.RESUBMIT ? id : 0,
      staffVocNo: AutoYearwisestaffVoc.text,
      employeeId: staffController.selectedstaffId.value,
      vocType: commonVoucherController.VocType.value,
      vocDate: staffvocDate.text,
      accTypeId: commonVoucherController.selectedAccTypeId.value,
      payFor: commonVoucherController.selectedAccPayId.value,
      paymentMode: commonVoucherController.selectedPaymodeId.value,
      payType: type.value == "Direct Payment/Office" ? "DP" : "SP",
      vocAmount: double.tryParse(TotalAmount.text),
      paidBy: 0,
      companyId: 0,
      remarks: Remarks.text,
      bankId: selectedbankId.value,
      chequeNo: ChequeNo.text,
      chequeDate: ChequeDate.text,
      nameThrough: commonVoucherController.namethrough.text,
      requisitionId: 0,
      accountPayee: payeeType.value==true? 1 : 0,
      projectId: projectController.selectedProjectId.value,
      createdBy: int.tryParse(loginController.EmpId()),
      createdDate: BaseUtitiles().convertToUtcIso(staffvocDate.text),
      accountNameId: commonVoucherController.selectedAccnameId.value,
      accStaffVocSWpaymentS: getSitevoucherDet(id),
    ));

    final list = await StaffVoucher_provider.SaveSitevoucherScreenEntryAPI(body, id);

    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        await getStaffVoc_EntryList();
        clearDatas();
        delete_Sitevoucher_itemlist_Table();
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

  List<AccStaffVocSWpayment>? getSitevoucherDet(id) {
    getSiteDetList.value=[];
    Staffvoucher_itemview_GetDbList.value.forEach((element) {
      var list = new AccStaffVocSWpayment(
          id: SaveButton.value == RequestConstant.RESUBMIT ?element.reqDetId:0,
          staffVocherId: SaveButton.value == RequestConstant.RESUBMIT ? id : 0,
          payType: element.paytype.toString(),
          amount: element.amt,
          tdsPercentage: element.TdsPer,
          tdsAmount: element.TdsAmt,
          netAmount: element.NetAmt,
          purOrdMasId: 0,
          purOrdBillMasId: 0,
          workOrderId: 0,
          workId: 0,
          nmrWorkId: 0,
          nmrWorkDetId: 0,
          siteId: element.siteid,
          projectId: element.projectid,
          reqAmount: element.amt,
          paymentReqId: 0);
      getSiteDetList.value.add(list);
    });
    return getSiteDetList.value;
  }

  //----Delete---
  Future<bool> StaffvoucherList_DeleteApi(int vocId) async {
    return StaffVoucher_provider.Staffvoucher_entryList_deleteAPI(vocId);
  }

  // ---------Edit Call API----------

  Future Sitevoucher_entrylist_editSaveDetTable() async {
    staffvouchersiteTableList.clear();
    Sitevoucher_EditListApiValue.forEach((element) {
      element.accStaffVocSWpaymentS.forEach((val) {
        staffvouchersiteItemListTableModel = new StaffvouchersiteDetlist();
        staffvouchersiteItemListTableModel.reqDetId = val.id;
        staffvouchersiteItemListTableModel.siteid = val.siteId;
        staffvouchersiteItemListTableModel.projectid = val.projectId;
        staffvouchersiteItemListTableModel.sitename = val.siteName.toString();
        staffvouchersiteItemListTableModel.projectname =
            val.projectName.toString();
        staffvouchersiteItemListTableModel.paytype = val.payType.toString();
        staffvouchersiteItemListTableModel.amt = val.amount;
        staffvouchersiteItemListTableModel.TdsPer = val.tdsPercentage;
        staffvouchersiteItemListTableModel.TdsAmt = val.tdsAmount;
        staffvouchersiteItemListTableModel.NetAmt = val.netAmount;
        staffvouchersiteTableList.add(staffvouchersiteItemListTableModel);
      });
    });
    var savedatas =
        await staffvouchersitelistService.StaffvoucherSiteItemlist_table_Save(
            staffvouchersiteTableList);
    return savedatas;
  }

  Future StaffvoucherEntryList_EditApi(int VocId, BuildContext context) async {
    Sitevoucher_EditListApiValue.value = [];
    final value = await StaffVoucher_provider.SitevoucherSite_entryList_editAPI(VocId);
    if (value != null) {
      if (value.success == true) {
          Sitevoucher_EditListApiValue.value = [value.result];
          if (Sitevoucher_EditListApiValue.value.isNotEmpty) {
            SaveButton.value = RequestConstant.RESUBMIT;
          await Sitevoucher_entrylist_editSaveDetTable();
          await getstaffvouchersiteTablesDatas();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Staff_Voucher_EntryScreen()),
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
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          bool result = await StaffvoucherList_DeleteApi(
                              StaffVocEtyList[index].id);
                          if (result) {
                            StaffVocEtyList.removeAt(index);
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

          // ElevatedButton(
          //   onPressed: () => Navigator.of(context).pop(),
          //   child:Text('No'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     editcheck=0;
          //     itemcheck=0;
          //     Active=0;
          //     delete_Sitevoucher_itemlist_Table();
          //     Sitevoucher_itemview_GetDbList.value.clear();
          //     SitevoucherList_DeleteApi(StaffVocEtyList[index].vocId,StaffVocEtyList[index].vocNo);
          //     StaffVocEtyList.removeAt(index);
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),
        ],
      ),
    );
  }
}
