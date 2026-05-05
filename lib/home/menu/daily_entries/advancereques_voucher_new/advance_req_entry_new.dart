import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/payfor_alert.dart';
import '../../../../commonpopup/vouchertype_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/advance_reqvoucher_new_controller.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/commonvoucher_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'advance_sitewisepayment_new.dart';

class AdvReq_voucher_New extends StatefulWidget {
  const AdvReq_voucher_New({Key? key}) : super(key: key);

  @override
  State<AdvReq_voucher_New> createState() => _AdvReq_voucher_NewState();
}

class _AdvReq_voucher_NewState extends State<AdvReq_voucher_New> {
  AutoYearWiseNoController autoYearWiseNoController =
  Get.put(AutoYearWiseNoController());
  AdvanceReqVoucherController_new advanceReqVoucherController_new =
  Get.put(AdvanceReqVoucherController_new());
  CommonVoucherController commonVoucherController =
  Get.put(CommonVoucherController());
  ProjectController projectController = Get.put(ProjectController());
  // CommanController commanController = Get.put(CommanController());
  BottomsheetControllers bottomsheetControllers =
  Get.put(BottomsheetControllers());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      await autoYearWiseNoController.AutoYearWiseNo("ADVANCE REQ VOUCHER");
      // await advanceReqVoucherController_new.netamountCalculation();
      advanceReqVoucherController_new.saveButton.value = RequestConstant.SUBMIT;
      advanceReqVoucherController_new.listButton.value = "List";
      await projectController.getProjectList();
      advanceReqVoucherController_new.autoYearWiseNoController.text =
          autoYearWiseNoController.AdvReqautoYrsWise.value;
      if (advanceReqVoucherController_new.editcheck == 1) {
        advanceReqVoucherController_new.ButtonChanges(
            advanceReqVoucherController_new.editListApiDatas[0].vocId);
        advanceReqVoucherController_new.radioType.value = "SiteWise Payment";
        advanceReqVoucherController_new.editListApiDatas.value
            .forEach((element) async {
          advanceReqVoucherController_new.vocId = element.vocId;
          advanceReqVoucherController_new.autoYearWiseNoController.text =
              element.vocNo;
          advanceReqVoucherController_new.entryDateController.text =
              element.vocDate.toString();
          projectController.projectname.text = element.projectName.toString();
          projectController.selectedProjectId.value = element.projectId;
          commonVoucherController.VoucherTypeController.text =
          element.vocType == "P" ? "Site Petty Cash" : "Advance";
          commonVoucherController.selectedAccTypeId.value = element.accTypeId;
          commonVoucherController.selectedAccnameId.value = element.accNameId;
          commonVoucherController.selectedAccPayId.value = element.payFor;
          commonVoucherController.AccPayforname.text =
              element.payForName.toString();
          commonVoucherController.selectedPaymodeId.value = element.payMode;
          commonVoucherController.AccountTypename.text =
              element.accTypeName.toString();
          commonVoucherController.namethrough.text =
              element.accNameName.toString();
          commonVoucherController.Accountname.text =
              element.accNameName.toString();
          // commonVoucherController.Paymodename.text = element.payForName.toString();
          advanceReqVoucherController_new.remarksController.text =
              element.remarks.toString();
          advanceReqVoucherController_new.radioType.value =
              element.payType.toString();
          commonVoucherController.payforController.text =
              element.payForName.toString();
          commonVoucherController.payfor.value = element.payFor;
          advanceReqVoucherController_new.listButton.value =
          commonVoucherController.selectedAccTypeId.value == 4
              ? "List"
              : "Sitewise List";
          advanceReqVoucherController_new.entry_amount.text =
              element.vocAmt.toString();
        });
      }
      if (advanceReqVoucherController_new.entrycheck == 0) {
        advanceReqVoucherController_new.ItemGetTableListdata.value = [];
        advanceReqVoucherController_new.GetTableList.value = [];
        advanceReqVoucherController_new.getDetList_Advance.value = [];
        advanceReqVoucherController_new.getDetList_NMR.value = [];

        advanceReqVoucherController_new.vocId = 0;
        advanceReqVoucherController_new.entryDateController.text =
            BaseUtitiles.initiateCurrentDateFormat();
        commonVoucherController.VoucherTypeController.text = "--SELECT--";
        commonVoucherController.VocType.value = "S";
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        commonVoucherController.AccountTypename.text = "--SELECT--";
        commonVoucherController.Accountname.text = "--SELECT--";
        commonVoucherController.selectedAccnameId.value = 0;
        commonVoucherController.payforController.text = RequestConstant.SELECT;
        commonVoucherController.Paymodename.text = RequestConstant.SELECT;
        commonVoucherController.namethrough.text = '--SELECT--';
        commonVoucherController.Accountname.text = '--SELECT--';
        commonVoucherController.namethrough.text = "";
        advanceReqVoucherController_new.remarksController.text = "";
        advanceReqVoucherController_new.radioType.value = "SiteWise Payment";
        advanceReqVoucherController_new.entry_amount.text = "0.0";
        await advanceReqVoucherController_new.delete_ListTable();
        await advanceReqVoucherController_new.itemlistTable_Delete();
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Advance Requisition Voucher",
                            style: TextStyle(
                                fontSize: RequestConstant.Heading_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style:
                              TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Container(
                          width:
                          BaseUtitiles.getWidthtofPercentage(context, 50),
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
                                controller: advanceReqVoucherController_new
                                    .autoYearWiseNoController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Request No",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                      RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.requestNo),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width:
                          BaseUtitiles.getWidthtofPercentage(context, 40),
                          margin: EdgeInsets.only(top: 10, right: 10),
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
                                controller: advanceReqVoucherController_new
                                    .entryDateController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Due Date",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                      RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.date),
                                ),
                                onTap: () async {
                                  if (advanceReqVoucherController_new
                                      .editcheck ==
                                      1) {
                                  } else {
                                    var Entrydate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context)
                                                    .primaryColor,
                                                // header background color
                                                onPrimary: Colors.white,
                                                // header text color
                                                onSurface: Colors
                                                    .black, // body text color
                                              ),
                                              textButtonTheme:
                                              TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  primary: Colors
                                                      .black, // button text color
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        });
                                    advanceReqVoucherController_new
                                        .entryDateController.text =
                                        BaseUtitiles.selectDateFormat(
                                            Entrydate!);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
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
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller:
                            commonVoucherController.VoucherTypeController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "VOC Type",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.types),
                            ),
                            onTap: () {
                              if (advanceReqVoucherController_new.editcheck ==
                                  1) {
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return VoucherTypeAlert();
                                    });
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value == "--Select--" ||
                                  value == "--SELECT--") {
                                return '\u26A0 ${RequestConstant.VALIDATE}';
                              }
                              return null;
                            },
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller: projectController.projectname,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Project Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.projectName),
                            ),
                            onTap: () {
                              setState(() {
                                if (advanceReqVoucherController_new.editcheck ==
                                    1) {
                                } else {
                                  bottomsheetControllers.ProjectName(context,
                                      projectController.getdropDownvalue.value);
                                }
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value == "--Select--" ||
                                  value == "--SELECT--") {
                                return '\u26A0 ${RequestConstant.VALIDATE}';
                              }
                              return null;
                            },
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller: commonVoucherController.AccountTypename,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "ACC Type",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.types),
                            ),
                            onTap: () async {
                              if (commonVoucherController
                                  .VoucherTypeController.text ==
                                  "Site Petty Cash") {
                                Fluttertoast.showToast(
                                    msg:
                                    "Voc type is site petty cash so can't access");
                              } else if (advanceReqVoucherController_new
                                  .editcheck ==
                                  1) {
                              } else {
                                // await commonVoucherController
                                //     .getAccountTypeList(context, 1);
                                bottomsheetControllers.AccountType(
                                    context,
                                    commonVoucherController
                                        .getdropDownvalue.value);

                              }
                            },
                            validator: (value) {
                              if (commonVoucherController
                                  .VoucherTypeController.text !=
                                  "Site Petty Cash") {
                                if (value!.isEmpty ||
                                    value == "--Select--" ||
                                    value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              }
                            },
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller: commonVoucherController.Accountname,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "ACC Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.accountName),
                            ),
                            onTap: () async {
                              if (commonVoucherController
                                  .VoucherTypeController.text ==
                                  "Site Petty Cash") {
                                Fluttertoast.showToast(
                                    msg:
                                    "Voc type is site petty cash so can't access");
                              } else if (advanceReqVoucherController_new
                                  .editcheck ==
                                  1) {
                              } else {
                                await commonVoucherController
                                    .getAccountName();
                                bottomsheetControllers.AccountName(
                                    context,
                                    commonVoucherController
                                        .getaccdropDownvalue.value);
                              }
                            },
                            validator: (value) {
                              if (commonVoucherController
                                  .VoucherTypeController.text !=
                                  "Site Petty Cash") {
                                if (value!.isEmpty ||
                                    value == "--Select--" ||
                                    value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    // Container(
                    //   margin: EdgeInsets.only(top: 5),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Expanded(
                    //         flex: 1,
                    //         child: InkWell(
                    //           child: Container(
                    //             margin: EdgeInsets.only(right: 5,left: 5),
                    //             alignment: Alignment.center,
                    //             height: BaseUtitiles.getheightofPercentage(context, 4),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(0),
                    //               color: Theme.of(context).primaryColor,
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                     offset: Offset(0, 10),
                    //                     blurRadius: 50,
                    //                     color: Color(0xffEEEEEE)
                    //                 ),
                    //               ],
                    //             ),
                    //             child: Icon(Icons.add_circle_outline_rounded, color: Colors.white),
                    //           ),
                    //           onTap: (){
                    //             if (commonVoucherController.AccountTypename.text ==
                    //                 "OTHERS" ||
                    //                 commonVoucherController.AccountTypename.text ==
                    //                     "SITE-OTHERS" ||
                    //                 commonVoucherController.AccountTypename.text ==
                    //                     "MATERIAL") {
                    //               if (commonVoucherController.Accountname.text ==
                    //                   "--Select--" ||
                    //                   commonVoucherController.Accountname.text ==
                    //                       "--SELECT--") {
                    //                 showDialog(
                    //                     context: context,
                    //                     builder: (BuildContext context) {
                    //                       return AccountnameAddAlert();
                    //                     });
                    //               } else {
                    //                 BaseUtitiles.showToast("You are Not Authorised");
                    //               }
                    //             } else {}
                    //           },
                    //         ),
                    //       ),
                    //       Expanded(
                    //         flex: 1,
                    //         child: InkWell(
                    //           child: Container(
                    //             margin: EdgeInsets.only(right: 5),
                    //             alignment: Alignment.center,
                    //             height: BaseUtitiles.getheightofPercentage(context, 4),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(0),
                    //               color: Theme.of(context).primaryColor,
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                     offset: Offset(0, 10),
                    //                     blurRadius: 50,
                    //                     color: Color(0xffEEEEEE)
                    //                 ),
                    //               ],
                    //             ),
                    //             child: Icon(Icons.edit, color: Colors.white),
                    //           ),
                    //           onTap: (){
                    //             if (commonVoucherController.AccountTypename.text ==
                    //                 "OTHERS" ||
                    //                 commonVoucherController.AccountTypename.text ==
                    //                     "SITE-OTHERS" ||
                    //                 commonVoucherController.AccountTypename.text ==
                    //                     "MATERIAL") {
                    //               if (commonVoucherController.Accountname.text ==
                    //                   "--Select--" ||
                    //                   commonVoucherController.Accountname.text ==
                    //                       "--SELECT--") {
                    //                 BaseUtitiles.showToast("You are Not Authorised");
                    //               } else {
                    //                 showDialog(
                    //                     context: context,
                    //                     builder: (BuildContext context) {
                    //                       return AccountnameAddAlert();
                    //                     });
                    //               }
                    //             } else {
                    //             }
                    //           },
                    //         ),
                    //       ),
                    //       Expanded(
                    //         flex: 1,
                    //         child: InkWell(
                    //           child: Container(
                    //             margin: EdgeInsets.only(right: 5),
                    //             alignment: Alignment.center,
                    //             height: BaseUtitiles.getheightofPercentage(context, 4),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(0),
                    //               color: Theme.of(context).primaryColor,
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                     offset: Offset(0, 10),
                    //                     blurRadius: 50,
                    //                     color: Color(0xffEEEEEE)
                    //                 ),
                    //               ],
                    //             ),
                    //             child: Icon(Icons.delete_forever, color: Colors.white),
                    //           ),
                    //           onTap: (){
                    //             if(commonVoucherController.AccountTypename.text ==
                    //                 "OTHERS" ||
                    //                 commonVoucherController.AccountTypename.text ==
                    //                     "SITE-OTHERS" ||
                    //                 commonVoucherController.AccountTypename.text ==
                    //                     "MATERIAL"){
                    //               if(commonVoucherController.Accountname.text ==
                    //                   "--Select--" ||
                    //                   commonVoucherController.Accountname.text ==
                    //                       "--SELECT--"){
                    //
                    //               }
                    //               else{
                    //                 commonVoucherController.Accountname_DeleteApi(commonVoucherController.selectedAccId.value, commonVoucherController.selectedAccnameId.value);
                    //               }
                    //
                    //             }
                    //             else{
                    //
                    //             }
                    //           },
                    //         ),
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       margin: EdgeInsets.only(top: 15),
                    //       alignment: Alignment.center,
                    //       height: BaseUtitiles.getheightofPercentage(context, 3),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(5),
                    //         color: Theme.of(context).primaryColor,
                    //         boxShadow: [
                    //           BoxShadow(
                    //               offset: Offset(0, 10),
                    //               blurRadius: 50,
                    //               color: Color(0xffEEEEEE)),
                    //         ],
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(5),
                    //         child: Text(
                    //           "Payment Options",
                    //           style: TextStyle(
                    //               fontSize: RequestConstant.ALERT_Font_SIZE,
                    //               color: Colors.white),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // // Container(
                    // //   margin: EdgeInsets.only(top: 10),
                    // //   alignment: Alignment.center,
                    // //   height: BaseUtitiles.getheightofPercentage(context, 3),
                    // //   decoration: BoxDecoration(
                    // //     borderRadius: BorderRadius.circular(5),
                    // //     color: Theme.of(context).primaryColor,
                    // //     boxShadow: [
                    // //       BoxShadow(
                    // //           offset: Offset(0, 10),
                    // //           blurRadius: 50,
                    // //           color: Color(0xffEEEEEE)
                    // //       ),
                    // //     ],
                    // //   ),
                    // //   child: Text("Payment Options",style: TextStyle(fontSize: 10),),
                    // // ),

                    Container(
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
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly:
                            advanceReqVoucherController_new.editcheck == 1
                                ? true
                                : commonVoucherController
                                .VoucherTypeController.text ==
                                "Site Petty Cash"
                                ? true
                                : false,
                            controller: commonVoucherController.namethrough,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Name Through",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.namethrough),
                            ),
                            onTap: () {
                              if (commonVoucherController
                                  .VoucherTypeController.text ==
                                  "Site Petty Cash") {
                                Fluttertoast.showToast(
                                    msg:
                                    "Voc type is site petty cash so can't access");
                              }
                            },
                            validator: (value) {
                              if (commonVoucherController
                                  .VoucherTypeController.text !=
                                  "Site Petty Cash") {
                                if (value!.isEmpty ||
                                    value == "--Select--" ||
                                    value == "--SELECT--") {
                                  return '\u26A0 ${RequestConstant.VALIDATE}';
                                }
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
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
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller:
                            commonVoucherController.payforController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Pay For",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.payfor),
                            ),
                            // onTap: () async {
                            //   if(advanceReqVoucherController_new.editcheck==1){
                            //
                            //   }else{
                            //     showDialog(
                            //         context: context,
                            //         builder: (BuildContext context) {
                            //           return Payfor_Alert();
                            //         });
                            //   }
                            //   // await commonVoucherController.getPayforList(context);
                            //   // bottomsheetControllers.Payfor(
                            //   //     context,
                            //   //     commonVoucherController
                            //   //         .getPayfordropDownvalue.value);
                            // },
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value == "--Select--" ||
                                  value == "--SELECT--") {
                                return '\u26A0 ${RequestConstant.VALIDATE}';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //     margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        //     child: Card(
                        //       shape: RoundedRectangleBorder(
                        //         side: BorderSide(color: Colors.white70, width: 1),
                        //         borderRadius: BorderRadius.circular(15),
                        //       ),
                        //       elevation: 3,
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(
                        //             top: 3, left: 10, bottom: 5),
                        //         child: TextFormField(
                        //           readOnly: true,
                        //           controller: commonVoucherController.Paymodename,
                        //           cursorColor: Colors.black,
                        //           style: TextStyle(color: Colors.black),
                        //           decoration: InputDecoration(
                        //             contentPadding: EdgeInsets.zero,
                        //             border: InputBorder.none,
                        //             labelText: "Mode of Pay",
                        //             labelStyle: TextStyle(
                        //                 color: Colors.grey,
                        //                 fontSize: RequestConstant.Lable_Font_SIZE),
                        //             prefixIconConstraints:
                        //                 BoxConstraints(minWidth: 0, minHeight: 0),
                        //             prefixIcon: Padding(
                        //                 padding: EdgeInsets.symmetric(
                        //                     vertical: 8, horizontal: 8),
                        //                 child: ConstIcons.modeofpay),
                        //           ),
                        //           onTap: () async {
                        //             if(advanceReqVoucherController_new.editcheck==1){
                        //
                        //             }else{
                        //               await commonVoucherController.getPaymodeList(context);
                        //               setState(() {
                        //                 bottomsheetControllers.ModeofPay(
                        //                     context,
                        //                     commonVoucherController
                        //                         .getpaymodedropDownvalue.value);
                        //               });
                        //             }
                        //           },
                        //           validator: (value) {
                        //             if (value!.isEmpty) {
                        //               return '\u26A0 Enter user name';
                        //             }
                        //             return null;
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin:
                            EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  readOnly: commonVoucherController
                                      .VoucherTypeController.text ==
                                      "Site Petty Cash"
                                      ? false
                                      : true,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  controller: advanceReqVoucherController_new
                                      .entry_amount,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Amount",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                        RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.amount),
                                  ),
                                  validator: (value) {
                                    if ((value!.isEmpty || value == '0.0') &&
                                        commonVoucherController
                                            .VoucherTypeController.text ==
                                            "Site Petty Cash") {
                                      return '\u26A0 ${RequestConstant.VALIDATE}';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    if (commonVoucherController
                                        .VoucherTypeController.text ==
                                        "Site Petty Cash") {
                                      advanceReqVoucherController_new
                                          .entry_amount.text ==
                                          "0.0"
                                          ? advanceReqVoucherController_new
                                          .entry_amount.text = ""
                                          : advanceReqVoucherController_new
                                          .entry_amount.text;
                                    }
                                  },
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
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller: advanceReqVoucherController_new
                                .remarksController,
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
                                  child: ConstIcons.remarks),
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

                    SizedBox(height: 5),

                    Obx(() => Visibility(
                      visible: commonVoucherController.VocType.value == "A",
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Setmybackground,
                        ),
                        onPressed: () async {
                          if (advanceReqVoucherController_new.editcheck == 1) {
                          }
                          else {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (commonVoucherController
                                  .VoucherTypeController.text ==
                                  "Site Petty Cash") {
                                Fluttertoast.showToast(
                                    msg:
                                    "Voc type is site petty cash so can't access");
                              } else if (projectController
                                  .selectedProjectId.value ==
                                  0) {
                                BaseUtitiles.showToast(
                                    "Please select Project Name");
                              } else {
                                if (commonVoucherController.selectedAccTypeId.value == 4) {
                                  await advanceReqVoucherController_new.delete_ListTable();
                                  await advanceReqVoucherController_new.getAdvList();
                                  await advanceReqVoucherController_new.saveListTable();
                                  await advanceReqVoucherController_new.getTableListDatas();
                                  setState(() {
                                    for (final controller in advanceReqVoucherController_new.amount_ListControllers) {
                                      final parsed = double.tryParse(controller.text) ?? 0;
                                      advanceReqVoucherController_new.reduceAmount(parsed);
                                    }
                                  });
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            advance_sitewisepayment_new()),
                                  );
                                }
                              }
                            }
                          }
                        },
                        child: Obx(() => Text(
                          advanceReqVoucherController_new
                              .listButton.value,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    )),

                    SizedBox(
                        height:
                        BaseUtitiles.getheightofPercentage(context, 35)),
                  ],
                ),
              ),
              Obx(() => commonVoucherController.VocType.value == "A" && commonVoucherController.selectedAccTypeId.value == 5
                  ? Container(
                child: Visibility(
                  visible: advanceReqVoucherController_new
                      .ItemGetTableListdata.isEmpty
                      ? false
                      : true,
                  child: Container(
                    height:
                    BaseUtitiles.getheightofPercentage(context, 100),
                    child: DraggableScrollableSheet(
                      minChildSize: 0.1,
                      maxChildSize: 0.9,
                      initialChildSize: 0.3,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Setmybackground,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                  height:
                                  MediaQuery.of(context).size.height *
                                      0.9,
                                  width:
                                  MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        // SizedBox(height: 30),
                                        Container(
                                            margin:
                                            EdgeInsets.only(top: 10),
                                            child:
                                            ListDetails_SiteWiseList(
                                                context,
                                                scrollController)),
                                      ],
                                    ),
                                  )),
                              IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft:
                                      const Radius.circular(40.0),
                                      topRight:
                                      const Radius.circular(40.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        height: 5,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
                  : Container(
                child: Visibility(
                  visible:
                  advanceReqVoucherController_new.GetTableList.isEmpty
                      ? false
                      : true,
                  child: Container(
                    height:
                    BaseUtitiles.getheightofPercentage(context, 95),
                    child: DraggableScrollableSheet(
                      minChildSize: 0.1,
                      maxChildSize: 0.9,
                      initialChildSize: 0.3,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Setmybackground,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                  height:
                                  MediaQuery.of(context).size.height *
                                      1,
                                  width:
                                  MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        Container(
                                            margin:
                                            EdgeInsets.only(top: 10),
                                            child: ListDetails(context,
                                                scrollController)),
                                      ],
                                    ),
                                  )),
                              IgnorePointer(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        height: 5,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )),
            ],
          ),
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: advanceReqVoucherController_new.checkColor == 0
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color:
                            advanceReqVoucherController_new.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        advanceReqVoucherController_new.checkColor = 1;
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
                          color: advanceReqVoucherController_new.checkColor == 0
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                          advanceReqVoucherController_new.saveButton.value,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: advanceReqVoucherController_new
                                  .checkColor ==
                                  0
                                  ? Colors.white
                                  : Theme.of(context).primaryColor),
                        ))),
                    onTap: () async {
                      advanceReqVoucherController_new.checkColor = 0;
                      // int i = 0;
                      // advanceReqVoucherController_new.GetTableList.value.forEach((element){
                      //   if(advanceReqVoucherController_new.amount_ListControllers[i].value.text == "0.0" || advanceReqVoucherController_new.amount_ListControllers[i].value.text == "0" || advanceReqVoucherController_new.amount_ListControllers[i].value.text == ""){
                      //     advanceReqVoucherController_new.entry_amount.text = advanceReqVoucherController_new.amount_ListControllers[i].value.text;
                      //   }
                      //   i++;
                      // });

                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (commonVoucherController
                            .VoucherTypeController.text !=
                            "Site Petty Cash" &&
                            (advanceReqVoucherController_new
                                .entry_amount.text ==
                                '0.0' ||
                                advanceReqVoucherController_new
                                    .entry_amount.text ==
                                    '0' ||
                                advanceReqVoucherController_new
                                    .entry_amount.text ==
                                    '0.00')) {
                          BaseUtitiles.showToast("Can not allow 0 amount");
                        } else {
                          await SubmitAlert(context);
                        }
                      }
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
                          advanceReqVoucherController_new.vocId = 0;
                          advanceReqVoucherController_new.entryDateController
                              .text = BaseUtitiles.initiateCurrentDateFormat();
                          commonVoucherController.VoucherTypeController.text =
                          "--SELECT--";
                          commonVoucherController.VocType.value = "S";
                          projectController.projectname.text =
                              RequestConstant.SELECT;
                          projectController.selectedProjectId.value = 0;
                          commonVoucherController.AccountTypename.text =
                              RequestConstant.SELECT;
                          commonVoucherController.Accountname.text =
                              RequestConstant.SELECT;
                          commonVoucherController.selectedAccnameId.value = 0;
                          // commonVoucherController.payforController.text = RequestConstant.SELECT;
                          // commonVoucherController.Paymodename.text = RequestConstant.SELECT;
                          commonVoucherController.namethrough.text = "";
                          advanceReqVoucherController_new
                              .remarksController.text = "";
                          advanceReqVoucherController_new.radioType.value =
                          "SiteWise Payment";
                          advanceReqVoucherController_new.entry_amount.text =
                          "0.0";
                          await advanceReqVoucherController_new
                              .delete_ListTable();
                          await advanceReqVoucherController_new
                              .itemlistTable_Delete();
                          setState(() {
                            advanceReqVoucherController_new.GetTableList.value
                                .clear();
                            advanceReqVoucherController_new.getDetList_Advance
                                .clear();
                          });
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

  Future SubmitAlert(BuildContext context) async {
    advanceReqVoucherController_new.buttonControl = 0;
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(advanceReqVoucherController_new.editcheck == 1
            ? 'Are you sure to Re-Submit?'
            : 'Are you sure to submit?'),
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

                  // Expanded(
                  //   child: TextButton(
                  //       onPressed: () async {
                  //         // BaseUtitiles.showLoadingDialog(context, Theme.of(context).primaryColor);
                  //         if(advanceReqVoucherController_new.buttonControl == 0){
                  //           if(commonVoucherController.payfor.value=="A"){
                  //             await advanceReqVoucherController_new.getTableListDatas();
                  //
                  //           }else{
                  //             await advanceReqVoucherController_new.getItemlistTablesDatas();
                  //           }
                  //           await advanceReqVoucherController_new.SaveApi_ItemlistScreen(context, advanceReqVoucherController_new.vocId);
                  //         }
                  //         else if(  advanceReqVoucherController_new.buttonControl==1){
                  //           advanceReqVoucherController_new.buttonControl==0;
                  //           BaseUtitiles.showToast("Please wait... processing.");
                  //         }
                  //       },
                  //       child:
                  //       Text(
                  //           advanceReqVoucherController_new.saveButton.value,
                  //           style: TextStyle(
                  //               color: Theme.of(context).primaryColor,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: RequestConstant.Lable_Font_SIZE))),
                  // )

                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                        onPressed: () async {
                          if (commonVoucherController.VocType.value == "A" &&
                              commonVoucherController.selectedAccTypeId.value ==
                                  4) {
                            await advanceReqVoucherController_new
                                .getTableListDatas();
                          } else {
                            await advanceReqVoucherController_new
                                .getItemlistTablesDatas();
                          }
                          if (await BaseUtitiles.checkNetworkAndShowLoader(
                              context)) {
                            await advanceReqVoucherController_new
                                .SaveApi_ItemlistScreen(context,
                                advanceReqVoucherController_new.vocId);
                          }
                        },
                        child: Text(
                          advanceReqVoucherController_new.saveButton.value,
                          style: TextStyle(
                            color:
                            advanceReqVoucherController_new.buttonControl ==
                                0
                                ? Theme.of(context).primaryColor
                                : Colors.grey, // Change color when disabled
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

  Widget ListDetails_SiteWiseList(
      BuildContext context, ScrollController scrollController) {
    return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5)),
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: Obx(() => ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: ScrollPhysics(),
                itemCount: advanceReqVoucherController_new
                    .ItemGetTableListdata.length,
                itemBuilder: (BuildContext context, int index) {
                  advanceReqVoucherController_new
                      .itemlist_textControllersInitiate();
                  return Container(
                    margin: EdgeInsets.only(
                        left: 5, right: 5, bottom: 10, top: 10),
                    child: Column(
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 4, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        advanceReqVoucherController_new
                                            .ItemGetTableListdata[index]
                                            .siteName
                                            .toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: Container(
                                          height: BaseUtitiles
                                              .getheightofPercentage(
                                              context, 2),
                                          width: BaseUtitiles
                                              .getWidthtofPercentage(
                                              context, 8),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: Text(RequestConstant
                                                          .DO_YOU_WANT_DELETE),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                            child: Text(
                                                                RequestConstant
                                                                    .NO),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        ElevatedButton(
                                                            child: Text(
                                                                RequestConstant
                                                                    .YES),
                                                            onPressed: () {
                                                              advanceReqVoucherController_new.reduceAmount(
                                                                  advanceReqVoucherController_new
                                                                      .ItemGetTableListdata
                                                                      .value[
                                                                  index]
                                                                      .netAmount);
                                                              advanceReqVoucherController_new
                                                                  .deleteParticularList(
                                                                  advanceReqVoucherController_new
                                                                      .ItemGetTableListdata
                                                                      .value[index]);
                                                              advanceReqVoucherController_new
                                                                  .ItemGetTableListdata
                                                                  .remove(advanceReqVoucherController_new
                                                                  .ItemGetTableListdata[
                                                              index]);
                                                              advanceReqVoucherController_new
                                                                  .getItemlistTablesDatas();
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                      ],
                                                    ),
                                              );
                                            },
                                            child: Image.asset(
                                                'assets/cancle.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                          "Payment Type",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    Expanded(
                                        child: Text(
                                          "Advance",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                          "Amount",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    Expanded(
                                        child: Text(
                                          advanceReqVoucherController_new
                                              .ItemGetTableListdata[index]
                                              .amount
                                              .toString(),
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                  ],
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(
                              //       left: 10, right: 10, bottom: 5, top: 5),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceAround,
                              //     children: <Widget>[
                              //       Expanded(
                              //           child: Text(
                              //         "Net Amount",
                              //         style: TextStyle(color: Colors.black),
                              //       )),
                              //       Expanded(
                              //           child: Text(
                              //         advanceReqVoucherController_new
                              //             .ItemGetTableListdata[index]
                              //             .netAmount
                              //             .toString(),
                              //         style: TextStyle(color: Colors.black),
                              //       )),
                              //       //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
            ),
          ],
        ));
  }

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5)),
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: Obx(() => ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount:
                advanceReqVoucherController_new.GetTableList.length,
                itemBuilder: (BuildContext context, int index) {
                  advanceReqVoucherController_new
                      .TableList_textControllersInitiate();
                  return Container(
                    margin: EdgeInsets.only(
                        left: 5, right: 5, bottom: 10, top: 10),
                    child: Column(
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 4, top: 3),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        advanceReqVoucherController_new
                                            .GetTableList
                                            .value[index]
                                            .orderNo
                                            .toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: Container(
                                          height: BaseUtitiles
                                              .getheightofPercentage(
                                              context, 2),
                                          width: BaseUtitiles
                                              .getWidthtofPercentage(
                                              context, 8),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: Text(RequestConstant
                                                          .DO_YOU_WANT_DELETE),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                            child: Text(
                                                                RequestConstant
                                                                    .NO),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        ElevatedButton(
                                                            child: Text(
                                                                RequestConstant
                                                                    .YES),
                                                            onPressed:
                                                                () async {
                                                              advanceReqVoucherController_new.reduceAmount(double.tryParse(
                                                                  advanceReqVoucherController_new
                                                                      .amount_ListControllers[
                                                                  index]
                                                                      .text)!);
                                                              advanceReqVoucherController_new
                                                                  .deleteParticularTableList(
                                                                  advanceReqVoucherController_new
                                                                      .GetTableList
                                                                      .value[index]);
                                                              advanceReqVoucherController_new
                                                                  .GetTableList
                                                                  .remove(advanceReqVoucherController_new
                                                                  .GetTableList[
                                                              index]);
                                                              advanceReqVoucherController_new
                                                                  .getTableListDatas();
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                      ],
                                                    ),
                                              );
                                            },
                                            child: Image.asset(
                                                'assets/cancle.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                          advanceReqVoucherController_new
                                              .GetTableList
                                              .value[index]
                                              .siteName
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),

                                    //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                          commonVoucherController
                                              .selectedAccTypeId.value ==
                                              4
                                              ? "PO Amt"
                                              : commonVoucherController
                                              .selectedAccTypeId
                                              .value ==
                                              5
                                              ? "Amt Bal in WO"
                                              : "NetAmt", //---------(5 means SUBCONTRACTOR, 4 means SUPPLIER)
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    Expanded(
                                        child: Text(
                                          advanceReqVoucherController_new
                                              .GetTableList.value[index].dprAmt
                                              .toString(),
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                          "Adv Amt",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    Expanded(
                                        child: Text(
                                          advanceReqVoucherController_new
                                              .GetTableList
                                              .value[index]
                                              .advanceAmt
                                              .toString(),
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                          "Bal Amt",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    Expanded(
                                        child: Text(
                                          advanceReqVoucherController_new
                                              .GetTableList.value[index].bAmount
                                              .toString(),
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                                  ],
                                ),
                              ),

                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Amount",
                                          style: TextStyle(
                                              color: Colors.black),
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 5, right: 30, bottom: 5),
                                      height: BaseUtitiles
                                          .getheightofPercentage(
                                          context, 3),
                                      width: BaseUtitiles
                                          .getWidthtofPercentage(
                                          context, 40),
                                      child: TextField(
                                        cursorColor:
                                        Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller:
                                        advanceReqVoucherController_new
                                            .amount_ListControllers[
                                        index],
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.fromLTRB(
                                              5.0, 0.0, 5.0, 0.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(5))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                        style:
                                        TextStyle(color: Colors.black),
                                        onChanged: (value) async {
                                          await advanceReqVoucherController_new
                                              .AmtItemlist_clickEdit();
                                          await advanceReqVoucherController_new
                                              .updateConsumTables();
                                          await advanceReqVoucherController_new
                                              .netamountCalculation();
                                        },
                                        onTap: () {
                                          advanceReqVoucherController_new
                                              .amount_ListControllers[
                                          index]
                                              .text ==
                                              "0.0"
                                              ? advanceReqVoucherController_new
                                              .amount_ListControllers[
                                          index]
                                              .text = ""
                                              : advanceReqVoucherController_new
                                              .amount_ListControllers[
                                          index]
                                              .text;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Container(
                              //   margin: EdgeInsets.only(
                              //       left: 10, right: 10, bottom: 5, top: 5),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceAround,
                              //     children: <Widget>[
                              //       Expanded(
                              //           child: Text(
                              //         "Amt",
                              //         style: TextStyle(color: Colors.black),
                              //       )),
                              //       Expanded(
                              //           child: Text(
                              //         advanceReqVoucherController_new.GetTableList[index].Amount.toString(),
                              //         style: TextStyle(color: Colors.black),
                              //       )),
                              //       //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
            ),
          ],
        ));
  }
}
