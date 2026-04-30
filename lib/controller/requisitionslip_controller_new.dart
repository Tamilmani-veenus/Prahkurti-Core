import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:prahkurticore/controller/pendinglistcontroller.dart';
import 'package:prahkurticore/controller/reports_controller.dart';
import '../controller/logincontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
// import '../models/reqslipapproval_model.dart';
import '../home/menu/payroll/requisitionslip/entry_requisitionslip.dart';
import '../models/reqslipapproval_model.dart';
import '../models/requisitionslipsave_model.dart';
import '../provider/reuisitionslip_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';



class  RequisitionSlipControllerNew extends GetxController{
  final ReqAutoyearwise=TextEditingController();
  final Reqdate=TextEditingController();
  final Staffname=TextEditingController();
  final Location=TextEditingController();
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
  final reqtype=TextEditingController();

  ///Verify and Approval-----
  final verifyRemarks=TextEditingController();

  // List<TextEditingController> leaveReasonControllers = [];
  // List<TextEditingController> FromdateControllers = [];
  // List<TextEditingController> TodateControllers = [];
  // List<TextEditingController> TotaldaysControllers = [];

  ReportsController reportsController = Get.put(ReportsController());
  PendingListController pendingListController = Get.put(PendingListController());

  // RxString type="Leave".obs;
  var type = 'Leave'.obs;
  int checkColor = 0;
  bool willPop = false;

  //----This for ScreenChek-------
  int reqSlip = 0;
  RxInt projectLocationID = 0.obs;
  RxInt selectedstaffId = 0.obs;
  int buttonControl = 0;


  int reqId=0;
  int editCheck = 0;
  int entryCheck = 0;
  RxString saveButton=RequestConstant.SUBMIT.obs;
  RxList ReqSlipEtyList = [].obs;
  RxList mainentrylist = [].obs;
  RxList staffLeaveInfolist = [].obs;
  RxList ReqSlipEditList = [].obs;
  LoginController loginController=Get.put(LoginController());



  Future getRequisitionslip_EntryList() async {
    mainentrylist.value.clear();
    ReqSlipEtyList.value.clear();
    await RequisitionslipProvider.getReqSlipEntry_List(
        loginController.user.value.empId,
        loginController.UserType(),
        EntrylistFromdate.text,
        EntrylistTodate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        mainentrylist.value = value;
        ReqSlipEtyList.value = mainentrylist.value;
        return mainentrylist.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
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


  //---------RequisitionSlip Verify button------
  Future<void> reqSlipApproveApi(BuildContext context, String urlName, int? reqId, String reqNo,) async {
    String body = reqSlipApprovalToJson(ReqSlipApproval(
      urlName: urlName,
      reqId: reqId.toString(),
      reqNo: reqNo,
      deviceName: BaseUtitiles.deviceName,
      userId: loginController.user.value.userId.toString(),
      approvedBy: loginController.user.value.empId.toString(),
      appRemarks: verifyRemarks.text,
    ));
    final returnRes = await RequisitionslipProvider.RequisitionSlipAPI(body, context);
    if (returnRes != null) {
      print('RequisitionVerify :: $returnRes');
      BaseUtitiles.showToast(returnRes);
      await pendingListController.getPendingList();
      if(returnRes=="Record Rejected Successfully..."){
      Navigator.pop(context);
      Navigator.pop(context);
      }else{
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } else {
      Fluttertoast.showToast(msg: RequestConstant.NORECORD_FOUND);
    }
  }




  Future SaveButtonStaffReqScreen(BuildContext context,int staffId, int id) async {
    if(type.value=="Leave"){
      reqtype.text="L";
    }
    else if(type.value=="OnDuty"){
      reqtype.text="O";
    }else if(type.value=="Compensate Leave"){
      reqtype.text="C";
    }
    else{
      reqtype.text="P";
    }

    String body = requisitonSlipsaveRequestToJson(RequisitonSlipsaveRequest(
      reqId: id != 0 ? id.toString() : "0",
      reqNo: ReqAutoyearwise.text,
      reqDate: Reqdate.text,
      staffId: staffId.toString(),
      projectid: projectLocationID.value.toString(),
      reqType: reqtype.text,
      leaveReason: LeaveReason.text,
      lFrdate: Fromdate.text,
      lTodate: Todate.text,
      totalLeave: Totaldays.text,
      perReason: Reason.text,
      pFrTime: Fromtime.text,
      pToTime: Totime.text,
      pFrdate: Date.text,
      pTodate: Date.text,
      pTimeHrs: RequiredHrs.text,
      pTimeMins: RequiredMins.text,
      totalPerHrs: TotalHrs.text,
      userId: loginController.UserId(),
      deviceName: BaseUtitiles.deviceName,
      entryMode:saveButton.value==RequestConstant.SUBMIT?"ADD":saveButton.value==RequestConstant.RESUBMIT?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
    ));
    final list = await RequisitionslipProvider.SaveReqslipScreenEntryAPI(body, id,context);
    if (list != null && id != 0) {
      BaseUtitiles.showToast(list);
      editCheck=0;
      buttonControl = 0;
      await getRequisitionslip_EntryList();
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);

      // return Navigator.pushReplacement(
      //     context,
      //     new MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //         new Requisitionslip_EntryList()));
    } else {
      if (list == RequestConstant.DUPLICATE_OCCURED) {
        Navigator.pop(context);
        Navigator.pop(context);
        buttonControl = 0;
        return BaseUtitiles.showToast(list);
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        BaseUtitiles.showToast(list);
        editCheck=0;
        buttonControl = 0;
        await getRequisitionslip_EntryList();
        Navigator.pop(context);
        // return Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new Requisitionslip_EntryList()));
      }
    }
  }


  // Future Requisitionslip_EditApi(int reqId, BuildContext context) async {
  //   await RequisitionslipProvider.Requisitionslip_editAPI(reqId).then((value) async {
  //     if (  value.length != 0) {
  //       editCheck = 1;
  //       ReqSlipEditList.value = value;
  //       if (mounted) {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => RequisitionSlip_Entry())
  //         );
  //       }
  //
  //     }
  //   });
  // }
  Future Requisitionslip_EditApi(int reqId, BuildContext context) async {
    try {
      var value = await RequisitionslipProvider.Requisitionslip_editAPI(reqId);

      // Check if the value is not null and has data
      if (value != null && value.isNotEmpty) {
        editCheck = 1;
        ReqSlipEditList.value = value;

        // Check if context is not null and valid before using it
        if (context != null) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RequisitionSlip_Entry())
          );
        } else {
          print("Context is invalid");
        }
      } else {
        print("No data received from API");
      }
    } catch (e) {
      print("Error during API call: $e");
    }
  }


  RxList verifyList = [].obs;
  Future RequistionslipVerify(int reqId, BuildContext context) async {
    await RequisitionslipProvider.Requisitionslip_editAPI(reqId).then((value) async {
      if(value.isNotEmpty){
        verifyList.value = value;
      }
      return verifyList.value;
    });
  }


  //--Entrylist Delete--
  Future Requisition_DeleteApi(int reqId, String ReqNo) async {
    await RequisitionslipProvider.Requisitionslip_entryList_deleteAPI(reqId,ReqNo, loginController.UserId(), BaseUtitiles.deviceName).then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
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


  Future DeleteAlert(BuildContext context,int index) async {
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
                          entryCheck=0;
                          editCheck=0;
                          await Requisition_DeleteApi(ReqSlipEtyList.value[index].requestionId,ReqSlipEtyList.value[index].requestionNo);
                          ReqSlipEtyList.removeAt(index);
                          Navigator.of(context).pop();
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