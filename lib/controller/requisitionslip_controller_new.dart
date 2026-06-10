import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:prahkurticore/controller/pendinglistcontroller.dart';
import 'package:prahkurticore/controller/reports_controller.dart';
import 'package:prahkurticore/controller/staffcontroller.dart';
import '../controller/logincontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../home/menu/payroll/requisitionslip/entry_requisitionslip.dart';
import '../models/reqslipapproval_model.dart';
import '../models/requisitionslipsave_model.dart';
import '../provider/reuisitionslip_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';


class  RequisitionSlipControllerNew extends GetxController{
  final ReqAutoyearwise=TextEditingController();
  final Reqdate=TextEditingController();
  final LeaveReason=TextEditingController();
  final Reason=TextEditingController();
  final Fromdate=TextEditingController();
  final Todate=TextEditingController();
  final Totaldays=TextEditingController();
  final Date=TextEditingController();
  final Fromtime=TextEditingController();
  final Totime=TextEditingController();
  final TotalHrs=TextEditingController();
  final RequiredHrs=TextEditingController();
  final RequiredMins=TextEditingController();

  ///------report-------
  final reportFromDate = TextEditingController();
  final reportToDate = TextEditingController();
  final reqLeaveType = TextEditingController();

  var leaveType = "".obs;
  var yearofLeavedays = ''.obs;
  var yearofPerHrs = ''.obs;


  final ondutyDate=TextEditingController();
  final perDate=TextEditingController();
  final pFromtime=TextEditingController();

  final pTotime=TextEditingController();
  final EntrylistFromdate=TextEditingController();
  final EntrylistTodate=TextEditingController();

  ///Verify and Approval-----
  final remarksValue=TextEditingController();

  ReportsController reportsController = Get.put(ReportsController());
  PendingListController pendingListController = Get.put(PendingListController());
  StaffController staffController = Get.put(StaffController());

  var type = 'L'.obs;
  bool willPop = false;

  int reqId=0;
  RxString saveButton=RequestConstant.SUBMIT.obs;
  RxList ReqSlipEtyList = [].obs;
  RxList mainentrylist = [].obs;
  RxList staffLeaveInfolist = [].obs;
  RxList ReqSlipEditList = [].obs;
  RxList staffReqTypeList = [].obs;
  RxList verifyList = [].obs;
  LoginController loginController=Get.put(LoginController());


