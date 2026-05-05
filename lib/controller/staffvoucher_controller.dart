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

class StaffVoucher_Controller extends GetxController{
  final StaffVocEntrylistFrDate = TextEditingController();
  final StaffVocEntrylistToDate = TextEditingController();
  final AutoYearwisestaffVoc=new TextEditingController();
  final staffvocDate=new TextEditingController();
  final DetAmount=TextEditingController();
  final Tds=TextEditingController();
  final Tdsamount=TextEditingController();
  final NetAmount=TextEditingController();
  final TotalAmount=TextEditingController();
  final Remarks=TextEditingController();
  final BankName=TextEditingController();
  final ChequeDate=TextEditingController();
  final CheckNo=TextEditingController();

  int checkColor = 0;



  LoginController loginController = Get.put(LoginController());
  ProjectController projectController=Get.put(ProjectController());

  RxList StaffVocEtyList = [].obs;
  RxList mainentrylist = [].obs;

  RxList getbankNameList = [].obs;
  RxList SearchBar_bankNameList = [].obs;
  RxList bankDropdownName = [].obs;
  RxInt selectedbankId = 0.obs;
  RxString selectedbankdropdownName = "".obs;
  int buttonControl = 0;

  SiteController siteController=Get.put(SiteController());
  CommonVoucherController commonVoucherController=Get.put(CommonVoucherController());
  StaffController staffController=Get.put(StaffController());

  var staffvouchersiteItemListTableModel = StaffvouchersiteDetlist();
  late List<StaffvouchersiteDetlist> staffvouchersiteTableList = <StaffvouchersiteDetlist>[];
  late List<StaffvouchersiteDetlist> deleteModelList = <StaffvouchersiteDetlist>[];
  RxList<VocDet> getSiteDetList = <VocDet>[].obs;
  var staffvouchersitelistService = StaffvouchersitelistService();


  RxList Sitevoucher_itemview_GetDbList = [].obs;
  RxList Sitevoucher_EditListApiValue=[].obs;
  int editcheck=0;
  int itemcheck=0;
  int Active=0;
  int VocID=0;
  RxString type="SiteWise Payment".obs;
  String edittype="";
  RxString Button=RequestConstant.SUBMIT.obs;
  RxString SaveButton=RequestConstant.SUBMIT.obs;


  clearDatas(){
    SaveButton.value=RequestConstant.SUBMIT;
    Button.value=RequestConstant.SUBMIT;
    type.value="SiteWise Payment";
    delete_Sitevoucher_itemlist_Table();
    Sitevoucher_itemview_GetDbList.clear();
    TotalAmount.text="0.00";
    staffvocDate.text=BaseUtitiles.initiateCurrentDateFormat();

    staffController.Staffname.text="--Select--";
    commonVoucherController.VoucherTypeController.text="Payment";
    commonVoucherController.VocType.value = "P";
    commonVoucherController.AccountTypename.text="--Select--";
    commonVoucherController.Accountname.text="--Select--";
    commonVoucherController.selectedAccnameId=0.obs;
    commonVoucherController.Paymodename.text="--Select--";
    commonVoucherController.AccPayforname.text="--Select--";
    Remarks.text="";
  }



  Future getStaffVoc_EntryList() async {
    mainentrylist.value.clear();
    StaffVocEtyList.value.clear();
    await StaffVoucher_provider.getStaffVouc_Entry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        StaffVocEntrylistFrDate.text,
        StaffVocEntrylistToDate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        mainentrylist.value = value;
        StaffVocEtyList.value = mainentrylist.value;
        return mainentrylist.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }
  calculation(double? amt,double? tds){
    Tdsamount.text=(amt! * tds!/100).toString();
    NetAmount.text=(amt - double.parse(Tdsamount.text)).toString();

  }
//---Save to Db
  Sitevoucher_Save_DB(BuildContext context) async {
    staffvouchersiteTableList.clear();
    int j=0;
    int amt=0;
    int netAmount=0;
    if (NetAmount.text == "0.0" ||
        NetAmount.text == "0.00" ||
        NetAmount.text == "0") {
    } else {
      staffvouchersiteItemListTableModel =new StaffvouchersiteDetlist();
      staffvouchersiteItemListTableModel.siteid = siteController.selectedsiteId.value;
      staffvouchersiteItemListTableModel.projectid = projectController.selectedProjectId.value;
      staffvouchersiteItemListTableModel.sitename = siteController.Sitename.text;
      staffvouchersiteItemListTableModel.projectname = projectController.projectname.text;
      staffvouchersiteItemListTableModel.paytype = commonVoucherController.detVocType;
      amt=double.parse(DetAmount.text).round();
      staffvouchersiteItemListTableModel.amt = amt.toDouble();
      staffvouchersiteItemListTableModel.TdsPer = double.parse(Tds.text);
      staffvouchersiteItemListTableModel.TdsAmt = double.parse(Tdsamount.text);
      netAmount= double.parse(NetAmount.text).round();
      staffvouchersiteItemListTableModel.NetAmt =netAmount.toDouble();
      Sitevoucher_itemview_GetDbList.value.forEach((element) {
        if(element.siteid ==staffvouchersiteItemListTableModel.siteid){
          j=1;
        }
      });
      if(j==0){
        staffvouchersiteTableList.add(staffvouchersiteItemListTableModel);
      }
      else{
        j=0;
      }
    }

    var savedatas = await staffvouchersitelistService.StaffvoucherSiteItemlist_table_Save(staffvouchersiteTableList);
    return Navigator.pop(context, savedatas);
  }

