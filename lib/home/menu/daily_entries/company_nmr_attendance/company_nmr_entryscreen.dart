import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/worktype_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/dailyentries_controller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../home/menu/daily_entries/company_nmr_attendance/statusalert.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/company_nmr_controller.dart';
import '../../../../controller/companycontroller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Company_nmr_entryscreen extends StatefulWidget {
  final String heading;
  const Company_nmr_entryscreen({Key? key,required this.heading}) : super(key: key);

  @override
  State<Company_nmr_entryscreen> createState() =>
      _Company_nmr_entryscreenState();
}

class _Company_nmr_entryscreenState extends State<Company_nmr_entryscreen> {
  CompanyNmrAttendanceController companyNmrAttendanceController =
      Get.put(CompanyNmrAttendanceController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  CompanyController companyController = Get.put(CompanyController());
  AutoYearWiseNoController autoYearWiseNoController =
      Get.put(AutoYearWiseNoController());
  LoginController loginController = Get.put(LoginController());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  DailyEntriesController dailyEntriesController =
      Get.put(DailyEntriesController());

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      if (companyNmrAttendanceController.saveButton.value == RequestConstant.SUBMIT) {
        companyNmrAttendanceController.attendId = 0;
        companyNmrAttendanceController.Company_EntryDate.text = BaseUtitiles.initiateCurrentDateFormat();
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        siteController.Sitename.text = "--SELECT--";
        siteController.selectedsiteId.value = 0;
        subcontractorController.Subcontractorname.text = "--SELECT--";
        subcontractorController.selectedSubcontId.value = 0;
        dailyEntriesController.WorkTypeTextController.text = "NMR";
        dailyEntriesController.Nmr_Rate.value = RequestConstant.N;
        companyNmrAttendanceController.delete_cmpNmrdetTable();
        companyNmrAttendanceController.cmpNmr_getDbDetList.clear();
        companyNmrAttendanceController.Company_EntryRemarks.text = "";
        await autoYearWiseNoController.AutoYearWiseNo("COMPANY NMR");
        companyNmrAttendanceController.Company_EntryNo.text =
            autoYearWiseNoController.companyNMR_autoYrsWise.value;
      }

      else if(companyNmrAttendanceController.saveButton.value == RequestConstant.RESUBMIT || companyNmrAttendanceController.saveButton.value == RequestConstant.APPROVAL) {
          companyNmrAttendanceController.EditListApiValue.forEach((element) {
            companyNmrAttendanceController.attendId=element.id;
            companyNmrAttendanceController.Company_EntryNo.text=element.nmrLabourAttendanceNo.toString();
            companyNmrAttendanceController.Company_EntryDate.text=element.nmrLabourAttendanceDate;
            projectController.selectedProjectId.value=element.projectId;
            projectController.projectname.text=element.projectName.toString();
            siteController.selectedsiteId.value=element.siteId;
            siteController.Sitename.text=element.siteName.toString();
            subcontractorController.Subcontractorname.text = element.subContractorName.toString();
            subcontractorController.selectedSubcontId.value = element.subContractorId;
            dailyEntriesController.WorkTypeTextController.text = element.workType! == "N" ? "NMR" : element.workType! == "R" ? "Rate" : "";
            dailyEntriesController.Nmr_Rate.value = element.workType!;
            companyNmrAttendanceController.Company_EntryRemarks.text=element.remarks.toString();
          });
        }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Form(
        key: _formkey,
        child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height:
                      BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Theme.of(context).primaryColor
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
                        height:
                        BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).primaryColor
                        ),
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                          companyNmrAttendanceController.saveButton.value,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color:
                               Colors.white
                                  ),
                        ))),
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        if(companyNmrAttendanceController
                            .cmpNmr_getDbDetList.value.isEmpty)
                        {
                          BaseUtitiles.showToast("Please add labour details");
                        }else{
                          SubmitAlert(context);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.heading,
                              style: TextStyle(
                                  fontSize: companyNmrAttendanceController.saveButton.value == RequestConstant.APPROVAL ? 16 : RequestConstant.Heading_Font_SIZE,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Back",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                companyNmrAttendanceController.Company_EntryNo,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Attendance No",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
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
                      margin:
                          const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                              readOnly: true,
                              controller: companyNmrAttendanceController
                                  .Company_EntryDate,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Date",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.date),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '\u26A0 Enter user name';
                                }
                                return null;
                              },
                              onTap: () async {
                                var Entrydate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    // .subtract(
                                    // const Duration(days: 1)),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary:
                                                Theme.of(context).primaryColor,
                                            // header background color
                                            onPrimary: Colors.white,
                                            // header text color
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
                                companyNmrAttendanceController
                                        .Company_EntryDate.text =
                                    BaseUtitiles.selectDateFormat(Entrydate!);
                              }),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.always,
                            readOnly: true,
                            controller: projectController.projectname,
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
                              if (companyNmrAttendanceController
                                      .saveButton.value ==
                                  RequestConstant.SUBMIT) {
                                await projectController.getProjectList();
                                bottomsheetControllers.ProjectName(context,
                                    projectController.getdropDownvalue.value);
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
                      margin:
                          const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.always,
                            readOnly: true,
                            controller: siteController.Sitename,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
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
                              if (companyNmrAttendanceController
                                      .saveButton.value ==
                                  RequestConstant.SUBMIT) {
                                bottomsheetControllers.SiteName(context,
                                    siteController.getSiteDropdownvalue.value);
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
                      margin:
                          const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.always,
                            readOnly: true,
                            controller:
                                subcontractorController.Subcontractorname,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "SubContractor Name",
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
                            onTap: () {
                              if (companyNmrAttendanceController
                                      .saveButton.value ==
                                  RequestConstant.SUBMIT) {
                                bottomsheetControllers.SubcontractorName(
                                    context,
                                    subcontractorController
                                        .getdropDownvalue.value);
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
                      margin:
                          const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            autovalidateMode:
                                AutovalidateMode.always,
                            controller:
                                dailyEntriesController.WorkTypeTextController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
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
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value == "--Select--" ||
                                  value == "--SELECT--") {
                                return '\u26A0 ${RequestConstant.VALIDATE}';
                              }
                              return null;
                            },
                            onTap: () {
                              if (companyNmrAttendanceController
                                      .saveButton.value ==
                                  RequestConstant.SUBMIT) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const WorkTypeAlert();
                                    });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.always,
                            readOnly: false,
                            controller: companyNmrAttendanceController
                                .Company_EntryRemarks,
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
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return '\u26A0 ${RequestConstant.VALIDATE}';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: BaseUtitiles.getheightofPercentage(context, 1)),
                    Center(
                      child: SizedBox(
                        width: 220, // Fixed width
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Setmybackground,
                          ),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              companyNmrAttendanceController.getLabourList(
                                  context,
                                  subcontractorController
                                      .selectedSubcontId.value);
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Add Labour Details",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(() => Visibility(
                  visible: companyNmrAttendanceController
                          .cmpNmr_getDbDetList.value.isEmpty
                      ? false
                      : true,
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 95),
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
                                      MediaQuery.of(context).size.height * 1,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: ListDetails(
                                                context, scrollController)),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                  ))),
            ],
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
                          companyNmrAttendanceController.saveButton.value=RequestConstant.SUBMIT;
                          companyNmrAttendanceController.attendId = 0;
                          companyNmrAttendanceController.Company_EntryDate.text =
                              BaseUtitiles.initiateCurrentDateFormat();
                          projectController.projectname.text = "--SELECT--";
                          projectController.selectedProjectId.value = 0;
                          siteController.Sitename.text = "--SELECT--";
                          siteController.selectedsiteId.value = 0;
                          subcontractorController.Subcontractorname.text = "--SELECT--";
                          subcontractorController.selectedSubcontId.value = 0;
                          dailyEntriesController.WorkTypeTextController.text = "NMR";
                          dailyEntriesController.Nmr_Rate.value = RequestConstant.N;
                          companyNmrAttendanceController.delete_cmpNmrdetTable();
                          companyNmrAttendanceController.cmpNmr_getDbDetList.clear();
                          companyNmrAttendanceController.Company_EntryRemarks.text = "";
                          await autoYearWiseNoController.AutoYearWiseNo("COMPANY NMR");
                          companyNmrAttendanceController.Company_EntryNo.text =
                              autoYearWiseNoController.companyNMR_autoYrsWise.value;
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
        content: Text( 'Are you sure to ${companyNmrAttendanceController.saveButton.value}?'),
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
                        onPressed: () async {
                            await companyNmrAttendanceController
                                .getcmpNMRTablesDatas();
                            if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                              await companyNmrAttendanceController
                                  .SaveAPI(
                                context,
                                companyNmrAttendanceController.attendId,
                              );
                            }
                        },
                        child: Text(
                          companyNmrAttendanceController.saveButton.value,
                          style: TextStyle(
                            color:  Theme.of(context).primaryColor,
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

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2)),
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: Obx(() => ListView.builder(
                shrinkWrap: true,
                // padding: EdgeInsets.only(bottom: 50   ),
                physics: BouncingScrollPhysics(),
                itemCount: companyNmrAttendanceController.cmpNmr_getDbDetList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  companyNmrAttendanceController
                      .textControllersInitiate();
                  return Container(
                    margin: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 0),
                    child: Column(
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          margin: EdgeInsets.only(left: 5, right: 5,top: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        companyNmrAttendanceController.cmpNmr_getDbDetList.value[index].labourName.toString(),
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize: RequestConstant.ALERT_Font_SIZE,
                                            color:Colors.black),
                                      ),
                                    ),
                                    Expanded(flex: 1,
                                      child: Text(
                                        "   ${companyNmrAttendanceController
                                            .cmpNmr_getDbDetList.value[index].categaryName
                                            .toString()}",
                                        style: TextStyle(
                                          fontSize: RequestConstant.ALERT_Font_SIZE,
                                          color: Theme.of(context).primaryColor,fontWeight:
                                        FontWeight
                                            .bold,),
                                      ),
                                    ),
                                    Expanded(flex: 3,
                                      child: Text(
                                        "  ( ₹ ${companyNmrAttendanceController
                                            .cmpNmr_getDbDetList.value[index].wages
                                            .toString()} ) ",
                                        style: TextStyle(
                                          fontSize: RequestConstant.ALERT_Font_SIZE,
                                          color: Colors.red,fontWeight:
                                        FontWeight
                                            .bold,),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context:
                                          context,
                                          builder:
                                              (context) =>
                                              AlertDialog(
                                                title:
                                                const Text(
                                                  RequestConstant.DO_YOU_WANT_DELETE,
                                                  style:
                                                  TextStyle(color: Colors.black),
                                                ),
                                                actions: <Widget>[
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
                                                            onPressed: () {
                                        companyNmrAttendanceController
                                            .deleteParticularList(
                                        companyNmrAttendanceController
                                            .cmpNmr_getDbDetList
                                            .value[index]);
                                        companyNmrAttendanceController
                                            .cmpNmr_getDbDetList
                                            .remove(
                                        companyNmrAttendanceController
                                            .cmpNmr_getDbDetList
                                            .value[index]);
                                        companyNmrAttendanceController
                                            .getcmpNMRTablesDatas();
                                        Navigator.pop(context);
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
                                      },
                                      child: const Icon(
                                          Icons
                                              .remove_circle,
                                          color: Colors
                                              .red),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "Status ",
                                          style: TextStyle(
                                            fontSize: RequestConstant.Dropdown_Font_SIZE,
                                            color: Colors.black),
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(top: 5, right: 5),
                                      height: BaseUtitiles.getheightofPercentage(
                                          context, 4),
                                      width: BaseUtitiles.getWidthtofPercentage(
                                          context, 24),
                                      child: TextField(
                                        readOnly: true,
                                        cursorColor: Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: companyNmrAttendanceController
                                            .statusText[index],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:  Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(5))),
                                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5))),
                                        ),
                                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),
                                        onTap: () async {
                                          await companyNmrAttendanceController.getLabourStatusList();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return StatusAlert(
                                                    value:
                                                    companyNmrAttendanceController
                                                        .cmpNmr_getDbDetList
                                                        .value[index]
                                                        .labourId);
                                              });
                                        },
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "OT Hrs",
                                          style: TextStyle(
                                            fontSize: RequestConstant.Dropdown_Font_SIZE,
                                            color: Colors.black),
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(top: 5, right: 5),
                                      height: BaseUtitiles.getheightofPercentage(
                                          context, 4),
                                      width: BaseUtitiles.getWidthtofPercentage(
                                          context, 22),
                                      child: TextField(
                                        cursorColor: Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: companyNmrAttendanceController
                                            .oThrsText[index],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor), borderRadius: const BorderRadius.all(Radius.circular(5))),
                                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5))),

                                        ),
                                        style: TextStyle(color: Colors.black,),
                                        onChanged: (value) {
                                          companyNmrAttendanceController
                                              .updateDBTables();
                                        },
                                        onTap: (){
                                          if(companyNmrAttendanceController.oThrsText[index].text=="0.0"||companyNmrAttendanceController.oThrsText[index].text=="0"){
                                            companyNmrAttendanceController.oThrsText[index].text="";
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1)),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "Remarks",
                                          style: TextStyle(
                                            fontSize: RequestConstant.Dropdown_Font_SIZE,
                                            color: Colors.black),
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 5, right: 5, bottom: 5),
                                      height: BaseUtitiles.getheightofPercentage(
                                          context, 4),
                                      width: BaseUtitiles.getWidthtofPercentage(
                                          context, 74),
                                      child: TextField(
                                        cursorColor: Theme.of(context).primaryColor,
                                        textAlign: TextAlign.center,
                                        controller: companyNmrAttendanceController
                                            .remarksText[index],
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor), borderRadius: const BorderRadius.all(Radius.circular(5))),
                                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5))),

                                        ),
                                        style: TextStyle(color: Colors.black,),
                                        onChanged: (value) {
                                          companyNmrAttendanceController
                                              .updateDBTables();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1)),
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
