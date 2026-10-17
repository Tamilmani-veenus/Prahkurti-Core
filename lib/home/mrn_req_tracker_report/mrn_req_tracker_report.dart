import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/accountsettings_controller.dart';
import '../../controller/attendancecontroller.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/logincontroller.dart';
import '../../controller/mrn_request_indent_controller.dart';
import '../../controller/projectcontroller.dart';
import '../../controller/reports_controller.dart';
import '../../controller/sitecontroller.dart';
import '../../controller/subcontcontroller.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/common_date_fields.dart';
import '../../utilities/requestconstant.dart';
import 'mrn_reqtracker_popup.dart';

class MRN_ReqTracker_Report extends StatefulWidget {
  const MRN_ReqTracker_Report({super.key});

  @override
  State<MRN_ReqTracker_Report> createState() => _MRN_ReqTracker_ReportState();
}

class _MRN_ReqTracker_ReportState extends State<MRN_ReqTracker_Report> {
  final ProjectController projectController=Get.put(ProjectController());
  final SubcontractorController subcontractorController=Get.put(SubcontractorController());
  final AttendanceController attendanceController=Get.put(AttendanceController());
  final SiteController siteController =Get.put(SiteController());
  LoginController loginController=Get.put(LoginController());
  ReportsController reportsController = Get.put(ReportsController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  AccountSetingController accountSetingController = Get.put(AccountSetingController());
  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      siteController.mrnReqTrackerListValue.value=[];
      DateTime currentDate = DateTime.now();
      DateTime oneWeekBefore = currentDate.subtract(const Duration(days: 7));
      siteController.FromdateController.text = oneWeekBefore.toString().substring(0, 10);
      siteController.TodateController.text = currentDate.toString().substring(0, 10);
      reportsController.projectname.text = "--ALL--";
      reportsController.selectedProjectId.value = 0;
      reportsController.sitename.text = "--ALL--";
      reportsController.selectedsiteId.value = 0;
      reportsController.companyName.text = "--ALL--";
      reportsController.selectedCompanyId.value = 0;
      reportsController.Subheadername.text = "--ALL--";
      reportsController.materialDropdowntId.value = 0;
    });
    super.initState();
  }

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
                        "MRN - Request Tracker",
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

                CommonDateFields(
                  date1: CommonDateFieldConfig(
                    title: "From Date",
                    value: siteController.FromdateController.text,
                    controller: siteController.FromdateController,
                    selectable: true,
                    initialDate: DateTime.now().subtract(const Duration(days: 7)),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    onChanged: (date) {
                      setState(() {
                        siteController.FromdateController.text =
                            CommonDateUtils.formatApiDate(date);
                      });
                    },
                  ),

                  date2: CommonDateFieldConfig(
                    title: "To Date",
                    value: siteController.TodateController.text,
                    controller: siteController.TodateController,
                    selectable: true,
                    initialDate: DateTime.tryParse(
                        siteController.FromdateController.text) ??
                        DateTime.now(),
                    firstDate: DateTime.tryParse(
                        siteController.FromdateController.text) ??
                        DateTime.now(),
                    lastDate: DateTime.now(),
                    onChanged: (date) {
                      setState(() {
                        siteController.TodateController.text =
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
                      padding:
                      const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                      child: TextFormField(
                        readOnly: true,
                        controller: reportsController.companyName,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Company Name",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.billType

                          ),
                        ),
                        onTap: () async {
                          await reportsController.getCompanyReportList(type: "MRNReqTracker");
                          bottomsheetControllers.CompanyName(context, reportsController.getCompanyDropDownvalue.value,type: "mrnReqTracker");
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
                        onTap: () async {
                          await reportsController.getReportProjectList(type: "mrnReqTracker");
                          bottomsheetControllers.projectNameReport(context, reportsController.getProjectdropDownvalue.value);
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
                        onTap: () async {
                          await siteController.subcontEntry_siteDropdowntList(context, 0,type: "Report");
                          bottomsheetControllers.siteNameReport(context, siteController.getSiteDropdownvalue.value);
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
                        controller: reportsController.Subheadername,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Material Name",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE),
                          prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.materialName

                          ),
                        ),
                        onTap: () async {
                          await reportsController.getReportMaterialList(type:"mrnReqTracker");
                          bottomsheetControllers.MRNMaterialName(context, reportsController.getMaterialdropDownvalue.value);
                        },
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                            height: BaseUtitiles.getheightofPercentage(context, 4),
                            width: BaseUtitiles.getWidthtofPercentage(context, 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color:  Theme.of(context).primaryColor
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text("Show",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              siteController.mrnReqTrackerListValue.value=[];
                              await siteController.getMrnReqTrackerList();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2)),

                ListDetails(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ListDetails(){
    return Container(
      height:BaseUtitiles.getheightofPercentage(context,38),
      width: BaseUtitiles.getWidthtofPercentage(context,100),
      child: Obx(()=>ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: siteController.mrnReqTrackerListValue.value.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                await mrn_request_controller.getCheckApprovalLevel();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return mrnReqTrackerPopup(list: siteController.mrnReqTrackerListValue[index], approvalLevelList:mrn_request_controller.checkApprovalLevelData);
                    });
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    siteController.mrnReqTrackerListValue.value[index].mrnDate??"-",
                                    style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(siteController.mrnReqTrackerListValue.value[index].mrnNo??"-",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Project Name",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 4,
                              child: Text(
                                siteController.mrnReqTrackerListValue.value[index].projectName??"-",style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Site Name",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 4,
                              child: Text(
                                siteController.mrnReqTrackerListValue.value[index].siteName??"-",style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Material Name",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),

                            Expanded(
                              flex: 4,
                              child: Text(
                                siteController.mrnReqTrackerListValue.value[index].material??"-",style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
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
