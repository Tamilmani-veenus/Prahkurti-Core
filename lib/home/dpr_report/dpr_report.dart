
import 'package:url_launcher/url_launcher.dart';

import '../../app_theme/app_colors.dart';
import '../../commonpopup/reporttype_alert.dart';
import '../../commonpopup/worktype_alert.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/attendancecontroller.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/comman_controller.dart';
import '../../controller/dailywrk_done_dpr_controller.dart';
import '../../controller/dprcontroller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/projectcontroller.dart';
import '../../controller/reports_controller.dart';
import '../../controller/sitecontroller.dart';
import '../../controller/subcontcontroller.dart';
import '../../newhome/maindashboard/dashboard.dart';
import '../../utilities/apiconstant.dart';
import '../../utilities/baseutitiles.dart';

import '../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pdf_generate/pdf_model/pdfmodel.dart';
import '../pdf_generate/pdf_openfilepath.dart';
import 'dpr_reportpdf.dart';

class DPRReport extends StatefulWidget {
  const DPRReport({Key? key}) : super(key: key);

  @override
  State<DPRReport> createState() => _DPRReportState();
}

class _DPRReportState extends State<DPRReport> {
  final ProjectController projectController=Get.put(ProjectController());
  final SubcontractorController subcontractorController=Get.put(SubcontractorController());
  final AttendanceController attendanceController=Get.put(AttendanceController());
  final SiteController siteController =Get.put(SiteController());
  final DprController dprController =Get.put(DprController());
  LoginController loginController=Get.put(LoginController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  ReportsController reportsController = Get.put(ReportsController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      dprController.FromdateController.clear();
      dprController.TodateController.clear();
      siteController.siteDropdownName.clear();
      DateTime currentDate = DateTime. now();
      dprController.dprList.value=[];
      dprController.FromdateController.text=currentDate.toString().substring(0,10);
      dprController.TodateController.text=currentDate.toString().substring(0,10);
      await reportsController.getReportProjectList();
      await reportsController.getSiteReportList(context,0);
      await reportsController.getSubcontactorReportList();
      reportsController.projectname.text = "--ALL--";
      reportsController.selectedProjectId.value = 0;
      reportsController.subcontractorname.text = "--ALL--";
      reportsController.selectedSubcontId.value = 0;
      reportsController.selectedsiteId.value = 0;
      reportsController.sitename.text = "--ALL--";
      dailyWrkDone_DPR_Controller.workType_DPR_Controller.text = "--SELECT--";
      dailyWrkDone_DPR_Controller.wrktype_DPR.value ="0";
      dailyWrkDone_DPR_Controller.reportTypeController.text="--SELECT--";
      dailyWrkDone_DPR_Controller.reportType.value = 0;
    });
    super.initState();
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "DPR Report",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
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
                  margin: EdgeInsets.only(top: 3, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: TextFormField(
                                readOnly: true,
                                controller: dprController.FromdateController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
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
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
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
                                  dprController.FromdateController.text = Frdate.toString().substring(0, 10);
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
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: BaseUtitiles.getWidthtofPercentage(context, 38),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: TextFormField(
                                readOnly: true,
                                controller: dprController.TodateController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "To Date",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon(Icons.calendar_month,
                                          color: Theme.of(context).primaryColor)),
                                ),
                                onTap: () async {
                                  var Todate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
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
                                  dprController.TodateController.text = Todate.toString().substring(0, 10);
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
                              child: ConstIcons.projectName
      
                          ),
                        ),
                        onTap: () {
                          // await projectController.getProjectList(context, 0);
                          setState(() {
                            bottomsheetControllers.projectNameReport(context, reportsController.getProjectdropDownvalue.value);
                          });
      
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
                              child: ConstIcons.siteName
      
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            bottomsheetControllers.siteNameReport(context, reportsController.getSiteDropdownvalue.value );
                          });
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
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
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
                              child: ConstIcons.subcontractorName
      
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            bottomsheetControllers.subcontractorNameReport(context, reportsController.getdropDownvalue.value);
                          });
      
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
      
                // Container(
                //   margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       side: BorderSide(color: Colors.white70, width: 1),
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     elevation: 3,
                //     child: Padding(
                //       padding:
                //       const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                //       child: TextFormField(
                //         readOnly: true,
                //         controller: dailyWrkDone_DPR_Controller.workType_DPR_Controller,
                //         cursorColor: Colors.black,
                //         style: TextStyle(color: Colors.black),
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.zero,
                //           border: InputBorder.none,
                //           labelText: "Work Type",
                //           labelStyle: TextStyle(
                //               color: Colors.grey,
                //               fontSize: RequestConstant.Lable_Font_SIZE),
                //           prefixIconConstraints:
                //           BoxConstraints(minWidth: 0, minHeight: 0),
                //           prefixIcon: Padding(
                //               padding: EdgeInsets.symmetric(
                //                   vertical: 8, horizontal: 8),
                //               child: ConstIcons.types
                //
                //           ),
                //         ),
                //         onTap: () {
                //           showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return  wrkTypeAlertAll();
                //               });
                //         },
                //
                //         validator: (value) {
                //           if (value!.isEmpty) {
                //             return '\u26A0 Please select work type';
                //           }
                //           return null;
                //         },
                //
                //       ),
                //     ),
                //   ),
                // ),
      
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
                        controller: dailyWrkDone_DPR_Controller.reportTypeController,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Report Type",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.accounttype
                          ),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return  ReportType_Alert();
                              });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '\u26A0 Please select report type';
                          }
                          return null;
                        },
      
                      ),
                    ),
                  ),
                ),
      
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: dprController.checkColor == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child:
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text("List View",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: dprController.checkColor == 0
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              dprController.dprList.value=[];
                              await dprController.getDprReportList();
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
                            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: dprController.checkColor == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child:
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text("PDF Download",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: dprController.checkColor == 0
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              download(loginController.user.value.userId!, loginController.user.value.userType!,reportsController.selectedProjectId.value, reportsController.selectedsiteId.value, reportsController.selectedSubcontId.value, dprController.FromdateController.text, dprController.TodateController.text, reportsController.projectname.text, reportsController.sitename.text, reportsController.subcontractorname.text,dailyWrkDone_DPR_Controller.wrktype_DPR.value,dailyWrkDone_DPR_Controller.reportType.value);
                            }
                          },
                        ),
      
                      ],
                    ),
                  ),
                ),
      
                SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2),),
      
                ListDetails(),
      
      
      
              ],
            ),
          ),
        ),
      ),
    );
  }

  download(int uid,String uType,int pId,int SId,int subId,String fdate,String todate,String pName,String sName,String subName,String wType,int repType){
     launch(ApiConstant.Web_URL + 'MobileReports/Mobile_DPR_RPT.aspx?UID=$uid&UTYPE=$uType&PID=$pId&SID=$SId&SUBID=$subId&FDT=$fdate&TDT=$todate&PNAME=$pName&SNAME=$sName&SUBNAME=$subName&WORKTYPE=$wType&REPTYPE=$repType');
     print(ApiConstant.Web_URL + 'MobileReports/Mobile_DPR_RPT.aspx?UID=$uid&UTYPE=$uType&PID=$pId&SID=$SId&SUBID=$subId&FDT=$fdate&TDT=$todate&PNAME=$pName&SNAME=$sName&SUBNAME=$subName&WORKTYPE=$wType&REPTYPE=$repType');
  }

  List<PdfListModel> getDpr_ReportList() {
    dprController.getDprList_Pdf.clear();
    dprController.dprList.forEach((element) async {
      var list = PdfListModel(
        workNo: element.workNo,
        // workDate: element.workDate,
        projectName: element.projectName,
        siteName: element.siteName,
        subContName: element.subContName,
      );
      dprController.getDprList_Pdf.add(list);
    });
    return dprController.getDprList_Pdf;
  }


  Widget ListDetails(){
    return Container(
      height:BaseUtitiles.getheightofPercentage(context,48),
      child: Obx(()=>ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: dprController.dprList.value.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                dprController.OnItemsSelected(dprController.dprList.value[index].workId,dprController.dprList.value[index].workNo, context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 3, top: 5, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only( right: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                  ConstIcons.list_date,
                                  Text(
                                    dprController.dprList.value[index].workDate.toString(),
                                    style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(dprController.dprList.value[index].workNo.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Project Name",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 3,
                              child: Text(
                                dprController.dprList.value[index].projectName.toString(),style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Site Name ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 3,
                              child: Text(
                                dprController.dprList.value[index].siteName.toString(),style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Contractor",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 3,
                              child: Text(
                                dprController.dprList.value[index].subContName.toString(),style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Aproval",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 3,
                              child: Text(
                                dprController.dprList.value[index].appStatus,
                                style: dprController.dprList.value[index].appStatus == "Approval Made" ? TextStyle(color: Colors.green, fontWeight: FontWeight.bold) :TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),


                        // Container(
                        //   margin: EdgeInsets.only(top: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         ("Project Name" ),style: TextStyle(color: Colors.white),
                        //       ),
                        //       Container(
                        //         width: BaseUtitiles.getWidthtofPercentage(context, 55),
                        //         child: Text(
                        //           (dprController.dprList.value[index].projectName.toString()),style: TextStyle(color: Colors.white),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(top: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         ("Site Name " ),style: TextStyle(color: Colors. white),
                        //       ),
                        //       Container(
                        //         width: BaseUtitiles.getWidthtofPercentage(context, 55),
                        //         child: Text(
                        //           (dprController.dprList.value[index].siteName.toString()),style: TextStyle(color: Colors.white),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(top: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         ("Aproval"),style: TextStyle(color: Colors. white),
                        //       ),
                        //       Container(
                        //         width: BaseUtitiles.getWidthtofPercentage(context, 55),
                        //         child: Text(
                        //           (
                        //               dprController.dprList.value[index].appStatus.toString()),style: TextStyle(color:Colors.white),
                        //         ),
                        //       ),
                        //
                        //     ],
                        //   ),
                        // ),


                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      ),
    );
  }
}
