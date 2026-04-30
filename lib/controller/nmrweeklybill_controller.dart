import '../controller/logincontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entry_site.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entrylist_site.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_week_billgeneration_site.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../provider/common_provider.dart';
import '../provider/nmrwkly_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../home/menu/daily_entries/subcont_nmr_weekbill_site/aprovedpopup.dart';

class NMRWklyController extends GetxController {
  final NmrentryDateController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  final RemarksController = TextEditingController();
  final BillNoController = TextEditingController();
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

  List<TextEditingController> SitenameController = [];
  List<TextEditingController> CategorynameController = [];
  List<TextEditingController> TotalNosController = [];
  List<TextEditingController> TotalOTController = [];
  List<TextEditingController> NetAmtController = [];

  List<TextEditingController> WagesController = [];
  List<TextEditingController> TotalAmtController = [];
  List<TextEditingController> TotalOTHrsController = [];

  RxList<NmrBillDet> getNMRDetList = <NmrBillDet>[].obs;
  int workid = 0;
  int aprovedButton = 0;
  int buttonControl = 0;
  RxList NmrEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList NmritemList = [].obs;
  RxList NmrcheckStatusList = [].obs;
  RxList NmrcheckCountList = [].obs;
  RxList getNMRBillNoValue = [].obs;

  int editCheck = 0;
  int submitCheck = 0;
  int checkColor = 0;

  RxString saveButton = RequestConstant.SAVE.obs;

  double totalNetBillamount = 0.0;
  double totalNetPayAmt = 0.0;
  String to_be_dection_advance = "0";

  RxList EditListSaveDatas = [].obs;

  LoginController loginController = Get.put(LoginController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());