  //Get Values

  Future getstaffvouchersiteTablesDatas() async {
    Sitevoucher_itemview_GetDbList.clear();
    var siteItem = await staffvouchersitelistService.StaffvoucherSiteItemlist_table_readAll();
    siteItem.forEach((user) {
      var StaffvouchersiteItemlist =StaffvouchersiteDetlist();
      StaffvouchersiteItemlist.siteid = user['siteid'];
      StaffvouchersiteItemlist.projectid = user['projectid'];
      StaffvouchersiteItemlist.sitename = user['sitename'];
      StaffvouchersiteItemlist.projectname = user['projectname'];
      StaffvouchersiteItemlist.paytype = user['paytype'];
      StaffvouchersiteItemlist.amt = user['amt'];
      StaffvouchersiteItemlist.TdsPer = user['TdsPer'];
      StaffvouchersiteItemlist.TdsAmt = user['TdsAmt'];
      StaffvouchersiteItemlist.NetAmt = user['NetAmt'];
      Sitevoucher_itemview_GetDbList.add(StaffvouchersiteItemlist);
    });
  }

  netamountCalculation(){
    TotalAmount.text="0.0";
    int count=0;
    if(Sitevoucher_itemview_GetDbList.value.isNotEmpty) {
      Sitevoucher_itemview_GetDbList.forEach((element) {
        count=(double.parse(TotalAmount.text) + element.NetAmt).round();
        TotalAmount.text = count.toString();
      });
    }
    else{
      TotalAmount.text="0.0";
    }
  }



  //Particular delete
  Future deleteParticularList(StaffvouchersiteDetlist data) async {
    deleteModelList.clear();
    staffvouchersiteItemListTableModel = new StaffvouchersiteDetlist();
    staffvouchersiteItemListTableModel.siteid = data.siteid;
    deleteModelList.add(staffvouchersiteItemListTableModel);
    await staffvouchersitelistService.StaffvoucherSitedeleteById(deleteModelList);
  }

  delete_Sitevoucher_itemlist_Table() async {
    await staffvouchersitelistService.StaffvoucherSiteItemlist_table_delete();
  }


  //---------BankName List----------------
  // Future getBankName_List() async {
  //   bankNameList.value.clear();
  //   // SearchBar_bankNameList.clear();
  //   await StaffVoucher_provider.getBankName_List().then((value) async {
  //     if (value != null && value.length > 0) {
  //       bankNameList.value = value;
  //       // SearchBar_bankNameList.value = bankNameList.value;
  //       return bankNameList.value;
  //     }
  //     else {
  //       BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
  //     }
  //   });
  // }



  Future getBankName_List(BuildContext context) async {
    getbankNameList.value = await StaffVoucher_provider.getBankName_List();
    getbankNameList.value.forEach((element) {
      return bankDropdownName.add(element.bank);
    });
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return StaffShowPopup(list:getStaffDropdownvalue.value,value: 0,);
    //     });
  }

  setSelectedBankID(String value) {
    if (getbankNameList.value.length>0) {
      getbankNameList.forEach((element) {
        if(value == element.bank){
          selectedbankId(element.bankId);
        }
      });
    }
    setSelectedstafftName(selectedbankId.value);
  }

  setSelectedstafftName(int? id) {
    if (getbankNameList.value != null) {
      getbankNameList.value.forEach((element) {
        if (id == element.bankId) {
          selectedbankdropdownName(element.bank.toString());
        }
      });
    }
    BankName.text=selectedbankdropdownName.value;
  }






