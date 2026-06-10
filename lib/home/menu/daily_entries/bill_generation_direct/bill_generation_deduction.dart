import 'package:fluttertoast/fluttertoast.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/billgenerationdirect_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Bill_Generation_direct_deduction extends StatefulWidget {
  const Bill_Generation_direct_deduction({Key? key}) : super(key: key);

  @override
  State<Bill_Generation_direct_deduction> createState() =>
      _Bill_Generation_direct_deductionState();
}

class _Bill_Generation_direct_deductionState
    extends State<Bill_Generation_direct_deduction> {
  BillGenerationDirectController billGenerationDirectController =
      Get.put(BillGenerationDirectController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController =
      Get.put(AutoYearWiseNoController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {

      if (billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT || billGenerationDirectController.saveButton.value == RequestConstant.VERIFY || billGenerationDirectController.saveButton.value == RequestConstant.APPROVAL) {
        billGenerationDirectController.bill_editListApiDatas.forEach((element) {
          billGenerationDirectController.workid = element.id;
          billGenerationDirectController.billamount.text = element.billAmount.toString();
          billGenerationDirectController.Creditamt.text = element.creditAmount.toString();
          billGenerationDirectController.Debitamt.text = element.debitAmount.toString();
          billGenerationDirectController.Advded.text = element.advanceAmount.toString();
          billGenerationDirectController.materialDebitamt.text = element.materialDebitAmount.toString();
          billGenerationDirectController.tobededadv.text = element.actualAdvanceAmount.toString();
          billGenerationDirectController.Roundoff.text = element.roundOff.toString();
          billGenerationDirectController.CreditRemarksController.text = element.creditRemarks.toString();
          billGenerationDirectController.DebitRemarksController.text = element.debitRemarks.toString();
          billGenerationDirectController.materialDebitRemarks.text = element.materialDebitRemarks.toString();
          billGenerationDirectController.tobededadv.text = element.actualAdvanceAmount.toString();
          billGenerationDirectController.to_be_dection_advance = element.advanceAmount.toString();
          billGenerationDirectController.netpayamt.text = element.netPayAmount.toString();

        });
        billGenerationDirectController.setBaseNetPay(
            billGenerationDirectController.billamount.text);
      }
      await billGenerationDirectController.DirectBill_CalculationList();

      if (billGenerationDirectController.saveButton.value == RequestConstant.SUBMIT) {
        billGenerationDirectController.workid = 0;
        billGenerationDirectController.materialDebitamt.text = "0.0";
        billGenerationDirectController.Creditamt.text = "0.0";
        billGenerationDirectController.Debitamt.text = "0.0";
        billGenerationDirectController.Advded.text = "0.0";
        billGenerationDirectController.Roundoff.text = "0.0";
        billGenerationDirectController.tobededadv.text = billGenerationDirectController.to_be_dection_advance;
        billGenerationDirectController.deductionPaymentCalculation();
        billGenerationDirectController.CreditRemarksController.text = "-";
        billGenerationDirectController.DebitRemarksController.text = "-";
        billGenerationDirectController.materialDebitRemarks.text = "-";

      }
      billGenerationDirectController.Advded.text = "0";
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Bill Generation Direct Deduction",
                          style: TextStyle(
                              fontSize: RequestConstant.Heading_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: billGenerationDirectController.billamount,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Bill Amount",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                            ),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.discription,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == "0.0" ||
                                value == "0.00") {
                              return '\u26A0 ${RequestConstant.VALIDATE}';
                            }
                            return null;
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
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                controller:
                                billGenerationDirectController.materialDebitamt,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "MaterialDebit Amount",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.creditAmt,
                                  ),
                                ),
                                onChanged: (value) async {

                                  // PREVENT LOOP
                                  if (billGenerationDirectController.isRestoring) {
                                    return;
                                  }

                                  // STORE OLD VALUE
                                  String oldValue =
                                      billGenerationDirectController.oldmatDebitValue;

                                  // CALCULATE
                                  bool success =
                                  await billGenerationDirectController
                                      .deductionPaymentCalculation();

                                  // INVALID
                                  if (!success) {

                                    BaseUtitiles.showToast(
                                      "Net Bill Amount cannot be negative. "
                                          "Please reduce the deductions "
                                          "or add-less percentages.",
                                    );

                                    // PREVENT onChanged LOOP
                                    billGenerationDirectController.isRestoring = true;

                                    // RESTORE OLD VALUE
                                    billGenerationDirectController.materialDebitamt.text =
                                        oldValue;

                                    // CURSOR POSITION
                                    billGenerationDirectController.materialDebitamt.selection =
                                        TextSelection.fromPosition(
                                          TextPosition(
                                            offset: oldValue.length,
                                          ),
                                        );

                                    billGenerationDirectController.isRestoring = false;

                                    // RECALCULATE
                                    await billGenerationDirectController
                                        .deductionPaymentCalculation();

                                  } else {

                                    // SAVE VALID VALUE
                                    billGenerationDirectController.oldmatDebitValue =
                                        value;
                                  }
                                },
                                onTap: (){
                                  if(billGenerationDirectController.materialDebitamt.text=="0.0"||billGenerationDirectController.materialDebitamt.text=="0"){
                                    billGenerationDirectController.materialDebitamt.text="";
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 ${RequestConstant.VALIDATE}';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                controller: billGenerationDirectController
                                    .materialDebitRemarks,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Remarks",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
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
                          margin:
                              const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onTap: () {
                                  if (billGenerationDirectController
                                              .Creditamt.text !=
                                          "" &&
                                      billGenerationDirectController
                                              .Creditamt.text !=
                                          "0" &&
                                      billGenerationDirectController
                                              .Creditamt.text !=
                                          "0.0") {
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationDirectController
                                          .Creditamt.text = "";
                                      billGenerationDirectController
                                          .deductionPaymentCalculation();
                                    });
                                  }
                                },
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                controller:
                                    billGenerationDirectController.Creditamt,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Credit-Amount",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.creditAmt,
                                  ),
                                ),
                                onChanged: (value) async {

                                  // PREVENT LOOP
                                  if (billGenerationDirectController.isRestoring) {
                                    return;
                                  }

                                  // STORE OLD VALUE
                                  String oldValue =
                                      billGenerationDirectController.oldCreditValue;

                                  // CALCULATE FIRST
                                  bool success =
                                  await billGenerationDirectController
                                      .deductionPaymentCalculation();

                                  // INVALID
                                  if (!success) {

                                    BaseUtitiles.showToast(
                                      "Net Bill Amount cannot be negative. "
                                          "Please reduce the deductions "
                                          "or add-less percentages.",
                                    );

                                    // PREVENT onChanged LOOP
                                    billGenerationDirectController.isRestoring = true;

                                    // RESTORE OLD VALUE
                                    billGenerationDirectController.Creditamt.text =
                                        oldValue;

                                    // CURSOR POSITION
                                    billGenerationDirectController.Creditamt.selection =
                                        TextSelection.fromPosition(
                                          TextPosition(
                                            offset: oldValue.length,
                                          ),
                                        );

                                    billGenerationDirectController.isRestoring = false;

                                    // RECALCULATE
                                    await billGenerationDirectController
                                        .deductionPaymentCalculation();

                                  } else {

                                    // SAVE VALID VALUE
                                    billGenerationDirectController.oldCreditValue =
                                        value;
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 ${RequestConstant.VALIDATE}';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                              const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                controller: billGenerationDirectController
                                    .CreditRemarksController,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Remarks",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
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
                          margin:
                              const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onTap: () {
                                  if (billGenerationDirectController
                                              .Debitamt.text !=
                                          "" &&
                                      billGenerationDirectController
                                              .Debitamt.text !=
                                          "0" &&
                                      billGenerationDirectController
                                              .Debitamt.text !=
                                          "0.0") {
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationDirectController
                                          .Debitamt.text = "";
                                      billGenerationDirectController
                                          .deductionPaymentCalculation();
                                    });
                                  }
                                },
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                controller:
                                    billGenerationDirectController.Debitamt,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Debit-Amount",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.debitAmt),
                                ),
                                onChanged: (value) async {

                                  // PREVENT LOOP
                                  if (billGenerationDirectController.isRestoring) {
                                    return;
                                  }

                                  // STORE OLD VALUE
                                  String oldValue =
                                      billGenerationDirectController.oldDebitValue;

                                  // CALCULATE
                                  bool success =
                                  await billGenerationDirectController
                                      .deductionPaymentCalculation();

                                  // INVALID
                                  if (!success) {

                                    BaseUtitiles.showToast(
                                      "Net Bill Amount cannot be negative. "
                                          "Please reduce the deductions "
                                          "or add-less percentages.",
                                    );

                                    // PREVENT RE-TRIGGER
                                    billGenerationDirectController.isRestoring = true;

                                    // RESTORE OLD VALUE
                                    billGenerationDirectController.Debitamt.text =
                                        oldValue;

                                    // CURSOR
                                    billGenerationDirectController.Debitamt.selection =
                                        TextSelection.fromPosition(
                                          TextPosition(
                                            offset: oldValue.length,
                                          ),
                                        );

                                    // ALLOW AGAIN
                                    billGenerationDirectController.isRestoring = false;

                                    await billGenerationDirectController
                                        .deductionPaymentCalculation();

                                  } else {

                                    // SAVE VALID VALUE
                                    billGenerationDirectController.oldDebitValue =
                                        value;
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 ${RequestConstant.VALIDATE}';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                              const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                controller: billGenerationDirectController
                                    .DebitRemarksController,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
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
                                    child: ConstIcons.remarks,
                                  ),
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
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child:  TextFormField(
                                readOnly: true,
                                controller: billGenerationDirectController.tobededadv,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
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
                                      vertical: 8,
                                      horizontal: 8,
                                    ),
                                    child: ConstIcons.deduction,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                readOnly: billGenerationDirectController.advance(
                                    billGenerationDirectController.tobededadv.text),
                                controller: billGenerationDirectController.Advded,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Advance Deduction Amt",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.advancededuction,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    billGenerationDirectController
                                        .deductionPaymentCalculation();
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 Enter advance deduction amount';
                                  }
                                  return null;
                                },
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
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                onTap: () {
                                  if (billGenerationDirectController
                                      .Roundoff.text !=
                                      "" &&
                                      billGenerationDirectController
                                          .Roundoff.text !=
                                          "0" &&
                                      billGenerationDirectController
                                          .Roundoff.text !=
                                          "0.0") {
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationDirectController
                                          .Roundoff.text = "";
                                      billGenerationDirectController
                                          .deductionPaymentCalculation();
                                    });
                                  }
                                },
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                controller:
                                billGenerationDirectController.Roundoff,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Round off",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.roundoff,
                                  ),
                                ),
                                onChanged: (value) async {

                                  // PREVENT LOOP
                                  if (billGenerationDirectController.isRestoring) {
                                    return;
                                  }

                                  // STORE OLD VALUE
                                  String oldValue =
                                      billGenerationDirectController.oldRoundOffValue;

                                  // CALCULATE
                                  bool success =
                                  await billGenerationDirectController
                                      .deductionPaymentCalculation();

                                  // INVALID
                                  if (!success) {

                                    BaseUtitiles.showToast(
                                      "Net Bill Amount cannot be negative. "
                                          "Please reduce the deductions "
                                          "or add-less percentages.",
                                    );

                                    // PREVENT onChanged LOOP
                                    billGenerationDirectController.isRestoring = true;

                                    // RESTORE OLD VALUE
                                    billGenerationDirectController.Roundoff.text =
                                        oldValue;

                                    // CURSOR POSITION
                                    billGenerationDirectController.Roundoff.selection =
                                        TextSelection.fromPosition(
                                          TextPosition(
                                            offset: oldValue.length,
                                          ),
                                        );

                                    billGenerationDirectController.isRestoring = false;

                                    // RECALCULATE
                                    await billGenerationDirectController
                                        .deductionPaymentCalculation();

                                  } else {

                                    // SAVE VALID VALUE
                                    billGenerationDirectController.oldRoundOffValue =
                                        value;
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 ${RequestConstant.VALIDATE}';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                controller:
                                billGenerationDirectController.netpayamt,
                                cursorColor: Colors.black,
                                readOnly: true,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 ${RequestConstant.VALIDATE}';
                                  }
                                  return null;
                                },
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
                          ...List.generate(billGenerationDirectController.directBillGen_ItemReadList.length ,(index) {
                            final item = billGenerationDirectController.directBillGen_ItemReadList[index];

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
                                    controller: billGenerationDirectController.percentControllers[index],
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.black,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                          color: Colors.grey, // normal border color
                                          width: 1,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                          color: Colors.grey, // focused border color
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      final item =
                                      billGenerationDirectController
                                          .directBillGen_ItemReadList[index];

                                      double oldPercent =
                                          item.percentValue ?? 0.0;

                                      double oldAmount =
                                          item.amount ?? 0.0;

                                      final percent =
                                          double.tryParse(val) ?? 0.0;

                                      bool success =
                                      billGenerationDirectController.calculateAndUpdate(

                                        item.addLessId!,

                                        percent,

                                        billGenerationDirectController.baseNetPayAmt,
                                      );

                                      // RESTORE ONLY CURRENT FIELD
                                      if (!success) {

                                        billGenerationDirectController
                                            .percentControllers[index]
                                            .text =
                                        oldPercent == 0
                                            ? ''
                                            : oldPercent.toString();

                                        billGenerationDirectController
                                            .percentControllers[index]
                                            .selection =
                                            TextSelection.fromPosition(
                                              TextPosition(
                                                offset:
                                                billGenerationDirectController
                                                    .percentControllers[index]
                                                    .text
                                                    .length,
                                              ),
                                            );

                                        item.percentValue = oldPercent;
                                        item.amount = oldAmount;

                                        billGenerationDirectController
                                            .directBillGen_ItemReadList
                                            .refresh();
                                      }
                                    },
                                    onEditingComplete: () async {
                                      FocusScope.of(context).unfocus();   // closes keyboard
                                      await billGenerationDirectController.saveUpdatedCalcData();
                                    },
                                  ),
                                ),
                                Obx(() {
                                  final updated = billGenerationDirectController.directBillGen_ItemReadList
                                      .firstWhereOrNull((e) => e.addLessId == item.addLessId);
                                  return tableCellText(
                                    (updated?.amount ?? 0.0).toStringAsFixed(2),
                                    align: TextAlign.right,
                                  );
                                }),

                              ],
                            );

                          }),
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

                              Obx(() => Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  billGenerationDirectController.totalAddLess.toStringAsFixed(2), // ← getter from controller
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
                  )
                ],
              ),
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



                /// BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              color:  Colors.white
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Reset",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                color:  Theme.of(context).primaryColor
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            ResetAlert(context);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              color:  Theme.of(context).primaryColor

                          ),
                          alignment: Alignment.center,
                          child: Text(
                            billGenerationDirectController.saveButton.value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                color:Colors.white
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if( ((billGenerationDirectController.Creditamt.text != "0" &&
                                  billGenerationDirectController.Creditamt.text != "0.0" &&
                                  billGenerationDirectController.Creditamt.text != "0.00") &&
                                  billGenerationDirectController.CreditRemarksController.text.isEmpty) &&  ((billGenerationDirectController.Debitamt.text != "0" &&
                                  billGenerationDirectController.Debitamt.text != "0.0" &&
                                  billGenerationDirectController.Debitamt.text != "0.00") &&
                                  billGenerationDirectController.DebitRemarksController.text.isEmpty)){
                                Fluttertoast.showToast(msg: "Please enter credit and debit remarks");
                              } else if ((billGenerationDirectController.Creditamt.text != "0" &&
                                  billGenerationDirectController.Creditamt.text != "0.0" &&
                                  billGenerationDirectController.Creditamt.text != "0.00") &&
                                  billGenerationDirectController.CreditRemarksController.text.isEmpty) {
                                Fluttertoast.showToast(msg: "Please enter credit remarks");
                              }
                              else if ((billGenerationDirectController.Debitamt.text != "0" &&
                                  billGenerationDirectController.Debitamt.text != "0.0" &&
                                  billGenerationDirectController.Debitamt.text != "0.00") &&
                                  billGenerationDirectController.DebitRemarksController.text.isEmpty) {
                                Fluttertoast.showToast(msg: "Please enter debit remarks");
                              }

                              else {
                                SubmitAlert(context);
                              }
                            }
                          });

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
        title: const Text('Alert!'),
        content: Text(
          billGenerationDirectController.saveButton.value == RequestConstant.RESUBMIT
              ? 'Are you sure to Re-Submit?'
              : 'Are you sure to Submit?',
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                        onPressed:  () async {

                                if (_formKey.currentState!.validate()) {
                                  if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                                    await billGenerationDirectController
                                        .SaveButton_DeductionScreen(
                                        context,
                                        billGenerationDirectController
                                            .workid,subcontractorController.selectedWorkOrderId.value);
                                  }
                                } else if (double.parse(billGenerationDirectController.netpayamt.text) < 0) {
                                  BaseUtitiles.showToast(
                                      "Net pay amount must be greater than 0");
                                } else {
                                  BaseUtitiles.showToast(
                                      "Please check all details once again");
                                }
                              },
                        child: Text(
                          billGenerationDirectController.saveButton.value,
                          style: TextStyle(
                            color:
                                 Theme.of(context).primaryColor,
                            // Change color when disabled
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                          ),
                        ),
                      ),
                    ),
                  ),
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
        title: const Text('Alert!'),
        content: const Text('Are you sure to Reset?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
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
                          billGenerationDirectController.to_be_dection_advance =
                              "0";
                          billGenerationDirectController.saveButton.value =
                              RequestConstant.SUBMIT;
                          billGenerationDirectController.workid = 0;
                          projectController.projectname.text = "--SELECT--";
                          projectController.selectedProjectId.value = 0;
                          subcontractorController.Subcontractorname.text =
                              "--SELECT--";
                          subcontractorController.selectedSubcontId.value = 0;
                          billGenerationDirectController.RemarksController
                              .clear();
                          billGenerationDirectController.billentryDateController
                              .text = BaseUtitiles.initiateCurrentDateFormat();
                          billGenerationDirectController.FromdateController
                              .text = BaseUtitiles.initiateCurrentDateFormat();
                          billGenerationDirectController.TodateController.text =
                              BaseUtitiles.initiateCurrentDateFormat();
                          billGenerationDirectController
                                  .autoYearWiseNoController.text =
                              autoYearWiseNoController
                                  .DirectBillautoYrsWise.value;
                          siteController.selectedsiteId = 0.obs;
                          siteController.selectedsitedropdownName =
                              "--SELECT--".obs;
                          siteController.getSiteDropdownvalue.value.clear();
                          siteController.Sitename.text = RequestConstant.SELECT;
                          siteController.siteDropdownName.clear();

                          billGenerationDirectController
                              .billgen_itemlistTable_Delete();
                          billGenerationDirectController
                              .ItemGetTableListdata.value
                              .clear();

                          billGenerationDirectController.billamount.text =
                              "0.0";
                          billGenerationDirectController.Creditamt.text = "0.0";
                          billGenerationDirectController.Debitamt.text = "0.0";
                          billGenerationDirectController
                              .CreditRemarksController.text = "";
                          billGenerationDirectController
                              .DebitRemarksController.text = "";
                          billGenerationDirectController.Advded.text =
                              billGenerationDirectController.tobededadv.text;
                          billGenerationDirectController.Roundoff.text = "0";
                          billGenerationDirectController.netpayamt.text = "0.0";
                          billGenerationDirectController.tobededadv.text =
                              billGenerationDirectController
                                  .to_be_dection_advance;
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
