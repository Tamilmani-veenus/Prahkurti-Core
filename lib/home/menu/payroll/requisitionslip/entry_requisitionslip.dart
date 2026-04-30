import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/reports_controller.dart';
import '../../../../controller/requisitionslip_controller.dart';
import '../../../../controller/requisitionslip_controller_new.dart';
import '../../../../controller/staffcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class RequisitionSlip_Entry extends StatefulWidget {
  const RequisitionSlip_Entry({super.key});

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
   var duration = Duration(seconds: 0);
   Future.delayed(duration, () async {
     requisitionSlipController.reqSlip = 1;
     await autoYearWiseNoController.AutoYearWiseNo("REQ SLIP");
     await reportsController.getReportProjectList();
     await requisitionSlipController.getLeaveInfo_List(loginController.user.value.empId!);
     await staffController.get_staffDropdowntList(context);
     requisitionSlipController.Staffname.text = loginController.user.value.empName.toString();
     requisitionSlipController.selectedstaffId.value = loginController.user.value.empId!;

     // if(loginController.user.value.userType! == "A"){
     //   await staffController.get_staffDropdowntList(context);
     // }else{
     //   await requisitionSlipController.getLeaveInfo_List(loginController.user.value.empId!);
     // }

     if(requisitionSlipController.editCheck==1){
       requisitionSlipController.saveButton.value=RequestConstant.RESUBMIT;
       requisitionSlipController.ReqSlipEditList.forEach((element) {
         requisitionSlipController.reqId=element.reqId;
         requisitionSlipController.ReqAutoyearwise.text=element.reqNo;
         requisitionSlipController.Reqdate.text=element.reqDate;
         requisitionSlipController.Staffname.text=element.staffName;
         requisitionSlipController.Location.text= element.projectName;
         requisitionSlipController.projectLocationID.value = element.projectid;
         requisitionSlipController.type.value=element.reqType=="L"?"Leave":element.reqType=="O"?"OnDuty": element.reqType=="C"?"Compensate Leave":"Permission";
         requisitionSlipController.Fromdate.text=element.lFrdate;
         requisitionSlipController.Todate.text=element.lTodate;
         requisitionSlipController.Reason.text=element.perReason;
         requisitionSlipController.LeaveReason.text = element.leaveReason;
         requisitionSlipController.Date.text = element.lFrdate;
         requisitionSlipController.Fromtime.text = element.pFrTime;
         requisitionSlipController.Totaldays.text=element.totalLeave.toString();
         requisitionSlipController.Totime.text = element.pToTime;
         requisitionSlipController.TotalHrs.text=element.totalPerHrs.toStringAsFixed(2);
         // requisitionSlipController.RequiredHrs.text = element.pTimeHrs.toString();
         // requisitionSlipController.RequiredMins.text = element.pTimeMins.toString();
         ///**********
         // requisitionSlipController.ondutyDate.text=element.pFrdate;
         // requisitionSlipController.perDate.text=element.pFrdate;
         // requisitionSlipController.pFromtime.text=element.pFrTime;
         // requisitionSlipController.pTotime.text=element.pToTime;
         // requisitionSlipController.OndutyReason.text=element.perReason;
         // requisitionSlipController.PerReason.text=element.perReason;
       });
     }
     else{
       requisitionSlipController.reqId=0;
       requisitionSlipController.saveButton.value = RequestConstant.SUBMIT;
       requisitionSlipController.ReqAutoyearwise.text = autoYearWiseNoController.RequisitionSlip_autoYrsWise.value;
       requisitionSlipController.Reqdate.text = BaseUtitiles.initiateCurrentDateFormat();
       requisitionSlipController.Staffname.text=loginController.user.value.empName!;
       requisitionSlipController.selectedstaffId.value = loginController.user.value.empId!;
       requisitionSlipController.Location.text  = "--SELECT--";
       requisitionSlipController.projectLocationID.value = 0;
       // reportsController.selectedProjectId.value = 0;
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

       // requisitionSlipController.ondutyDate.text=BaseUtitiles.initiateCurrentDateFormat();
       // requisitionSlipController.perDate.text = BaseUtitiles.initiateCurrentDateFormat();

       requisitionSlipController.type.value = "Leave";
       requisitionSlipController.TotalHrs.text = "0.0";

       // reportsController.setSelectedProjectListName(0);
       // requisitionSlipController.OndutyReason.text="";
       // requisitionSlipController.PerReason.text="";
     }
   });

    super.initState();
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
                          const Text(
                            "Requisition Slip",
                            style: TextStyle(
                                fontSize: RequestConstant.Heading_Font_SIZE,
                                fontWeight: FontWeight.bold),
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller: requisitionSlipController.Staffname,
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
                              // setState(() {
                              if( requisitionSlipController.editCheck == 1){

                              } else if(loginController.user.value.userType == "A"){
                                  Future.delayed(Duration(seconds: 0),()async {
                                    // await bottomsheetControllers.StaffName(context, staffController.getStaffDropdownvalue.value, requisitionSlipController.reqSlip);
                                  });
                                }
                                FocusScope.of(context).unfocus();
                              // });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '\u26A0 Please select Staff Name.';
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: requisitionSlipController.Location,
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
                                return '\u26A0 Please select Location';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1)),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Divider(
                        thickness: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),

                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:<Widget> [
                        Obx(() =>  Expanded(
                          child: Radio<String>(
                            value: 'Leave',
                            groupValue: requisitionSlipController.type.value,
                            onChanged: (value) {
                              setState(() {
                                requisitionSlipController.type.value = value!;
                                requisitionSlipController.Reason.text = "";
                                requisitionSlipController.LeaveReason.text = "";
                                requisitionSlipController.Fromtime.text = "00:00";
                                requisitionSlipController.pFromtime.text = "00:00";
                                requisitionSlipController.Totime.text="00:00";
                                requisitionSlipController.pTotime.text="00:00";
                                requisitionSlipController.TotalHrs.text="0.0";
                                requisitionSlipController.Totaldays.text = "1";
                                requisitionSlipController.Fromdate.text = BaseUtitiles.initiateCurrentDateFormat();
                                requisitionSlipController.Todate.text = BaseUtitiles.initiateCurrentDateFormat();
                                requisitionSlipController.checkColor = 1;
                              });
                            },
                          ),
                        )),
                        const Expanded(
                            flex: 1,
                            child: Text('Leave  ')),

                        Obx(() =>  Expanded(
                          child: Radio<String>(
                            value: 'Compensate Leave',
                            groupValue: requisitionSlipController.type.value,
                            onChanged: (value) {
                              setState(() {
                                requisitionSlipController.type.value = value!;
                                requisitionSlipController.Reason.text="";
                                requisitionSlipController.LeaveReason.text="";
                                requisitionSlipController.Fromtime.text="00:00";
                                requisitionSlipController.pFromtime.text="00:00";
                                requisitionSlipController.Totime.text="00:00";
                                requisitionSlipController.pTotime.text="00:00";
                                requisitionSlipController.TotalHrs.text="0.0";
                                requisitionSlipController.Totaldays.text = "1";
                                requisitionSlipController.Fromdate.text = BaseUtitiles.initiateCurrentDateFormat();
                                requisitionSlipController.Todate.text = BaseUtitiles.initiateCurrentDateFormat();
                              });
                            },
                          ),
                        ),),
                        Expanded(
                            flex: 2,
                            child: const Text('Compensate Leave')),
                      ],
                    ),

                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(() =>  Expanded(
                          child: Radio<String>(
                            value: 'OnDuty',
                            groupValue: requisitionSlipController.type.value,
                            onChanged: (value) {
                              setState(() {
                                requisitionSlipController.type.value = value!;
                                requisitionSlipController.LeaveReason.text="";
                                requisitionSlipController.Reason.text="";
                                requisitionSlipController.pFromtime.text="00:00";
                                requisitionSlipController.pTotime.text="00:00";
                                requisitionSlipController.TotalHrs.text="0.0";
                                requisitionSlipController.Totaldays.text = "1";
                                requisitionSlipController.RequiredHrs.text = "0";
                                requisitionSlipController.RequiredMins.text = "0";
                              });
                            },
                          ),
                        ),),
                        const Expanded(
                            flex: 1,
                            child: Text('OnDuty')),

                        Obx(() =>  Expanded(
                          child: Radio<String>(
                            value: 'Permission',
                            groupValue: requisitionSlipController.type.value,
                            onChanged: (value) {
                              setState(() {
                                requisitionSlipController.type.value = value!;
                                requisitionSlipController.Reason.text="";
                                requisitionSlipController.LeaveReason.text="";
                                requisitionSlipController.Fromtime.text="00:00";
                                requisitionSlipController.Totime.text="00:00";
                                requisitionSlipController.TotalHrs.text="0.0";
                                requisitionSlipController.Totaldays.text = "1";
                                requisitionSlipController.RequiredHrs.text = "0";
                                requisitionSlipController.RequiredMins.text = "0";
                              });
                            },
                          ),
                        ),),
                        const Expanded(
                            flex: 2,
                            child: Text('Permission   ')),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Divider(
                        thickness: 2,
                        color: Theme.of(context).primaryColor,
                      ),),

                    Obx(() => Container(
                      child: Visibility(
                        visible: requisitionSlipController.type.value=="Leave"?true:false,
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                          return '\u26A0 Please enter reason';
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
                                                    initialDate: DateTime.parse(requisitionSlipController.Fromdate.text),
                                                    firstDate: DateTime(1900),
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
                                                    lastDate: DateTime.parse(requisitionSlipController.Fromdate.text).add(Duration(days: 3)),
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                          return '\u26A0 Please enter total days';
                                        }
                                        return null;
                                      },
                                  ),
                                ),
                              ),
                              ),

                              // Container(
                              //   margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                              //   child: Card(
                              //     shape: RoundedRectangleBorder(
                              //       side: const BorderSide(color: Colors.white70, width: 1),
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     elevation: 3,
                              //     child: Padding(
                              //       padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              //       child: TextFormField(
                              //
                              //         textAlign: TextAlign.right,
                              //         readOnly: false,
                              //         autovalidateMode: AutovalidateMode.onUserInteraction,
                              //         controller: requisitionSlipController.yearofLeavedays,
                              //         cursorColor: Colors.black,
                              //         style: const TextStyle(color: Colors.black),
                              //         decoration: const InputDecoration(
                              //           contentPadding: EdgeInsets.zero,
                              //           border: InputBorder.none,
                              //           // labelText: "Total Days",
                              //           // labelStyle: TextStyle(
                              //           //     color: Colors.grey,
                              //           //     fontSize: RequestConstant.Lable_Font_SIZE),
                              //           prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                              //           prefixIcon: Padding(
                              //             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              //             child: Text("Previous Leave Taken (This Year)"),
                              //             // Icon(Icons.format_list_numbered_rounded, color: ConstIcons.IconColor),
                              //           ),
                              //           // suffixIcon: Padding(
                              //           //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              //           //   child: Text(requisitionSlipController.yearofLeavedays.text),
                              //           //   // Icon(Icons.format_list_numbered_rounded, color: ConstIcons.IconColor),
                              //           // ),
                              //         ),
                              //         validator: (value) {
                              //           if (value!.isEmpty) {
                              //             return '\u26A0 Please enter total days';
                              //           }
                              //           return null;
                              //         },
                              //       ),
                              //     ),
                              //   ),
                              // ),

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



                              // Container(
                              //   padding: EdgeInsets.only(left: 1, bottom: 8),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         flex: 1,
                              //         child: Container(
                              //           margin: EdgeInsets.only(left: 20,top: 10),
                              //           height: BaseUtitiles.getheightofPercentage(context, 4),
                              //           child: Text("Reason",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              //         ),
                              //       ),
                              //       Expanded(
                              //         flex: 1,
                              //         child: Container(
                              //           height: BaseUtitiles.getheightofPercentage(context, 4),
                              //           margin: EdgeInsets.only(left: 10, right: 20),
                              //           decoration: BoxDecoration(),
                              //           child: TextField(
                              //             style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
                              //             controller: requisitionSlipController.Reason,
                              //             textAlign: TextAlign.center,
                              //             decoration: InputDecoration(
                              //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              //               focusedBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //               ),
                              //               enabledBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //               ),
                              //               border: OutlineInputBorder(),
                              //             ),
                              //
                              //             onTap: () {
                              //
                              //             },
                              //           ),
                              //
                              //         ),
                              //
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //     children: <Widget>[
                              //       Container(
                              //         height: BaseUtitiles.getheightofPercentage(context, 4),
                              //         width: BaseUtitiles.getWidthtofPercentage(context, 40),
                              //         margin: EdgeInsets.only(left: 5, right: 5),
                              //         decoration: BoxDecoration(),
                              //         child: TextField(
                              //           style: TextStyle(fontSize: 13),
                              //           readOnly: true,
                              //           controller: requisitionSlipController.Fromdate,
                              //           decoration: InputDecoration(
                              //             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              //             focusedBorder: OutlineInputBorder(
                              //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //             ),
                              //             enabledBorder: OutlineInputBorder(
                              //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //             ),
                              //             border: OutlineInputBorder(),
                              //             prefixIcon: Icon(Icons.date_range_sharp,
                              //                 color: Theme.of(context).primaryColor),
                              //           ),
                              //           onTap: () async {
                              //
                              //             var Frdate = await showDatePicker(
                              //                 fieldHintText: "From",
                              //                 context: context,
                              //                 initialDate: DateTime.now(),
                              //                 firstDate: DateTime(1900),
                              //                 lastDate: DateTime(2100));
                              //             requisitionSlipController.Fromdate.text = BaseUtitiles.selectDateFormat(Frdate!);
                              //             requisitionSlipController.vehicleAge(DateTime.parse(requisitionSlipController.Fromdate.text),DateTime.parse(requisitionSlipController.Todate.text));
                              //
                              //           },
                              //         ),
                              //       ),
                              //       Container(
                              //         height: BaseUtitiles.getheightofPercentage(context, 4),
                              //         width: BaseUtitiles.getWidthtofPercentage(context, 40),
                              //         margin: EdgeInsets.only(left: 4, right: 5),
                              //         decoration: BoxDecoration(),
                              //         child: TextField(
                              //           readOnly: true,
                              //           style: TextStyle(fontSize: 13),
                              //           controller: requisitionSlipController.Todate,
                              //           decoration: InputDecoration(
                              //             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              //             focusedBorder: OutlineInputBorder(
                              //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //             ),
                              //             enabledBorder: OutlineInputBorder(
                              //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //             ),
                              //             border: OutlineInputBorder(),
                              //             prefixIcon: Icon(Icons.date_range_sharp,
                              //                 color: Theme.of(context).primaryColor),
                              //           ),
                              //           onTap: () async {
                              //             var Todate = await showDatePicker(
                              //                 context: context,
                              //                 initialDate: DateTime.now(),
                              //                 firstDate: DateTime(1900),
                              //                 lastDate: DateTime(2100));
                              //             requisitionSlipController.Todate.text =BaseUtitiles.selectDateFormat(Todate!);
                              //             requisitionSlipController.vehicleAge(DateTime.parse(requisitionSlipController.Fromdate.text),DateTime.parse(requisitionSlipController.Todate.text));
                              //
                              //           },
                              //
                              //         ),
                              //       ),
                              //
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   padding: EdgeInsets.only(left: 1, bottom: 8,top: 8),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         flex: 1,
                              //         child: Container(
                              //           margin: EdgeInsets.only(left: 20,top: 10),
                              //           height: BaseUtitiles.getheightofPercentage(context, 4),
                              //           child: Text("Total Days",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
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
                              //             style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
                              //             controller: requisitionSlipController.Totaldays,
                              //             textAlign: TextAlign.center,
                              //             decoration: InputDecoration(
                              //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              //               focusedBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //               ),
                              //               enabledBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //               ),
                              //               border: OutlineInputBorder(),
                              //             ),
                              //
                              //             onTap: () {
                              //
                              //             },
                              //           ),
                              //
                              //         ),
                              //
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Divider(
                              //   thickness: 2,
                              //   color: Theme.of(context).primaryColor,
                              // )
                            ],
                          ),
                        ),
                      ),
                    )),

                    Obx(() => Container(
                      child: Visibility(
                        visible: requisitionSlipController.type.value=="Compensate Leave"?true:false,
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                          return '\u26A0 Please enter reason';
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
                                                    initialDate: DateTime.parse(requisitionSlipController.Fromdate.text),
                                                    firstDate: DateTime(1900),
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
                                                    lastDate: DateTime.parse(requisitionSlipController.Fromdate.text).add(Duration(days: 3)),
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                          return '\u26A0 Please enter total days';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              // Container(
                              //   margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                              //   child: Card(
                              //     shape: RoundedRectangleBorder(
                              //       side: const BorderSide(color: Colors.white70, width: 1),
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     elevation: 3,
                              //     child: Padding(
                              //       padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              //       child: TextFormField(
                              //
                              //         textAlign: TextAlign.right,
                              //         readOnly: false,
                              //         autovalidateMode: AutovalidateMode.onUserInteraction,
                              //         controller: requisitionSlipController.yearofLeavedays,
                              //         cursorColor: Colors.black,
                              //         style: const TextStyle(color: Colors.black),
                              //         decoration: const InputDecoration(
                              //           contentPadding: EdgeInsets.zero,
                              //           border: InputBorder.none,
                              //           // labelText: "Total Days",
                              //           // labelStyle: TextStyle(
                              //           //     color: Colors.grey,
                              //           //     fontSize: RequestConstant.Lable_Font_SIZE),
                              //           prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                              //           prefixIcon: Padding(
                              //             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              //             child: Text("Previous Leave Taken (This Year)"),
                              //             // Icon(Icons.format_list_numbered_rounded, color: ConstIcons.IconColor),
                              //           ),
                              //           // suffixIcon: Padding(
                              //           //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              //           //   child: Text(requisitionSlipController.yearofLeavedays.text),
                              //           //   // Icon(Icons.format_list_numbered_rounded, color: ConstIcons.IconColor),
                              //           // ),
                              //         ),
                              //         validator: (value) {
                              //           if (value!.isEmpty) {
                              //             return '\u26A0 Please enter total days';
                              //           }
                              //           return null;
                              //         },
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Visibility(
                                visible: requisitionSlipController.type.value == "Compensate Leave"? false : true,
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



                              // Container(
                              //   padding: EdgeInsets.only(left: 1, bottom: 8),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         flex: 1,
                              //         child: Container(
                              //           margin: EdgeInsets.only(left: 20,top: 10),
                              //           height: BaseUtitiles.getheightofPercentage(context, 4),
                              //           child: Text("Reason",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              //         ),
                              //       ),
                              //       Expanded(
                              //         flex: 1,
                              //         child: Container(
                              //           height: BaseUtitiles.getheightofPercentage(context, 4),
                              //           margin: EdgeInsets.only(left: 10, right: 20),
                              //           decoration: BoxDecoration(),
                              //           child: TextField(
                              //             style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
                              //             controller: requisitionSlipController.Reason,
                              //             textAlign: TextAlign.center,
                              //             decoration: InputDecoration(
                              //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              //               focusedBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //               ),
                              //               enabledBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //               ),
                              //               border: OutlineInputBorder(),
                              //             ),
                              //
                              //             onTap: () {
                              //
                              //             },
                              //           ),
                              //
                              //         ),
                              //
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //     children: <Widget>[
                              //       Container(
                              //         height: BaseUtitiles.getheightofPercentage(context, 4),
                              //         width: BaseUtitiles.getWidthtofPercentage(context, 40),
                              //         margin: EdgeInsets.only(left: 5, right: 5),
                              //         decoration: BoxDecoration(),
                              //         child: TextField(
                              //           style: TextStyle(fontSize: 13),
                              //           readOnly: true,
                              //           controller: requisitionSlipController.Fromdate,
                              //           decoration: InputDecoration(
                              //             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              //             focusedBorder: OutlineInputBorder(
                              //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //             ),
                              //             enabledBorder: OutlineInputBorder(
                              //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //             ),
                              //             border: OutlineInputBorder(),
                              //             prefixIcon: Icon(Icons.date_range_sharp,
                              //                 color: Theme.of(context).primaryColor),
                              //           ),
                              //           onTap: () async {
                              //
                              //             var Frdate = await showDatePicker(
                              //                 fieldHintText: "From",
                              //                 context: context,
                              //                 initialDate: DateTime.now(),
                              //                 firstDate: DateTime(1900),
                              //                 lastDate: DateTime(2100));
                              //             requisitionSlipController.Fromdate.text = BaseUtitiles.selectDateFormat(Frdate!);
                              //             requisitionSlipController.vehicleAge(DateTime.parse(requisitionSlipController.Fromdate.text),DateTime.parse(requisitionSlipController.Todate.text));
                              //
                              //           },
                              //         ),
                              //       ),
                              //       Container(
                              //         height: BaseUtitiles.getheightofPercentage(context, 4),
                              //         width: BaseUtitiles.getWidthtofPercentage(context, 40),
                              //         margin: EdgeInsets.only(left: 4, right: 5),
                              //         decoration: BoxDecoration(),
                              //         child: TextField(
                              //           readOnly: true,
                              //           style: TextStyle(fontSize: 13),
                              //           controller: requisitionSlipController.Todate,
                              //           decoration: InputDecoration(
                              //             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              //             focusedBorder: OutlineInputBorder(
                              //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //             ),
                              //             enabledBorder: OutlineInputBorder(
                              //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //             ),
                              //             border: OutlineInputBorder(),
                              //             prefixIcon: Icon(Icons.date_range_sharp,
                              //                 color: Theme.of(context).primaryColor),
                              //           ),
                              //           onTap: () async {
                              //             var Todate = await showDatePicker(
                              //                 context: context,
                              //                 initialDate: DateTime.now(),
                              //                 firstDate: DateTime(1900),
                              //                 lastDate: DateTime(2100));
                              //             requisitionSlipController.Todate.text =BaseUtitiles.selectDateFormat(Todate!);
                              //             requisitionSlipController.vehicleAge(DateTime.parse(requisitionSlipController.Fromdate.text),DateTime.parse(requisitionSlipController.Todate.text));
                              //
                              //           },
                              //
                              //         ),
                              //       ),
                              //
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   padding: EdgeInsets.only(left: 1, bottom: 8,top: 8),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         flex: 1,
                              //         child: Container(
                              //           margin: EdgeInsets.only(left: 20,top: 10),
                              //           height: BaseUtitiles.getheightofPercentage(context, 4),
                              //           child: Text("Total Days",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
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
                              //             style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
                              //             controller: requisitionSlipController.Totaldays,
                              //             textAlign: TextAlign.center,
                              //             decoration: InputDecoration(
                              //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              //               focusedBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //               ),
                              //               enabledBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              //               ),
                              //               border: OutlineInputBorder(),
                              //             ),
                              //
                              //             onTap: () {
                              //
                              //             },
                              //           ),
                              //
                              //         ),
                              //
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Divider(
                              //   thickness: 2,
                              //   color: Theme.of(context).primaryColor,
                              // )
                            ],
                          ),
                        ),
                      ),
                    )),

                    Obx(() => Container(
                      child: Visibility(
                        visible: requisitionSlipController.type.value=="OnDuty"?true:false,
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                          return '\u26A0 Please enter reason';
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
                                            firstDate: DateTime(1900),
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
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                                  return '\u26A0 Please enter From Time';
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
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                                  return '\u26A0 Please enter To Time';
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
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                                    return '\u26A0 Please enter from time';
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
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                                    return '\u26A0 Please enter to time';
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                          return '\u26A0 Please enter total hours';
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
                        visible: requisitionSlipController.type.value=="Permission"?true:false,
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                          return '\u26A0 Please enter reason';
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
                                            firstDate: DateTime(1900),
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
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                                    return '\u26A0 Please enter From Time';
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
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                                    return '\u26A0 Please enter To Time';
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
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                                    return '\u26A0 Please enter from time';
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
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                                    return '\u26A0 Please enter to time';
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                          return '\u26A0 Please enter total hours';
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

                            if (type == "Leave") {
                              final totalDays = double.tryParse(requisitionSlipController.Totaldays.text.trim()) ?? 0;

                              if (totalDays == 0) {
                                Fluttertoast.showToast(msg: "Please enter a valid total days");
                                return;
                              }
                            }

                            if (type == "Permission") {
                              final totalHours = double.tryParse(requisitionSlipController.TotalHrs.text.trim()) ?? 0;

                              if (totalHours == 0) {
                                Fluttertoast.showToast(msg: "Please enter a valid total hours");
                                return;
                              }
                            }
                            requisitionSlipController.checkColor = 0;
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
                          requisitionSlipController.saveButton.value=RequestConstant.SAVE;
                          requisitionSlipController.Staffname.text=loginController.EmpName();
                          requisitionSlipController.Reqdate.text=BaseUtitiles.initiateCurrentDateFormat();
                          requisitionSlipController.Fromdate.text=BaseUtitiles.initiateCurrentDateFormat();
                          requisitionSlipController.Todate.text=BaseUtitiles.initiateCurrentDateFormat();
                          requisitionSlipController.ondutyDate.text=BaseUtitiles.initiateCurrentDateFormat();
                          requisitionSlipController.perDate.text=BaseUtitiles.initiateCurrentDateFormat();
                          requisitionSlipController.ReqAutoyearwise.text=autoYearWiseNoController.RequisitionSlip_autoYrsWise.value;
                          requisitionSlipController.Location.text="--SELECT--";
                          requisitionSlipController.Totaldays.text="1";
                          requisitionSlipController.type.value="Leave";
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
              requisitionSlipController.editCheck == 1
              ? 'Are you sure to Re-Submit?'
              : 'Are you sure to submit?'),
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
                               context, requisitionSlipController.selectedstaffId.value,
                               requisitionSlipController.reqId != 0
                                   ? requisitionSlipController.reqId
                                   : 0,);
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