  Future getRequisitionslip_EntryList() async {
    mainentrylist.value=[];
    ReqSlipEtyList.value=[];
    var response = await RequisitionslipProvider.getReqSlipEntry_List(
        EntrylistFromdate.text,
        EntrylistTodate.text);
    if (response != null) {
      if (response.success == true) {
        if (response.result!.isNotEmpty) {
          mainentrylist.assignAll(response.result!);
          ReqSlipEtyList.assignAll(response.result!);
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }

  Future getStaffReqTypeList() async {
    final value = await RequisitionslipProvider.getStaffReqTypeList();
    if (value != null) {
      if (value.success == true) {
        staffReqTypeList.value = value.result!;
      } else {
        BaseUtitiles.showToast(value.message ?? "Something Went Wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something Went Wrong..");
    }
  }

  Future getLeaveInfo_List(int empId) async {
    staffLeaveInfolist.value.clear();
    await RequisitionslipProvider.getStaffLeaveInfo_Provider(empId).then((value) async {
      if (value != null && value.length > 0) {
        staffLeaveInfolist.value = value;
        await leaveInfo();
        update();
        print("yearofLeavedays :: ${yearofLeavedays.value}");
        print("yearofPerHrs :: ${yearofPerHrs.value}");
        return staffLeaveInfolist.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }


  Future<void> leaveInfo() async {
    yearofLeavedays.value = '';
    yearofPerHrs.value = '';
    staffLeaveInfolist.forEach((element) {
      yearofLeavedays.value = element.leaveDays.toString();
      yearofPerHrs.value = element.leaveHours.toString();
    });
    update();
  }

  // Future<void> leaveInfo() async {
  //   yearofLeavedays.text = "";
  //   yearofPerHrs.text = "";
  //    staffLeaveInfolist.forEach((element) {
  //       yearofLeavedays.text = element.leaveDays.toString();
  //       yearofPerHrs.text = element.leaveHours.toString();
  //   });
  //    update();
  // }


  Future SaveButtonStaffReqScreen(BuildContext context, int id) async {
    String body = requisitonSlipsaveRequestToJson(RequisitonSlipsaveRequest(
      id: reqId,
      requisitionNo: ReqAutoyearwise.text,
      requisitionType: type.value,
      entryDate: Reqdate.text,
      staffId: staffController.selectedstaffId.value,
      projectId: reportsController.selectedProjectId.value,
      leaveReason: LeaveReason.text,
      leaveFromDate: Fromdate.text,
      leaveToDate: Todate.text,
      totalLeaveDays: double.tryParse(Totaldays.text),
      permissionReason: Reason.text,
      permissionFromDate: Date.text,
      permissionToDate: Date.text,
      permissionFromTime: Fromtime.text,
      permissionToTime: Totime.text,
      permissionTimeHrs: int.tryParse(RequiredHrs.text),
      permissionTimeMins: int.tryParse(RequiredMins.text),
      totalPermissionHours: double.tryParse(TotalHrs.text),
      createdBy: int.tryParse(loginController.EmpId()),
      createdDt: BaseUtitiles().convertToUtcIso(Reqdate.text),
      verifyStatus: "N",
      approveStatus: "N",
      verifyRemarks: "-",
      approveRemarks: "-"
    ));
    final list = await RequisitionslipProvider.SaveReqslipScreenEntryAPI(body, reqId);
    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        await getRequisitionslip_EntryList();
        BaseUtitiles.popMultiple(context, count: 3);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  Future reqSlipVerifyApproveApi(context,data,type) async {
    String body = requisitonSlipsaveRequestToJson(RequisitonSlipsaveRequest(
      id: data.id,
      requisitionNo: data.requisitionNo,
      requisitionType: data.requisitionTypeValue,
      entryDate: BaseUtitiles().convertDate(data.entryDate),
      staffId: data.staffId,
      projectId: type=="Approve"||type=="Approve-Reject"?data.projId:data.Projectid,
      leaveReason: data.LeaveReason,
      leaveFromDate: BaseUtitiles().convertDate(data.leaveFromDate),
      leaveToDate: BaseUtitiles().convertDate(data.leaveToDate),
      totalLeaveDays: data.totalLeaveDays,
      permissionReason: data.permissionReason,
      permissionFromDate: BaseUtitiles().convertDate(data.permissionFromDate),
      permissionToDate: BaseUtitiles().convertDate(data.permissionToDate),
      permissionFromTime: type=="Approve"||type=="Approve-Reject"?data.PermissionFromTime:data.permissionFromTime,
      permissionToTime: data.permissionToTime,
      permissionTimeHrs: data.permissionTimeHrs,
      permissionTimeMins: data.permissionTimeMins,
      totalPermissionHours: data.totalPermissionHours,
      createdBy: int.tryParse(loginController.EmpId()),
      createdDt: data.entryDateMobile,
      verifyRemarks: type=="Verify"||type=="Verify-Reject"?remarksValue.text:"",
      approveRemarks: type=="Approve"||type=="Approve-Reject"?remarksValue.text:"",
      verifyStatus: type=="Verify-Reject"?"R":"Y",
      approveStatus: type=="Approve-Reject"?"R":type=="Approve"?"Y":"N",
    ));
    final list = await RequisitionslipProvider.SaveReqslipScreenEntryAPI(body, data.id);
    if (list != null ) {
      if(list["success"] == true){
        BaseUtitiles.showToast(list["message"]);
        await pendingListController.getPendingList();
        BaseUtitiles.popMultiple(context, count: 2);
      }
      else {
        BaseUtitiles.showToast(list["message"] ?? 'Something went wrong..');
        BaseUtitiles.popMultiple(context, count: 2);
      }
    }
    else {
      BaseUtitiles.showToast("Something went wrong..");
      BaseUtitiles.popMultiple(context, count: 2);
    }
  }

  Future Requisitionslip_EditApi(int reqId, BuildContext context, status) async {
    ReqSlipEditList.value=[];
    var response = await RequisitionslipProvider.Requisitionslip_editAPI(reqId,status);
    if (response != null) {
      if (response.success == true) {
        ReqSlipEditList.value = [response.result];
        if (ReqSlipEditList.isNotEmpty) {
          saveButton.value=RequestConstant.RESUBMIT;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RequisitionSlip_Entry())
          );
        } else {
          BaseUtitiles.showToast("No Data Found");
        }
      } else {
        BaseUtitiles.showToast(response.message ?? "Something went wrong..");
      }
    } else {
      BaseUtitiles.showToast("Something went wrong..");
    }
  }


  //--Entrylist Delete--

  Future<bool> Requisition_DeleteApi(int reqId,status) async {
    return RequisitionslipProvider.Requisitionslip_entryList_deleteAPI(reqId,status);
  }

  // vehicleAge(DateTime Fromdate, DateTime Todate) {
  //   var dt1 = Jiffy(Fromdate);
  //   var dt2 = Jiffy(Todate);
  //
  //   int years = int.parse("${dt2.diff(dt1, Units.YEAR)}");
  //   dt1.add(years: years);
  //
  //   int month = int.parse("${dt2.diff(dt1, Units.MONTH)}");
  //   dt1.add(months: month);
  //
  //   var days = dt2.diff(dt1, Units.DAY)+1;
  //
  //   Totaldays.text=days.toString();
  //   // return "$years Years $month Month $days Days";
  //
  // }

  void vehicleAge(DateTime fromDate, DateTime toDate) {
    int totalDays = toDate.difference(fromDate).inDays + 1;
    totalDays = totalDays < 1 ? 1 : totalDays;
    Totaldays.text = totalDays.toString();
  }



  // void calculateTimeDifference() {
  //   // Assuming the times are in a 12-hour format with AM/PM
  //   String fromTime = Fromtime.text; // e.g., '02:30 PM'
  //   String toTime = Totime.text;     // e.g., '04:45 PM'
  //
  //   DateFormat dateFormat = DateFormat.jm(); // 'jm' parses time like '2:30 PM'
  //
  //   // Parsing the times
  //   DateTime fromDateTime = dateFormat.parse(fromTime);
  //   DateTime toDateTime = dateFormat.parse(toTime);
  //
  //   // If the 'Totime' is earlier than 'Fromtime', assume the 'Totime' is on the next day
  //   if (toDateTime.isBefore(fromDateTime)) {
  //     toDateTime = toDateTime.add(const Duration(days: 1));
  //   }
  //
  //   // Calculating the difference
  //   Duration difference = toDateTime.difference(fromDateTime);
  //
  //   // Extracting hours and minutes from the difference
  //   int hours = difference.inHours;
  //   int minutes = difference.inMinutes % 60;
  //
  //   // Assigning to the controllers
  //   RequiredHrs.text = hours.toString();
  //   RequiredMins.text = minutes.toString();
  //   TotalHrs.text = '${hours}.${minutes}';
  //   print("RequiredHrs :: ${ RequiredHrs.text }");
  //   print("RequiredMins :: ${ RequiredMins.text }");
  //   print("TotalHrs :: ${ TotalHrs.text }");
  // }

  // Function to show time picker and format selected time

  void calculateTimeDifference() {
    String fromTime = Fromtime.text.trim();
    String toTime = Totime.text.trim();

    print("From Time: '$fromTime'");
    print("To Time: '$toTime'");

    try {
      DateFormat dateFormat = DateFormat.jm(); // e.g. 2:30 PM

      if (fromTime.isEmpty || toTime.isEmpty) {
        throw FormatException("FromTime or ToTime is empty");
      }

      DateTime fromDateTime = dateFormat.parse(fromTime);
      DateTime toDateTime = dateFormat.parse(toTime);

      if (toDateTime.isBefore(fromDateTime)) {
        toDateTime = toDateTime.add(const Duration(days: 1));
      }

      Duration difference = toDateTime.difference(fromDateTime);

      int hours = difference.inHours;
      int minutes = difference.inMinutes % 60;

      RequiredHrs.text = hours.toString();
      RequiredMins.text = minutes.toString();
      TotalHrs.text = '${hours}.${minutes.toString().padLeft(2, '0')}';

      print("RequiredHrs :: ${RequiredHrs.text}");
      print("RequiredMins :: ${RequiredMins.text}");
      print("TotalHrs :: ${TotalHrs.text}");
    } catch (e) {
      print("⚠️ Error parsing time: $e");
    }
  }

  Future<void> selectTime(BuildContext context, TextEditingController timeController) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      String formattedTime = DateFormat('hh:mm a').format(selectedTime);
      timeController.text = formattedTime; // Update the TextFormField
    }
  }

  Future<void> showCustomTimePicker(BuildContext context, TextEditingController controller) async {
    DateTime selectedTime = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Time"),
          content: SizedBox(
            height: 150,
            child: TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: const TextStyle(fontSize: 18, color: Colors.grey),
              highlightedTextStyle: const TextStyle(fontSize: 22, color: Colors.black),
              spacing: 50,
              itemHeight: 40,
              isForce2Digits: true,
              minutesInterval: 15, // 👈 Only 00, 15, 30, 45
              onTimeChange: (time) {
                selectedTime = time;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final now = DateTime.now();
                final calculatedTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );

                String formattedTime = DateFormat('hh:mm a').format(calculatedTime);
                controller.text = formattedTime;

                Navigator.of(context).pop();

                // Call only if both times are set
                if (Fromtime.text.isNotEmpty && Totime.text.isNotEmpty) {
                  calculateTimeDifference();
                }
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }


  Future DeleteAlert(BuildContext context,int index,bool status) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
        actions:[
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
                          bool result = await Requisition_DeleteApi(ReqSlipEtyList.value[index].id,status);
                          if (result) {
                            ReqSlipEtyList.removeAt(index);
                            Navigator.of(context).pop();
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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