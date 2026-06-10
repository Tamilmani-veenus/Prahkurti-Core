import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/billgenerationdirect_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/nmrweeklybill_controller.dart';
import '../../../../utilities/baseutitiles.dart';

class Subcont_NMR_Deduction_Site extends StatefulWidget {
  const Subcont_NMR_Deduction_Site({Key? key}) : super(key: key);

  @override
  State<Subcont_NMR_Deduction_Site> createState() =>
      _Subcont_NMR_DeductionState_Site();
}

class _Subcont_NMR_DeductionState_Site
    extends State<Subcont_NMR_Deduction_Site> {
  NMRWklyController nmrWklyController = Get.put(NMRWklyController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {

      if (nmrWklyController.saveButton.value == RequestConstant.RESUBMIT || nmrWklyController.saveButton.value == RequestConstant.VERIFY || nmrWklyController.saveButton.value == RequestConstant.APPROVAL) {
        nmrWklyController.EditListSaveDatas.forEach((element) {
          nmrWklyController.workid = element.id;
          nmrWklyController.billamount.text = element.billAmount.toString();
          nmrWklyController.Creditamt.text = element.creditAmount.toString();
          nmrWklyController.Debitamt.text = element.debitAmount.toString();
          nmrWklyController.Advded.text = element.advanceAmount.toString();
          nmrWklyController.foodDeduction.text = element.foodAmount.toString();
          nmrWklyController.tobededadv.text = element.actualAdvanceAmount.toString();
          nmrWklyController.Roundoff.text = element.roundOff.toString();
          nmrWklyController.CreditRemarksController.text =
              element.creditRemarks.toString();
          nmrWklyController.DebitRemarksController.text =
              element.debitRemarks.toString();
          nmrWklyController.netpayamt.text = element.netPayAmount.toString();
        });
        nmrWklyController.setBaseNetPay(
            nmrWklyController.billamount.text);
      }
      await nmrWklyController.DirectBill_CalculationList();

    if (nmrWklyController.saveButton.value == RequestConstant.SUBMIT) {
      nmrWklyController.workid = 0;
      nmrWklyController.foodDeduction.text = "0.0";
      nmrWklyController.Creditamt.text = "0.0";
      nmrWklyController.Debitamt.text = "0.0";
      nmrWklyController.Advded.text = "0.0";
      nmrWklyController.Roundoff.text = "0.0";
      nmrWklyController.tobededadv.text = nmrWklyController.to_be_dection_advance;
      nmrWklyController.deduction_paymentCalculation();
      nmrWklyController.CreditRemarksController.text = "-";
      nmrWklyController.DebitRemarksController.text = "-";
    }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Deduction",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Back",
                              style:
                              TextStyle(color: Colors.grey, fontSize: 18)))
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        readOnly: true,
                        controller: nmrWklyController.billamount,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Bill Amount",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.discription),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        controller: nmrWklyController.foodDeduction,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Food Deduction",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.preparedBy),
                        ),
                        onChanged: (value) async {

                          // PREVENT LOOP
                          if (nmrWklyController.isRestoring) {
                            return;
                          }

                          // STORE OLD VALUE
                          String oldValue =
                              nmrWklyController.oldFoodValue;

                          // CALCULATE
                          bool success =
                          await nmrWklyController
                              .deduction_paymentCalculation();

                          // INVALID
                          if (!success) {

                            BaseUtitiles.showToast(
                              "Net Bill Amount cannot be negative. "
                                  "Please reduce the deductions "
                                  "or add-less percentages.",
                            );

                            // PREVENT onChanged LOOP
                            nmrWklyController.isRestoring = true;

                            // RESTORE OLD VALUE
                            nmrWklyController.foodDeduction.text =
                                oldValue;

                            // CURSOR POSITION
                            nmrWklyController.foodDeduction.selection =
                                TextSelection.fromPosition(
                                  TextPosition(
                                    offset: oldValue.length,
                                  ),
                                );

                            nmrWklyController.isRestoring = false;

                            // RECALCULATE
                            await nmrWklyController
                                .deduction_paymentCalculation();

                          } else {

                            // SAVE VALID VALUE
                            nmrWklyController.oldFoodValue =
                                value;
                          }
                        },
                        onTap: (){
                          if(nmrWklyController.foodDeduction.text=="0.0"||nmrWklyController.foodDeduction.text=="0"){
                            nmrWklyController.foodDeduction.text="";
                          }
                        },
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: nmrWklyController.Creditamt,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Credit-Amount",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.creditAmt),
                              ),
                              onChanged: (value) async {

                                // PREVENT LOOP
                                if (nmrWklyController.isRestoring) {
                                  return;
                                }

                                // STORE OLD VALUE
                                String oldValue =
                                    nmrWklyController.oldCreditValue;

                                // CALCULATE FIRST
                                bool success =
                                await nmrWklyController
                                    .deduction_paymentCalculation();

                                // INVALID
                                if (!success) {

                                  BaseUtitiles.showToast(
                                    "Net Bill Amount cannot be negative. "
                                        "Please reduce the deductions "
                                        "or add-less percentages.",
                                  );

                                  // PREVENT onChanged LOOP
                                  nmrWklyController.isRestoring = true;

                                  // RESTORE OLD VALUE
                                  nmrWklyController.Creditamt.text =
                                      oldValue;

                                  // CURSOR POSITION
                                  nmrWklyController.Creditamt.selection =
                                      TextSelection.fromPosition(
                                        TextPosition(
                                          offset: oldValue.length,
                                        ),
                                      );

                                  nmrWklyController.isRestoring = false;

                                  // RECALCULATE
                                  await nmrWklyController
                                      .deduction_paymentCalculation();

                                } else {

                                  // SAVE VALID VALUE
                                  nmrWklyController.oldCreditValue =
                                      value;
                                }
                              },
                              onTap: (){
                                if(nmrWklyController.Creditamt.text=="0.0"||nmrWklyController.Creditamt.text=="0"){
                                  nmrWklyController.Creditamt.text="";
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              controller:
                              nmrWklyController.CreditRemarksController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Remarks",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.remarks),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              // readOnly: true,
                              keyboardType: TextInputType.number,
                              controller: nmrWklyController.Debitamt,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Debit-Amount",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.debitAmt),
                              ),
                              onChanged: (value) async {

                                // PREVENT LOOP
                                if (nmrWklyController.isRestoring) {
                                  return;
                                }

                                // STORE OLD VALUE
                                String oldValue =
                                    nmrWklyController.oldDebitValue;

                                // CALCULATE
                                bool success =
                                await nmrWklyController
                                    .deduction_paymentCalculation();

                                // INVALID
                                if (!success) {

                                  BaseUtitiles.showToast(
                                    "Net Bill Amount cannot be negative. "
                                        "Please reduce the deductions "
                                        "or add-less percentages.",
                                  );

                                  // PREVENT RE-TRIGGER
                                  nmrWklyController.isRestoring = true;

                                  // RESTORE OLD VALUE
                                  nmrWklyController.Debitamt.text =
                                      oldValue;

                                  // CURSOR
                                  nmrWklyController.Debitamt.selection =
                                      TextSelection.fromPosition(
                                        TextPosition(
                                          offset: oldValue.length,
                                        ),
                                      );

                                  // ALLOW AGAIN
                                  nmrWklyController.isRestoring = false;

                                  await nmrWklyController
                                      .deduction_paymentCalculation();

                                } else {

                                  // SAVE VALID VALUE
                                  nmrWklyController.oldDebitValue =
                                      value;
                                }
                              },
                              onTap: (){
                                if(nmrWklyController.Debitamt.text=="0.0"||nmrWklyController.Debitamt.text=="0"){
                                  nmrWklyController.Debitamt.text="";
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              controller:
                              nmrWklyController.DebitRemarksController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Remarks",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.remarks),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        readOnly: true,
                        controller: nmrWklyController.tobededadv,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "To Be Deduction in Advance",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.deduction),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        readOnly: nmrWklyController.advance(nmrWklyController.tobededadv.text),
                        controller: nmrWklyController.Advded,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Advance Deduction Amt",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.advancededuction),
                        ),
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: nmrWklyController.Roundoff,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Round off",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.roundoff),
                              ),
                              onChanged: (value) async {

                                // PREVENT LOOP
                                if (nmrWklyController.isRestoring) {
                                  return;
                                }

                                // STORE OLD VALUE
                                String oldValue =
                                    nmrWklyController.oldRoundOffValue;

                                // CALCULATE
                                bool success =
                                await nmrWklyController
                                    .deduction_paymentCalculation();

                                // INVALID
                                if (!success) {

                                  BaseUtitiles.showToast(
                                    "Net Bill Amount cannot be negative. "
                                        "Please reduce the deductions "
                                        "or add-less percentages.",
                                  );

                                  // PREVENT onChanged LOOP
                                  nmrWklyController.isRestoring = true;

                                  // RESTORE OLD VALUE
                                  nmrWklyController.Roundoff.text =
                                      oldValue;

                                  // CURSOR POSITION
                                  nmrWklyController.Roundoff.selection =
                                      TextSelection.fromPosition(
                                        TextPosition(
                                          offset: oldValue.length,
                                        ),
                                      );

                                  nmrWklyController.isRestoring = false;

                                  // RECALCULATE
                                  await nmrWklyController
                                      .deduction_paymentCalculation();

                                } else {

                                  // SAVE VALID VALUE
                                  nmrWklyController.oldRoundOffValue =
                                      value;
                                }
                              },
                              onTap: (){
                                if(nmrWklyController.Roundoff.text=="0.0"||nmrWklyController.Roundoff.text=="0"){
                                  nmrWklyController.Roundoff.text="";
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: nmrWklyController.netpayamt,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Net Pay Amt",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.netAmt),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Obx((){
                    return Table(
                      border: TableBorder(
                        horizontalInside: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        verticalInside: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(2.5),
                        1: FlexColumnWidth(1.2),
                        2: FlexColumnWidth(1.5),
                        3: FlexColumnWidth(2),
                      },
                      children: [

                        /// HEADER
                        TableRow(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                          children:  [
                            tableHeader("DESCRIPTION"),
                            tableHeader("+/-"),
                            tableHeader("%"),
                            tableHeader("AMOUNT"),
                          ],
                        ),

                        /// ROWS
                        // ADD THIS
                        ...List.generate(
                          nmrWklyController.directBillGen_ItemReadList.length,
                              (index) {
                            final item = nmrWklyController.directBillGen_ItemReadList[index];

                            return TableRow(
                              children: [
                                tableCellText(item.addLessName ?? ''),
                                Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: item.addLessType == "+"
                                          ? Colors.green.shade100
                                          : Colors.red.shade100,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.addLessType ?? '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: item.addLessType == "+"
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 45,
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: nmrWklyController.percentControllers[index],
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.black,
                                    textInputAction: TextInputAction.done,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(color: Colors.grey, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    onChanged: (val) {

                                      final item =
                                      nmrWklyController
                                          .directBillGen_ItemReadList[index];

                                      double oldPercent =
                                          item.percentValue ?? 0.0;

                                      double oldAmount =
                                          item.amount ?? 0.0;

                                      final percent =
                                          double.tryParse(val) ?? 0.0;

                                      bool success =
                                      nmrWklyController.calculateAndUpdate(

                                        item.addLessId!,

                                        percent,

                                        nmrWklyController.baseNetPayAmt,
                                      );

                                      // RESTORE ONLY CURRENT FIELD
                                      if (!success) {

                                        nmrWklyController
                                            .percentControllers[index]
                                            .text =
                                        oldPercent == 0
                                            ? ''
                                            : oldPercent.toString();

                                        nmrWklyController
                                            .percentControllers[index]
                                            .selection =
                                            TextSelection.fromPosition(
                                              TextPosition(
                                                offset:
                                                nmrWklyController
                                                    .percentControllers[index]
                                                    .text
                                                    .length,
                                              ),
                                            );

                                        item.percentValue = oldPercent;
                                        item.amount = oldAmount;

                                        nmrWklyController
                                            .directBillGen_ItemReadList
                                            .refresh();
                                      }
                                    },
                                    onEditingComplete: () async {
                                      FocusScope.of(context).unfocus();   // closes keyboard
                                      await nmrWklyController.saveUpdatedCalcData();
                                    },
                                  ),
                                ),
                                Obx(() {
                                  final updated = nmrWklyController.directBillGen_ItemReadList
                                      .firstWhereOrNull((e) => e.addLessId == item.addLessId);
                                  return tableCellText(
                                    (updated?.amount ?? 0.0).toStringAsFixed(2),
                                    align: TextAlign.right,
                                  );
                                }),
                              ],
                            );
                          },
                        ),
                        /// TOTAL ROW
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                          ),
                          children: [
                            Container(
                              height: 50,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(),
                              child: const Text(
                                "Total Add/Less",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(),
                            const SizedBox(),
                            /// TOTAL AMOUNT
                            // ADD THIS
                            Obx(() => Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                (nmrWklyController.totalAddLess.abs() < 0.001
                                    ? 0.0
                                    : nmrWklyController.totalAddLess)
                                    .toStringAsFixed(2), // ← getter from controller
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    );}
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
              padding: EdgeInsets.only(
                top: 8,
                bottom: 10,
              ),

              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                  )
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [

                  SizedBox(height: 7),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            alignment: Alignment.center,
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          onTap: () {
                            ResetAlert(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Theme.of(context).primaryColor),
                            alignment: Alignment.center,
                            child: Text(
                              nmrWklyController.saveButton.value,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            SubmitAlert(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }

  Widget tableHeader(String text) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget tableCellText(
      String text, {
        TextAlign align = TextAlign.left,
      }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: align,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }


  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to ${nmrWklyController.saveButton.value}?'),
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
                        onPressed: () async {
                          if (
                          projectController.selectedProjectId.value != 0 &&
                              siteController.selectedsiteId.value != 0 &&
                              subcontractorController.selectedSubcontId.value !=
                                  0) {
                            if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                              await nmrWklyController
                                  .SaveButton_DeductionScreen(
                                  context,
                                  nmrWklyController.workid != 0
                                      ? nmrWklyController.workid
                                      : 0);
                            }
                          } else {
                            BaseUtitiles.showToast("Please check once again");
                          }
                        },
                        child: Text(
                            nmrWklyController.saveButton.value,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
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

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Reset?'),
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
                        onPressed: () async {
                          nmrWklyController.workid = 0;
                          nmrWklyController.Creditamt.text = "0.0";
                          nmrWklyController.Debitamt.text = "0.0";
                          nmrWklyController.Advded.text = "0.0";
                          nmrWklyController.Roundoff.text = "0.0";
                          nmrWklyController.tobededadv.text =
                              nmrWklyController.to_be_dection_advance;

                          nmrWklyController.deduction_paymentCalculation();
                          nmrWklyController.CreditRemarksController.text = "-";
                          nmrWklyController.DebitRemarksController.text = "-";

                          nmrWklyController.tobededadv.text = "0.0";

                          nmrWklyController.NmritemList.value.clear();
                          nmrWklyController.EditListSaveDatas.value.clear();
                          nmrWklyController.saveButton.value =
                              RequestConstant.SUBMIT;
                          nmrWklyController.workid = 0;
                          nmrWklyController.billamount.text = "0.0";
                          nmrWklyController.foodDeduction.text = "0.0";
                          nmrWklyController.Creditamt.text = "0.0";
                          nmrWklyController.Debitamt.text = "0.0";
                          nmrWklyController.CreditRemarksController.text = "-";
                          nmrWklyController.DebitRemarksController.text = "-";
                          nmrWklyController.Advded.text = "0.0";
                          nmrWklyController.Roundoff.text = "0.0";
                          nmrWklyController.netpayamt.text = "0.0";
                          nmrWklyController.tobededadv.text = "0.0";

                          Navigator.pop(context);
                        },
                        child: Text("Reset",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
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
