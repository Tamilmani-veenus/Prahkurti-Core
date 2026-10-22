import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/controller/workOrderBoq_Controller.dart';
import 'package:prahkurticore/home/menu/main_menu/workOrder_BOQ/workOrder_BOQ_Deduction.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/workorderActiveType.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/common_date_fields.dart';
import '../../../../utilities/requestconstant.dart';

class WorkOrderBoqEntryScreen extends StatefulWidget {
  final String heading;
  const WorkOrderBoqEntryScreen({super.key, required this.heading});

  @override
  State<WorkOrderBoqEntryScreen> createState() => _WorkOrderBoqEntryScreenState();
}

class _WorkOrderBoqEntryScreenState extends State<WorkOrderBoqEntryScreen> {

  WorkOrderBoqController workOrderBoqController = Get.put(WorkOrderBoqController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {

      if (workOrderBoqController.saveButton.value == RequestConstant.RESUBMIT || workOrderBoqController.saveButton.value == RequestConstant.VERIFY || workOrderBoqController.saveButton.value == RequestConstant.APPROVAL) {
        workOrderBoqController.workOrderBoq_editListApiDatas.forEach((element) {
          workOrderBoqController.workid = element.id!;
          workOrderBoqController.autoYearWiseNoController.text = element.workOrderNo.toString();
          workOrderBoqController.workOrdentryDateController.text = element.entryDate.toString();
          projectController.projectname.text = element.projectName.toString();
          projectController.selectedProjectId.value = element.projectId;
          siteController.Sitename.text = element.siteName.toString();
          siteController.selectedsiteId.value = element.siteId;
          subcontractorController.Subcontractorname.text = element.subContractorName.toString();
          subcontractorController.selectedSubcontId.value = element.subContractorId;
          workOrderBoqController.WorkOrdActiveTypeText.text = element.active == "Y" ? "Active" : "Inactive";
          workOrderBoqController.workOrdActTypeID.value = element.active.toString();
          siteController.headNameController.text = element.headName.toString();
          workOrderBoqController.PreparedByController.text = element.createdName.toString();
          workOrderBoqController.createdById.value = element.createdBy;
          workOrderBoqController.RemarksController.text = element.remarks.toString();
        });
      }


      if (workOrderBoqController.saveButton.value == RequestConstant.SUBMIT) {
        await autoYearWiseNoController.AutoYearWiseNo("WORK ORDER BOQ");
        workOrderBoqController.autoYearWiseNoController.text = autoYearWiseNoController.WorkOrdBoq_autoYrWise.value;
        workOrderBoqController.workOrdentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        workOrderBoqController.workid = 0;
        subcontractorController.selectedWorkOrderId.value = 0;
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value = 0;
        siteController.Sitename.text = "--SELECT--";
        siteController.selectedsiteId.value = 0;
        subcontractorController.Subcontractorname.text = "--SELECT--";
        subcontractorController.selectedSubcontId.value=0;
        workOrderBoqController.WorkOrdActiveTypeText.text = "--SELECT--";
        workOrderBoqController.workOrdActTypeID.value = "0";
        siteController.headNameController.text = "--SELECT--";
        siteController.selectedHeadId.value = 0;
        workOrderBoqController.PreparedByController.text = loginController.EmpName();
        workOrderBoqController.RemarksController.text = "";
        workOrderBoqController.termsAndCondition.clear();
        workOrderBoqController.filteredTermsAndCondition.clear();
        workOrderBoqController.selectedTerms.clear();
        // workOrderBoqController.createdById.value=0;
        workOrderBoqController.delete_WorkOrderBoq_itemlist_Table();
        workOrderBoqController.WorkOrdBoq_ItemList.value.clear();
        workOrderBoqController.workOrdamount.text = "0.0";
        workOrderBoqController.rebateAmount.text = "0.0";
        workOrderBoqController.Roundoff.text = "0.0";
      }
      if (!mounted) return;

      setState(() {});
    });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100 / 100;
    final double height = MediaQuery.of(context).size.height * 50 / 100;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Form(
        key: _formKey,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: Setmybackground,
            body: Stack(
              children: [
                SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.heading,
                              style: TextStyle(
                                  fontSize: workOrderBoqController.saveButton.value == RequestConstant.RESUBMIT || workOrderBoqController.saveButton.value == RequestConstant.SUBMIT? RequestConstant.Heading_Font_SIZE : 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              ))
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
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            readOnly: true,
                            controller: workOrderBoqController.autoYearWiseNoController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Work Order No",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.requestNo)),
                          ),
                        ),
                      ),
                    ),

                    CommonDateFields(
                      date1: CommonDateFieldConfig(
                        title: "Work Order Date",
                        value: workOrderBoqController.workOrdentryDateController.text,
                        controller: workOrderBoqController.workOrdentryDateController,
                        selectable: loginController.user.value.userType != "S",
                        initialDate: DateTime.tryParse(
                          workOrderBoqController.workOrdentryDateController.text,
                        ) ??
                            DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        onChanged: (date) {
                          setState(() {
                            workOrderBoqController.workOrdentryDateController.text =
                                CommonDateUtils.formatApiDate(date);
                          });
                        },
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
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.always,
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
                            onTap: () async {
                              if(workOrderBoqController.saveButton.value == RequestConstant.RESUBMIT || workOrderBoqController.saveButton.value == RequestConstant.VERIFY || workOrderBoqController.saveButton.value == RequestConstant.APPROVAL)
                              {}
                              else{
                                await projectController.getProjectList();
                                if(mounted) {
                                  bottomsheetControllers.ProjectName(context,
                                      projectController.getdropDownvalue.value);
                                }}
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
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            readOnly: true,
                            controller: siteController.Sitename,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: RequestConstant.SITE_NAME,
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
                            onTap: () {
                              if(workOrderBoqController.saveButton.value == RequestConstant.RESUBMIT || workOrderBoqController.saveButton.value == RequestConstant.VERIFY || workOrderBoqController.saveButton.value == RequestConstant.APPROVAL)
                              {}
                              else{
                                setState(() {
                                  bottomsheetControllers.SiteName(context,
                                      siteController.getSiteDropdownvalue.value);
                                });}
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
                      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            readOnly: true,
                            controller: subcontractorController.Subcontractorname,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: RequestConstant.SUBCONTRACTOR_NAME,
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
                              if(workOrderBoqController.saveButton.value == RequestConstant.RESUBMIT || workOrderBoqController.saveButton.value == RequestConstant.VERIFY || workOrderBoqController.saveButton.value == RequestConstant.APPROVAL)
                              {}
                              else{
                                await subcontractorController.getSubcontList(context,
                                    projectController.selectedProjectId.value,
                                    siteController.selectedsiteId.value,"");
                                bottomsheetControllers.SubcontractorName(context,
                                    subcontractorController.getdropDownvalue.value);
                              } },
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
                            controller: workOrderBoqController.WorkOrdActiveTypeText,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Active Status",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Icon(Icons.task_alt,color: Theme.of(context).primaryColor,)),
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value == "--Select--" ||
                                  value == "--SELECT--") {
                                return '\u26A0 ${RequestConstant.VALIDATE}';
                              }
                              return null;
                            },
                            onTap: () async {
                              if(workOrderBoqController.saveButton.value == RequestConstant.VERIFY || workOrderBoqController.saveButton.value == RequestConstant.APPROVAL)
                              {}
                              else{
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WorkOrderType_Alert();
                                    });}

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
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
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
                              if(workOrderBoqController.saveButton.value == RequestConstant.VERIFY || workOrderBoqController.saveButton.value == RequestConstant.APPROVAL)
                              {}
                              else{
                                await siteController.headNameList("WORKORDBOQ");
                                bottomsheetControllers.dprNewHeadName(context, siteController.getHeadNameDropdownvalue.value,"WORKORDBOQ" );
                              }},
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
                            controller: workOrderBoqController.PreparedByController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Prepared by",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Icon(Icons.content_paste_go,color: Theme.of(context).primaryColor,)),
                            ),
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
                            controller: workOrderBoqController.RemarksController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
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
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: BaseUtitiles.getheightofPercentage(context, 1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Setmybackground,
                            ),
                            onPressed: () async {
                              if(_formKey.currentState!.validate()){
                                _formKey.currentState!.save();
                                workOrderBoqController.getWorkOrdItemList(context);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Add Items",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: height),
                  ],
                ),
              ),
                Obx(() => Visibility(
                  visible: workOrderBoqController
                      .WorkOrdBoqitem_itemview_GetDbList.value.isEmpty
                      ? false
                      : true,
                  child: SizedBox(
                    height: BaseUtitiles.getheightofPercentage(context, 100),
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
                                  MediaQuery.of(context).size.height * 0.9,
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
                                        margin: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        height: 5,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: Colors.grey,
                                        ),
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
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      width: BaseUtitiles.getWidthtofPercentage(context, 25),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).primaryColor

                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: Colors.white
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          if(workOrderBoqController.WorkOrdBoqitem_itemview_GetDbList.isEmpty){
                            Fluttertoast.showToast(msg: "Please add items");
                          }
                          else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WorkOrderBoqDeduction()));
                          }

                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget ListDetails(BuildContext context, ScrollController scrollController) {
  //   return SingleChildScrollView(
  //       controller: scrollController,
  //       child: Column(
  //         children: [
  //           SizedBox(height: BaseUtitiles.getheightofPercentage(context, 3)),
  //           SizedBox(
  //             height: MediaQuery.of(context).size.height * 0.79,
  //             child: Obx(()=>
  //                 ListView.builder(
  //                   shrinkWrap: true,
  //                   physics: BouncingScrollPhysics(),
  //                   itemCount: workOrderBoqController.WorkOrdBoqitem_itemview_GetDbList.value.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     workOrderBoqController
  //                         .Item_itemlist_textControllersInitiate();
  //                     return Card(
  //                       margin:
  //                       const EdgeInsets.only(bottom: 10, left: 5, right: 5),
  //                       color: Colors.white,
  //                       elevation: 5,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: <Widget>[
  //                           Container(
  //                             margin:
  //                             const EdgeInsets.only(left: 5, top: 5, right: 5,bottom: 5),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: <Widget>[
  //                                 SizedBox(
  //                                   width: BaseUtitiles.getWidthtofPercentage(
  //                                       context, 80),
  //                                   child: Text(
  //                                     "${workOrderBoqController.WorkOrdBoqitem_itemview_GetDbList.value[index].itemDesc} (${workOrderBoqController.WorkOrdBoqitem_itemview_GetDbList.value[index].scaleName})",
  //                                     textAlign: TextAlign.justify,
  //                                     style: TextStyle(
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Theme.of(context).primaryColor,
  //                                         fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: BaseUtitiles.getheightofPercentage(
  //                                       context, 2),
  //                                   width: BaseUtitiles.getWidthtofPercentage(
  //                                       context, 10),
  //                                   child: InkWell(
  //                                       onTap: () {
  //                                         showDialog(
  //                                           context: context,
  //                                           builder: (context) => AlertDialog(
  //                                             title: const Text(
  //                                               RequestConstant.DO_YOU_WANT_DELETE,
  //                                               style:
  //                                               TextStyle(color: Colors.black),
  //                                             ),
  //                                             actions: <Widget>[
  //                                               Container(
  //                                                 margin: const EdgeInsets.only(
  //                                                     left: 20, right: 20),
  //                                                 child: IntrinsicHeight(
  //                                                   child: Row(
  //                                                     mainAxisAlignment:
  //                                                     MainAxisAlignment
  //                                                         .spaceBetween,
  //                                                     children: [
  //                                                       Expanded(
  //                                                         child: TextButton(
  //                                                             onPressed: () {
  //                                                               Navigator.pop(
  //                                                                   context);
  //                                                             },
  //                                                             child: const Text(
  //                                                                 "Cancel",
  //                                                                 style: TextStyle(
  //                                                                     color: Colors
  //                                                                         .grey,
  //                                                                     fontWeight:
  //                                                                     FontWeight
  //                                                                         .bold,
  //                                                                     fontSize:
  //                                                                     RequestConstant
  //                                                                         .Lable_Font_SIZE))),
  //                                                       ),
  //                                                       VerticalDivider(
  //                                                         color:
  //                                                         Colors.grey.shade400,
  //                                                         //color of divider
  //                                                         width: 5,
  //                                                         //width space of divider
  //                                                         thickness: 2,
  //                                                         //thickness of divier line
  //                                                         indent: 15,
  //                                                         //Spacing at the top of divider.
  //                                                         endIndent:
  //                                                         15, //Spacing at the bottom of divider.
  //                                                       ),
  //                                                       Expanded(
  //                                                         child: TextButton(
  //                                                             onPressed: () {
  //                                                               workOrderBoqController
  //                                                                   .deleteParticularList(
  //                                                                   workOrderBoqController
  //                                                                       .WorkOrdBoqitem_itemview_GetDbList[
  //                                                                   index]);
  //                                                               workOrderBoqController
  //                                                                   .WorkOrdBoqitem_itemview_GetDbList
  //                                                                   .remove(workOrderBoqController
  //                                                                   .WorkOrdBoqitem_itemview_GetDbList[
  //                                                               index]);
  //                                                               workOrderBoqController
  //                                                                   .getItemTablesDatas();
  //                                                               Navigator.pop(
  //                                                                   context);
  //                                                             },
  //                                                             child: const Text(
  //                                                                 "Delete",
  //                                                                 style: TextStyle(
  //                                                                     color: Colors
  //                                                                         .red,
  //                                                                     fontWeight:
  //                                                                     FontWeight
  //                                                                         .bold,
  //                                                                     fontSize:
  //                                                                     RequestConstant
  //                                                                         .Lable_Font_SIZE))),
  //                                                       )
  //                                                     ],
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         );
  //                                       },
  //                                       child: const Icon(Icons.remove_circle,
  //                                           color: Colors.red
  //                                       )
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: const EdgeInsets.only(top: 10),
  //                             child:  Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                               children: <Widget>[
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: Text(
  //                                     "BOQ Code",
  //                                     textAlign: TextAlign.center,
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: Text(
  //                                     "Bal qty",
  //                                     textAlign: TextAlign.center,
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: Text(
  //                                     "Lab rate",
  //                                     textAlign: TextAlign.center,
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: const EdgeInsets.only(top: 5, bottom: 5),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                               children: <Widget>[
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: Text(
  //                                     workOrderBoqController
  //                                         .WorkOrdBoqitem_itemview_GetDbList
  //                                         .value[index]
  //                                         .boqcode
  //                                         .toString(),
  //                                     textAlign: TextAlign.center,
  //                                     style: const TextStyle(
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child:  Text(
  //                                     workOrderBoqController
  //                                         .WorkOrdBoqitem_itemview_GetDbList
  //                                         .value[index]
  //                                         .balqty
  //                                         .toString(),
  //                                     textAlign: TextAlign.center,
  //                                     style: const TextStyle(
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child:
  //                                   Text(
  //                                       workOrderBoqController
  //                                           .WorkOrdBoqitem_itemview_GetDbList
  //                                           .value[index]
  //                                           .labrate
  //                                           .toString(),
  //                                     textAlign: TextAlign.center,
  //                                     style: const TextStyle(
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: const EdgeInsets.only(top: 10),
  //                             child:  Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                               children: <Widget>[
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: Text(
  //                                     "Rate",
  //                                     textAlign: TextAlign.center,
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: Text(
  //                                     "Curr Qty",
  //                                     textAlign: TextAlign.center,
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: Text(
  //                                     "Amount",
  //                                     textAlign: TextAlign.center,
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: const EdgeInsets.only(top: 5, bottom: 5),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                               children: <Widget>[
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: SizedBox(
  //                                     height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                     child: TextFormField(
  //                                         cursorColor: Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                         controller: workOrderBoqController.Addwork_qtyControllers[index],
  //                                         keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
  //
  //                                         inputFormatters: [
  //                                           TextInputFormatter.withFunction((oldValue, newValue) {
  //                                             return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
  //                                                 ? newValue
  //                                                 : oldValue;
  //                                           }),
  //                                         ],
  //                                         decoration: InputDecoration(
  //                                           contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
  //                                           focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Theme.of(context).primaryColor),
  //                                             borderRadius: const BorderRadius.all(Radius.circular(10),
  //                                             ),
  //                                           ),
  //                                           enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Theme.of(context).primaryColor),
  //                                             borderRadius: const BorderRadius.all(Radius.circular(10),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         style: const TextStyle(color: Colors.black),
  //                                         onChanged: (value) async {
  //                                           // await workOrderBoqController.calculatelist();
  //                                           setState(() {});
  //                                         }),
  //                                   )
  //                                   // Text(
  //                                   //   workOrderBoqController
  //                                   //       .WorkOrdBoqitem_itemview_GetDbList
  //                                   //       .value[index]
  //                                   //       .rate
  //                                   //       .toString(),
  //                                   //   textAlign: TextAlign.center,
  //                                   //   style: const TextStyle(
  //                                   //       fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                   //       color: Colors.black),
  //                                   // ),
  //                                 ),
  //                                 const SizedBox(width: 10),
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: SizedBox(
  //                                     height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                     child: TextFormField(
  //                                         cursorColor: Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                         controller: workOrderBoqController.Addwork_qtyControllers[index],
  //                                         keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
  //                                         inputFormatters: [
  //                                           TextInputFormatter.withFunction((oldValue, newValue) {
  //                                             return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
  //                                                 ? newValue
  //                                                 : oldValue;
  //                                           }),
  //                                         ],
  //                                         decoration: InputDecoration(
  //                                           contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
  //                                           focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Theme.of(context).primaryColor),
  //                                             borderRadius: const BorderRadius.all(Radius.circular(10),
  //                                             ),
  //                                           ),
  //                                           enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Theme.of(context).primaryColor),
  //                                             borderRadius: const BorderRadius.all(Radius.circular(10),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         style: const TextStyle(color: Colors.black),
  //                                         onChanged: (value) async {
  //                                           // await workOrderBoqController.calculatelist();
  //                                           setState(() {});
  //                                         }),
  //                                   ),
  //                                 ),
  //                                 const SizedBox(width: 10),
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child:SizedBox(
  //                                     height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                     child: TextFormField(
  //                                         cursorColor: Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                         controller: workOrderBoqController.Addwork_qtyControllers[index],
  //                                         keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
  //
  //                                         inputFormatters: [
  //                                           TextInputFormatter.withFunction((oldValue, newValue) {
  //                                             return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
  //                                                 ? newValue
  //                                                 : oldValue;
  //                                           }),
  //                                         ],
  //                                         decoration: InputDecoration(
  //                                           contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
  //                                           focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Theme.of(context).primaryColor),
  //                                             borderRadius: const BorderRadius.all(Radius.circular(10),
  //                                             ),
  //                                           ),
  //                                           enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Theme.of(context).primaryColor),
  //                                             borderRadius: const BorderRadius.all(Radius.circular(10),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         style: const TextStyle(color: Colors.black),
  //                                         onChanged: (value) async {
  //                                           // await workOrderBoqController.calculatelist();
  //                                           setState(() {});
  //                                         }),
  //                                   )
  //                                   // Text(
  //                                   //   workOrderBoqController
  //                                   //       .Addwork_AmountControllers[index].text
  //                                   //       .toString(),
  //                                   //   textAlign: TextAlign.center,
  //                                   //   style: const TextStyle(
  //                                   //       fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                   //       color: Colors.black),
  //                                   // ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: const EdgeInsets.only(top: 5, bottom: 5),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                               children: <Widget>[
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: Text(
  //                                     "Remarks",
  //                                     textAlign: TextAlign.center,
  //                                     style: const TextStyle(fontWeight: FontWeight.bold,
  //                                         fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                         color: Colors.black),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                   flex: 2,
  //                                   child: SizedBox(
  //                                     height: BaseUtitiles.getheightofPercentage(context, 4),
  //                                     child: TextFormField(
  //                                         cursorColor: Theme.of(context).primaryColor,
  //                                         textAlign: TextAlign.center,
  //                                         controller: workOrderBoqController.Addwork_qtyControllers[index],
  //                                         keyboardType: Platform.isAndroid ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
  //
  //                                         inputFormatters: [
  //                                           TextInputFormatter.withFunction((oldValue, newValue) {
  //                                             return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
  //                                                 ? newValue
  //                                                 : oldValue;
  //                                           }),
  //                                         ],
  //                                         decoration: InputDecoration(
  //                                           contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
  //                                           focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Theme.of(context).primaryColor),
  //                                             borderRadius: const BorderRadius.all(Radius.circular(10),
  //                                             ),
  //                                           ),
  //                                           enabledBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(
  //                                                 color: Theme.of(context).primaryColor),
  //                                             borderRadius: const BorderRadius.all(Radius.circular(10),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         style: const TextStyle(color: Colors.black),
  //                                         onChanged: (value) async {
  //                                           // await workOrderBoqController.calculatelist();
  //                                           setState(() {});
  //                                         }),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 ),
  //             ),
  //           ),
  //         ],
  //       ));
  // }

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
            itemCount: workOrderBoqController.WorkOrdBoqitem_itemview_GetDbList.value.length,
            itemBuilder: (BuildContext context, int index) {
              workOrderBoqController.Item_itemlist_textControllersInitiate();
              print(workOrderBoqController
                  .WorkOrdBoqitem_itemview_GetDbList.value[index]
                  .rate.runtimeType);

              print(workOrderBoqController
                  .WorkOrdBoqitem_itemview_GetDbList.value[index]
                  .rate);
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
                                top: 5,
                                left: 10,
                                right: 25,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: workOrderBoqController
                                          .WorkOrdBoqitem_itemview_GetDbList.value[index]
                                          .itemDesc,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                      ' (${workOrderBoqController.WorkOrdBoqitem_itemview_GetDbList.value[index].scaleName})',
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
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
                                                      workOrderBoqController
                                                          .deleteParticularList(
                                                          workOrderBoqController
                                                              .WorkOrdBoqitem_itemview_GetDbList[
                                                          index]);
                                                      workOrderBoqController
                                                          .WorkOrdBoqitem_itemview_GetDbList
                                                          .remove(workOrderBoqController
                                                          .WorkOrdBoqitem_itemview_GetDbList[
                                                      index]);
                                                      workOrderBoqController
                                                          .getItemTablesDatas();
                                                      Navigator.pop(
                                                          context);
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
                                        text: "BoqCode",
                                      ),
                                      TextSpan(
                                        text:
                                        // workOrderBoqController
                                        //     .EntrySCreenNosControllers[
                                        // index]
                                        //     .text !=
                                        //     "" &&
                                        //     workOrderBoqController
                                        //         .EntrySCreenNosControllers[
                                        //     index]
                                        //         .text !=
                                        //         "0" &&
                                        //     workOrderBoqController
                                        //         .EntrySCreenNosControllers[
                                        //     index]
                                        //         .text !=
                                        //         "0.0"
                                        //     ? ""
                                        //     :
                                        "",
                                        // style: TextStyle(
                                        //   color: workOrderBoqController
                                        //       .EntrySCreenNosControllers[
                                        //   index]
                                        //       .text !=
                                        //       "" &&
                                        //       workOrderBoqController
                                        //           .EntrySCreenNosControllers[
                                        //       index]
                                        //           .text !=
                                        //           "0" &&
                                        //       workOrderBoqController
                                        //           .EntrySCreenNosControllers[
                                        //       index]
                                        //           .text !=
                                        //           "0.0"
                                        //       ? Colors.white
                                        //       : Colors.red,
                                        //   fontSize: 12.0,
                                        //   fontWeight: FontWeight.bold,
                                        // ),
                                      ),
                                    ]),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                    readOnly: true,
                                      // onTap: () {
                                      //   if (workOrderBoqController
                                      //       .EntrySCreenNosControllers[
                                      //   index]
                                      //       .text !=
                                      //       "" &&
                                      //       workOrderBoqController
                                      //           .EntrySCreenNosControllers[
                                      //       index]
                                      //           .text !=
                                      //           "0" &&
                                      //       workOrderBoqController
                                      //           .EntrySCreenNosControllers[
                                      //       index]
                                      //           .text !=
                                      //           "0.0") {
                                      //     return;
                                      //   } else {
                                      //     setState(() {
                                      //       workOrderBoqController
                                      //           .EntrySCreenNosControllers[
                                      //       index]
                                      //           .text = "";
                                      //       workOrderBoqController.clickEdit();
                                      //     });
                                      //   }
                                      // },
                                      style:
                                      const TextStyle(color: Colors.black),
                                      controller: workOrderBoqController.Itemlist_boqCodeControllers[index],
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
                                      onChanged: (value) {
                                        setState(() {
                                          // workOrderBoqController.clickEdit();
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
                                        text: "Lab rate",
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
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                    readOnly: true,
                                      // onTap: () {
                                      //   if (workOrderBoqController
                                      //       .ExtrasControllers[index]
                                      //       .text !=
                                      //       "" &&
                                      //       workOrderBoqController
                                      //           .ExtrasControllers[index]
                                      //           .text !=
                                      //           "0" &&
                                      //       workOrderBoqController
                                      //           .ExtrasControllers[index]
                                      //           .text !=
                                      //           "0.0") {
                                      //     return;
                                      //   } else {
                                      //     setState(() {
                                      //       workOrderBoqController
                                      //           .ExtrasControllers[index]
                                      //           .text = "";
                                      //       dailyEntriesController.clickEdit();
                                      //     });
                                      //   }
                                      // },
                                      style:
                                      const TextStyle(color: Colors.black),
                                      controller: workOrderBoqController.Itemlist_labRateControllers[index],
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
                                      onChanged: (value) {
                                        // setState(() {
                                        //   workOrderBoqController.clickEdit();
                                        // });
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
                                        text: "Boq BalQty",
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
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                    readOnly: true,
                                      // onTap: () {
                                      //   if (dailyEntriesController
                                      //       .MrngOtHrsControllers[index]
                                      //       .text !=
                                      //       "" &&
                                      //       dailyEntriesController
                                      //           .MrngOtHrsControllers[index]
                                      //           .text !=
                                      //           "0" &&
                                      //       dailyEntriesController
                                      //           .MrngOtHrsControllers[index]
                                      //           .text !=
                                      //           "0.0") {
                                      //     return;
                                      //   } else {
                                      //     setState(() {
                                      //       dailyEntriesController
                                      //           .MrngOtHrsControllers[index]
                                      //           .text = "";
                                      //       dailyEntriesController.clickEdit();
                                      //     });
                                      //   }
                                      // },
                                      style:
                                      const TextStyle(color: Colors.black),
                                      controller: workOrderBoqController.Itemlist_boqBalQtyControllers[index],
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
                                      onChanged: (value) {
                                        setState(() {
                                          // dailyEntriesController.clickEdit();
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
                                        text: "Rate",
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
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  decoration: BoxDecoration(
                                    color: workOrderBoqController.isRateExceeded(index)
                                        ? Colors.green.shade100
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                      onTap: () {
                                        if (workOrderBoqController
                                            .Addwork_rateControllers[index]
                                            .text !=
                                            "" &&
                                            workOrderBoqController
                                                .Addwork_rateControllers[index]
                                                .text !=
                                                "0" &&
                                            workOrderBoqController
                                                .Addwork_rateControllers[index]
                                                .text !=
                                                "0.0") {
                                          return;
                                        } else {
                                          setState(() {
                                            workOrderBoqController
                                                .Addwork_rateControllers[index]
                                                .text = "";
                                            workOrderBoqController.calculateAmount(index);
                                          });
                                        }
                                      },
                                      style:
                                      const TextStyle(color: Colors.black),
                                      controller: workOrderBoqController.Addwork_rateControllers[index],
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
                                      onChanged: (value) {
                                        setState(() {
                                          if (!workOrderBoqController.validateQty(index)) {
                                            return;
                                          }
                                          // workOrderBoqController.calculateAmount(index);
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
                                        text: "Qty",
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
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                      onTap: () {
                                        if (workOrderBoqController
                                            .Addwork_qtyControllers[index]
                                            .text !=
                                            "" &&
                                            workOrderBoqController
                                                .Addwork_qtyControllers[index]
                                                .text !=
                                                "0" &&
                                            workOrderBoqController
                                                .Addwork_qtyControllers[index]
                                                .text !=
                                                "0.0") {
                                          return;
                                        } else {
                                          setState(() {
                                            workOrderBoqController
                                                .Addwork_qtyControllers[index]
                                                .text = "";
                                            workOrderBoqController.calculateAmount(index);
                                          });
                                        }
                                      },
                                      controller: workOrderBoqController.Addwork_qtyControllers[index],
                                      style:
                                      const TextStyle(color: Colors.black),
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
                                      onChanged: (value) {
                                        setState(() {
                                          if (!workOrderBoqController.validateQty(index)) {
                                            return;
                                          }
                                          // workOrderBoqController.calculateAmount(index);
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
                                        text: "Amt",
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
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextField(
                                    readOnly: true,
                                    controller: workOrderBoqController.Addwork_AmountControllers[index],
                                    style: const TextStyle(color: Colors.black),
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
                            ),
                            Expanded(
                                flex: 8,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                    // onTap: () {
                                    //   dailyEntriesController
                                    //       .RemarksControllers[index].text = "";
                                    // },
                                    textAlign: TextAlign.center,
                                    controller: workOrderBoqController.RemarksControllers[index],
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
                                        // dailyEntriesController
                                        //     .updateSubcontDetValue();
                                      });
                                    },
                                  ),
                                )),
                            SizedBox(width: 10),
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
                                        text: "Active",
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
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: workOrderBoqController.remarksCheckList[index],
                                    activeColor: Theme.of(context).primaryColor,
                                    onChanged: (value) async {
                                      setState(() {
                                        workOrderBoqController.remarksCheckList[index] = value ?? true;
                                        workOrderBoqController
                                            .WorkOrdBoqitem_itemview_GetDbList[index]
                                            .workOrderStatus = value ?? true;
                                      });
                                      await workOrderBoqController.updateItemlistTable();
                                    },
                                  ),
                                ],
                              ),
                            ),
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


}