  //----- POST and PUT JSON Values----
  Future SaveButtonSitevoucher_ItemlistScreen(BuildContext context, int id) async {
    buttonControl = 1;
    getSiteDetList.value.clear();
    if (type.value == "SiteWise Payment") {
      await getstaffvouchersiteTablesDatas();
    }
    String body = staffvouchersiteRequestToJson(StaffvouchersiteRequest(
      vocId: id != 0 ? id.toString() : "0",
      vocNo: AutoYearwisestaffVoc.text,
      vocDate: staffvocDate.text,
      vocType: commonVoucherController.VocType.value,
      staffId: staffController.selectedstaffId.value.toString(),
      accTypeId: commonVoucherController.selectedAccTypeId.value.toString(),
      accNameId: commonVoucherController.selectedAccnameId.value.toString(),
      payFor: commonVoucherController.selectedAccPayId.value.toString(),
      payMode: commonVoucherController.selectedPaymodeId.value.toString(),
      payType: type.value == "Direct Payment/Office" ? "DP" : "SP",
      vocAmt: TotalAmount.text,
      companyId: "0",
      bankId: selectedbankId.value.toString(),
      chqNo: CheckNo.text,
      chqDate: ChequeDate.text,
      nameThrough: commonVoucherController.namethrough.text,
      remarks: Remarks.text,
      preparedby: loginController.EmpId(),
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      entryMode: SaveButton.value == "Submit" ? "ADD" : SaveButton.value ==
          "Re-Submit" ? "UPDATE" : SaveButton.value == "Verify"
          ? "VERIFY"
          : SaveButton.value == "Approve" ? "APPROVE" : "",
      vocDet: getSiteDetList.value.length == 0
          ? getSitevoucherDet()
          : getSiteDetList.value,
    ));

    final list = await StaffVoucher_provider.SaveSitevoucherScreenEntryAPI(
        body, id, buttonControl, context);
    if (list != null) {
      if (id != 0) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.pushReplacement(
        //     context,
        //     new MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //         new Staff_Voucher_EntryListScreen()));
        buttonControl = 0;
        editcheck = 0;
        BaseUtitiles.showToast(list);
        delete_Sitevoucher_itemlist_Table();
        Sitevoucher_itemview_GetDbList.clear();
        itemcheck = 0;
        Active = 1;
        clearDatas();
        Clear();
        await getStaffVoc_EntryList();
        // return Navigator.of(context).pop();
      }
      else {
        if (list == RequestConstant.DUPLICATE_OCCURED) {
          Navigator.pop(context);
          Navigator.pop(context);
          buttonControl = 0;
          return BaseUtitiles.showToast(list!);
        } else {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          // Navigator.pushReplacement(
          //     context,
          //     new MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //         new Staff_Voucher_EntryListScreen()));
          buttonControl = 0;
          editcheck = 0;
          itemcheck = 0;
          Active = 1;
          clearDatas();
          BaseUtitiles.showToast(list!);
          delete_Sitevoucher_itemlist_Table();
          Clear();
          Sitevoucher_itemview_GetDbList.clear();
          await getStaffVoc_EntryList();
          // return Navigator.of(context).pop();
        }
      }
    }
  }


  List<VocDet>? getSitevoucherDet() {
    Sitevoucher_itemview_GetDbList.value.forEach((element) {
      var list = new VocDet(
        siteId: element.siteid.toString(),
        projectId: element.projectid.toString(),
        payType: element.paytype.toString(),
        amt:element.amt.toString(),
        tdsPer:element.TdsPer.toString(),
        tdsAmt: element.TdsAmt.toString(),
        netAmt: element.NetAmt.toString(),
      );
      getSiteDetList.value.add(list);
    });
    return getSiteDetList.value;
  }

  //----Delete---
  Future SitevoucherList_DeleteApi(int VocId, String VocNo) async {
    await StaffVoucher_provider.Staffvoucher_entryList_deleteAPI(VocId,VocNo, loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  // ---------Edit Call API----------


  Future Sitevoucher_entrylist_editSaveDetTable() async {
    staffvouchersiteTableList.clear();
    Sitevoucher_EditListApiValue.forEach((element) {
      element.vocEditDet.forEach((val) {
        staffvouchersiteItemListTableModel =new StaffvouchersiteDetlist();
        staffvouchersiteItemListTableModel.siteid = val.siteId;
        staffvouchersiteItemListTableModel.projectid = val.projectId;
        staffvouchersiteItemListTableModel.sitename = val.siteName.toString();
        staffvouchersiteItemListTableModel.projectname = val.projectName.toString();
        staffvouchersiteItemListTableModel.paytype = val.payType.toString();
        staffvouchersiteItemListTableModel.amt = val.amt;
        staffvouchersiteItemListTableModel.TdsPer = val.tdsPer;
        staffvouchersiteItemListTableModel.TdsAmt = val.tdsAmt;
        staffvouchersiteItemListTableModel.NetAmt = val.netAmt;
        staffvouchersiteTableList.add(staffvouchersiteItemListTableModel);
      });
    });
    var savedatas = await staffvouchersitelistService.StaffvoucherSiteItemlist_table_Save(staffvouchersiteTableList);
    return  savedatas;
  }

  Future StaffvoucherEntryList_EditApi(int VocId, BuildContext context) async {
    await StaffVoucher_provider.SitevoucherSite_entryList_editAPI(VocId).then((value) async {
      if (value != null && value.length > 0) {
        Sitevoucher_EditListApiValue.value.clear();
        editcheck = 1;
        itemcheck=1;
        Sitevoucher_EditListApiValue.value = value;
        await Sitevoucher_entrylist_editSaveDetTable();
        await getstaffvouchersiteTablesDatas();
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Staff_Voucher_EntryScreen()),
        );
      }
    });
  }

  Clear(){
    TotalAmount.text="0.00";
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
                          editcheck=0;
                          itemcheck=0;
                          Active=0;
                          delete_Sitevoucher_itemlist_Table();
                          Sitevoucher_itemview_GetDbList.value.clear();
                          SitevoucherList_DeleteApi(StaffVocEtyList[index].vocId,StaffVocEtyList[index].vocNo);
                          StaffVocEtyList.removeAt(index);
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