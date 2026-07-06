import 'dart:convert';

import 'package:prahkurticore/controller/pendinglistcontroller.dart';

import '../controller/logincontroller.dart';
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import '../db_model/direct_bill_gst_calculation_model.dart';
import '../db_services/direct_bill_itemlist_service.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entry_site.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entrylist_site.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_week_billgeneration_site.dart';
import '../models/billdirectgstcalculations.dart';
import '../models/nmrwklybill_deduction_save_model.dart';
import '../provider/common_provider.dart';
import '../provider/directbill_generat_provider.dart';
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
import 'billgenerationdirect_controller.dart';

class NMRWklyController extends GetxController {
  final NmrentryDateController = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final FromdateController = TextEditingController();
  final TodateController = TextEditingController();
  final RemarksController = TextEditingController();
  final billamount = TextEditingController();
  final foodDeduction = TextEditingController();
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
  RxList billDet_Calculation = [].obs;
  RxBool isAdvanceReadOnly = true.obs;

  List<TextEditingController> SitenameController = [];
  List<TextEditingController> CategorynameController = [];
  List<TextEditingController> TotalNosController = [];
  List<TextEditingController> TotalOTController = [];
  List<TextEditingController> NetAmtController = [];
  List<TextEditingController> TotalAmtController = [];

  RxList<SubContractorNmrBillDet> getNMRDetList = <SubContractorNmrBillDet>[].obs;
  RxList<SubContractorNmrBillAddLessSetup> getNMRAddLessDetList = <SubContractorNmrBillAddLessSetup>[].obs;
  int workid = 0;
  RxList NmrEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList NmritemList = [].obs;
  RxList NmrcheckStatusList = [].obs;
  RxList NmrcheckCountList = [].obs;
  RxList getNMRBillNoValue = [].obs;


  RxString saveButton = RequestConstant.SUBMIT.obs;

  double totalNetBillamount = 0.0;
  double totalNetPayAmt = 0.0;
  double baseNetPayAmt = 0.0;
  String oldAdvValue = "0.0";
  RxList reqDetIdNmrDet = [].obs;
  String oldRoundOffValue = "0.0";
  String oldDebitValue = "0.0";
  String oldFoodValue = "0.0";
  String oldCreditValue = "0.0";
  String to_be_dection_advance = "0.0";
  bool isRestoring = false;

  RxList EditListSaveDatas = [].obs;

