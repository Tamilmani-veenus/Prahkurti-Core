import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prahkurticore/controller/workOrderBoq_Controller.dart';
import 'package:prahkurticore/home/menu/main_menu/workOrder_BOQ/workOrderBoq_Terms&Condition.dart';

import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class WorkOrderBoqDeduction extends StatefulWidget {
  const WorkOrderBoqDeduction({super.key});

  @override
  State<WorkOrderBoqDeduction> createState() => _WorkOrderBoqDeductionState();
}

class _WorkOrderBoqDeductionState extends State<WorkOrderBoqDeduction> {

  WorkOrderBoqController workOrderBoqController = Get.put(WorkOrderBoqController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {

      if (workOrderBoqController.saveButton.value == RequestConstant.RESUBMIT || workOrderBoqController.saveButton.value == RequestConstant.VERIFY || workOrderBoqController.saveButton.value == RequestConstant.APPROVAL) {
        // workOrderBoqController.workOrder_editListApiDatas.forEach((element) {
        //   workOrderBoqController.workid = element.id;
        //   workOrderBoqController.workOrdamount.text = element.workOrderAmount.toString();
        //   workOrderBoqController.Roundoff.text = element.roundOff.toString();
        //   workOrderBoqController.netpayamt.text = element.netAmount.toString();
        //   // workOrderDirectController.deductionPaymentCalculation();
        // });
        await workOrderBoqController.deductionPaymentCalculation();
        workOrderBoqController.setBaseNetPay(
            workOrderBoqController.workOrdamount.text);
      }
      await workOrderBoqController.WorkOrder_CalculationList();

      if (workOrderBoqController.saveButton.value == RequestConstant.SUBMIT) {
        workOrderBoqController.workid = 0;
        workOrderBoqController.workOrdamount.text = "0.0";
        workOrderBoqController.rebateAmount.text = "0.0";
        workOrderBoqController.Roundoff.text = "0.0";
        workOrderBoqController.deductionPaymentCalculation();
      }
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
                          "Work Order Direct Deduction",
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
                          autovalidateMode: AutovalidateMode.always,
                          readOnly: true,
                          controller: workOrderBoqController.workOrdamount,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Work Order Amt",
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
                                AutovalidateMode.always,
                                onTap: () {
                                  if (workOrderBoqController
                                      .Roundoff.text !=
                                      "" &&
                                      workOrderBoqController
                                          .Roundoff.text !=
                                          "0" &&
                                      workOrderBoqController
                                          .Roundoff.text !=
                                          "0.0") {
                                    return;
                                  } else {
                                    setState(() {
                                      workOrderBoqController
                                          .Roundoff.text = "";
                                      workOrderBoqController
                                          .deductionPaymentCalculation();
                                    });
                                  }
                                },
                                keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,

                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                                        ? newValue
                                        : oldValue;
                                  }),
                                ],
                                controller:
                                workOrderBoqController.Roundoff,
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
                                  if (workOrderBoqController.isRestoring) {
                                    return;
                                  }

                                  // STORE OLD VALUE
                                  String oldValue =
                                      workOrderBoqController.oldRoundOffValue;

                                  // CALCULATE
                                  bool success =
                                  await workOrderBoqController
                                      .deductionPaymentCalculation();

                                  // INVALID
                                  if (!success) {

                                    BaseUtitiles.showToast(
                                      "Net Bill Amount cannot be negative. "
                                          "Please reduce the deductions "
                                          "or add-less percentages.",
                                    );

                                    // PREVENT onChanged LOOP
                                    workOrderBoqController.isRestoring = true;

                                    // RESTORE OLD VALUE
                                    workOrderBoqController.Roundoff.text =
                                        oldValue;

                                    // CURSOR POSITION
                                    workOrderBoqController.Roundoff.selection =
                                        TextSelection.fromPosition(
                                          TextPosition(
                                            offset: oldValue.length,
                                          ),
                                        );

                                    workOrderBoqController.isRestoring = false;

                                    // RECALCULATE
                                    await workOrderBoqController
                                        .deductionPaymentCalculation();

                                  } else {

                                    // SAVE VALID VALUE
                                    workOrderBoqController.oldRoundOffValue =
                                        value;
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
                                keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,

                                inputFormatters: [
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                                        ? newValue
                                        : oldValue;
                                  }),
                                ],
                                autovalidateMode:
                                AutovalidateMode.always,
                                controller:
                                workOrderBoqController.netpayamt,
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

                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin:  EdgeInsets.only(top: 8,bottom: 4,left: 2,right: 2),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// Title & Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Terms and Conditions",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const TermsConditionsDialog(),
                                );
                              },
                              icon: const Icon(Icons.add, size: 13),
                              label: const Text("Add Terms",style: TextStyle(fontSize: 11),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                              ),
                            ),
                          ],
                        ),


                        /// Table Border
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [

                              /// Header
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  children: [

                                    Container(
                                      width: 30,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      child: const Text(
                                        "S.No",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        alignment: Alignment.centerLeft,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            right: BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        child: const Text(
                                          "Terms & Conditions",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          "Action",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Obx(() {
                                if (workOrderBoqController.selectedTerms.isEmpty) {
                                  return  SizedBox(
                                    height: 180,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.description_outlined,
                                            size: 55,
                                            color: Colors.grey.shade400,
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            "No terms & conditions added yet",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: workOrderBoqController.selectedTerms.length,
                                  itemBuilder: (context, index) {
                                    final item = workOrderBoqController.selectedTerms[index];

                                    return Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            child: Center(child: Text("${index + 1}")),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Text(item.termsAndCondition ?? " "),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 40,
                                            child: IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                                              onPressed: () {
                                                workOrderBoqController.selectedTerms.removeAt(index);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              })
                            ],
                          ),
                        ),
                      ],
                    ),
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
                          ...List.generate(workOrderBoqController.workOrder_ItemReadList.length ,(index) {
                            final item = workOrderBoqController.workOrder_ItemReadList[index];

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
                                    controller: workOrderBoqController.percentControllers[index],
                                    keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,

                                    inputFormatters: [
                                      TextInputFormatter.withFunction((oldValue, newValue) {
                                        return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                                            ? newValue
                                            : oldValue;
                                      }),
                                    ],
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
                                      workOrderBoqController
                                          .workOrder_ItemReadList[index];

                                      double oldPercent =
                                          item.percentValue ?? 0.0;

                                      double oldAmount =
                                          item.amount ?? 0.0;

                                      final percent =
                                          double.tryParse(val) ?? 0.0;

                                      bool success =
                                      workOrderBoqController.calculateAndUpdate(

                                        item.addLessId!,

                                        percent,

                                        workOrderBoqController.baseNetPayAmt,
                                      );

                                      // RESTORE ONLY CURRENT FIELD
                                      if (!success) {

                                        workOrderBoqController
                                            .percentControllers[index]
                                            .text =
                                        oldPercent == 0
                                            ? ''
                                            : oldPercent.toString();

                                        workOrderBoqController
                                            .percentControllers[index]
                                            .selection =
                                            TextSelection.fromPosition(
                                              TextPosition(
                                                offset:
                                                workOrderBoqController
                                                    .percentControllers[index]
                                                    .text
                                                    .length,
                                              ),
                                            );

                                        item.percentValue = oldPercent;
                                        item.amount = oldAmount;

                                        workOrderBoqController
                                            .workOrder_ItemReadList
                                            .refresh();
                                      }
                                    },
                                    onEditingComplete: () async {
                                      FocusScope.of(context).unfocus();   // closes keyboard
                                      await workOrderBoqController.saveUpdatedCalcData();
                                    },
                                  ),
                                ),
                                Obx(() {
                                  final updated = workOrderBoqController.workOrder_ItemReadList
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
                                  workOrderBoqController.totalAddLess.toStringAsFixed(2), // ← getter from controller
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
                            workOrderBoqController.saveButton.value,
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
                              SubmitAlert(context);
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
            'Are you sure to ${workOrderBoqController.saveButton.value}?'
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
                              // await workOrderBoqController
                              //     .SaveButton_DeductionScreen(
                              //     context,
                              //     workOrderBoqController
                              //         .workid,subcontractorController.selectedWorkOrderId.value,
                              //     workOrderBoqController.saveButton.value == RequestConstant.VERIFY ||
                              //         workOrderBoqController.saveButton.value == RequestConstant.APPROVAL ? false : true);
                            }
                          } else if (double.parse(workOrderBoqController.netpayamt.text) < 0) {
                            BaseUtitiles.showToast(
                                "Net pay amount must be greater than 0");
                          } else {
                            BaseUtitiles.showToast(
                                "Please check all details once again");
                          }
                        },
                        child: Text(
                          workOrderBoqController.saveButton.value,
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
                          workOrderBoqController.saveButton.value = RequestConstant.SUBMIT;
                          workOrderBoqController.workid = 0;
                          projectController.projectname.text = "--SELECT--";
                          projectController.selectedProjectId.value = 0;
                          subcontractorController.Subcontractorname.text = "--SELECT--";
                          subcontractorController.selectedSubcontId.value = 0;
                          workOrderBoqController.workOrdentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();

                          workOrderBoqController
                              .autoYearWiseNoController.text =
                              autoYearWiseNoController
                                  .DirectBillautoYrsWise.value;
                          siteController.selectedsiteId = 0.obs;
                          siteController.selectedsitedropdownName = "--SELECT--".obs;
                          siteController.getSiteDropdownvalue.value.clear();
                          siteController.Sitename.text = RequestConstant.SELECT;
                          siteController.siteDropdownName.clear();

                          workOrderBoqController.delete_WorkOrderBoq_itemlist_Table();
                          workOrderBoqController.WorkOrdBoqitem_itemview_GetDbList.value.clear();

                          workOrderBoqController.workOrdamount.text = "0.0";
                          workOrderBoqController.Roundoff.text = "0";
                          workOrderBoqController.netpayamt.text = "0.0";
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
