import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/worktype_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/companycontroller.dart';
import '../../../../controller/dailyentries_controller.dart';
import '../../../../controller/dailyentries_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/image_view.dart';
import '../../../../utilities/print_logger.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import '../../../punch_in_out/camera_screen.dart';

class SubattendanceSiteEntry extends StatefulWidget {
  const SubattendanceSiteEntry({Key? key}) : super(key: key);

  @override
  State<SubattendanceSiteEntry> createState() => _SubAttendanceSiteEntryState();
}

class _SubAttendanceSiteEntryState extends State<SubattendanceSiteEntry> {
  CompanyController companyController = Get.put(CompanyController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController =
      Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  DailyEntriesController dailyEntriesController =
      Get.put(DailyEntriesController());
  AutoYearWiseNoController autoYearWiseNoController =
      Get.put(AutoYearWiseNoController());
  BottomsheetControllers bottomsheetControllers =
      Get.put(BottomsheetControllers());

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {

      if (dailyEntriesController.saveButton.value == RequestConstant.SUBMIT) {
        await autoYearWiseNoController.AutoYearWiseNo("SUBCONTRACTOR ATTENDANCE");
        await projectController.getProjectList();
        dailyEntriesController.deleteSubcontDetTableDatas();
        dailyEntriesController.readListdata.value=[];
        dailyEntriesController.autoYearWiseNoController.text = autoYearWiseNoController.SubcontAttendance_autoYrsWise.value;
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId = 0.obs;
        siteController.Sitename.text = "--SELECT--";
        siteController.selectedsiteId.value = 0;
        subcontractorController.Subcontractorname.text = "--SELECT--";
        subcontractorController.selectedSubcontId.value = 0;
        dailyEntriesController.attendId = 0;
        dailyEntriesController.AttendDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        dailyEntriesController.RemarksController.text = "";
        dailyEntriesController.WorkTypeTextController.text = "NMR";
        dailyEntriesController.Nmr_Rate.value = RequestConstant.N;
      }

      if (dailyEntriesController.saveButton.value == RequestConstant.RESUBMIT || dailyEntriesController.saveButton.value == RequestConstant.APPROVAL ) {
        dailyEntriesController.EditListResDatas.forEach((element) async {
          DLRId = element.id;
          dailyEntriesController.attendId = element.id!;
          dailyEntriesController.AttendDateController.text = element.labourAttendanceDate;
          dailyEntriesController.autoYearWiseNoController.text = element.labourAttendanceNo;
          projectController.projectname.text = element.projectName;
          projectController.selectedProjectId.value = element.projectId;
          subcontractorController.Subcontractorname.text = element.subContractorName;
          subcontractorController.selectedSubcontId.value = element.subcontractorId;
          siteController.Sitename.text = element.siteName;
          siteController.selectedsiteId.value = element.siteId;
          dailyEntriesController.RemarksController.text = element.remarks;
          dailyEntriesController.WorkTypeTextController.text = element.workType! == "N" ? "NMR" : element.workType! == "R" ? "Rate" : "";
          dailyEntriesController.Nmr_Rate.value = element.workType!;
        });
        await dailyEntriesController.gettingImage();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
    return WillPopScope(
      onWillPop: () async {
        await subcontractorController.checkSubcontList();
        print("${subcontractorController.checkScreen}");
        return true;
      },
      child: Form(
        key: _formkey,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: Setmybackground,
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
                            const Text(
                              "SubContractor Attendance",
                              style: TextStyle(
                                fontSize: RequestConstant.Heading_Font_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                                onPressed: () async {
                                  await subcontractorController
                                      .checkSubcontList();
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  "Back",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                              readOnly: true,
                              controller: dailyEntriesController
                                  .autoYearWiseNoController,
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
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 2, left: 10, right: 10),
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
                                    readOnly: true,
                                    controller: dailyEntriesController
                                        .AttendDateController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Date",
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              RequestConstant.Lable_Font_SIZE),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
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
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      ColorScheme.light(
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
                                        dailyEntriesController
                                                .AttendDateController.text =
                                            BaseUtitiles.selectDateFormat(
                                                Entrydate!);
                                      }
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                                  AutovalidateMode.onUserInteraction,
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
                              onTap: () {
                                if (dailyEntriesController.saveButton.value == RequestConstant.SUBMIT ){
                                    bottomsheetControllers.ProjectName(
                                        context,
                                        projectController
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
                                  AutovalidateMode.onUserInteraction,
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
                                if (dailyEntriesController.saveButton.value == RequestConstant.SUBMIT ){
                                    bottomsheetControllers.SiteName(
                                        context,
                                        siteController
                                            .getSiteDropdownvalue.value);
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
                                  AutovalidateMode.onUserInteraction,
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
                                if (dailyEntriesController.saveButton.value == RequestConstant.SUBMIT ){
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
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                if (dailyEntriesController.saveButton.value == RequestConstant.SUBMIT ){
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
                                  AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              controller:
                                  dailyEntriesController.RemarksController,
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
                      SizedBox(
                          height:
                              BaseUtitiles.getheightofPercentage(context, 1)),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Setmybackground,
                                  ),
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      _formkey.currentState!.save();
                                        dailyEntriesController.getShowClickPopList(context);
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        flex: 8,
                                        child: Text(
                                          "Add Labour Details",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Setmybackground,
                                  ),
                                  onPressed: () async {

                                    if (dailyEntriesController.saveButton.value == RequestConstant.APPROVAL) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Image can't add in approve stage");
                                    } else if (dailyEntriesController
                                            .WorkTypeTextController.text ==
                                        "No Work") {
                                      Fluttertoast.showToast(
                                          msg: "No Work can't add Image");
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => CameraCapturePage(
                                                  fromScreen:
                                                      "Subcontractor Attendance",
                                                )),
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text(
                                        "Add Image",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.05),

                      Obx(() {
                        final allImages = [
                          ...dailyEntriesController.gettingNetworkImages,
                          ...dailyEntriesController.imageFiles,
                        ];

                        if (allImages.isEmpty) return SizedBox();
                        return Container(
                          height:
                              BaseUtitiles.getheightofPercentage(context, 37),
                          width:
                              BaseUtitiles.getWidthtofPercentage(context, 95),
                          child: Builder(
                            builder: (context){
                              return GridView.builder(
                                padding: const EdgeInsets.all(8),
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1,
                                ),
                                itemCount: allImages.length,
                                itemBuilder: (context, index) {
                                  final image = allImages[index];
                                  final isNetwork = image
                                      is String; // URL → network, File → local

                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: isNetwork
                                                ? Image.network(
                                              "$image?time=${DateTime.now().millisecondsSinceEpoch}",
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  )
                                                : Image.file(
                                                    image
                                                        as File, // 👈 cast to File
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  ),
                                          ),
                                        ),
                                        onTap: () {
                                          if (image is String) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageViewPage(
                                                          imageUrl: "$image?time=${DateTime.now().millisecondsSinceEpoch}",
                                                          netUrl: true,
                                                        )));
                                          } else if (image is File) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageViewPage(
                                                          imagePath: image,
                                                          netUrl: false,
                                                        )));
                                          }
                                        },
                                      ),
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: GestureDetector(
                                          onTap: () {
                                              if (image is String) {
                                                DeleteAlert(
                                                    context, index, "String");
                                              } else if (image is File) {
                                                DeleteAlert(
                                                    context, index, "File");
                                              }
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 12,
                                            child: Icon(Icons.close,
                                                color: Colors.white, size: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }),

                      SizedBox(height: height),
                    ],
                  ),
                ),
                Obx(() => Visibility(
                      visible: dailyEntriesController.readListdata.value.isEmpty
                          ? false
                          : true,
                      child: SizedBox(
                        height:
                            BaseUtitiles.getheightofPercentage(context, 100),
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
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            ListDetails(
                                                context, scrollController),
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
                                            margin: const EdgeInsets.only(
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
                    )),
              ],
            ),
            bottomNavigationBar: Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color:  Colors.white
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color:  Theme.of(context).primaryColor),
                        ),
                      ),
                      onTap: () {
                        ResetAlert(context);
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
                            color:  Theme.of(context).primaryColor
                          ),
                          alignment: Alignment.center,
                          child: Obx(
                            () => Text(
                              dailyEntriesController.saveButton.value,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RequestConstant.Lable_Font_SIZE,
                                  color:  Colors.white
                              ),
                            ),
                          )),
                      onTap: () {
                       if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          if (dailyEntriesController.readListdata.isEmpty) {
                            Fluttertoast.showToast(msg: "Please add labour details");
                          } else {
                            SubmitAlert(context);
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
      ),
    );
  }

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
        SizedBox(
          height: MediaQuery.of(context).size.height * 75 / 100,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: dailyEntriesController.readListdata.value.length,
            itemBuilder: (BuildContext context, int index) {
              dailyEntriesController.textControllersInitiate();
              return SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  color: Colors.white,
                  // margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 10, right: 25),
                              child: Text(
                                '${dailyEntriesController.readListdata.value[index].siteName}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      RequestConstant.DO_YOU_WANT_DELETE,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    actions: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Cancel",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                RequestConstant
                                                                    .Lable_Font_SIZE))),
                                              ),
                                              VerticalDivider(
                                                color: Colors.grey.shade400,
                                                width: 5,
                                                thickness: 2,
                                                indent: 15,
                                                endIndent:
                                                    15, //Spacing at the bottom of divider.
                                              ),
                                              Expanded(
                                                child: TextButton(
                                                    onPressed: () {
                                                      dailyEntriesController
                                                          .deleteParticularList(
                                                              dailyEntriesController
                                                                      .readListdata[
                                                                  index]);
                                                      dailyEntriesController
                                                          .getDetTablesDatas();
                                                      dailyEntriesController
                                                          .readListdata
                                                          .remove(dailyEntriesController
                                                                  .readListdata[
                                                              index]);
                                                      Navigator.pop(
                                                          context,
                                                          dailyEntriesController
                                                              .readListdata);
                                                    },
                                                    child: const Text("Delete",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                RequestConstant
                                                                    .Lable_Font_SIZE))),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: ConstIcons.cancle))
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 5),
                        child: Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: dailyEntriesController
                                            .readListdata.value[index].catName +
                                        "  ",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        "( ${RequestConstant.CURRENCY_SYMBOL}${dailyEntriesController.readListdata.value[index].wages} )",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 5, right: 3),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: "Nos",
                                      ),
                                      TextSpan(
                                        text: dailyEntriesController
                                                        .EntrySCreenNosControllers[
                                                            index]
                                                        .text !=
                                                    "" &&
                                                dailyEntriesController
                                                        .EntrySCreenNosControllers[
                                                            index]
                                                        .text !=
                                                    "0" &&
                                                dailyEntriesController
                                                        .EntrySCreenNosControllers[
                                                            index]
                                                        .text !=
                                                    "0.0"
                                            ? ""
                                            : " *",
                                        style: TextStyle(
                                          color: dailyEntriesController
                                                          .EntrySCreenNosControllers[
                                                              index]
                                                          .text !=
                                                      "" &&
                                                  dailyEntriesController
                                                          .EntrySCreenNosControllers[
                                                              index]
                                                          .text !=
                                                      "0" &&
                                                  dailyEntriesController
                                                          .EntrySCreenNosControllers[
                                                              index]
                                                          .text !=
                                                      "0.0"
                                              ? Colors.white
                                              : Colors.red,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),

                              // Text(
                              //   RequestConstant.NOS,
                              //   style: TextStyle(color: Colors.black),
                              // ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                      onTap: () {
                                        if (dailyEntriesController
                                                    .EntrySCreenNosControllers[
                                                        index]
                                                    .text !=
                                                "" &&
                                            dailyEntriesController
                                                    .EntrySCreenNosControllers[
                                                        index]
                                                    .text !=
                                                "0" &&
                                            dailyEntriesController
                                                    .EntrySCreenNosControllers[
                                                        index]
                                                    .text !=
                                                "0.0") {
                                          return;
                                        } else {
                                          setState(() {
                                            dailyEntriesController
                                                .EntrySCreenNosControllers[
                                                    index]
                                                .text = "";
                                            dailyEntriesController.clickEdit();
                                          });
                                        }
                                      },
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: dailyEntriesController
                                          .EntrySCreenNosControllers[index],
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          dailyEntriesController.clickEdit();
                                        });
                                      }),
                                )),
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Extras",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                              // Text(
                              //   "Extras",
                              //   style: TextStyle(color: Colors.black),
                              // ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                      onTap: () {
                                        if (dailyEntriesController
                                                    .ExtrasControllers[index]
                                                    .text !=
                                                "" &&
                                            dailyEntriesController
                                                    .ExtrasControllers[index]
                                                    .text !=
                                                "0" &&
                                            dailyEntriesController
                                                    .ExtrasControllers[index]
                                                    .text !=
                                                "0.0") {
                                          return;
                                        } else {
                                          setState(() {
                                            dailyEntriesController
                                                .ExtrasControllers[index]
                                                .text = "";
                                            dailyEntriesController.clickEdit();
                                          });
                                        }
                                      },
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: dailyEntriesController
                                          .ExtrasControllers[index],
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          dailyEntriesController.clickEdit();
                                        });
                                      })),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 5, right: 3),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Morning OT Hrs",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),

                              // Text(
                              //   "Mrng OT Nos",
                              //   style: TextStyle(color: Colors.black),
                              // ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                      onTap: () {
                                        if (dailyEntriesController
                                                    .MrngOtHrsControllers[index]
                                                    .text !=
                                                "" &&
                                            dailyEntriesController
                                                    .MrngOtHrsControllers[index]
                                                    .text !=
                                                "0" &&
                                            dailyEntriesController
                                                    .MrngOtHrsControllers[index]
                                                    .text !=
                                                "0.0") {
                                          return;
                                        } else {
                                          setState(() {
                                            dailyEntriesController
                                                .MrngOtHrsControllers[index]
                                                .text = "";
                                            dailyEntriesController.clickEdit();
                                          });
                                        }
                                      },
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: dailyEntriesController
                                          .MrngOtHrsControllers[index],
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          dailyEntriesController.clickEdit();
                                        });
                                      }),
                                )),
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Morning OT Amt",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),

                              // Text(
                              //   "Mrg OT Amt",
                              //   style: TextStyle(color: Colors.black),
                              // ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextField(
                                      readOnly: true,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: dailyEntriesController
                                          .MrngOtAmtControllers[index],
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          dailyEntriesController.clickEdit();
                                        });
                                      })),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 5, right: 3),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Evening OT Hrs",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                              // Text(
                              //   "Evg OT Hrs",
                              //   style: TextStyle(color: Colors.black),
                              // ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                      onTap: () {
                                        if (dailyEntriesController
                                                    .EvgOtHrsControllers[index]
                                                    .text !=
                                                "" &&
                                            dailyEntriesController
                                                    .EvgOtHrsControllers[index]
                                                    .text !=
                                                "0" &&
                                            dailyEntriesController
                                                    .EvgOtHrsControllers[index]
                                                    .text !=
                                                "0.0") {
                                          return;
                                        } else {
                                          setState(() {
                                            dailyEntriesController
                                                .EvgOtHrsControllers[index]
                                                .text = "";
                                            dailyEntriesController.clickEdit();
                                          });
                                        }
                                      },
                                      controller: dailyEntriesController
                                          .EvgOtHrsControllers[index],
                                      style:
                                          const TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          dailyEntriesController.clickEdit();
                                        });
                                      }),
                                )),
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Evening OT Amt",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                              // Text(
                              //   "Evg OT Amt",
                              //   style: TextStyle(color: Colors.black),
                              // ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextField(
                                    readOnly: true,
                                    controller: dailyEntriesController
                                        .EvgOtAmtControllers[index],
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          8.0, 0.0, 8.0, 0.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 5, right: 3),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Ext Amt",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                              // Text(
                              //   "Evg Ext Amt",
                              //   style: TextStyle(color: Colors.black),
                              // ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextField(
                                      onTap: () {
                                        if (dailyEntriesController
                                                    .EvgExtraAmtControllers[
                                                        index]
                                                    .text !=
                                                "" &&
                                            dailyEntriesController
                                                    .EvgExtraAmtControllers[
                                                        index]
                                                    .text !=
                                                "0" &&
                                            dailyEntriesController
                                                    .EvgExtraAmtControllers[
                                                        index]
                                                    .text !=
                                                "0.0") {
                                          return;
                                        } else {
                                          setState(() {
                                            dailyEntriesController
                                                .EvgExtraAmtControllers[index]
                                                .text = "";
                                            dailyEntriesController.clickEdit();
                                          });
                                        }
                                      },
                                      controller: dailyEntriesController
                                          .EvgExtraAmtControllers[index],
                                      style:
                                          const TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          dailyEntriesController.clickEdit();
                                        });
                                      }),
                                )),
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Net Amt",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),

                              // Text(
                              //   "Net Amt",
                              //   style: TextStyle(color: Colors.black),
                              // ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextField(
                                    readOnly: true,
                                    controller: dailyEntriesController
                                        .NetAmtController[index],
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          8.0, 0.0, 8.0, 0.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 10, left: 5, right: 3, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Remarks",
                                      ),
                                      TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),

                              // Text(
                              //   "Remarks",
                              //   style: TextStyle(color: Colors.black),
                              // ),
                            ),
                            Expanded(
                                flex: 10,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 0),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                    onTap: () {
                                      dailyEntriesController
                                          .RemarksControllers[index].text = "";
                                    },
                                    textAlign: TextAlign.center,
                                    controller: dailyEntriesController
                                        .RemarksControllers[index],
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          8.0, 0.0, 8.0, 0.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        dailyEntriesController
                                            .updateSubcontDetValue();
                                      });
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: BaseUtitiles.getheightofPercentage(context, 4)),
      ],
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
                          Future.delayed(Duration(seconds: 0), () async {
                            setState(() {
                              if (dailyEntriesController.saveButton.value != RequestConstant.APPROVAL) {
                                dailyEntriesController.readListdata.value
                                    .clear();
                                dailyEntriesController
                                    .deleteSubcontDetTableDatas();
                                siteController.selectedsiteId.value = 0;
                                subcontractorController
                                    .selectedSubcontId.value = 0;
                                siteController.getSiteDropdownvalue.value
                                    .clear();
                                dailyEntriesController.saveButton.value =
                                    RequestConstant.SUBMIT;
                                dailyEntriesController.attendId = 0;
                                projectController.selectedProjectId = 0.obs;
                                dailyEntriesController
                                        .AttendDateController.text =
                                    BaseUtitiles.initiateCurrentDateFormat();
                                dailyEntriesController
                                        .autoYearWiseNoController.text =
                                    autoYearWiseNoController
                                        .SubcontAttendance_autoYrsWise.value;
                                dailyEntriesController.RemarksController.text =
                                    "";
                                projectController.projectname.text =
                                    "--SELECT--";
                                subcontractorController.Subcontractorname.text =
                                    "--SELECT--";
                                subcontractorController
                                    .selectedSubcontId.value = 0;
                                siteController.Sitename.text = "--SELECT--";
                                siteController.siteDropdownName.clear();
                                dailyEntriesController
                                    .WorkTypeTextController.text = "NMR";
                                dailyEntriesController.Nmr_Rate.value =
                                    RequestConstant.N;
                                bottomsheetControllers.searchcontroller.text =
                                    "";
                                dailyEntriesController.imageFiles.value = [];
                                Navigator.pop(context);
                              } else {
                                BaseUtitiles.showToast(
                                    "In this approval page can't be reset");
                              }
                            });
                          });
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
        content: Text('Are you sure to ${dailyEntriesController.saveButton.value}?'),
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
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),

                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) => TextButton(
                        onPressed: () async {
                            if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                              await dailyEntriesController.getDetTablesDatas();
                              await dailyEntriesController.SaveEntryScreen(
                                context,
                                dailyEntriesController.attendId != 0
                                    ? dailyEntriesController.attendId
                                    : 0
                              );
                            }
                        },
                        child: Text(
                          dailyEntriesController.saveButton.value,
                          style: TextStyle(
                            color:  Theme.of(context).primaryColor,
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

  Future DeleteAlert(BuildContext context, int index, itemType) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Do you want to Delete?'),
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
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if (itemType == "String") {
                            final imageId = dailyEntriesController.imageIds[index];

                            final isDeleted = await dailyEntriesController.deletingImage(imageId);

                            if (isDeleted) {
                              dailyEntriesController.gettingNetworkImages.removeAt(index);
                            }
                          } else if (itemType == "File") {
                            int localIndex = index -
                                dailyEntriesController
                                    .gettingNetworkImages.length;
                            if (localIndex >= 0 &&
                                localIndex <
                                    dailyEntriesController.imageFiles.length) {
                              setState(() {
                                dailyEntriesController.imageFiles
                                    .removeAt(localIndex);
                              });
                            }
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Delete",
                            style: TextStyle(
                                color: Colors.red,
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
