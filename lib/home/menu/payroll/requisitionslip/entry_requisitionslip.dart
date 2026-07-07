import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/reports_controller.dart';
import '../../../../controller/requisitionslip_controller_new.dart';
import '../../../../controller/staffcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
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
       requisitionSlipController.LeaveReason.text = "";
       requisitionSlipController.Reason.text = "";
       requisitionSlipController.Fromdate.text = BaseUtitiles.initiateCurrentDateFormat();
       requisitionSlipController.Todate.text = BaseUtitiles.initiateCurrentDateFormat();
       requisitionSlipController.Totaldays.text = "1";
       requisitionSlipController.Date.text = BaseUtitiles.initiateCurrentDateFormat();
       requisitionSlipController.Fromtime.text = "00:00";
       requisitionSlipController.Totime.text = "00:00";
       requisitionSlipController.RequiredHrs.text = "0";
       requisitionSlipController.RequiredMins.text = "0";
       requisitionSlipController.TotalHrs.text = "0.0";
       requisitionSlipController.yearofLeavedays.value="0";
       await autoYearWiseNoController.AutoYearWiseNo("REQ SLIP");
       requisitionSlipController.ReqAutoyearwise.text = autoYearWiseNoController.RequisitionSlip_autoYrsWise.value;
       await requisitionSlipController.getStaffReqTypeList();
       requisitionSlipController.type.value = "L";
     }

     else if(requisitionSlipController.saveButton.value==RequestConstant.RESUBMIT){
       requisitionSlipController.ReqSlipEditList.forEach((element) {
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
         requisitionSlipController.Totaldays.text=element.totalLeaveDays.toString();
         requisitionSlipController.Fromtime.text = element.permissionFromTime;
         requisitionSlipController.Totime.text = element.permissionToTime;
         requisitionSlipController.TotalHrs.text=element.totalPermissionHours.toStringAsFixed(2);
         requisitionSlipController.yearofLeavedays.value="0";
       });
     }
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
                                  controller: requisitionSlipController.Reqdate,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Request Date",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE,
                                    ),
                                    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.date),
                                  ),
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
                                          requisitionSlipController.RequiredHrs.text = "0";
                                          requisitionSlipController.RequiredMins.text = "0";
                                          requisitionSlipController.Fromdate.text =
                                              BaseUtitiles.initiateCurrentDateFormat();
                                          requisitionSlipController.Todate.text =
                                              BaseUtitiles.initiateCurrentDateFormat();
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


                    Obx(() => Container(
                      child: Visibility(
                        visible: requisitionSlipController.type.value=="L"?true:false,
                        child: Container(
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
                                              controller: requisitionSlipController.Fromdate,
                                              cursorColor: Colors.black,
                                              style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                                labelText: "From Date",
                                                labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                                ),
                                                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                                prefixIcon: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 8, horizontal: 8),
                                                    child: ConstIcons.date),
                                              ),
                                              onTap: () async {
                                                var Frdate = await showDatePicker(
                                                  fieldHintText: "From",
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(), // disables previous dates
                                                  lastDate: DateTime(2100),

                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: Theme.of(context).copyWith(
                                                        colorScheme: ColorScheme.light(
                                                          primary: Theme.of(context).primaryColor,
                                                          onPrimary: Colors.white,
                                                          onSurface: Colors.black,
                                                        ),
                                                        textButtonTheme: TextButtonThemeData(
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                );
                                                requisitionSlipController.Fromdate.text = BaseUtitiles.selectDateFormat(Frdate!);
                                                requisitionSlipController.vehicleAge(DateTime.parse(requisitionSlipController.Fromdate.text),DateTime.parse(requisitionSlipController.Todate.text));

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
                                              controller: requisitionSlipController.Todate,
                                              cursorColor: Colors.black,
                                              style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                                labelText: "To Date",
                                                labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                                ),
                                                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                                prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                    child: ConstIcons.date),
                                              ),
                                              onTap: () async {
                                                var Todate = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.parse(requisitionSlipController.Fromdate.text),
                                                    firstDate:DateTime.parse(requisitionSlipController.Fromdate.text),
                                                    lastDate: DateTime(2100),
                                                    builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context).copyWith(
                                                      colorScheme: ColorScheme.light(
                                                        primary: Theme.of(context).primaryColor,
                                                        onPrimary: Colors.white,
                                                        onSurface:
                                                        Colors.black, // body text color
                                                      ),
                                                      textButtonTheme: TextButtonThemeData(
                                                        style: TextButton.styleFrom(
                                                          primary: Colors.black, // button text color
                                                        ),
                                                      ),
                                                    ),
                                                    child: child!,
                                                  );
                                                });
                                                requisitionSlipController.Todate.text =BaseUtitiles.selectDateFormat(Todate!);
                                                requisitionSlipController.vehicleAge(DateTime.parse(requisitionSlipController.Fromdate.text),DateTime.parse(requisitionSlipController.Todate.text));
                                              },
                                            ),
                                          ),
                                        ),
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
                        ),
                      ),
                    )),

                    Obx(() => Container(
                      child: Visibility(
                        visible: requisitionSlipController.type.value=="C"?true:false,
                        child: Container(
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
                                              controller: requisitionSlipController.Fromdate,
                                              cursorColor: Colors.black,
                                              style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                                labelText: "From Date",
                                                labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                                ),
                                                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                                prefixIcon: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 8, horizontal: 8),
                                                    child: ConstIcons.date),
                                              ),
                                              onTap: () async {
                                                var Frdate = await showDatePicker(
                                                  fieldHintText: "From",
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(), // disables previous dates
                                                  lastDate: DateTime(2100),

                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: Theme.of(context).copyWith(
                                                        colorScheme: ColorScheme.light(
                                                          primary: Theme.of(context).primaryColor,
                                                          onPrimary: Colors.white,
                                                          onSurface: Colors.black,
                                                        ),
                                                        textButtonTheme: TextButtonThemeData(
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                );
                                                requisitionSlipController.Fromdate.text = BaseUtitiles.selectDateFormat(Frdate!);
                                                requisitionSlipController.vehicleAge(DateTime.parse(requisitionSlipController.Fromdate.text),DateTime.parse(requisitionSlipController.Todate.text));

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
                                              controller: requisitionSlipController.Todate,
                                              cursorColor: Colors.black,
                                              style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                                labelText: "To Date",
                                                labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                                ),
                                                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                                prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                    child: ConstIcons.date),
                                              ),
                                              onTap: () async {
                                                var Todate = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.parse(requisitionSlipController.Fromdate.text),
                                                    firstDate:DateTime.parse(requisitionSlipController.Fromdate.text),
                                                    lastDate: DateTime(2100),
                                                    builder: (context, child) {
                                                      return Theme(
                                                        data: Theme.of(context).copyWith(
                                                          colorScheme: ColorScheme.light(
                                                            primary: Theme.of(context).primaryColor,
                                                            onPrimary: Colors.white,
                                                            onSurface:
                                                            Colors.black, // body text color
                                                          ),
                                                          textButtonTheme: TextButtonThemeData(
                                                            style: TextButton.styleFrom(
                                                              primary: Colors.black, // button text color
                                                            ),
                                                          ),
                                                        ),
                                                        child: child!,
                                                      );
                                                    });
                                                requisitionSlipController.Todate.text =BaseUtitiles.selectDateFormat(Todate!);
                                                requisitionSlipController.vehicleAge(DateTime.parse(requisitionSlipController.Fromdate.text),DateTime.parse(requisitionSlipController.Todate.text));
                                              },
                                            ),
                                          ),
                                        ),
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
                                      readOnly: false,
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



                              Visibility(
                                visible: requisitionSlipController.type.value == "C"? false : true,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 14, right: 14),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                              flex: 2,
                                              child: Text("Previous Leave Taken (This Year)", style:  TextStyle(fontWeight: FontWeight.bold),)),
                                          Expanded(
                                              child: Obx(() => Text(requisitionSlipController.yearofLeavedays.value.toString(),style:  TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),)
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),

                    Obx(() => Container(
                      child: Visibility(
                        visible: requisitionSlipController.type.value=="O"?true:false,
                        child: Container(
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
                                      controller: requisitionSlipController.Date,
                                      cursorColor: Colors.black,
                                      style: const TextStyle(color: Colors.black),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        labelText: "Date",
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: RequestConstant.Lable_Font_SIZE,
                                        ),
                                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                        prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                            child: ConstIcons.date),
                                      ),
                                      onTap: () async {
                                        var Entrydate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                            builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context).primaryColor,
                                                onPrimary: Colors.white,
                                                onSurface:
                                                Colors.black, // body text color
                                              ),
                                              textButtonTheme: TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  primary: Colors.black, // button text color
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        });
                                        requisitionSlipController.Date.text =BaseUtitiles.selectDateFormat(Entrydate!);
                                      },
                                    ),
                                  ),
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
                        ),
                      ),
                    )),

                    Obx(() => Container(
                      child: Visibility(
                        visible: requisitionSlipController.type.value=="P"?true:false,
                        child: Container(
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
                                      controller: requisitionSlipController.Date,
                                      cursorColor: Colors.black,
                                      style: const TextStyle(color: Colors.black),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        labelText: "Date",
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: RequestConstant.Lable_Font_SIZE,
                                        ),
                                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                        prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                            child: ConstIcons.date),
                                      ),
                                      onTap: () async {
                                        var Entrydate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                            builder: (context, child) {
                                              return Theme(
                                                data: Theme.of(context).copyWith(
                                                  colorScheme: ColorScheme.light(
                                                    primary: Theme.of(context).primaryColor,
                                                    onPrimary: Colors.white,
                                                    onSurface:
                                                    Colors.black, // body text color
                                                  ),
                                                  textButtonTheme: TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      primary: Colors.black, // button text color
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            });
                                        requisitionSlipController.Date.text =BaseUtitiles.selectDateFormat(Entrydate!);
                                      },
                                    ),
                                  ),
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

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    margin:  EdgeInsets.only(left: 14, right: 14),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text("Previous Leave Taken (This Year)", style:  TextStyle(fontWeight: FontWeight.bold),)),
                                        Expanded(
                                            child: Obx(() => Text(requisitionSlipController.yearofPerHrs.value.toString(),style:  TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),))
                                        )
                                      ],
                                    )
                                ),
                              ),

                            ],
                          ),
                        ),
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
                          requisitionSlipController.type.value="L";
                          requisitionSlipController.TotalHrs.text="0";
                          requisitionSlipController.Reason.text="";
                          requisitionSlipController.LeaveReason.text="";
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
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return requisitionSlipController.willPop;
        },
        child: AlertDialog(
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
      ),
    );
  }

}