  LoginController loginController = Get.put(LoginController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  BillGenerationDirectController billGenerationDirectController = Get.put(BillGenerationDirectController());
  var directBillTable = DirectBillGSTCalTable();
  late List<DirectBillGSTCalTable> directBillTableModelList = <DirectBillGSTCalTable>[];
  var directBillGen_ItemlistService = DirectBillGen_ItemlistService();
  RxList<DirectBillGSTCalTable> directBillGen_ItemReadList = <DirectBillGSTCalTable>[].obs;
  late List<DirectBillGSTCalTable> updateBillGen_ItemReadList = <DirectBillGSTCalTable>[];
  List<TextEditingController> percentControllers = [];
  PendingListController pendingListController = Get.put(PendingListController());


  Future getNmrEntryList() async {
    NmrEtyList.value=[];
    mainEtyList.value=[];
    var response = await NMRWklyprovider.getSubcontNmrEntry_List(EntrylistFrDate.text, EntrylistToDate.text);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          mainEtyList.assignAll(response.result!);
          NmrEtyList.assignAll(response.result!);
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
  // void validateAdvanceAmount(String value) {
  //   final double enteredAmt = double.tryParse(value) ?? 0.0;
  //   final double maxAmt = double.tryParse(tobededadv.text) ?? 0.0;
  //
  //   if (enteredAmt > maxAmt) {
  //     BaseUtitiles.showToast(
  //         "Advance deduction cannot exceed the advance amount.");
  //
  //     Advded.text = "0.0";
  //
  //     // Move cursor to end
  //     Advded.selection = TextSelection.fromPosition(
  //       TextPosition(offset: Advded.text.length),
  //     );
  //   }
  // }


  Future submit_getNmrItemList_Site() async {
    NmritemList.value=[];
    var response = await NMRWklyprovider.getSubcontNmrItem_List_Site(
        subcontractorController.selectedSubcontId.value,
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value,
        FromdateController.text,
        TodateController.text);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          NmritemList.value = response.result!;
          BaseUtitiles.showToast(RequestConstant.RECORD_SUCCESSFULLY);
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
    setTextControllersValue();
}


  setTextControllersValue() async {
    int i = 0;
    NmritemList.value.forEach((element) {
      reqDetIdNmrDet.add(0);
      totalNetBillamount = totalNetBillamount + element.netAmt;
      textControllersInitiate();
      SitenameController[i].text = element.siteName;
      CategorynameController[i].text = element.categoryName;
      TotalNosController[i].text = element.totalNos.toString();
      TotalOTController[i].text = element.totalOtAmount.toString();
      NetAmtController[i].text = element.netAmt.toString();
      i++;
    });
  }

  setTextEditListControllersValue() async {
    reqDetIdNmrDet.value=[];
    int i = 0;
    EditListSaveDatas.value.forEach((element) {
      element.subContractorNmrBillDetS.forEach((value) {
        textControllersInitiate();
        reqDetIdNmrDet.add(value.id);
        SitenameController[i].text = value.siteName;
        CategorynameController[i].text = value.categoryName;
        TotalNosController[i].text = value.totalNos.toString();
        TotalAmtController[i].text = value.nmrAmount.toString();
        TotalOTController[i].text = value.totalOtAmount.toString();
        NetAmtController[i].text = value.nmrAmount.toString();
        i++;
      });
    });
  }

  textControllersInitiate() {
    SitenameController.add(new TextEditingController());
    CategorynameController.add(new TextEditingController());
    TotalNosController.add(new TextEditingController());
    TotalAmtController.add(new TextEditingController());
    NetAmtController.add(new TextEditingController());
    TotalOTController.add(new TextEditingController());
  }


  clearDatas(){
    NmritemList.value=[];
    projectController.projectname.text="--SELECT--";
    projectController.selectedProjectId.value=0;
    siteController.Sitename.text=RequestConstant.SELECT;
    siteController.selectedsiteId.value=0;
    subcontractorController.Subcontractorname.text="--SELECT--";
    subcontractorController.selectedSubcontId.value=0;
    RemarksController.clear();
    subcontractorController.InvoiceNo.text="-";
    NmrentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
    FromdateController.text=BaseUtitiles.initiateCurrentDateFormat();
    TodateController.text=BaseUtitiles.initiateCurrentDateFormat();
    EditListSaveDatas.value=[];
    workid=0;
    billamount.text="0.0";
    foodDeduction.text="0.0";
    Creditamt.text="0.0";
    Debitamt.text="0.0";
    CreditRemarksController.text="-";
    DebitRemarksController.text="-";
    Advded.text="0.0";
    Roundoff.text="0.0";
    netpayamt.text="0.0";
  }

  Future SaveButton_DeductionScreen(BuildContext context, int id) async {
    String body = nmrSaveRequestToJson(NmrSaveRequest(
      id: id,
      workNo: autoYearWiseNoController.text,
      entryDate: NmrentryDateController.text,
      projectId: projectController.selectedProjectId.value,
      siteId: siteController.selectedsiteId.value,
      subContractorId: subcontractorController.selectedSubcontId.value,
      fromDate: FromdateController.text,
      toDate: TodateController.text,
      billNo: subcontractorController.InvoiceNo.text,
      billAmount: double.tryParse(billamount.text) ?? 0.0,
      foodAmount: double.tryParse(foodDeduction.text) ?? 0.0,
      bankCharges: 0,
      debitAmount: double.tryParse(Debitamt.text) ?? 0.0,
      debitRemarks: DebitRemarksController.text,
      creditAmount: double.tryParse(Creditamt.text) ?? 0.0,
      creditRemarks: CreditRemarksController.text,
      advanceAmount: double.tryParse(Advded.text) ?? 0.0,
      actualAdvanceAmount: double.tryParse(tobededadv.text) ?? 0.0,
      roundOff: double.tryParse(Roundoff.text) ?? 0.0,
      netPayAmount: double.tryParse(netpayamt.text) ?? 0.0,
      balanceAmount: 0,
      remarks: RemarksController.text,
      createdBy: int.tryParse(loginController.EmpId()),
      createdDt: BaseUtitiles().convertToUtcIso(NmrentryDateController.text),
      verifyStatus: saveButton.value == RequestConstant.VERIFY || saveButton.value == RequestConstant.APPROVAL? "Y":"N",
      approveStatus: saveButton.value == RequestConstant.APPROVAL? "Y":"N",
      subContractorNmrBillDetS: getNmrBillDet(id),
      subContractorNmrBillAddLessSetupS: getNmrBillAddLess(id),
    ));
    final decodedJson = jsonDecode(body);

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(decodedJson);

    debugPrint(prettyJson, wrapWidth: 1024);

    final list = await NMRWklyprovider.SaveSubContScreenEntryAPI(body, id);
    if (list != null) {
      if(list["success"] == true){
        clearDatas();
        BaseUtitiles.showToast(list["message"]);
        if(saveButton.value == RequestConstant.VERIFY || saveButton.value == RequestConstant.APPROVAL){
          await pendingListController.getPendingList();
        }else{
          await getNmrEntryList();
        }
        BaseUtitiles.popMultiple(context, count: 4);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    }else{
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  List<SubContractorNmrBillDet>? getNmrBillDet(int id) {
    getNMRDetList.value=[];
    int i = 0;
    NmritemList.forEach((element) {
      var list = new SubContractorNmrBillDet(
        id: reqDetIdNmrDet[i],
        subContractorNmrBillMasId: id,
        projectId: projectController.selectedProjectId.value,
        siteId: siteController.selectedsiteId.value,
        subContractorId: subcontractorController.selectedSubcontId.value,
        categoryId: element.categoryId,
        nmrAmount: element.nmrAmount,
        totalNos: element.totalNos,
        totalOtAmount: element.totalOtAmount,
      );
      getNMRDetList.add(list);
      i++;
    });
    return getNMRDetList;
  }

  List<SubContractorNmrBillAddLessSetup>? getNmrBillAddLess(int id) {
    getNMRAddLessDetList.value=[];
    directBillGen_ItemReadList.forEach((element) {
      if(element.percentValue!>0) {
        var list = SubContractorNmrBillAddLessSetup(
            id: element.reqDetId,
            subContractorNmrBillMasId: id,
            addLessId: element.addLessId,
            percentValue: element.percentValue,
            amount: element.amount
        );
        getNMRAddLessDetList.add(list);
      }
    });
    return getNMRAddLessDetList;
  }


  Future<bool> deduction_paymentCalculation() async {

    double advLimit =
        double.tryParse(tobededadv.text) ?? 0;

    double advDed =
        double.tryParse(Advded.text) ?? 0;

    if (advLimit < advDed) {
      advDed=0;
      BaseUtitiles.showToast(
          "Please change the adv deduction amount");

      return false;
    }

    if (NmritemList.value.isEmpty) return false;

    double totalNetAmount = 0.0;

    for (var item in NmritemList.value) {

      totalNetAmount +=
      (saveButton.value ==
          RequestConstant.RESUBMIT ||

          saveButton.value ==
              RequestConstant.VERIFY ||

          saveButton.value ==
              RequestConstant.APPROVAL)

          ? (item.nmrAmount ?? 0)

          : (item.netAmt ?? 0);
    }

    billamount.text =
        totalNetAmount.toStringAsFixed(2);

    double bill =
        double.tryParse(billamount.text) ?? 0;

    double food =
        double.tryParse(foodDeduction.text) ?? 0;

    double credit =
        double.tryParse(Creditamt.text) ?? 0;

    double debit =
        double.tryParse(Debitamt.text) ?? 0;

    double adv =
        double.tryParse(Advded.text) ?? 0;

    double round =
        double.tryParse(Roundoff.text) ?? 0;

    // IMPORTANT
    setBaseNetPay(billamount.text);

    // RECALCULATE ADD/LESS FIRST
    for (var item in directBillGen_ItemReadList) {

      double percent =
          item.percentValue ?? 0.0;

      double amt =
          (bill * percent) / 100;

      if (amt == 0) {

        item.amount = 0.0;

      } else {

        item.amount =
        item.addLessType == "-"
            ? -amt
            : amt;
      }
    }

    // NOW GET UPDATED TOTAL
    double addLessTotal =
        totalAddLess;

    // FINAL NET
    double netAmount =
        bill +
            credit -
            debit -
            adv -
            food +
            round +
            addLessTotal;

    // VALIDATION
    if (netAmount < 0) {
      return false;
    }

    netpayamt.text = netAmount.toStringAsFixed(2);

    directBillGen_ItemReadList.refresh();

    await saveUpdatedCalcData();

    return true;
  }



  void updateAdvanceReadOnly() {
    final amt = double.tryParse(tobededadv.text) ?? 0.0;
    isAdvanceReadOnly.value = amt <= 0;
  }

  Future DirectBill_CalculationList() async {
    billDet_Calculation.value=[];
    final value = await DirectBillGenerateProvider.getBillDirectCalculation_List();
    if (value != null) {
      if(value.success==true){
        if(value.result!.isNotEmpty){
          billDet_Calculation.value = value.result!;
          await DirectBillCal_itemlistTable_Delete();
          await directBillCalculationSave();
          await getDirectBillCalDatas();
          if(saveButton.value == RequestConstant.RESUBMIT || saveButton.value == RequestConstant.VERIFY || saveButton.value == RequestConstant.APPROVAL) {
            setBaseNetPay(billamount.text);
            await preloadEditAddLessData(EditListSaveDatas[0].subContractorNmrBillAddLessSetupS);
          }
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

  void setBaseNetPay(String value) {
    baseNetPayAmt = double.tryParse(value) ?? 0.0;
    netpayamt.text = baseNetPayAmt.toStringAsFixed(2);
    print("=== setBaseNetPay called: $baseNetPayAmt ==="); // 👈 add this

  }

// ADD THIS
  bool calculateAndUpdate(
      int addLessId,
      double percent,
      double baseAmount,
      ) {

    final item = directBillGen_ItemReadList
        .firstWhereOrNull(
          (e) => e.addLessId == addLessId,
    );

    if (item == null) return false;

    // OLD VALUES
    double oldPercent =
        item.percentValue ?? 0.0;

    double oldAmount =
        item.amount ?? 0.0;

    // NEW AMOUNT
    double amt =
        (baseAmount * percent) / 100;

    double newAmount;

    if (amt == 0) {

      newAmount = 0.0;

    } else {

      newAmount =
      item.addLessType == "-"
          ? -amt
          : amt;
    }

    // TEMP TOTAL
    double tempTotal =
        totalAddLess -
            oldAmount +
            newAmount;

    double bill =
        double.tryParse(billamount.text) ?? 0;

    double food =
        double.tryParse(foodDeduction.text) ?? 0;

    double credit =
        double.tryParse(Creditamt.text) ?? 0;

    double debit =
        double.tryParse(Debitamt.text) ?? 0;

    double adv =
        double.tryParse(Advded.text) ?? 0;

    double round =
        double.tryParse(Roundoff.text) ?? 0;

    double netAmount =
        bill +
            credit -
            debit -
            adv -
            food +
            round +
            tempTotal;

    // NEGATIVE VALIDATION
    if (netAmount < 0) {

      BaseUtitiles.showToast(
        "Net Bill Amount cannot be negative. "
            "Please reduce the deductions "
            "or add-less percentages.",
      );

      // RESTORE OLD VALUES
      item.percentValue = oldPercent;
      item.amount = oldAmount;

      directBillGen_ItemReadList.refresh();

      return false;
    }

    // FINAL UPDATE
    item.percentValue = percent;
    item.amount = newAmount;

    netpayamt.text =
        netAmount.toStringAsFixed(2);

    directBillGen_ItemReadList.refresh();

    update();

    return true;
  }

  // ADD THIS
  void updateNetPay() {

    double bill = double.tryParse(billamount.text) ?? 0;
    double food = double.tryParse(foodDeduction.text) ?? 0;
    double credit = double.tryParse(Creditamt.text) ?? 0;
    double debit = double.tryParse(Debitamt.text) ?? 0;
    double adv = double.tryParse(Advded.text) ?? 0;
    double round = double.tryParse(Roundoff.text) ?? 0;

    double addLessTotal = totalAddLess;

    double netAmount =
        bill +
            credit -
            debit -
            adv -
            food +
            round +
            addLessTotal;

    netpayamt.text = netAmount.toStringAsFixed(2);
  }

// ADD THIS
  Future<void> saveUpdatedCalcData() async {
    await updateDirectBillCalDatas();
  }

// ADD THIS
  double get totalAddLess {
    return directBillGen_ItemReadList.fold(
      0.0,
          (sum, item) => sum + (item.amount ?? 0.0),
    );
  }

  void initPercentControllers() {
    percentControllers.clear();
    for (var item in directBillGen_ItemReadList) {
      percentControllers.add(
        TextEditingController(
          text: (item.percentValue ?? 0.0) == 0.0
              ? ''
              : item.percentValue.toString(),
        ),
      );
    }
  }


  directBillCalculationSave() async {
    int i = 0;
    directBillTableModelList=[];
    billDet_Calculation.value.forEach((element) {
      directBillTable = new DirectBillGSTCalTable();
      directBillTable.reqDetId = 0;
      directBillTable.addLessId = element.id;
      directBillTable.percentValue = 0.0;
      directBillTable.amount = 0.0;
      directBillTable.addLessName =  element.addLessName;
      directBillTable.addLessType = element.addLessType;
      directBillTableModelList.add(directBillTable);
      i++;
    });
    var savedatas = await directBillGen_ItemlistService.DirectBillGST_ItemTable_Save(directBillTableModelList);
    return savedatas;
  }

  Future getDirectBillCalDatas() async {
    var datas = await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_readAll();
    directBillGen_ItemReadList.value = <DirectBillGSTCalTable>[];
    directBillGen_ItemReadList.clear();
    datas.forEach((value) {
      directBillTable = DirectBillGSTCalTable();
      directBillTable.reqDetId=value['reqDetId'];
      directBillTable.addLessId=value['addLessId'];
      directBillTable.percentValue=value['percentValue'];
      directBillTable.amount=value['amount'];
      directBillTable.addLessName=value['addLessName'];
      directBillTable.addLessType=value['addLessType'];
      directBillGen_ItemReadList.add(directBillTable);
    });
    initPercentControllers();
  }

  updateDirectBillCalDatas() async {
    int i=0;
    updateBillGen_ItemReadList.clear();
    directBillGen_ItemReadList.forEach((element) {
      directBillTable = DirectBillGSTCalTable();
      directBillTable.reqDetId=element.reqDetId;
      directBillTable.addLessId=element.addLessId;
      directBillTable.percentValue=element.percentValue;
      directBillTable.amount=element.amount;
      directBillTable.addLessName=element.addLessName;
      directBillTable.addLessType=element.addLessType;
      updateBillGen_ItemReadList.add(directBillTable);
      i++;
    });
    await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_Update(updateBillGen_ItemReadList);
  }

  DirectBillCal_itemlistTable_Delete() async {
    await directBillGen_ItemlistService.DirectBillGST_ItemlistTable_delete();
  }

  Future<void> preloadEditAddLessData(List<dynamic> editAddLessList) async {

    // First load local DB rows
    await getDirectBillCalDatas();

    // Update local rows with edit API values
    for (var editItem in editAddLessList) {

      int index = directBillGen_ItemReadList.indexWhere(
            (e) => e.addLessId == editItem.addLessId,
      );

      if (index != -1) {

        directBillGen_ItemReadList[index].reqDetId =
        editItem.id;

        directBillGen_ItemReadList[index].percentValue =
            (editItem.percentValue ?? 0).toDouble();

        directBillGen_ItemReadList[index].amount =
            (editItem.amount ?? 0).toDouble();

        // Update controller text also
        percentControllers[index].text =
        (editItem.percentValue ?? 0) == 0
            ? ''
            : editItem.percentValue.toString();
      }
    }

    // Refresh UI
    directBillGen_ItemReadList.refresh();

    // Recalculate total/netpay
    updateNetPay();
  }

  Future NmrEntryList_EditApi(int workid,String MenuName, BuildContext context,from, bool checkSts) async {
    EditListSaveDatas.value=[];
    NmritemList.value=[];
    var response = await NMRWklyprovider.nmr_entryList_editAPI(workid,checkSts);
    if (response != null) {
      if (response.success == true) {
          EditListSaveDatas.value=[response.result!];
          if(EditListSaveDatas.isNotEmpty) {
            setTextEditListControllersValue();
            if(from=="Verify") {
              saveButton.value = RequestConstant.VERIFY;
            }
            else if(from=="Approve"){
              saveButton.value = RequestConstant.APPROVAL;
            }
            else{
              saveButton.value = RequestConstant.RESUBMIT;
            }
            return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Subcont_Nmr_EntryScreen_Site(heading: MenuName,)),
            );
          }
        else {
          BaseUtitiles.showToast("No Data Found");
        }
      }  else {
        BaseUtitiles.showToast(response.message ?? 'Something went wrong..');
      }
    }
    else {
      BaseUtitiles.showToast("Something Went Wrong...");
    }
  }

  Future<bool> Nmr_EntryList_DeleteApi(int WorkId) async {
    return NMRWklyprovider.nmr_entryList_deleteAPI(WorkId);
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
                        onPressed: () async {
                          bool result = await Nmr_EntryList_DeleteApi(NmrEtyList[index].id);
                          if (result) {
                            NmrEtyList.removeAt(index);
                            Navigator.of(context).pop();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getNmrcheckstatus(int pid,String subId,int sid,String fadte,String tdate,BuildContext context) async {
    NmrcheckStatusList.value=[];
    var response = await NMRWklyprovider.getNmrcheckedapproved(pid,subId,sid,fadte,tdate);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          NmrcheckStatusList.value = response.result!;
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return ApprovedAlertPopup(list:NmrcheckStatusList.value);
              });
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

  Future getNmrcheckstatusCount(int pid,String subId,int sid,String fadte,String tdate) async {
    NmrcheckCountList.value=[];
    var response = await NMRWklyprovider.getNmrcheckedapprovedCount(pid,subId,sid,fadte,tdate);
    if (response != null) {
      if (response.success == true) {
        if(response.result!.isNotEmpty) {
          if(response.result![0].reccount==response.result![0].appCount){
             submit_getNmrItemList_Site();
          }
          else{
            NmritemList.value=[];
          }
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
}

