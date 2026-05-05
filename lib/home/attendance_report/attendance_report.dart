import '../../controller/reports_controller.dart';
import '../../utilities/apiconstant.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app_theme/app_colors.dart';
import '../../commonpopup/worktype_alert.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/attendancecontroller.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/logincontroller.dart';
import '../../controller/projectcontroller.dart';
import '../../controller/sitecontroller.dart';
import '../../controller/subcontcontroller.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pdf_generate/pdf_model/pdfmodel.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({Key? key}) : super(key: key);

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  final ProjectController projectController = Get.put(ProjectController());
  final SiteController siteController = Get.put(SiteController());
  final SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  LoginController loginController = Get.put(LoginController());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());
  ReportsController reportsController = Get.put(ReportsController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      attendanceController.FromdateController.clear();
      attendanceController.TodateController.clear();
      DateTime currentDate = DateTime.now();

      attendanceController.FromdateController.text =
          currentDate.toString().substring(0, 10);
      attendanceController.TodateController.text =
          currentDate.toString().substring(0, 10);

      reportsController.projectname.text = "--ALL--";
      reportsController.selectedProjectId.value = 0;

      reportsController.sitename.text = "--ALL--";
      reportsController.selectedsiteId.value = 0;

      reportsController.subcontractorname.text = "--ALL--";
      reportsController.selectedSubcontId.value = 0;

      attendanceController.workTypeController.text = "--SELECT--";
      attendanceController.wrktype.value = "0";
      attendanceController.attendanceDatas.value = [];
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Attendance Report",
                        style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 3, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  attendanceController.FromdateController,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "From Date",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.date,
                                ),
                              ),
                              onTap: () async {
                                var Frdate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary:
                                                Theme.of(context).primaryColor,
                                            onPrimary: Colors.white,
                                            onSurface:
                                                Colors.black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Colors
                                                  .black, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    });
                                attendanceController.FromdateController.text =
                                    Frdate.toString().substring(0, 10);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select Date';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 38),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: TextFormField(
                                readOnly: true,
                                controller:
                                    attendanceController.TodateController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "To Date",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon(Icons.calendar_month,
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                                onTap: () async {
                                  var Todate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2010),
                                      lastDate: DateTime.now(),
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
                                  attendanceController.TodateController.text =
                                      Todate.toString().substring(0, 10);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select Date';
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
                      padding:
                          const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        readOnly: true,
                        controller: reportsController.projectname,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
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
                        onTap: () async {
                          await reportsController.getReportProjectList(
                              type: "attendance Rpt");
                          if (mounted) {
                            bottomsheetControllers.projectNameReport(
                                context,
                                reportsController
                                    .getProjectdropDownvalue.value);
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == "--Select--") {
                            return '\u26A0 Please select project name.';
                          }
                          return null;
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
                      padding:
                          const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        readOnly: true,
                        controller: reportsController.sitename,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Site Name",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.siteName),
                        ),
                        onTap: () async {
                          await siteController.subcontEntry_siteDropdowntList(
                              context, 0,
                              type: "InwardReport");
                          if (mounted) {
                            bottomsheetControllers.siteNameReport(context,
                                siteController.getSiteDropdownvalue.value);
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '\u26A0 Please select site name.';
                          }
                          return null;
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
                      padding:
                          const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        readOnly: true,
                        controller: reportsController.subcontractorname,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Subcontractor Name",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.subcontractorName),
                        ),
                        onTap: () async {
                          await reportsController.getSubcontactorReportList();
                          if (mounted) {
                            bottomsheetControllers.subcontractorNameReport(
                                context,
                                reportsController.getdropDownvalue.value);
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == "--Select--") {
                            return '\u26A0 Please select Subcontractor name.';
                          }
                          return null;
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
                      padding:
                          const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        readOnly: true,
                        controller: attendanceController.workTypeController,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Work Type",
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return WorkType_AttendRPT();
                              });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '\u26A0 Please select work type';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            height:
                                BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: attendanceController.checkColor == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "List View",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: attendanceController.checkColor == 0
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              attendanceController.attendanceDatas.value = [];
                              await attendanceController
                                  .getAttendance_rptList();
                            }
                          },
                        ),
                        VerticalDivider(
                          color: Colors.grey.shade400,
                          width: 5,
                          thickness: 2,
                          indent: 15,
                          endIndent: 8, //Spacing at the bottom of divider.
                        ),
                        InkWell(
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            height:
                                BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: attendanceController.checkColor == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "PDF Download",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: attendanceController.checkColor == 0
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await download(
                                  reportsController.selectedProjectId.value,
                                  reportsController.selectedsiteId.value,
                                  reportsController.selectedSubcontId.value,
                                  attendanceController.wrktype.value,
                                  attendanceController.FromdateController.text,
                                  attendanceController.TodateController.text);
                            } else {}
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: BaseUtitiles.getheightofPercentage(context, 2),
                ),

                ListDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  download(int pId, int sId, int SubId, String wid, fdate, String todate) {
    launch("${ApiConfig.WebURL}mobile-nmr-weekly-report?fromDate=$fdate&toDate=$todate&projectId=$pId&siteId=$sId&labourId=$SubId&workType=$wid&access_token=${loginController.user.value.accessToken}");
    print("${ApiConfig.WebURL}mobile-nmr-weekly-report?fromDate=$fdate&toDate=$todate&projectId=$pId&siteId=$sId&labourId=$SubId&workType=$wid&access_token=${loginController.user.value.accessToken}");
  }

  List<PdfListModel> getSubContAttdList() {
    attendanceController.getSubcontAttdList_Pdf.clear();
    attendanceController.attendanceDatas.forEach((element) async {
      var list = PdfListModel(
        subContName: element.subContName,
        projectName: element.projectName,
        appStatus: element.appStatus,
        WorkType: element.WorkType,
      );
      attendanceController.getSubcontAttdList_Pdf.add(list);
    });
    return attendanceController.getSubcontAttdList_Pdf;
  }

  Widget ListDetails() {
    return Container(
      height: BaseUtitiles.getheightofPercentage(context, 50),
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: BaseUtitiles.getheightofPercentage(context, 48),
              width: BaseUtitiles.getWidthtofPercentage(context, 100),
              child: Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount:
                        attendanceController.attendanceDatas.value.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          attendanceController.OnItemsSelected(
                              attendanceController
                                  .attendanceDatas.value[index].attenId,
                              attendanceController
                                  .attendanceDatas.value[index].attenNo,
                              context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 3, right: 3, top: 5, bottom: 5),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 3, top: 5, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            ConstIcons.list_date,
                                            Text(
                                              (attendanceController
                                                  .attendanceDatas
                                                  .value[index]
                                                  .attenDate
                                                  .toString()),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          attendanceController.attendanceDatas
                                              .value[index].attenNo
                                              .toString(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 5,),
                                  //
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //         flex: 2,
                                  //         child: Text("Shift",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                                  //
                                  //     Expanded(
                                  //       flex: 2,
                                  //       child: Text(
                                  //         (attendanceController
                                  //             .attendanceDatas.value[index].shiftName.toString()),style: TextStyle(color: Colors.black),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  SizedBox(
                                    height: 5,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 2,
                                          child: Text("App Status",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          (attendanceController.attendanceDatas
                                              .value[index].appStatus
                                              .toString()
                                              .toUpperCase()),
                                          style: attendanceController
                                                      .attendanceDatas
                                                      .value[index]
                                                      .appStatus ==
                                                  "Pending in Approval"
                                              ? TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold)
                                              : TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 2,
                                          child: Text("Project",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            attendanceController.attendanceDatas
                                                .value[index].projectName
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 3,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 2,
                                          child: Text("SubContractor",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          attendanceController.attendanceDatas
                                              .value[index].subContName
                                              .toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 3,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 2,
                                          child: Text("WorkType",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          attendanceController.attendanceDatas
                                                      .value[index].WorkType ==
                                                  'NMR'
                                              ? 'Claimable NMR'
                                              : attendanceController
                                                          .attendanceDatas
                                                          .value[index]
                                                          .WorkType ==
                                                      'RATE'
                                                  ? 'Daily attendance'
                                                  : attendanceController
                                                      .attendanceDatas
                                                      .value[index]
                                                      .WorkType,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 2,
                                          child: Text("ShiftType",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          attendanceController.attendanceDatas
                                              .value[index].ShiftName,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
