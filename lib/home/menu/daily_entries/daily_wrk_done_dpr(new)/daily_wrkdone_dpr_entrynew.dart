import 'dart:io';

import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/entry_type_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../controller/headname_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../home/menu/daily_entries/daily_wrk_done_dpr/type_subcont_alert.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/image_view.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../punch_in_out/camera_screen.dart';
import 'daily_wrkdone_dpr_labour.dart';

class DailyWork_done_DPR_Entry_New extends StatefulWidget {
  const DailyWork_done_DPR_Entry_New({Key? key}) : super(key: key);

  @override
  State<DailyWork_done_DPR_Entry_New> createState() => _DailyWork_done_DPR_New_EntryState();
}

class _DailyWork_done_DPR_New_EntryState extends State<DailyWork_done_DPR_Entry_New> {

  CommanController commanController=Get.put(CommanController());
  LoginController loginController=Get.put(LoginController());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());


  @override
  void initState() {
    var duration = Duration(seconds:0);
    Future.delayed(duration,() async {
      dailyWrkDone_DPRNEW_Controller.imageFiles.value=[];
      dailyWrkDone_DPRNEW_Controller.gettingNetworkImages.value = [];

      if(dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.SUBMIT){
        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value=0;
        siteController.Sitename.text = "--SELECT--";
        siteController.selectedsiteId.value=0;
        dailyWrkDone_DPR_Controller.entryTypeController.text = "--SELECT--";
        dailyWrkDone_DPR_Controller.entryType = "0";
        dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--SELECT--";
        dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;
        siteController.headNameController.text = "--SELECT--";
        siteController.selectedHeadId.value=0;
        dailyWrkDone_DPRNEW_Controller.dpr_new_preparedbyController.text=loginController.EmpName();
        dailyWrkDone_DPRNEW_Controller.dpr_new_remarksController.text="";
        await autoYearWiseNoController.AutoYearWiseNo("DPR NEW");
        dailyWrkDone_DPRNEW_Controller.autoYearWiseNoController.text=autoYearWiseNoController.DPRNEW_autoYrsWise.value;
        dailyWrkDone_DPRNEW_Controller.dateController.text=BaseUtitiles.initiateCurrentDateFormat();
        dailyWrkDone_DPRNEW_Controller.level3ItemIdValue.value=0;

        dailyWrkDone_DPRNEW_Controller.dprNew_DetTable_Delete();
        dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.clear();

        //Labour Screen
        dailyWrkDone_DPRNEW_Controller.dprNew_LabourTable_Delete();
        dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList=[];
        dailyWrkDone_DPRNEW_Controller.totalNetAmnt=0.0;

        //Material Screen
        dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_NameController.text="--SELECT--";
        dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_ScaleController.text="UNIT";
        dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_QtyController.text="0.0";
        dailyWrkDone_DPRNEW_Controller.matScaleId.value=0;
        dailyWrkDone_DPRNEW_Controller.selectedMatId.value=0;
        dailyWrkDone_DPRNEW_Controller.dprNew_MaterialTable_Delete();
        dailyWrkDone_DPRNEW_Controller.dprNewGetMatreadListdata.value=[];

        //Masurement Screen
        dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DescController.text = "";
        dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_NosController.text = "";
        dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_LengthController.text = "";
        dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_BreathController.text = "";
        dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DepthController.text = "";
        dailyWrkDone_DPRNEW_Controller.dpr_new_currQtyController.text=dailyWrkDone_DPRNEW_Controller.currentQty.toString();
        dailyWrkDone_DPRNEW_Controller.dprNew_MSRTable_Delete();
        dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value.clear();



      }

      if(dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.RESUBMIT || dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.APPROVAL){
        await dailyWrkDone_DPRNEW_Controller.gettingImage();
        dailyWrkDone_DPRNEW_Controller.dprNew_EditApiList.value.forEach((element) {
          dailyWrkDone_DPRNEW_Controller.autoYearWiseNoController.text=element.workNo;
          dailyWrkDone_DPRNEW_Controller.dateController.text=element.workDate;
          projectController.projectname.text=element.projectName;
          projectController.selectedProjectId.value=element.projectId;
          siteController.Sitename.text= element.siteName;
          siteController.selectedsiteId.value=element.siteId;
          dailyWrkDone_DPR_Controller.TypeSubcontractorname.text=element.subcontractorName;
          dailyWrkDone_DPR_Controller.TypeSubcontId.value=element.subContractorId;
          dailyWrkDone_DPR_Controller.entryTypeController.text=element.entryTypeDesc;
          dailyWrkDone_DPR_Controller.entryType=element.entryType;
          siteController.headNameController.text = element.headItemName;
          siteController.selectedHeadId.value=element.headItemId;
          dailyWrkDone_DPRNEW_Controller.dpr_new_preparedbyController.text=element.createdName;
          dailyWrkDone_DPRNEW_Controller.dpr_new_remarksController.text=element.remarks;
        });
      }

    });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100/100;
    final double height = MediaQuery.of(context).size.height * 50/100;
    return WillPopScope(
      onWillPop: () async {
        await dailyWrkDone_DPRNEW_Controller.dpr_New_getEntryList();
        return true;
      },
      child: GestureDetector(
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
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40),
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "DPR - NEW",
                                style: TextStyle(
                                    fontSize: RequestConstant.Heading_Font_SIZE,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                  onPressed: () {
                                    dailyWrkDone_DPRNEW_Controller.dpr_New_getEntryList();
                                    dailyWrkDone_DPRNEW_Controller.dprnew_ClearData();
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Back",
                                    style: TextStyle(color: Colors.grey, fontSize: 18),
                                  ))
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                                controller: dailyWrkDone_DPRNEW_Controller.autoYearWiseNoController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Entry No",
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
                          margin: EdgeInsets.only(top: 2, right: 10, left: 10),
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
                                controller: dailyWrkDone_DPRNEW_Controller.dateController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
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
                                onTap: () async {
                                  if(dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.RESUBMIT || dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.APPROVAL){

                                  }
                                  else{
                                    var Entrydate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now().subtract(Duration(days: 2)),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Theme.of(context).primaryColor, // header background color
                                              onPrimary: Colors.white, // header text color
                                              onSurface: Colors.black, // body text color
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
                                    dailyWrkDone_DPRNEW_Controller.dateController.text = BaseUtitiles.selectDateFormat(Entrydate!);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15)),
                            elevation: 3,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  if(dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.RESUBMIT || dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.APPROVAL){

                                  }else{
                                    await projectController.getProjectList();
                                    bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value );
                                  }
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
                          margin: EdgeInsets.only(top: 2, left: 10, right: 10),
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
                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  if(dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.RESUBMIT || dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.APPROVAL) {

                                  }else{
                                      bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value );
                                  }
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
                          margin: EdgeInsets.only(top: 2, left: 10, right: 10),
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
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                readOnly: true,
                                controller: dailyWrkDone_DPR_Controller.entryTypeController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "TYPE",
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
                                  if(dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.RESUBMIT || dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.APPROVAL){

                                  }
                                  else{
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return  EntryTypeAlert_DPR_New();
                                          });
                                  }
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
                          margin: EdgeInsets.only(top: 2, left: 10, right: 10),
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
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                readOnly: true,
                                controller: dailyWrkDone_DPR_Controller.TypeSubcontractorname,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
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
                                  await  dailyWrkDone_DPR_Controller.dpr_getSubcotType(type: "Dprnew",entryType: dailyWrkDone_DPR_Controller.entryType);
                                  if(dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.RESUBMIT || dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.APPROVAL){

                                  }
                                  else{
                                    if(dailyWrkDone_DPR_Controller.entryTypeController.text=="TYPE" && projectController.selectedProjectId.value ==0 && siteController.selectedsiteId.value==0){

                                    }
                                    else{
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return  TypeSubcontAlert(list: dailyWrkDone_DPR_Controller.dpr_subcontractorList,);
                                          });
                                    }
                                  }
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
                          margin: EdgeInsets.only(top: 2, left: 10, right: 10),
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
                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  if(dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.RESUBMIT || dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.APPROVAL) {

                                  }else{
                                     await siteController.headNameList("DPRNEW");
                                      bottomsheetControllers.dprNewHeadName(context, siteController.getHeadNameDropdownvalue.value,"DPRNEW" );
                                  }
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
                          margin: EdgeInsets.only(top: 2, left: 10, right: 10),
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
                                controller: dailyWrkDone_DPRNEW_Controller.dpr_new_preparedbyController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
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
                          margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: dailyWrkDone_DPRNEW_Controller.dpr_new_remarksController,
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
                        SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1)),

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
                                    dailyWrkDone_DPRNEW_Controller.getAddBoqDetails(context);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.add, color: Theme.of(context).primaryColor,),
                                    SizedBox(width: 5),
                                    Text("Add BOQ", style: TextStyle(color: Theme.of(context).primaryColor),),
                                  ],
                                )),
                            const SizedBox(
                              width: 14,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Setmybackground,
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CameraCapturePage(
                                          fromScreen:
                                          "DPR-NEW",
                                        )),
                                  );
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
                          ],
                        ),

                        Obx(() {
                          final allImages = [
                            ...dailyWrkDone_DPRNEW_Controller.gettingNetworkImages,
                            ...dailyWrkDone_DPRNEW_Controller.imageFiles,
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
                                                image,
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
                                                            imageUrl: image,
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


                  Obx(()=>Visibility(
                    visible: dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value.isEmpty?false:true,
                    child: Container(
                      height: BaseUtitiles.getheightofPercentage(context, 100),
                      child: DraggableScrollableSheet(
                        minChildSize: 0.1,
                        maxChildSize: 0.9,
                        initialChildSize: 0.3,
                        builder: (BuildContext context, ScrollController scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Setmybackground,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(40.0),
                                topRight: const Radius.circular(40.0),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: ListDetails(context, scrollController)
                                          ),

                                        ],
                                      ),
                                    )),
                                IgnorePointer(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(40.0),
                                        topRight: const Radius.circular(40.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 20, bottom: 20),
                                          height: 5,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
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
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text("Reset",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                                color:  Theme.of(context).primaryColor ),
                          ),
                        ),
                        onTap: (){
                            if(dailyWrkDone_DPRNEW_Controller.saveButton.value==RequestConstant.APPROVAL){
                              BaseUtitiles.showToast("In this approval page can't be reset");
                            }else {
                              ResetAlert(context);
                            }
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20 , right: 20),
                          height: BaseUtitiles.getheightofPercentage(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color:  Theme.of(context).primaryColor
                          ),
                          alignment: Alignment.center,
                          child: Text("NEXT",  style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                              color:  Colors.white ),),
                        ),
                        onTap: () async {
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              if(dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.isEmpty){
                                BaseUtitiles.showToast("Please add BOQ details");
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => const DailyWork_done_DPR_Labour()));
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
      ),
    );
  }

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return Obx(()=> Visibility(
      visible: dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.value.isEmpty?false:true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 35),
          Container(
            margin: EdgeInsets.only(left: 10,top:5, bottom: 5),
            child: Text("Item Description", style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
          ),

         Container(
           margin: EdgeInsets.only(left: 15, bottom: 5),
           child: Text(dailyWrkDone_DPRNEW_Controller.dpr_new_descripionController.text),
         ),

          Container(
            margin: EdgeInsets.only(top: 10, bottom: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text("Rate",style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor ),),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: Text("Units",style: TextStyle(fontSize: RequestConstant.App_Font_SIZE, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),)),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: Text("Bal-BOQ qty",style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),)),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: Text("Current Qty",style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(),
                    child: TextField(
                      readOnly:true,
                      keyboardType: TextInputType.number,
                      controller: dailyWrkDone_DPRNEW_Controller.dpr_new_rateController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                        ),
                      ),
                      onChanged: (value){
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(),
                    child: TextField(
                      readOnly:true,
                      keyboardType: TextInputType.number,
                      controller:dailyWrkDone_DPRNEW_Controller.dpr_new_unitsController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                        ),
                      ),
                      onChanged: (value){
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(),
                    child: TextField(
                      readOnly:true,
                      keyboardType: TextInputType.number,
                      controller:dailyWrkDone_DPRNEW_Controller.dpr_new_boqQtyController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                        ),
                      ),
                      onChanged: (value){
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(),
                    child: TextField(
                      readOnly:true,
                      keyboardType: TextInputType.number,
                      controller:dailyWrkDone_DPRNEW_Controller.dpr_new_currQtyController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                        ),
                      ),
                      onChanged: (value){
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Reset?'),
        actions:[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
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
                        onPressed: () {
                          Future.delayed(Duration(seconds: 0),(){
                            dailyWrkDone_DPRNEW_Controller.saveButton.value=RequestConstant.SUBMIT;
                            dailyWrkDone_DPRNEW_Controller.dpr_new_currQtyController.text="0.0";


                            projectController.projectname.text = "--SELECT--";
                            projectController.selectedProjectId.value=0;

                            siteController.Sitename.text = "--SELECT--";
                            siteController.selectedsiteId.value=0;

                            dailyWrkDone_DPR_Controller.entryTypeController.text = "--SELECT--";
                            dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--SELECT--";
                            dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;
                            dailyWrkDone_DPRNEW_Controller.imageFiles.value=[];
                            siteController.headNameController.text = "--SELECT--";
                            siteController.selectedHeadId.value=0;
                            dailyWrkDone_DPRNEW_Controller.dpr_new_preparedbyController.text=loginController.EmpName();
                            dailyWrkDone_DPRNEW_Controller.autoYearWiseNoController.text=autoYearWiseNoController.DPRNEW_autoYrsWise.value;
                            dailyWrkDone_DPRNEW_Controller.dateController.text=BaseUtitiles.initiateCurrentDateFormat();
                            dailyWrkDone_DPRNEW_Controller.dpr_new_remarksController.text="";
                            dailyWrkDone_DPRNEW_Controller.dprNew_DetTable_Delete();
                            dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.clear();


                            //Labour Screen
                            dailyWrkDone_DPRNEW_Controller.dprNew_LabourTable_Delete();
                            dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList.clear();
                            dailyWrkDone_DPRNEW_Controller.totalNetAmnt=0.0;

                            //Material Screen
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_NameController.text="--SELECT--";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_ScaleController.text="UNIT";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_QtyController.text="0.0";
                            dailyWrkDone_DPRNEW_Controller.matScaleId.value=0;
                            dailyWrkDone_DPRNEW_Controller.selectedMatId.value=0;
                            dailyWrkDone_DPRNEW_Controller.dprNew_MaterialTable_Delete();
                            dailyWrkDone_DPRNEW_Controller.dprNewGetMatreadListdata.value.clear();

                            //Masurement Screen
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DescController.text = "";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_NosController.text = "";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_LengthController.text = "";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_BreathController.text = "";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DepthController.text = "";
                            dailyWrkDone_DPRNEW_Controller.dprNew_MSRTable_Delete();
                            dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value.clear();
                            Navigator.pop(context);
                          });

                        },
                        child: Text("Reset", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future DeleteAlert(BuildContext context,int index,itemType) async {
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
                          if(itemType=="String"){
                            final imageId =
                            dailyWrkDone_DPRNEW_Controller.imageIds[index];

                            final isDeleted = await dailyWrkDone_DPRNEW_Controller
                                .deletingImage(imageId);

                            if (isDeleted) {
                              dailyWrkDone_DPRNEW_Controller.gettingNetworkImages
                                  .removeAt(index);
                            }
                          }
                          else if (itemType == "File") {
                            int localIndex = index - dailyWrkDone_DPRNEW_Controller.gettingNetworkImages.length;
                            if (localIndex >= 0 && localIndex < dailyWrkDone_DPRNEW_Controller.imageFiles.length) {
                              setState(() {
                                dailyWrkDone_DPRNEW_Controller.imageFiles.removeAt(localIndex);
                              });
                            }
                          }
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
  }

}