  Future getNmrEntryList() async {
    NmrEtyList.value.clear();
    mainEtyList.value.clear();
    await NMRWklyprovider.getSubcontNmrEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        EntrylistFrDate.text,
        EntrylistToDate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        mainEtyList.value = value;
        NmrEtyList.value = mainEtyList.value;
        return mainEtyList.value;
      }
    });
  }

  Future getNmrAdvance() async {
    to_be_dection_advance="0";
    await NMRWklyprovider.NMR_adv_balance(projectController.selectedProjectId.value,
      subcontractorController.selectedSubcontId.value,
      // siteController.selectedsiteId.value
    ).then((value){
      if (value != null) {
        to_be_dection_advance = value;
        return to_be_dection_advance;
      }
    });
  }

  // Future submit_getNmrItemList() async {
  //   NmritemList.value.clear();
  //   await NMRWklyprovider.getSubcontNmrItem_List(
  //           subcontractorController.selectedSubcontId.value,
  //           projectController.selectedProjectId.value,
  //           FromdateController.text,
  //           TodateController.text)
  //       .then((value) async {
  //     if (value != null && value.length > 0) {
  //       submitCheck = 1;
  //       NmritemList.value = value;
  //       BaseUtitiles.showToast(RequestConstant.RECORD_SUCCESSFULLY);
  //       return NmritemList.value;
  //     } else {
  //       BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
  //     }
  //   });
  //   setTextControllersValue();
  // }

  Future submit_getNmrItemList_Site() async {
    NmritemList.value.clear();
    await NMRWklyprovider.getSubcontNmrItem_List_Site(
        subcontractorController.selectedSubcontId.value,
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,
        FromdateController.text,
        TodateController.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        submitCheck = 1;
        NmritemList.value = value;
        BaseUtitiles.showToast(RequestConstant.RECORD_SUCCESSFULLY);
        return NmritemList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
    setTextControllersValue();
  }

  setTextControllersValue() async {
    int i = 0;
    NmritemList.value.forEach((element) {
      totalNetBillamount = totalNetBillamount + element.netAmt;
      textControllersInitiate();
      SitenameController[i].text = element.siteName;
      CategorynameController[i].text = element.categoryName;
      WagesController[i].text = element.Rate.toString();
      TotalNosController[i].text = element.totnos.toString();
      TotalOTHrsController[i].text = element.total_othrs.toString();
      TotalAmtController[i].text = element.Totamt.toString();
      TotalOTController[i].text = element.totalOtamt.toString();
      NetAmtController[i].text = element.netAmt.toString();
      i++;
    });
  }

  setTextEditListControllersValue() async {
    int i = 0;
    EditListSaveDatas.value.forEach((element) {
      element.nmrBillDet.forEach((value) {
        textControllersInitiate();
        SitenameController[i].text = value.siteName;
        CategorynameController[i].text = value.categoryName;
        WagesController[i].text = value.wages.toString();
        TotalNosController[i].text = value.totnos.toString();
        TotalOTHrsController[i].text = value.totalOthrs.toString();
        TotalAmtController[i].text = value.amt.toString();
        TotalOTController[i].text = value.totalOtamt.toString();
        NetAmtController[i].text = value.nmrAmt.toString();
        i++;
      });
    });
  }

  textControllersInitiate() {
    SitenameController.add(new TextEditingController());
    CategorynameController.add(new TextEditingController());
    WagesController.add(new TextEditingController());
    TotalNosController.add(new TextEditingController());
    TotalOTHrsController.add(new TextEditingController());
    TotalAmtController.add(new TextEditingController());
    NetAmtController.add(new TextEditingController());
    TotalOTController.add(new TextEditingController());
  }


  clearDatas(){
    NmritemList.value.clear();
    projectController.projectname.text="--Select--";
    projectController.selectedProjectId.value=0;
    siteController.Sitename.text=RequestConstant.SELECT;
    siteController.selectedsiteId.value=0;
    subcontractorController.Subcontractorname.text="--Select--";
    subcontractorController.selectedSubcontId.value=0;
    RemarksController.clear();
    BillNoController.text="-";
    NmrentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    FromdateController.text=BaseUtitiles.initiateCurrentDateFormat();
    TodateController.text=BaseUtitiles.initiateCurrentDateFormat();
    EditListSaveDatas.value.clear();
    saveButton.value=RequestConstant.SAVE;
    workid=0;
    billamount.text="0.0";
    Creditamt.text="0";
    Debitamt.text="0";
    CreditRemarksController.text="-";
    DebitRemarksController.text="-";
    Advded.text="0";
    Roundoff.text="0";
    netpayamt.text="0.0";
  }

  Future SaveButton_DeductionScreen(BuildContext context, int id) async {
    buttonControl=1;
    getNMRDetList.value.clear();
    String body = subcontNmrSaveRequestToJson(NmrSaveRequest(
      workId: id != 0 ? id.toString() : "0",
      workNo: autoYearWiseNoController.text,
      entryDate: NmrentryDateController.text,
      projectId: projectController.selectedProjectId.value.toString(),
      siteId: siteController.selectedsiteId.toString(),
      subContId: subcontractorController.selectedSubcontId.value.toString(),
      fromDate: FromdateController.text,
      toDate: TodateController.text,
      remarks: RemarksController.text,
      rndOff: Roundoff.text,
      billNo: BillNoController.text,
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
      entryMode:saveButton.value=="Save"?"ADD":saveButton.value=="Re-Submit"?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
      nmrBillDet: getNMRDetList.value.length == 0
          ? getNmrBillDet(id)
          : getNMRDetList.value,
    ));
    final list = await NMRWklyprovider.SaveSubContScreenEntryAPI(body, id);
    if (list != null ) {
      if (id != 0) {
        BaseUtitiles.showToast(list);
        clearDatas();
        editCheck = 0;
        submitCheck = 0;
        buttonControl = 0;
        await getNmrEntryList();
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        return;
      } else {
        if (list == RequestConstant.DUPLICATE_OCCURED) {
          Navigator.pop(context);
          Navigator.pop(context);
          return BaseUtitiles.showToast(list);
        } else {
          BaseUtitiles.showToast(list);
          clearDatas();
          editCheck = 0;
          submitCheck = 0;
          buttonControl = 0;
          await getNmrEntryList();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          return;
        }
      }
    }
  }

  List<NmrBillDet>? getNmrBillDet(int id) {
    NmritemList.value.forEach((element) {
      var list = new NmrBillDet(
        projectId: "0",
        siteId: element.siteId.toString(),
        nmrAmt: element.nmrAmt.toString(),
        categoryId: element.categoryId.toString(),
        // wages: editCheck==1? element.wages.toString() : element.Rate.toString(),
        // amt: editCheck==1? element.amt.toString() : element.Totamt.toString(),
        // totalOthrs:editCheck==1? element.totalOthrs.toString() : element.total_othrs.toString(),
        totnos: element.totnos.toString(),
        totalOtamt: element.totalOtamt.toString(),
      );
      getNMRDetList.value.add(list);
    });
    return getNMRDetList.value;
  }

  Future getNMRBillNoList(int pid,  int subid) async {
    getNMRBillNoValue.value = await CommonProvider.getNMRBillNoList(pid,subid);
    getNMRBillNoValue.value.forEach((element){
      BillNoController.text=element.EntryAutoNo.toString();
    });
  }

  // deduction_paymentCalculation() {
  //   if(double.parse(to_be_dection_advance)< double.parse(Advded.text)){
  //     BaseUtitiles.showToast("Please change the adv deduction amount");
  //     Advded.text="0.0";
  //   }
  //   else{
  //     var tot_netamnt = 0.0;
  //     var netamount;
  //     int roundoff;
  //     if (NmritemList.value.isNotEmpty) {
  //       if (editCheck == 1) {
  //         NmritemList.value.forEach((element) {
  //           tot_netamnt = tot_netamnt + element.nmrAmt!;
  //         });
  //         billamount.text = tot_netamnt.toString();
  //         netamount = double.parse(billamount.text) + double.parse(Creditamt.text) - double.parse(Debitamt.text) - double.parse(Advded.text) +
  //             double.parse(Roundoff.text);
  //         roundoff = netamount.round();
  //         netpayamt.text = roundoff.toString();
  //       }
  //       else {
  //         NmritemList.value.forEach((element) {
  //           tot_netamnt = tot_netamnt + element.netAmt;
  //         });
  //         billamount.text = tot_netamnt.toString();
  //         netamount = double.parse(billamount.text) +
  //             double.parse(Creditamt.text) -
  //             double.parse(Debitamt.text) -
  //             double.parse(Advded.text) +
  //             double.parse(Roundoff.text);
  //         roundoff = netamount.round();
  //         netpayamt.text = roundoff.toString();
  //       }
  //     }
  //   }
  // }

  void deduction_paymentCalculation() {
    double advLimit = double.tryParse(tobededadv.text) ?? 0;
    double advDed = double.tryParse(Advded.text) ?? 0;

    if (advLimit < advDed) {
      BaseUtitiles.showToast("Please change the adv deduction amount");
      Advded.text = "0.0";
      netpayamt.text = billamount.text;
      return;
    }

    if (NmritemList.value.isEmpty) return;

    double totalNetAmount = 0.0;

    for (var item in NmritemList.value) {
      totalNetAmount += (editCheck == 1)
          ? (item.nmrAmt ?? 0)
          : (item.netAmt ?? 0);
    }

    billamount.text = totalNetAmount.toStringAsFixed(2);

    double bill = double.tryParse(billamount.text) ?? 0;
    double credit = double.tryParse(Creditamt.text) ?? 0;
    double debit = double.tryParse(Debitamt.text) ?? 0;
    double adv = double.tryParse(Advded.text) ?? 0;
    double round = double.tryParse(Roundoff.text) ?? 0;

    double netAmount =
        bill + credit - debit - adv + round;

    int roundedAmount = netAmount.round();

    netpayamt.text = roundedAmount.toString();
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


  String ButtonChanges(int id, int aproval) {
    if (id != 0 || aproval != 0) {
      return saveButton.value = RequestConstant.UPDATE;
    } else
      return saveButton.value = RequestConstant.SAVE;
  }

  Future NmrEntryList_EditApi(
      int workid, BuildContext context, int check) async {
    check != 0 ? aprovedButton = 1 : aprovedButton = 0;
    await NMRWklyprovider.nmr_entryList_editAPI(workid).then((value) async {
      if (value != null && value.length > 0) {
        editCheck = 1;
        EditListSaveDatas.value = value;
        setTextEditListControllersValue();
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Subcont_Nmr_EntryScreen_Site()),
        );
      }
    });
  }

  Future Nmr_EntryList_DeleteApi(int WorkId, int subid, String WorkNo) async {
    await NMRWklyprovider.nmr_entryList_deleteAPI(WorkId, subid, WorkNo,
        loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
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
                          submitCheck=0;
                          editCheck=0;
                          NmritemList.value.clear();
                          Nmr_EntryList_DeleteApi(NmrEtyList[index].nmrWorkId,NmrEtyList[index].subcontid,NmrEtyList[index].workNo);
                          NmrEtyList.removeAt(index);
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
          //     submitCheck=0;
          //     editCheck=0;
          //     NmritemList.value.clear();
          //     Nmr_EntryList_DeleteApi(NmrEtyList[index].nmrWorkId,NmrEtyList[index].subcontid,NmrEtyList[index].workNo);
          //     NmrEtyList.removeAt(index);
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),
        ],
      ),
    );
  }


  Future getNmrcheckstatus(int pid,String subId,int sid,String fadte,String tdate,BuildContext context) async {
    NmrcheckStatusList.value.clear();
    await NMRWklyprovider.getNmrcheckedapproved(pid,subId,sid,fadte,tdate).then((value) async {
      if (value != null && value.length > 0) {
        NmrcheckStatusList.value = value;
        return   showDialog(
            context: context,
            builder: (BuildContext context) {
              return ApprovedAlertPopup(list:NmrcheckStatusList.value);
            });
      }
      else{
        BaseUtitiles.showToast("No Record Found..");
      }
    });
  }

  Future getNmrcheckstatusCount(int pid,String subId,int sid,String fadte,String tdate) async {
    NmrcheckCountList.value.clear();
    await NMRWklyprovider.getNmrcheckedapprovedCount(pid,subId,sid,fadte,tdate).then((value) async {
      if (value != null && value.length > 0) {
        if(value[0].reccount==value[0].appCount){
          submit_getNmrItemList_Site();
        }
        else{
          NmritemList.value.clear();
        }
      }
    });
  }
}
