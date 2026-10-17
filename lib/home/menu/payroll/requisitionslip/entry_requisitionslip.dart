import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/worktype_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/reports_controller.dart';
import '../../../../controller/requisitionslip_controller_new.dart';
import '../../../../controller/staffcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/common_date_fields.dart';
import '../../../../utilities/requestconstant.dart';

class RequisitionSlip_Entry extends StatefulWidget {
  final String heading;
  const RequisitionSlip_Entry({super.key,required this.heading});

  @override
  State<RequisitionSlip_Entry> createState() => _RequisitionSlip_EntryState();
}

class _RequisitionSlip_EntryState extends State<RequisitionSlip_Entry> {

  final RequisitionSlipControllerNew requisitionSlipController = Get.put(RequisitionSlipControllerNew());
  StaffController staffController = Get.put(StaffController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  LoginController loginController = Get.put(LoginController());
  AutoYearWiseNoController autoYearWiseNoController=Get.put(AutoYearWiseNoController());
  ReportsController reportsController = Get.put(ReportsController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await requisitionSlipController.getStaffReqTypeList();
      if(requisitionSlipController.saveButton.value==RequestConstant.SUBMIT){
        requisitionSlipController.reqId=0;
        requisitionSlipController.Reqdate.text = BaseUtitiles.initiateCurrentDateFormat();
        if(loginController.user.value.userType == "A"){
          staffController.selectedstaffId.value = 0;
          staffController.Staffname.text = "--SELECT--";
        }
        else{
          staffController.selectedstaffId.value = loginController.user.value.empId!;
          staffController.Staffname.text = loginController.user.value.empName!;
        }
        reportsController.projectname.text  = "--SELECT--";
        reportsController.selectedProjectId.value = 0;
        requisitionSlipController.createdById.value = 0;
        requisitionSlipController.LeaveReason.text = "";
        requisitionSlipController.Reason.text = "";
        requisitionSlipController.Fromdate.text = BaseUtitiles.initiateCurrentDateFormat();
        requisitionSlipController.Todate.text = BaseUtitiles.initiateCurrentDateFormat();
        requisitionSlipController.Totaldays.text = "1";
        requisitionSlipController.totalLeaveValue.value = "1";
        requisitionSlipController.Date.text = BaseUtitiles.initiateCurrentDateFormat();
        requisitionSlipController.Fromtime.text = "00:00";
        requisitionSlipController.Totime.text = "00:00";
        requisitionSlipController.RequiredHrs.text = "0";
        requisitionSlipController.RequiredMins.text = "0";
        requisitionSlipController.TotalHrs.text = "0.0";
        requisitionSlipController.yearofLeavedays.value="0";
        requisitionSlipController.leaveTypeText.text="--SELECT--";
        requisitionSlipController.leaveTypeValue.value="-";
        await autoYearWiseNoController.AutoYearWiseNo("REQ SLIP");
        requisitionSlipController.ReqAutoyearwise.text = autoYearWiseNoController.RequisitionSlip_autoYrsWise.value;
        requisitionSlipController.type.value = "L";
        requisitionSlipController.isHalfDay.value=false;
      }

      else if(requisitionSlipController.saveButton.value==RequestConstant.RESUBMIT){
        for (var element in requisitionSlipController.ReqSlipEditList) {
          requisitionSlipController.reqId=element.id;
          requisitionSlipController.ReqAutoyearwise.text=element.requisitionNo;
          requisitionSlipController.Reqdate.text=element.entryDate;
          staffController.selectedstaffId.value =element.staffId;
          staffController.Staffname.text = element.staffName;
          reportsController.projectname.text= element.projectName;
          reportsController.selectedProjectId.value = element.projectId;
          requisitionSlipController.type.value=element.requisitionType.toString();
          requisitionSlipController.Fromdate.text=element.leaveFromDate;
          requisitionSlipController.Todate.text=element.leaveToDate;
          requisitionSlipController.Reason.text=element.permissionReason;
          requisitionSlipController.LeaveReason.text = element.leaveReason;
          requisitionSlipController.Date.text = element.permissionFromDate;
          requisitionSlipController.createdById.value = element.createdBy;
          requisitionSlipController.Totaldays.text = element.totalLeaveDays.toString();
          requisitionSlipController.totalLeaveValue.value = (element.totalLeaveDays ?? 0.0) == 1.0
              ? "1"
              : (element.totalLeaveDays ?? 0.0).toString();
          requisitionSlipController.Fromtime.text = element.permissionFromTime;
          requisitionSlipController.Totime.text = element.permissionToTime;
          requisitionSlipController.TotalHrs.text=element.totalPermissionHours.toStringAsFixed(2);
          requisitionSlipController.yearofLeavedays.value="0";
          requisitionSlipController.leaveTypeText.text=element.leaveTypeDesc;
          requisitionSlipController.leaveTypeValue.value=element.leaveType;
          requisitionSlipController.isHalfDay.value=element.isHalfDay;
        }
      }

      if (!mounted) return;

      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: Setmybackground,
            body: Stack(children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5)),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Expanded(
                             child: Text(
                             widget.heading,
                              style: TextStyle(
                                  fontSize: RequestConstant.Heading_Font_SIZE,
                                  fontWeight: FontWeight.bold),
                                                       ),
                           ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Back",
                              style: TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: requisitionSlipController.ReqAutoyearwise,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Request No",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: ConstIcons.requestNo),
                            ),
                          ),
                        ),
                      ),
                    ),
                    CommonDateFields(
                      date1: CommonDateFieldConfig(
                        title: "Request Date",
                        value: requisitionSlipController.Reqdate.text,
                        controller: requisitionSlipController.Reqdate,
                        selectable: loginController.user.value.userType != "S",
                        initialDate: DateTime.tryParse(
                          requisitionSlipController.Reqdate.text,
                        ) ??
                            DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        onChanged: (date) {
                          setState(() {
                            requisitionSlipController.Reqdate.text =
                                CommonDateUtils.formatApiDate(date);
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            readOnly: true,
                            controller: staffController.Staffname,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Staff Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: ConstIcons.projectName),
                            ),
                            onTap: () async {
                              if( requisitionSlipController.saveButton.value==RequestConstant.RESUBMIT){

                              } else if(loginController.user.value.userType == "A"){
                                await staffController.get_staffDropdowntList(context, "");
                                await bottomsheetControllers.StaffName(context, staffController.getStaffDropdownvalue.value);
                                }
                                FocusScope.of(context).unfocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty || value=="--SELECT--") {
                                return '\u26A0 Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            autovalidateMode: AutovalidateMode.always,
                            controller: reportsController.projectname,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Location",
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
                            onTap: () async {
                              await reportsController.getReportProjectList();
                              bottomsheetControllers.projectNameReport(context, reportsController.getProjectdropDownvalue.value);
                            },
                            validator: (value) {
                              if (value=="--SELECT--"|| value=="SELECT") {
                                return '\u26A0 Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1)),

                    Obx(() =>
                        requisitionSlipController.staffReqTypeList.value.isEmpty?const SizedBox():Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Divider(
                                thickness: 2,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemCount:
                              requisitionSlipController.staffReqTypeList.value.length,

                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 items per row
                                childAspectRatio: 3.5,
                              ),

                              itemBuilder: (context, index) {
                              final item = requisitionSlipController.staffReqTypeList.value[index];

                              return Row(
                                children: [

                                  Expanded(
                                    child: Obx(()=>
                                      Radio<String>(
                                        activeColor: Theme.of(context).primaryColor,
                                        value: item.requisitionTypeValue.toString(),
                                        groupValue: requisitionSlipController.type.value.toString(),
                                        onChanged: (value) {
                                          requisitionSlipController.type.value = value!;
                                          requisitionSlipController.Reason.clear();
                                          requisitionSlipController.LeaveReason.clear();
                                          requisitionSlipController.Fromtime.text = "00:00";
                                          requisitionSlipController.pFromtime.text = "00:00";
                                          requisitionSlipController.Totime.text = "00:00";
                                          requisitionSlipController.pTotime.text = "00:00";
                                          requisitionSlipController.TotalHrs.text = "0.0";
                                          requisitionSlipController.Totaldays.text = "1";
                                          requisitionSlipController.totalLeaveValue.value = "1";
                                          requisitionSlipController.RequiredHrs.text = "0";
                                          requisitionSlipController.RequiredMins.text = "0";
                                          requisitionSlipController.Fromdate.text =
                                              BaseUtitiles.initiateCurrentDateFormat();
                                          requisitionSlipController.Todate.text =
                                              BaseUtitiles.initiateCurrentDateFormat();
                                          requisitionSlipController.leaveTypeText.text="--SELECT--";
                                          requisitionSlipController.leaveTypeValue.value="-";
                                          requisitionSlipController.isHalfDay.value=false;
                                          },
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 3,
                                    child: Text(item.requisitionType.toString()),
                                  ),
                                ],
                              );
                            },
                                                  ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Divider(
                                thickness: 2,
                                color: Theme.of(context).primaryColor,
                              ),),

                          ],
                        ),
                    ),


                    Obx(() => Visibility(
                      visible: requisitionSlipController.type.value=="L"?true:false,
                      child: Column(
                        children: <Widget>[

                          Container(
                            margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1), borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: false,
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: requisitionSlipController.LeaveReason,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Reason",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        child: ConstIcons.remarks),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  readOnly: true,
                                  controller: requisitionSlipController.leaveTypeText,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Leave Type",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        child: ConstIcons.projectName),
                                  ),
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const LeaveTypeAlert();
                                        });
                                    FocusScope.of(context).unfocus();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty || value=="--SELECT--") {
                                      return '\u26A0 Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),

                          CommonDateFields(
                            date1: CommonDateFieldConfig(
                              title: "From Date",
                              value: requisitionSlipController.Fromdate.text,
                              controller: requisitionSlipController.Fromdate,
                              selectable: true,

                              initialDate: DateTime.tryParse(
                                  requisitionSlipController.Fromdate.text) ??
                                  DateTime.now(),

                              firstDate: loginController.user.value.userType == "A"
                                  ? DateTime(2000)
                                  : DateTime.now().subtract(const Duration(days: 4)),

                              lastDate: DateTime(2100),

                              onChanged: (date) {
                                requisitionSlipController.Fromdate.text =
                                    CommonDateUtils.formatApiDate(date);

                                requisitionSlipController.vehicleAge(
                                  date,
                                  CommonDateUtils.parseApiDate(
                                    requisitionSlipController.Todate.text,
                                  ),
                                );

                                setState(() {
                                  requisitionSlipController.isHalfDay.value = false;
                                });
                              },
                            ),

                            date2: CommonDateFieldConfig(
                              title: "To Date",
                              controller: requisitionSlipController.Todate,
                              value:  requisitionSlipController.Todate.text,
                              selectable: true,
                              initialDate: CommonDateUtils.parseApiDate(
                                requisitionSlipController.Todate.text,
                              ),

                              firstDate: CommonDateUtils.parseApiDate(
                                requisitionSlipController.Fromdate.text,
                              ),
                              lastDate: DateTime(2100),
                              onChanged: (date) {
                                requisitionSlipController.Todate.text =
                                    CommonDateUtils.formatApiDate(date);

                                requisitionSlipController.vehicleAge(
                                  CommonDateUtils.parseApiDate(
                                    requisitionSlipController.Fromdate.text,
                                  ),
                                  date,
                                );
                                setState(() {
                                  requisitionSlipController.isHalfDay.value = false;
                                });
                              },
                            ),
                          ),

                          Row(
                            children: [
                              Expanded(flex: 2,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 2, left: 10),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                      child: TextFormField(
                                        readOnly: true,
                                        autovalidateMode: AutovalidateMode.always,
                                        controller: requisitionSlipController.Totaldays,
                                        cursorColor: Colors.black,
                                        style: const TextStyle(color: Colors.black),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none,
                                          labelText: "Total Days",
                                          labelStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: RequestConstant.Lable_Font_SIZE),
                                          prefixIconConstraints:
                                          BoxConstraints(minWidth: 0, minHeight: 0),
                                          prefixIcon: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                              child: Icon(Icons.format_list_numbered_rounded, color: ConstIcons.IconColor),
                                        ),
                                      ),
                                        onTap: (){
                                          setState(() {
                                            requisitionSlipController.Totaldays.text == "0" ? requisitionSlipController.Totaldays.text = "" : requisitionSlipController.Totaldays.text;
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return '\u26A0 Required';
                                          }
                                          return null;
                                        },
                                    ),
                                  ),
                                ),
                                ),
                              ),
            Expanded(flex: 1,
              child: Row(
                children: [
                  Obx((){
                    return Checkbox(
                      value: requisitionSlipController.isHalfDay.value,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: requisitionSlipController.totalLeaveValue.value!="1" && requisitionSlipController.totalLeaveValue.value!="0.5"?Colors.grey:Theme.of(context).primaryColor,
                      ),
                      activeColor: requisitionSlipController.totalLeaveValue.value!="1" && requisitionSlipController.totalLeaveValue.value!="0.5"?Colors.grey:Theme.of(context).primaryColor,
                      checkColor: Colors.white,
                      onChanged: (bool? value) {
                        setState(() {
                          if(requisitionSlipController.totalLeaveValue.value=="1" ||requisitionSlipController.totalLeaveValue.value=="0.5") {
                            requisitionSlipController.isHalfDay.value = value ?? false;
                            if (requisitionSlipController.isHalfDay.value == true) {
                              requisitionSlipController.Totaldays.text = "0.5";
                            }
                            else {
                              requisitionSlipController.Totaldays.text = "1";
                            }
                          }
                        });
                      },
                    );},
                  ),
                  Text("Half Day", style:  TextStyle(fontWeight: FontWeight.bold,color: requisitionSlipController.totalLeaveValue.value!="1" && requisitionSlipController.totalLeaveValue.value!="0.5"?Colors.grey:Colors.black),),
                ],
              ),
            ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin:  EdgeInsets.only(left: 14, right: 14),
                                child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                          child: Text("Previous Leave Taken (This Year)", style:  TextStyle(fontWeight: FontWeight.bold),)),
                                      Expanded(
                                          child:
                                          Obx(() =>
                                              Text(requisitionSlipController.yearofLeavedays.value.toString(),style:  TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
                                          )
                                      )
                                    ],
                                )
                            ),
                          ),



                        ],
                      ),
                    )),

                    Obx(() => Visibility(
                      visible: requisitionSlipController.type.value=="C"?true:false,
                      child: Column(
                        children: <Widget>[

                          Container(
                            margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1), borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: false,
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: requisitionSlipController.LeaveReason,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Reason",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        child: ConstIcons.remarks),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  readOnly: true,
                                  controller: requisitionSlipController.leaveTypeText,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Leave Type",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        child: ConstIcons.projectName),
                                  ),
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const LeaveTypeAlert();
                                        });
                                    FocusScope.of(context).unfocus();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty || value=="--SELECT--") {
                                      return '\u26A0 Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),

                          CommonDateFields(
                            date1: CommonDateFieldConfig(
                              title: "From Date",
                              value: requisitionSlipController.Fromdate.text,
                              controller: requisitionSlipController.Fromdate,
                              selectable: true,

                              initialDate: DateTime.tryParse(
                                  requisitionSlipController.Fromdate.text) ??
                                  DateTime.now(),

                              firstDate: loginController.user.value.userType == "A"
                                  ? DateTime(2000)
                                  : DateTime.now().subtract(const Duration(days: 4)),

                              lastDate: DateTime(2100),

                              onChanged: (date) {
                                requisitionSlipController.Fromdate.text =
                                    CommonDateUtils.formatApiDate(date);

                                requisitionSlipController.vehicleAge(
                                  date,
                                  CommonDateUtils.parseApiDate(
                                    requisitionSlipController.Todate.text,
                                  ),
                                );

                                setState(() {
                                  requisitionSlipController.isHalfDay.value = false;
                                });
                              },
                            ),

                            date2: CommonDateFieldConfig(
                              title: "To Date",
                              controller: requisitionSlipController.Todate,
                              value:  requisitionSlipController.Todate.text,
                              selectable: true,
                              initialDate: CommonDateUtils.parseApiDate(
                                requisitionSlipController.Todate.text,
                              ),

                              firstDate: CommonDateUtils.parseApiDate(
                                requisitionSlipController.Fromdate.text,
                              ),
                              lastDate: DateTime(2100),
                              onChanged: (date) {
                                requisitionSlipController.Todate.text =
                                    CommonDateUtils.formatApiDate(date);

                                requisitionSlipController.vehicleAge(
                                  CommonDateUtils.parseApiDate(
                                    requisitionSlipController.Fromdate.text,
                                  ),
                                  date,
                                );
                                setState(() {
                                  requisitionSlipController.isHalfDay.value = false;
                                });
                              },
                            ),
                          ),

                          Row(
                            children: [
                              Expanded(flex: 2,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 2, left: 10),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                      child: TextFormField(
                                        readOnly: true,
                                        autovalidateMode: AutovalidateMode.always,
                                        controller: requisitionSlipController.Totaldays,
                                        cursorColor: Colors.black,
                                        style: const TextStyle(color: Colors.black),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none,
                                          labelText: "Total Days",
                                          labelStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: RequestConstant.Lable_Font_SIZE),
                                          prefixIconConstraints:
                                          BoxConstraints(minWidth: 0, minHeight: 0),
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                            child: Icon(Icons.format_list_numbered_rounded, color: ConstIcons.IconColor),
                                          ),
                                        ),
                                        onTap: (){
                                          requisitionSlipController.Totaldays.text == "0" ? requisitionSlipController.Totaldays.text = "" : requisitionSlipController.Totaldays.text;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return '\u26A0 Required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(flex: 1,
                                child: Row(
                                  children: [
                                    Obx((){
                                      return Checkbox(
                                        value: requisitionSlipController.isHalfDay.value,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        side: BorderSide(
                                          width: 1,
                                          color: requisitionSlipController.Totaldays.text!="1" && requisitionSlipController.Totaldays.text!="0.5"?Colors.grey:Theme.of(context).primaryColor,
                                        ),
                                        activeColor: requisitionSlipController.Totaldays.text!="1" && requisitionSlipController.Totaldays.text!="0.5"?Colors.grey:Theme.of(context).primaryColor,
                                        checkColor: Colors.white,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if(requisitionSlipController.Totaldays.text=="1" ||requisitionSlipController.Totaldays.text=="0.5") {
                                              requisitionSlipController.isHalfDay.value = value ?? false;
                                              if (requisitionSlipController.isHalfDay.value == true) {
                                                requisitionSlipController.Totaldays.text = "0.5";
                                              }
                                              else {
                                                requisitionSlipController.Totaldays.text = "1";
                                              }
                                            }
                                          });
                                        },
                                      );},
                                    ),
                                    Text("Half Day", style:  TextStyle(fontWeight: FontWeight.bold,color: requisitionSlipController.Totaldays.text!="1" && requisitionSlipController.Totaldays.text!="0.5"?Colors.grey:Colors.black),),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    )),

                    Obx(() => Visibility(
                      visible: requisitionSlipController.type.value=="O"?true:false,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: false,
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: requisitionSlipController.Reason,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Reason",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        child: ConstIcons.remarks),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          CommonDateFields(
                            date1: CommonDateFieldConfig(
                              title: "Date",
                              value: requisitionSlipController.Date.text,
                              controller: requisitionSlipController.Date,
                              selectable: true,
                              initialDate: DateTime.tryParse(
                                  requisitionSlipController.Date.text) ??
                                  DateTime.now(),
                              firstDate: loginController.user.value.userType == "A"
                                  ? DateTime(2000)
                                  : DateTime.now().subtract(const Duration(days: 4)),
                              lastDate: DateTime(2100),
                              onChanged: (date) {
                                setState(() {
                                  requisitionSlipController.Date.text =
                                      CommonDateUtils.formatApiDate(date);
                                });
                              },
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(color: Colors.white70, width: 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                        child: TextFormField(
                                          readOnly: true,
                                          autovalidateMode: AutovalidateMode.always,
                                          controller: requisitionSlipController.Fromtime,
                                          cursorColor: Colors.black,
                                          style: const TextStyle(color: Colors.black),
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            labelText: "From Time",
                                            labelStyle: TextStyle(color: Colors.grey, fontSize: RequestConstant.Lable_Font_SIZE),
                                            prefixIconConstraints:
                                            BoxConstraints(minWidth: 0, minHeight: 0),
                                            prefixIcon: Padding(
                                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                child: Icon(Icons.timer_sharp, color: ConstIcons.IconColor)
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty || value=="00:00") {
                                              return '\u26A0 Required';
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            await requisitionSlipController.selectTime(context, requisitionSlipController.Fromtime);
                                            requisitionSlipController.calculateTimeDifference();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(color: Colors.white70, width: 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                        child: TextFormField(
                                          readOnly: true,
                                          autovalidateMode: AutovalidateMode.always,
                                          controller: requisitionSlipController.Totime,
                                          cursorColor: Colors.black,
                                          style: const TextStyle(color: Colors.black),
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            labelText: "To Time",
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: RequestConstant.Lable_Font_SIZE),
                                            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                            prefixIcon: Padding(
                                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                child: Icon(Icons.timer_sharp, color: ConstIcons.IconColor),
                                          ),
                                        ),
                                          validator: (value) {
                                            if (value!.isEmpty || value=="00:00") {
                                              return '\u26A0 Required';
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            await requisitionSlipController.selectTime(context, requisitionSlipController.Totime);
                                            requisitionSlipController.calculateTimeDifference();
                                          },
                                      ),
                                    ),
                                  ),
                                ),
                            ),
                            ]),
                          ),
                          Container(
                            child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.white70, width: 1),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        elevation: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                          child: TextFormField(
                                            readOnly: true,
                                            autovalidateMode: AutovalidateMode.always,
                                            controller: requisitionSlipController.RequiredHrs,
                                            cursorColor: Colors.black,
                                            style: const TextStyle(color: Colors.black),
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              labelText: "Required Hrs",
                                              labelStyle: TextStyle(color: Colors.grey, fontSize: RequestConstant.Lable_Font_SIZE),
                                              prefixIconConstraints:
                                              BoxConstraints(minWidth: 0, minHeight: 0),
                                              prefixIcon: Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                  child: Icon(Icons.timer_sharp, color: ConstIcons.IconColor)
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '\u26A0 Required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.white70, width: 1),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        elevation: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                          child: TextFormField(
                                            readOnly: true,
                                            autovalidateMode: AutovalidateMode.always,
                                            controller: requisitionSlipController.RequiredMins,
                                            cursorColor: Colors.black,
                                            style: const TextStyle(color: Colors.black),
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              labelText: "Required Mins",
                                              labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: RequestConstant.Lable_Font_SIZE),
                                              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                child: Icon(Icons.timer_sharp, color: ConstIcons.IconColor),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '\u26A0 Required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: true,
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: requisitionSlipController.TotalHrs,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Total Hours",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        child: Icon(Icons.access_time_filled_outlined, color: ConstIcons.IconColor)),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Required';
                                    }
                                    return null;
                                  },
                                  // onTap: (){
                                  //   requisitionSlipController.TotalHrs.text == '0.0' ? requisitionSlipController.TotalHrs.text = "" : requisitionSlipController.TotalHrs.text;
                                  // },
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    )),

                    Obx(() => Visibility(
                      visible: requisitionSlipController.type.value=="P"?true:false,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: false,
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: requisitionSlipController.Reason,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Reason",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        child: ConstIcons.remarks),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          CommonDateFields(
                            date1: CommonDateFieldConfig(
                              title: "Date",
                              value: requisitionSlipController.Date.text,
                              controller: requisitionSlipController.Date,
                              selectable: true,
                              initialDate: DateTime.tryParse(
                                  requisitionSlipController.Date.text) ??
                                  DateTime.now(),
                              firstDate: loginController.user.value.userType == "A"
                                  ? DateTime(2000)
                                  : DateTime.now().subtract(const Duration(days: 4)),
                              lastDate: DateTime(2100),
                              onChanged: (date) {
                                setState(() {
                                  requisitionSlipController.Date.text =
                                      CommonDateUtils.formatApiDate(date);
                                });
                              },
                            ),
                          ),

                          Container(
                            child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.white70, width: 1),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        elevation: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                          child: TextFormField(
                                            readOnly: true,
                                            autovalidateMode: AutovalidateMode.always,
                                            controller: requisitionSlipController.Fromtime,
                                            cursorColor: Colors.black,
                                            style: const TextStyle(color: Colors.black),
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              labelText: "From Time",
                                              labelStyle: TextStyle(color: Colors.grey, fontSize: RequestConstant.Lable_Font_SIZE),
                                              prefixIconConstraints:
                                              BoxConstraints(minWidth: 0, minHeight: 0),
                                              prefixIcon: Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                  child: Icon(Icons.timer_sharp, color: ConstIcons.IconColor)
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty || value=="00:00") {
                                                return '\u26A0 Required';
                                              }
                                              return null;
                                            },
                                            onTap: () async {
                                              await requisitionSlipController.selectTime(context, requisitionSlipController.Fromtime);
                                              requisitionSlipController.calculateTimeDifference();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.white70, width: 1),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        elevation: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                          child: TextFormField(
                                            readOnly: true,
                                            autovalidateMode: AutovalidateMode.always,
                                            controller: requisitionSlipController.Totime,
                                            cursorColor: Colors.black,
                                            style: const TextStyle(color: Colors.black),
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              labelText: "To Time",
                                              labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: RequestConstant.Lable_Font_SIZE),
                                              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                child: Icon(Icons.timer_sharp, color: ConstIcons.IconColor),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty || value=="00:00" ) {
                                                return '\u26A0 Required';
                                              }
                                              return null;
                                            },
                                            onTap: () async {
                                              await requisitionSlipController.selectTime(context, requisitionSlipController.Totime);
                                              requisitionSlipController.calculateTimeDifference();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),

                          Container(
                            child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.white70, width: 1),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        elevation: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                          child: TextFormField(
                                            readOnly: true,
                                            autovalidateMode: AutovalidateMode.always,
                                            controller: requisitionSlipController.RequiredHrs,
                                            cursorColor: Colors.black,
                                            style: const TextStyle(color: Colors.black),
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              labelText: "Required Hrs",
                                              labelStyle: TextStyle(color: Colors.grey, fontSize: RequestConstant.Lable_Font_SIZE),
                                              prefixIconConstraints:
                                              BoxConstraints(minWidth: 0, minHeight: 0),
                                              prefixIcon: Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                  child: Icon(Icons.timer_sharp, color: ConstIcons.IconColor)
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '\u26A0 Required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.white70, width: 1),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        elevation: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                                          child: TextFormField(
                                            readOnly: true,
                                            autovalidateMode: AutovalidateMode.always,
                                            controller: requisitionSlipController.RequiredMins,
                                            cursorColor: Colors.black,
                                            style: const TextStyle(color: Colors.black),
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              labelText: "Required Mins",
                                              labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: RequestConstant.Lable_Font_SIZE),
                                              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                child: Icon(Icons.timer_sharp, color: ConstIcons.IconColor),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '\u26A0 Required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: true,
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: requisitionSlipController.TotalHrs,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Total Hours",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        child: Icon(Icons.access_time_filled_outlined, color: ConstIcons.IconColor)),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '\u26A0 Required';
                                    }
                                    return null;
                                  },
                                  onTap: (){
                                    requisitionSlipController.TotalHrs.text == '0.0'
                                        ? requisitionSlipController.TotalHrs.text = ""
                                        : requisitionSlipController.TotalHrs.text;
                                  },
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    )),

                    SizedBox(height: height),
                  ],
                ),
              ),
            ],
            ),

            bottomNavigationBar: Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    // visible: mrn_request_controller.screenCheck != "PendingScreen" ? true : false,
                    child: Expanded(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color:  Colors.white,
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
                            ResetAlert(context);
                        },
                      ),
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
                          child: Obx(() => Text(
                            requisitionSlipController.saveButton.value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                                color:  Colors.white
                            ),
                          ))),
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            final type = requisitionSlipController.type.value.trim();

                            if (type == "L") {
                              final totalDays = double.tryParse(requisitionSlipController.Totaldays.text.trim()) ?? 0;

                              if (totalDays == 0) {
                                Fluttertoast.showToast(msg: "Please enter a valid total days");
                                return;
                              }
                            }

                            if (type == "P") {
                              final totalHours = double.tryParse(requisitionSlipController.TotalHrs.text.trim()) ?? 0;

                              if (totalHours == 0) {
                                Fluttertoast.showToast(msg: "Please enter a valid total hours");
                                return;
                              }
                            }
                            await SubmitAlert(context);
                          }
                        }
                    ),
                  ),
                ],
              ),
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
                          requisitionSlipController.reqId=0;
                          requisitionSlipController.saveButton.value=RequestConstant.SUBMIT;
                          staffController.selectedstaffId.value = loginController.user.value.empId!;
                          staffController.Staffname.text = loginController.user.value.empName!;                          requisitionSlipController.Reqdate.text=BaseUtitiles.initiateCurrentDateFormat();
                          requisitionSlipController.Fromdate.text=BaseUtitiles.initiateCurrentDateFormat();
                          requisitionSlipController.Todate.text=BaseUtitiles.initiateCurrentDateFormat();
                          requisitionSlipController.ondutyDate.text=BaseUtitiles.initiateCurrentDateFormat();
                          requisitionSlipController.perDate.text=BaseUtitiles.initiateCurrentDateFormat();
                          requisitionSlipController.ReqAutoyearwise.text=autoYearWiseNoController.RequisitionSlip_autoYrsWise.value;
                          reportsController.projectname.text  = "--SELECT--";
                          reportsController.selectedProjectId.value = 0;
                          requisitionSlipController.Totaldays.text="1";
                          requisitionSlipController.totalLeaveValue.value = "1";
                          requisitionSlipController.type.value="L";
                          requisitionSlipController.TotalHrs.text="0";
                          requisitionSlipController.Reason.text="";
                          requisitionSlipController.LeaveReason.text="";
                          requisitionSlipController.isHalfDay.value=false;
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
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: Text(
            'Are you sure to ${requisitionSlipController.saveButton.value}?'),
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
                    child: TextButton(
                      onPressed: () async {
                           if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                           await requisitionSlipController.SaveButtonStaffReqScreen(
                             context,
                             requisitionSlipController.reqId
                           );
                         }
                      },
                      child: Text(
                        requisitionSlipController.saveButton.value,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                        ),
                      ),
                    ),

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
