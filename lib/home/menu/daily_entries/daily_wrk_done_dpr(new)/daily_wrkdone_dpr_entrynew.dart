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
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/dailywrk_done_dpr_controller.dart';
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
  HeadNameController headNameController=Get.put(HeadNameController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());


  @override
  void initState() {
    var duration = Duration(seconds:0);
    Future.delayed(duration,() async {
      dailyWrkDone_DPRNEW_Controller.saveButton.value="";
      await autoYearWiseNoController.AutoYearWiseNo("DPR NEW");
      await  dailyWrkDone_DPR_Controller.dpr_getSubcotType();
      await projectController.getProjectList();
      dailyWrkDone_DPRNEW_Controller.autoYearWiseNoController.text=autoYearWiseNoController.DPRNEW_autoYrsWise.value;
      dailyWrkDone_DPRNEW_Controller.dpr_new_currQtyController.text=dailyWrkDone_DPRNEW_Controller.currentQty.toString();
      if(dailyWrkDone_DPRNEW_Controller.editcheck==1){
        dailyWrkDone_DPRNEW_Controller.ButtonChanges(1,dailyWrkDone_DPRNEW_Controller.aprovedButton);
        dailyWrkDone_DPRNEW_Controller.dprNew_EditApiList.value.forEach((element) {
          if(dailyWrkDone_DPRNEW_Controller.editcheck==1){
            dailyWrkDone_DPRNEW_Controller.saveButton.value=RequestConstant.RESUBMIT;
          }else{
            dailyWrkDone_DPRNEW_Controller.saveButton.value=RequestConstant.APPROVAL;
          }
          dailyWrkDone_DPRNEW_Controller.autoYearWiseNoController.text=element.workNo;
          dailyWrkDone_DPRNEW_Controller.dateController.text=element.workDate;
          projectController.projectname.text=element.projectName;
          projectController.selectedProjectId.value=element.projectId;
          siteController.Sitename.text= element.siteName;
          siteController.selectedsiteId.value=element.siteId;
          dailyWrkDone_DPR_Controller.TypeSubcontractorname.text=element.subContName;
          dailyWrkDone_DPR_Controller.TypeSubcontId.value=element.subContId;
          dailyWrkDone_DPRNEW_Controller.dpr_new_referenceController.text=element.refNo;
          dailyWrkDone_DPR_Controller.entryTypeController.text=element.entryTypeName;
          dailyWrkDone_DPR_Controller.entryType=element.entryType;
          dailyWrkDone_DPRNEW_Controller.dpr_new_preparedbyController.text=element.preparedbyName;
          dailyWrkDone_DPRNEW_Controller.dpr_new_remarksController.text=element.remarks;
          headNameController.headName.text="--Select--";
          headNameController.selectedHeadId.value=0;
        });
      }

      if(dailyWrkDone_DPRNEW_Controller.entrycheck==0){
        //Entry Screen
        dailyWrkDone_DPRNEW_Controller.saveButton.value=RequestConstant.SUBMIT;
        dailyWrkDone_DPRNEW_Controller.dpr_new_currQtyController.text="0.0";
        headNameController.headName.text="--Select--";
        headNameController.selectedHeadId.value=0;

        projectController.projectname.text = "--SELECT--";
        projectController.selectedProjectId.value=0;

        subcontractorController.Subcontractorname.text = "--SELECT--";
        subcontractorController.selectedSubcontId.value=0;

        siteController.Sitename.text = "--SELECT--";
        siteController.selectedsiteId.value=0;

        dailyWrkDone_DPR_Controller.entryTypeController.text = "--SELECT--";
        dailyWrkDone_DPR_Controller.entryType = "0";
        dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--SELECT--";
        dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;

        dailyWrkDone_DPRNEW_Controller.dpr_new_preparedbyController.text=loginController.EmpName();
        dailyWrkDone_DPRNEW_Controller.autoYearWiseNoController.text=autoYearWiseNoController.DPRNEW_autoYrsWise.value;
        dailyWrkDone_DPRNEW_Controller.dateController.text=BaseUtitiles.initiateCurrentDateFormat();
        dailyWrkDone_DPRNEW_Controller.dpr_new_remarksController.text="";
        dailyWrkDone_DPRNEW_Controller.dpr_new_referenceController.text="";
        dailyWrkDone_DPRNEW_Controller.dprNew_DetTable_Delete();
        dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.clear();


        //Labour Screen
        dailyWrkDone_DPRNEW_Controller.dprNew_LabourTable_Delete();
        dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList.clear();
        dailyWrkDone_DPRNEW_Controller.totalNetAmnt=0.0;

        //Material Screen
        dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_ScaleController.text="UNIT";
        dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_QtyController.text="0.0";
        dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_NameController.text="";
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
                                  if(dailyWrkDone_DPRNEW_Controller.editcheck==1){

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
                                // onTap: () async {
                                //   if (dailyWrkDone_DPRNEW_Controller.editcheck == 1) {
                                //   } else {
                                //     var Entrydate = await showDatePicker(
                                //         context: context,
                                //         initialDate: DateTime.now(),
                                //         firstDate: DateTime(1900),
                                //         lastDate: DateTime(2100),
                                //         builder: (context, child) {
                                //           return Theme(
                                //             data: Theme.of(context).copyWith(
                                //               colorScheme: ColorScheme.light(
                                //                 primary:
                                //                 Theme.of(context).primaryColor,
                                //                 // header background color
                                //                 onPrimary: Colors.white,
                                //                 // header text color
                                //                 onSurface:
                                //                 Colors.black, // body text color
                                //               ),
                                //               textButtonTheme: TextButtonThemeData(
                                //                 style: TextButton.styleFrom(
                                //                   primary: Colors
                                //                       .black, // button text color
                                //                 ),
                                //               ),
                                //             ),
                                //             child: child!,
                                //           );
                                //         });
                                //     dailyWrkDone_DPRNEW_Controller.dateController.text = BaseUtitiles.selectDateFormat(Entrydate!);
                                //   }
                                // },
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
                                onTap: () {
                                  if(dailyWrkDone_DPRNEW_Controller.editcheck == 1){

                                  }else{
                                    setState(() {
                                      bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value );
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
                                  if(dailyWrkDone_DPRNEW_Controller.editcheck == 1) {

                                  }else{
                                    setState(() {
                                      bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value );
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
                                  if(dailyWrkDone_DPRNEW_Controller.editcheck==1){

                                  }
                                  // else if(dailyWrkDone_DPRNEW_Controller.check==1){
                                  //
                                  // }
                                  else{
                                    setState(() {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return  EntryTypeAlert_DPR_New();
                                          });
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
                                  await  dailyWrkDone_DPR_Controller.dpr_getSubcotType();
                                  if(dailyWrkDone_DPRNEW_Controller.editcheck==1){

                                  }
                                  else{
                                    if(dailyWrkDone_DPR_Controller.entryTypeController.text=="TYPE" && projectController.selectedProjectId.value ==0 && siteController.selectedsiteId.value==0){

                                    }
                                    else{
                                      // dailyWrkDone_DPR_Controller.SubcontractorName(context,dailyWrkDone_DPR_Controller.dpr_subcontractorList.value);
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
                                readOnly: true,
                                controller: dailyWrkDone_DPRNEW_Controller.dpr_new_preparedbyController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Preppared By",
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

                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Container(
                        //         margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        //         child: Card(
                        //           shape: RoundedRectangleBorder(
                        //             side: BorderSide(color: Colors.white70, width: 1),
                        //             borderRadius: BorderRadius.circular(15),
                        //           ),
                        //           elevation: 3,
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        //             child: TextFormField(
                        //               keyboardType: TextInputType.number,
                        //               controller: dailyWrkDone_DPRNEW_Controller.dpr_new_referenceController,
                        //               cursorColor: Colors.black,
                        //               style: TextStyle(color: Colors.black),
                        //               decoration: InputDecoration(
                        //                 contentPadding: EdgeInsets.zero,
                        //                 border: InputBorder.none,
                        //                 labelText: "Reffer No",
                        //                 labelStyle: TextStyle(
                        //                     color: Colors.grey,
                        //                     fontSize: RequestConstant.Lable_Font_SIZE),
                        //                 prefixIconConstraints:
                        //                 BoxConstraints(minWidth: 0, minHeight: 0),
                        //                 prefixIcon: Padding(
                        //                     padding: EdgeInsets.symmetric(
                        //                         vertical: 8, horizontal: 8),
                        //                     child: ConstIcons.requestNo),
                        //               ),
                        //               validator: (value) {
                        //                 if (value!.isEmpty) {
                        //                   return '\u26A0 Enter user name';
                        //                 }
                        //                 return null;
                        //               },
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child:
                        //     ),
                        //   ],
                        // ),

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
                                    if(dailyWrkDone_DPR_Controller.entryTypeController.text=="--SELECT--" ||projectController.selectedProjectId.value==0 || siteController.selectedsiteId.value==0||dailyWrkDone_DPR_Controller.TypeSubcontId.value==0){

                                    }
                                    else{
                                      dailyWrkDone_DPRNEW_Controller.getAddBoqDetails(context);
                                    }
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
                          ],
                        ),
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
                            color:  dailyWrkDone_DPRNEW_Controller.checkColor == 0 ? Colors.white : Theme.of(context).primaryColor ,
                          ),
                          alignment: Alignment.center,
                          child: Text("Reset",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                                color:  dailyWrkDone_DPRNEW_Controller.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white ),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            dailyWrkDone_DPRNEW_Controller.checkColor = 1;
                            ResetAlert(context);
                          });
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
                            color: dailyWrkDone_DPRNEW_Controller.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white  ,
                          ),
                          alignment: Alignment.center,
                          child: Text("NEXT",  style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                              color:  dailyWrkDone_DPRNEW_Controller.checkColor == 0 ? Colors.white :  Theme.of(context).primaryColor ),),
                        ),
                        onTap: () async {
                            dailyWrkDone_DPRNEW_Controller.checkColor = 0;
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DailyWork_done_DPR_Labour()));
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

          // dprNew_mainList.value



          // Container(
          //   height: BaseUtitiles.getheightofPercentage(context, 4),
          //   margin: EdgeInsets.only(left: 10, right: 10),
          //   decoration: BoxDecoration(),
          //   child: TextField(
          //     readOnly:true,
          //     controller: dailyWrkDone_DPRNEW_Controller.dpr_new_descripionController,
          //     textAlign: TextAlign.center,
          //     decoration: InputDecoration(
          //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          //       border: OutlineInputBorder(),
          //       enabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
          //       ),
          //     ),
          //     onChanged: (value){
          //     },
          //   ),
          // ),

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
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     child: Text("Bal-BOQ qty",style: TextStyle(fontSize: RequestConstant.App_Font_SIZE,fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
                //   ),
                // ),
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
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     height: BaseUtitiles.getheightofPercentage(context, 4),
                //     margin: EdgeInsets.only(left: 10, right: 10),
                //     decoration: BoxDecoration(),
                //     child: TextField(
                //       readOnly:true,
                //       keyboardType: TextInputType.number,
                //       controller:dailyWrkDone_DPRNEW_Controller.dpr_new_boqQtyController,
                //       textAlign: TextAlign.center,
                //       decoration: InputDecoration(
                //         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                //         border: OutlineInputBorder(),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                //         ),
                //       ),
                //       onChanged: (value){
                //       },
                //     ),
                //   ),
                // ),
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
                            headNameController.headName.text="--Select--";
                            headNameController.selectedHeadId.value=0;

                            projectController.projectname.text = "--SELECT--";
                            projectController.selectedProjectId.value=0;

                            subcontractorController.Subcontractorname.text = "--SELECT--";
                            subcontractorController.selectedSubcontId.value=0;

                            siteController.Sitename.text = "--SELECT--";
                            siteController.selectedsiteId.value=0;

                            dailyWrkDone_DPR_Controller.entryTypeController.text = "--SELECT--";
                            dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--SELECT--";
                            dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;

                            dailyWrkDone_DPRNEW_Controller.dpr_new_preparedbyController.text=loginController.EmpName();
                            dailyWrkDone_DPRNEW_Controller.autoYearWiseNoController.text=autoYearWiseNoController.DPRNEW_autoYrsWise.value;
                            dailyWrkDone_DPRNEW_Controller.dateController.text=BaseUtitiles.initiateCurrentDateFormat();
                            dailyWrkDone_DPRNEW_Controller.dpr_new_remarksController.text="";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_referenceController.text="";
                            dailyWrkDone_DPRNEW_Controller.dprNew_DetTable_Delete();
                            dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.clear();


                            //Labour Screen
                            dailyWrkDone_DPRNEW_Controller.dprNew_LabourTable_Delete();
                            dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList.clear();
                            dailyWrkDone_DPRNEW_Controller.totalNetAmnt=0.0;

                            //Material Screen
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_ScaleController.text="UNIT";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_QtyController.text="0.0";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_NameController.text="";
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


                            dailyWrkDone_DPRNEW_Controller.saveButton.value = RequestConstant.SUBMIT;
                            dailyWrkDone_DPRNEW_Controller.dpr_new_currQtyController.text="0.0";
                            headNameController.headName.text="--Select--";
                            headNameController.selectedHeadId.value=0;

                            projectController.projectname.text = "--SELECT--";
                            projectController.selectedProjectId.value=0;

                            subcontractorController.Subcontractorname.text = "--SELECT--";
                            subcontractorController.selectedSubcontId.value=0;

                            siteController.Sitename.text = "--SELECT--";
                            siteController.selectedsiteId.value=0;

                            dailyWrkDone_DPR_Controller.TypeSubcontractorname.text = "--SELECT--";
                            dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;

                            dailyWrkDone_DPRNEW_Controller.dpr_new_preparedbyController.text=loginController.EmpName();
                            dailyWrkDone_DPRNEW_Controller.autoYearWiseNoController.text=autoYearWiseNoController.DPRNEW_autoYrsWise.value;
                            dailyWrkDone_DPRNEW_Controller.dateController.text=BaseUtitiles.initiateCurrentDateFormat();
                            dailyWrkDone_DPRNEW_Controller.dpr_new_remarksController.text="";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_referenceController.text="";
                            dailyWrkDone_DPRNEW_Controller.dprNew_DetTable_Delete();
                            dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.clear();


                            //Labour Screen
                            dailyWrkDone_DPRNEW_Controller.dprNew_LabourTable_Delete();
                            dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList.clear();
                            dailyWrkDone_DPRNEW_Controller.totalNetAmnt=0.0;

                            //Material Screen
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_ScaleController.text="UNIT";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_QtyController.text="0.0";
                            dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_NameController.text="";
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


                          // dailyWrkDone_DPRNEW_Controller.dpr_new_currQtyController.text="0.0";
                          // headNameController.headName.text="--Select--";
                          // headNameController.selectedHeadId.value=0;
                          // projectController.projectname.text=RequestConstant.SELECT;
                          // projectController.selectedProjectId.value=0;
                          // subcontractorController.Subcontractorname.text=RequestConstant.SELECT;
                          // subcontractorController.selectedSubcontId.value=0;
                          // siteController.Sitename.text=RequestConstant.SELECT;
                          // siteController.selectedsiteId.value=0;
                          // dailyWrkDone_DPR_Controller.entryTypeController.text="TYPE";
                          // dailyWrkDone_DPR_Controller.TypeSubcontractorname.text=RequestConstant.SELECT;
                          // dailyWrkDone_DPR_Controller.TypeSubcontId.value=0;
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_preparedbyController.text=loginController.EmpName();
                          // dailyWrkDone_DPRNEW_Controller.autoYearWiseNoController.text=autoYearWiseNoController.DPRNEW_autoYrsWise.value;
                          // dailyWrkDone_DPRNEW_Controller.dateController.text=BaseUtitiles.initiateCurrentDateFormat();
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_remarksController.text="";
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_referenceController.text="";
                          // dailyWrkDone_DPRNEW_Controller.dprNew_DetTable_Delete();
                          // dailyWrkDone_DPRNEW_Controller.dprNew_EntryDetReadList.clear();
                          //
                          //
                          // //Labour Screen
                          // dailyWrkDone_DPRNEW_Controller.dprNew_LabourTable_Delete();
                          // dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList.clear();
                          // dailyWrkDone_DPRNEW_Controller.totalNetAmnt=0.0;
                          //
                          // //Material Screen
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_ScaleController.text="UNIT";
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_QtyController.text="0.0";
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_Mat_NameController.text="";
                          // dailyWrkDone_DPRNEW_Controller.dprNew_MaterialTable_Delete();
                          // dailyWrkDone_DPRNEW_Controller.dprNewGetMatreadListdata.value.clear();
                          //
                          // //Masurement Screen
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DescController.text = "";
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_NosController.text = "";
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_LengthController.text = "";
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_BreathController.text = "";
                          // dailyWrkDone_DPRNEW_Controller.dpr_new_Measur_DepthController.text = "";
                          // dailyWrkDone_DPRNEW_Controller.dprNew_MSRTable_Delete();
                          // dailyWrkDone_DPRNEW_Controller.dprNewGetMSRreadListdata.value.clear();

                        },
                        child: Text("Reset", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),

          // ElevatedButton(
          //   onPressed: () => Navigator.of(context).pop(),
          //   child:Text('No'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     entrycheck=0;
          //     editCheck=0;
          //     Material_EntryList_DeleteApi(MrnReqEtyList.value[index].reqMasId,MrnReqEtyList.value[index].reqOrdNo);
          //     MrnReqEtyList.removeAt(index);
          //     Navigator.of(context).pop();
          //   },
          //   child:Text('Yes'),
          // ),

        ],
      ),
    );
  }
}