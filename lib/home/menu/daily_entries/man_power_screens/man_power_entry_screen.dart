import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/man_power_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class ManPowerEntrySreen extends StatefulWidget {
  final String heading;
  const ManPowerEntrySreen({Key? key,required this.heading}) : super(key: key);

  @override
  State<ManPowerEntrySreen> createState() => _ManPowerEntrySreenState();
}

class _ManPowerEntrySreenState extends State<ManPowerEntrySreen> {
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  ManPowerController manPowerController=Get.put(ManPowerController());
  LoginController loginController = Get.put(LoginController());

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      if (manPowerController.saveButton.value == RequestConstant.SUBMIT) {
        manPowerController.readListdata.value=[];
        manPowerController.deleteSubcontDetTableDatas();
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        siteController.Sitename.text = "--SELECT--";
        siteController.selectedsiteId.value = 0;
        siteController.headNameController.text = "--SELECT--";
        siteController.selectedHeadId.value = 0;
        manPowerController.selectedIds.value=[];
        manPowerController.manpowerLevel3ItemList.value=[];
        await autoYearWiseNoController.AutoYearWiseNo("MANPOWER");
        manPowerController.autoYearWiseNoController.text = autoYearWiseNoController.ManPower_autoYrsWise.value;
        manPowerController.ManPowerEntryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        manPowerController.ManPowerReqDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        manPowerController.ManPowerDueDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        manPowerController.preparedbyController.text = loginController.EmpName();
        manPowerController.createdById.value = 0;
        manPowerController.RemarksController.text = "";
        manPowerController.AppRemarksController.text = "";
      }
      else {
        for (int j = 0; j < manPowerController.manpowerEditApiValue.length; j++) {
          final element = manPowerController.manpowerEditApiValue[j];

          projectController.projectname.text = element.projectName!;
          projectController.selectedProjectId.value = element.projectId!;
          siteController.Sitename.text = element.siteName!;
          siteController.selectedsiteId.value = element.siteId!;
          siteController.headNameController.text = element.materialHeadName!;
          siteController.selectedHeadId.value = element.headItemId!;
          manPowerController.autoYearWiseNoController.text = element.manPowerNo!;
          manPowerController.ManPowerEntryDateController.text = element.entryDate!;
          manPowerController.ManPowerReqDateController.text = element.reqDate!;
          manPowerController.ManPowerDueDateController.text = element.dueDate!;
          manPowerController.preparedbyController.text = element.createdByName!;
          manPowerController.createdById.value = element.createdBy!;
          manPowerController.RemarksController.text = element.remarks!;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
    return Form(
      key: _formkey,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                                fontSize: manPowerController.saveButton.value == RequestConstant.APPROVAL ? 16 : RequestConstant.Heading_Font_SIZE,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                await manPowerController
                                    .ManPower_EntryList();
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
                            controller: manPowerController.autoYearWiseNoController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Manpower No",
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
                                    controller: manPowerController
                                        .ManPowerEntryDateController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Entry Date",
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
                                        manPowerController
                                            .ManPowerEntryDateController.text =
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
                                    controller: manPowerController
                                        .ManPowerReqDateController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Req Date",
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
                                    onTap: () async {
                                      DateTime? entryDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000), // Earliest selectable date
                                        lastDate: DateTime(2100),  // Latest selectable date
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context).primaryColor,
                                                onPrimary: Colors.white,
                                                onSurface: Colors.black,
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );

                                      if (entryDate != null) {
                                        manPowerController.ManPowerReqDateController.text =
                                            BaseUtitiles.selectDateFormat(entryDate);

                                        if (manPowerController.ManPowerDueDateController.text.isNotEmpty) {
                                          final dueDate = DateTime.parse(
                                            manPowerController.ManPowerDueDateController.text,
                                          );

                                          if (dueDate.isBefore(entryDate)) {
                                            manPowerController.ManPowerDueDateController.text =
                                                BaseUtitiles.selectDateFormat(entryDate);
                                          }
                                        }
                                      }
                                    }
                                ),
                              ),
                            ),
                          ),
                        ),
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
                                    controller: manPowerController
                                        .ManPowerDueDateController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      labelText: "Req Due Date",
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
                                    onTap: () async {
                                      DateTime? entryDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.parse(manPowerController.ManPowerReqDateController.text),
                                        firstDate:DateTime.parse(manPowerController.ManPowerReqDateController.text),
                                        lastDate: DateTime(2100),  // Latest selectable date
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context).primaryColor,
                                                onPrimary: Colors.white,
                                                onSurface: Colors.black,
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );

                                      if (entryDate != null) {
                                        manPowerController.ManPowerDueDateController.text =
                                            BaseUtitiles.selectDateFormat(entryDate);
                                      }
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
                              if (manPowerController.saveButton.value == RequestConstant.SUBMIT ){
                                await projectController.getProjectList();
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
                              if (manPowerController.saveButton.value == RequestConstant.SUBMIT ){
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
                            autovalidateMode: AutovalidateMode.always,
                            readOnly: true,
                            controller: siteController.headNameController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Head Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.dcNo),
                            ),
                            onTap: () async {
                              await siteController.headNameList("ManPower");
                              bottomsheetControllers.dprNewHeadName(context, siteController.getHeadNameDropdownvalue.value,"ManPower" );
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "--Select--" || value == "--SELECT--") {
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
                            controller:
                            manPowerController.preparedbyController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Prepared By",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.preparedBy),
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
                            AutovalidateMode.always,
                            readOnly: false,
                            controller:
                            manPowerController.RemarksController,
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
                    if(manPowerController.saveButton.value == RequestConstant.APPROVAL)Container(
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
                            AutovalidateMode.always,
                            readOnly: false,
                            controller:
                            manPowerController.AppRemarksController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Approve Remarks",
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
                    SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1)),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Setmybackground,
                                ),
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    await manPowerController.getLevel3ItemList(context);
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
                                    Flexible(
                                      child: Obx(()=>
                                         Text(
                                           manPowerController.selectedIds.isEmpty?" Level 3 Items":" Level 3 Items (${manPowerController.selectedIds.length})",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color:
                                              Theme.of(context).primaryColor),
                                        ),
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
                                backgroundColor: Setmybackground,
                              ),
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                 await manPowerController.getShowClickPopList(context);
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
                                  Flexible(
                                    child: Text(
                                      " Labour Details",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                    Obx(() => manPowerController.selectedIds.isNotEmpty
                        ? const Text(
                      "   ⓘ Note: Tap again to view selected",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                        : const SizedBox(),
                    ),

                    SizedBox(height: height),
                  ],
                ),
              ),
              Obx(() => Visibility(
                visible: manPowerController.readListdata.value.isEmpty
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
                                      ListDetails(context, scrollController)
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
                                manPowerController.saveButton.value,
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
                        if(manPowerController.readListdata.value.isEmpty){
                          BaseUtitiles.showToast("Please add labour details");
                        }else{
                          bool hasInvalid = false;
                          for (int i = 0; i < manPowerController.readListdata.length; i++) {
                            final controller = manPowerController.EntrySCreenNosControllers[i];
                            final text = controller.text.trim();

                            if (text.isEmpty) {
                              hasInvalid = true;
                              break;
                            }

                            final value = double.tryParse(text);
                            if (value == null || value <= 0) {
                              hasInvalid = true;
                              break;
                            }
                          }
                          if (hasInvalid) {
                            BaseUtitiles.showToast("Nos cannot be empty or zero.");
                          } else {
                            SubmitAlert(context);
                          }
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
            itemCount: manPowerController.readListdata.value.length,
            itemBuilder: (BuildContext context, int index) {
              manPowerController.textControllersInitiate();
              return SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  color: Colors.white,
                  child: Container(padding: EdgeInsets.only(bottom: 10),
                    child: Stack(
                      children:[
                        Column(
                          children: [
                            SizedBox(height: 10,),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 15),
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color:  Theme.of(context)
                                      .primaryColor.withOpacity(0.1), // Light blue background
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.groups_outlined,
                                  color: Theme.of(context)
                                      .primaryColor, // Dark navy
                                  size: 25,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    '${manPowerController.readListdata.value[index].catName}',
                                    softWrap: true,
                                    maxLines: null,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text("Nos",
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      height: BaseUtitiles.getheightofPercentage(
                                          context, 4),
                                      child: TextFormField(
                                          onTap: () {
                                            if (manPowerController
                                                .EntrySCreenNosControllers[
                                            index]
                                                .text !=
                                                "" &&
                                                manPowerController
                                                    .EntrySCreenNosControllers[
                                                index]
                                                    .text !=
                                                    "0" &&
                                                manPowerController
                                                    .EntrySCreenNosControllers[
                                                index]
                                                    .text !=
                                                    "0.0") {
                                              return;
                                            } else {
                                              manPowerController
                                                  .EntrySCreenNosControllers[
                                              index]
                                                  .text = "";
                                            }
                                          },
                                          style:
                                          const TextStyle(color: Colors.black),
                                          controller: manPowerController
                                              .EntrySCreenNosControllers[index],
                                          cursorColor: Colors.black,
                                          keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,

                                          inputFormatters: [
                                            TextInputFormatter.withFunction((oldValue, newValue) {
                                              return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                                                  ? newValue
                                                  : oldValue;
                                            }),
                                          ],
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
                                          onChanged: (value) async {
                                            await manPowerController.updateManPowerDetValue();
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 50,),
                              // Container(
                              //   margin: const EdgeInsets.only(
                              //       top: 10, left: 10, right: 3, bottom: 8),
                              //   child: Row(
                              //     children: <Widget>[
                              //       Expanded(
                              //         flex: 2,
                              //         child: Text("Remarks",
                              //               style: TextStyle(
                              //                 fontSize: 13.0,
                              //                 fontWeight: FontWeight.normal,
                              //                 color: Colors.black,
                              //               ),
                              //         ),
                              //       ),
                              //       Expanded(
                              //           flex: 3,
                              //           child: Container(
                              //             margin: const EdgeInsets.only(right: 11),
                              //             height: BaseUtitiles.getheightofPercentage(
                              //                 context, 4),
                              //             child: TextFormField(
                              //               textAlign: TextAlign.center,
                              //               controller: manPowerController
                              //                   .RemarksControllers[index],
                              //               style: const TextStyle(color: Colors.black),
                              //               cursorColor: Colors.black,
                              //               keyboardType: TextInputType.name,
                              //               decoration: InputDecoration(
                              //                 contentPadding: const EdgeInsets.fromLTRB(
                              //                     8.0, 0.0, 8.0, 0.0),
                              //                 focusedBorder: OutlineInputBorder(
                              //                     borderSide: BorderSide(
                              //                         color: Theme.of(context)
                              //                             .primaryColor),
                              //                     borderRadius: const BorderRadius.all(
                              //                         Radius.circular(10))),
                              //                 enabledBorder: OutlineInputBorder(
                              //                     borderSide: BorderSide(
                              //                         color: Theme.of(context)
                              //                             .primaryColor),
                              //                     borderRadius: const BorderRadius.all(
                              //                         Radius.circular(10))),
                              //               ),
                              //                 onChanged: (value) async {
                              //                   await manPowerController
                              //                       .updateManPowerDetValue();
                              //                 }),
                              //           )),
                              //     ],
                              //   ),
                              // ),
                            ],
                                                  ),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
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
                                                      manPowerController.deleteParticularList(manPowerController.readListdata[index]);
                                                      manPowerController.readListdata.remove(manPowerController.readListdata[index]);
                                                      manPowerController.getDetTablesDatas();
                                                      Navigator.pop(context);
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
                                  child: ConstIcons.cancle)),
                        ),
                                        ]
                    ),
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
                              if (manPowerController.saveButton.value != RequestConstant.APPROVAL) {
                                manPowerController.readListdata.value=[];
                                manPowerController.deleteSubcontDetTableDatas();
                                projectController.projectname.text = "--SELECT--";
                                projectController.selectedProjectId.value = 0;
                                siteController.Sitename.text = "--SELECT--";
                                siteController.selectedsiteId.value = 0;
                                siteController.headNameController.text = "--SELECT--";
                                siteController.selectedHeadId.value = 0;
                                manPowerController.selectedIds.value=[];
                                manPowerController.manpowerLevel3ItemList.value=[];
                                await autoYearWiseNoController.AutoYearWiseNo("MANPOWER");
                                manPowerController.autoYearWiseNoController.text = autoYearWiseNoController.ManPower_autoYrsWise.value;
                                manPowerController.ManPowerEntryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
                                manPowerController.preparedbyController.text = loginController.EmpName();
                                manPowerController.createdById.value = 0;
                                manPowerController.RemarksController.text = "";
                              } else {
                                BaseUtitiles.showToast(
                                    "In this approval page can't be reset");
                              }
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
        content: Text('Are you sure to ${manPowerController.saveButton.value}?'),
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
                            await manPowerController.getDetTablesDatas();
                            await manPowerController.SaveEntryScreen(
                                context,
                                manPowerController.saveButton.value==RequestConstant.SUBMIT?0:manPowerController.manpowerEditApiValue[0].id!
                            );
                          }
                        },
                        child: Text(
                          manPowerController.saveButton.value,
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

}
