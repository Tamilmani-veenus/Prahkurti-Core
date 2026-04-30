import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
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
  SubcontractorController subcontractorController =
  Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  @override
  void initState() {
    nmrWklyController.tobededadv.text = "0.0";

    if (nmrWklyController.submitCheck == 1) {
      nmrWklyController.workid = 0;
      nmrWklyController.Creditamt.text = "0";
      nmrWklyController.Debitamt.text = "0";
      nmrWklyController.Advded.text = "0";
      nmrWklyController.Roundoff.text = "0";
      nmrWklyController.tobededadv.text =
          nmrWklyController.to_be_dection_advance;

      nmrWklyController.deduction_paymentCalculation();
      nmrWklyController.CreditRemarksController.text = "-";
      nmrWklyController.DebitRemarksController.text = "-";
    } else if (nmrWklyController.editCheck == 1) {
      nmrWklyController.ButtonChanges(1, nmrWklyController.aprovedButton);
      nmrWklyController.saveButton.value = RequestConstant.RESUBMIT;
      nmrWklyController.EditListSaveDatas.value.forEach((element) {
        nmrWklyController.workid = element.workId;
        nmrWklyController.billamount.text = element.billAmt.toString();
        nmrWklyController.Creditamt.text = element.creditAmt.toString();
        nmrWklyController.Debitamt.text = element.debitAmt.toString();
        nmrWklyController.Advded.text = element.advAmt.toString();
        nmrWklyController.tobededadv.text = element.actAdvAmt.toString();
        nmrWklyController.Roundoff.text = element.rndOff.toString();
        nmrWklyController.CreditRemarksController.text =
            element.creditRemarks.toString();
        nmrWklyController.DebitRemarksController.text =
            element.debitRemarks.toString();
        nmrWklyController.netpayamt.text = element.netPayAmt.toString();
      });
      // nmrWklyController.deduction_paymentCalculation();
    } else {
      nmrWklyController.NmritemList.value.clear();
      nmrWklyController.EditListSaveDatas.value.clear();
      nmrWklyController.saveButton.value = RequestConstant.SAVE;
      nmrWklyController.workid = 0;
      nmrWklyController.billamount.text = "0.0";
      nmrWklyController.Creditamt.text = "0";
      nmrWklyController.Debitamt.text = "0";
      nmrWklyController.CreditRemarksController.text = "-";
      nmrWklyController.DebitRemarksController.text = "-";
      nmrWklyController.Advded.text = "0";
      nmrWklyController.Roundoff.text = "0";
      nmrWklyController.netpayamt.text = "0.0";
      nmrWklyController.tobededadv.text = "0.0";
    }
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
                        validator: (value) {
                          if (value!.isEmpty || value == "0.0") {
                            return '\u26A0 can not allow to bill amount is 0';
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
                              onChanged: (value) {
                                nmrWklyController
                                    .deduction_paymentCalculation();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '\u26A0 Enter a credit amount';
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
                              onChanged: (value) {
                                nmrWklyController
                                    .deduction_paymentCalculation();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '\u26A0 Enter a debit amount';
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
                        readOnly: nmrWklyController
                            .advance(nmrWklyController.tobededadv.text),
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
                        onChanged: (value) {
                          nmrWklyController.deduction_paymentCalculation();
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
                              onChanged: (value) {
                                nmrWklyController
                                    .deduction_paymentCalculation();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '\u26A0 Enter a round off amont';
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '\u26A0 Enter user name';
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

                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           margin: EdgeInsets.only(left: 20,top: 10),
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           child: Text("Bill Amount"),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           margin: EdgeInsets.only(left: 10, right: 20),
                //           decoration: BoxDecoration(),
                //           child: TextField(
                //             readOnly: true,
                //             controller: nmrWklyController.billamount,
                //             enabled: true,
                //             textAlign: TextAlign.center,
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //               border: OutlineInputBorder(),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 5),
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           margin: EdgeInsets.only(left: 20,top: 10),
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           child: Text("Credit-Amount"),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           margin: EdgeInsets.only(left: 40,top: 10),
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           child: Text("Remarks"),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           margin: EdgeInsets.only(left: 10, right: 20),
                //           decoration: BoxDecoration(),
                //           child: TextField(
                //             keyboardType: TextInputType.number,
                //             controller: nmrWklyController.Creditamt,
                //             enabled: true,
                //             textAlign: TextAlign.center,
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //               border: OutlineInputBorder(),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                //               ),
                //             ),
                //             onChanged: (value){
                //               nmrWklyController.deduction_paymentCalculation();
                //             },
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           margin: EdgeInsets.only(left: 10, right: 20),
                //           decoration: BoxDecoration(),
                //           child: TextField(
                //             controller: nmrWklyController.CreditRemarksController,
                //             enabled: true,
                //             textAlign: TextAlign.center,
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //               border: OutlineInputBorder(),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 5),
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           margin: EdgeInsets.only(left: 20,top: 10),
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           child: Text("Debit-Amount"),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           margin: EdgeInsets.only(left: 40,top: 10),
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           child: Text("Remarks"),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           margin: EdgeInsets.only(left: 10, right: 20),
                //           decoration: BoxDecoration(),
                //           child: TextField(
                //             keyboardType: TextInputType.number,
                //             controller: nmrWklyController.Debitamt,
                //             enabled: true,
                //             textAlign: TextAlign.center,
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //               border: OutlineInputBorder(),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                //               ),
                //             ),
                //             onChanged: (value){
                //               nmrWklyController.deduction_paymentCalculation();
                //             },
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           margin: EdgeInsets.only(left: 10, right: 20),
                //           decoration: BoxDecoration(),
                //           child: TextField(
                //             controller: nmrWklyController.DebitRemarksController,
                //             enabled: true,
                //             textAlign: TextAlign.center,
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //               border: OutlineInputBorder(),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           margin: EdgeInsets.only(left: 20,top: 10),
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           child: Text("To Be Deduction in Advance"),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           margin: EdgeInsets.only(left: 10, right: 20),
                //           decoration: BoxDecoration(),
                //           child: TextField(
                //             readOnly: true,
                //             controller: nmrWklyController.tobededadv,
                //             enabled: true,
                //             textAlign: TextAlign.center,
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //               border: OutlineInputBorder(),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           margin: EdgeInsets.only(left: 20,top: 10),
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           child: Text("Advance Deduction Amt"),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           margin: EdgeInsets.only(left: 10, right: 20),
                //           decoration: BoxDecoration(),
                //           child: TextField(
                //             keyboardType: TextInputType.number,
                //             readOnly:nmrWklyController.advance(nmrWklyController.tobededadv.text),
                //             controller: nmrWklyController.Advded,
                //             textAlign: TextAlign.center,
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //               border: OutlineInputBorder(),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                //               ),
                //             ),
                //             onChanged: (value){
                //               nmrWklyController.deduction_paymentCalculation();
                //             },
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           margin: EdgeInsets.only(left: 20,top: 10),
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           child: Text("Round off"),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           margin: EdgeInsets.only(left: 10, right: 20),
                //           decoration: BoxDecoration(),
                //           child: TextField(
                //             keyboardType: TextInputType.number,
                //             controller: nmrWklyController.Roundoff,
                //             textAlign: TextAlign.center,
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //               border: OutlineInputBorder(),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                //               ),
                //             ),
                //             onChanged: (value){
                //               nmrWklyController.deduction_paymentCalculation();
                //             },
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 10,bottom: 10),
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           margin: EdgeInsets.only(left: 20,top: 10),
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           child: Text("Net Pay Amt"),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Container(
                //           height: BaseUtitiles.getheightofPercentage(context, 4),
                //           margin: EdgeInsets.only(left: 10, right: 20),
                //           decoration: BoxDecoration(),
                //           child: TextField(
                //             controller: nmrWklyController.netpayamt,
                //             readOnly: true,
                //             textAlign: TextAlign.center,
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //               border: OutlineInputBorder(),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
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
                      setState(() {
                        nmrWklyController.checkColor = 1;
                        ResetAlert(context);
                      });
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
                        nmrWklyController.editCheck == 1
                            ? RequestConstant.RESUBMIT
                            : RequestConstant.SUBMIT,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        nmrWklyController.checkColor = 0;
                        SubmitAlert(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(nmrWklyController.editCheck == 1
            ? 'Are you sure to Re-Submit?'
            : 'Are you sure to Submit?'),
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
                          if (double.parse(nmrWklyController.netpayamt.text) >
                              0 &&
                              projectController.selectedProjectId != 0 &&
                              siteController.selectedsiteId.value != 0 &&
                              subcontractorController.selectedSubcontId.value !=
                                  0) {
                            if (await BaseUtitiles.checkNetworkAndShowLoader(
                                context)) {
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
                            nmrWklyController.editCheck == 1
                                ? RequestConstant.RESUBMIT
                                : RequestConstant.SUBMIT,
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
                          nmrWklyController.submitCheck == 1;
                          nmrWklyController.workid = 0;
                          nmrWklyController.Creditamt.text = "0";
                          nmrWklyController.Debitamt.text = "0";
                          nmrWklyController.Advded.text = "0";
                          nmrWklyController.Roundoff.text = "0";
                          nmrWklyController.tobededadv.text =
                              nmrWklyController.to_be_dection_advance;

                          nmrWklyController.deduction_paymentCalculation();
                          nmrWklyController.CreditRemarksController.text = "-";
                          nmrWklyController.DebitRemarksController.text = "-";

                          nmrWklyController.tobededadv.text = "0.0";

                          nmrWklyController.NmritemList.value.clear();
                          nmrWklyController.EditListSaveDatas.value.clear();
                          nmrWklyController.saveButton.value =
                              RequestConstant.SAVE;
                          nmrWklyController.workid = 0;
                          nmrWklyController.billamount.text = "0.0";
                          nmrWklyController.Creditamt.text = "0";
                          nmrWklyController.Debitamt.text = "0";
                          nmrWklyController.CreditRemarksController.text = "-";
                          nmrWklyController.DebitRemarksController.text = "-";
                          nmrWklyController.Advded.text = "0";
                          nmrWklyController.Roundoff.text = "0";
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
