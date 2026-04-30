
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  const Company_nmr_entryscreen({Key? key}) : super(key: key);

  @override
  State<Company_nmr_entryscreen> createState() =>
      _Company_nmr_entryscreenState();
}

class _Company_nmr_entryscreenState extends State<Company_nmr_entryscreen> {
  CompanyNmrAttendanceController companyNmrAttendanceController = Get.put(CompanyNmrAttendanceController());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());
  CompanyController companyController = Get.put(CompanyController());
  AutoYearWiseNoController autoYearWiseNoController=Get.put(AutoYearWiseNoController());
  LoginController loginController=Get.put(LoginController());

  @override
  void initState() {


    var duration = Duration(seconds:0);
    Future.delayed(duration,() async {
      await autoYearWiseNoController.AutoYearWiseNo("COMPANY NMR");
      companyNmrAttendanceController.Company_EntryNo.text=autoYearWiseNoController.companyNMR_autoYrsWise.value;
      if(companyNmrAttendanceController.screencheck.value=="Aproval"){
        companyNmrAttendanceController.pendingAllDatasList.forEach((element) {
          companyNmrAttendanceController.saveButton.value="Approval";
          companyNmrAttendanceController.atId=element.attenId!;
          companyNmrAttendanceController.Company_EntryNo.text=element.attenNo.toString();
          companyNmrAttendanceController.Company_EntryDate.text=element.attenDate;
          projectController.selectedProjectId.value=element.projectId;
          projectController.projectname.text=element.projectName.toString();
          siteController.selectedsiteId.value=element.siteId;
          siteController.Sitename.text=element.siteName.toString();
          companyController.selectedCompanyId.value=element.companyId;
          companyController.CompanyName.text=element.companyName.toString();
          companyNmrAttendanceController.Company_EntryRemarks.text=element.remarks.toString();
          companyNmrAttendanceController.Company_EntryPreparedby.text=element.preparedbyName.toString();
        });
      }

      if(companyNmrAttendanceController.edicheck==1){
        companyNmrAttendanceController.EditListApiValue.forEach((element) {
          companyNmrAttendanceController.screencheck.value="";
          companyNmrAttendanceController.saveButton.value="Update";
          companyNmrAttendanceController.atId=element.attenId!;
          companyNmrAttendanceController.Company_EntryNo.text=element.attenNo.toString();
          companyNmrAttendanceController.Company_EntryDate.text=element.attenDate;
          projectController.selectedProjectId.value=element.projectId;
          projectController.projectname.text=element.projectName.toString();
          siteController.selectedsiteId.value=element.siteId;
          siteController.Sitename.text=element.siteName.toString();
          companyController.selectedCompanyId.value=element.companyId;
          companyController.CompanyName.text=element.companyName.toString();
          companyNmrAttendanceController.Company_EntryRemarks.text=element.remarks.toString();
          companyNmrAttendanceController.Company_EntryPreparedby.text=element.preparedbyName.toString();

        });

      }

      if(companyNmrAttendanceController.entrycheck==0){
        companyNmrAttendanceController.entrycheck=1;
        companyNmrAttendanceController.screencheck.value="";
        companyNmrAttendanceController.saveButton.value="Save";
        companyNmrAttendanceController.atId=0;
        companyNmrAttendanceController.delete_cmpNmrdetTable();
        companyNmrAttendanceController.cmpNmr_getDbDetList.clear();
        companyNmrAttendanceController.Company_EntryDate.text=BaseUtitiles.initiateCurrentDateFormat();
        projectController.selectedProjectId.value=0;
        projectController.projectname.text="";
        siteController.selectedsiteId.value=0;
        siteController.Sitename.text="";
        companyController.selectedCompanyId.value=0;
        companyController.CompanyName.text="";
        companyNmrAttendanceController.Company_EntryRemarks.text="";
        companyNmrAttendanceController.Company_EntryPreparedby.text=loginController.EmpName();
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      child: Text(
                        "Entry No",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      margin: EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(),
                      child: TextField(
                        readOnly: true,
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor),
                        controller:
                            companyNmrAttendanceController.Company_EntryNo,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.0),
                          ),
                        ),
                        onChanged: (value) {
                          //nmrWklyController.deduction_paymentCalculation();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      child: Text(
                        "Entry Date",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      margin: EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(),
                      child: TextField(
                        readOnly: true,
                        style: TextStyle(fontSize: 13),
                        controller:
                            companyNmrAttendanceController.Company_EntryDate,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.date_range_sharp,
                              color: Theme.of(context).primaryColor),
                        ),
                        onTap: () async {

                          if(companyNmrAttendanceController.edicheck==1){

                          }
                          else{
                            var Entrydate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate:  DateTime(1900),
                                lastDate: DateTime.now(),builder: (context, child) {
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
                            companyNmrAttendanceController.Company_EntryDate.text =BaseUtitiles.selectDateFormat(Entrydate!);
                          }

                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              height: BaseUtitiles.getheightofPercentage(context, 5),
              width: BaseUtitiles.getWidthtofPercentage(context, 90),
              child: TextField(
                style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                readOnly: true,
                controller: projectController.projectname,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  labelText: RequestConstant.PROJECT_NAME,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                  ),
                ),
                onTap: () {
                  projectController.getProjectList();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              height: BaseUtitiles.getheightofPercentage(context, 5),
              width: BaseUtitiles.getWidthtofPercentage(context, 90),
              child: TextField(
                style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                readOnly: true,
                controller: siteController.Sitename,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  labelText: RequestConstant.SITE_NAME,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                  ),
                ),
                onTap: () {
                  siteController.subcontEntry_siteDropdowntList(context,0);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              height: BaseUtitiles.getheightofPercentage(context, 5),
              width: BaseUtitiles.getWidthtofPercentage(context, 90),
              child: TextField(
                style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                readOnly: true,
                controller: companyController.CompanyName,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  labelText: RequestConstant.COMPANY_NAME,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                  ),
                ),
                onTap: () {
                  companyController.getCompanyList(context,1);
                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      child: Text("Prepared By",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      margin: EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        readOnly: true,
                        controller: companyNmrAttendanceController
                            .Company_EntryPreparedby,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.0),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      child: Text("Remarks",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: BaseUtitiles.getheightofPercentage(context, 4),

                      margin: EdgeInsets.only(left: 10, right: 20),
                      //decoration: BoxDecoration(),
                      child: TextField(
                        controller:
                            companyNmrAttendanceController.Company_EntryRemarks,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.0),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            Container(
              height: BaseUtitiles.getheightofPercentage(context, 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  side: BorderSide(width: 3, color: Colors.black),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  companyNmrAttendanceController.getCompanyaddList(companyController.selectedCompanyId.value, context);
                },
                child: Text('List'),
              ),
            ),
            Obx(() => Container(
                  child: Visibility(
                      visible: companyNmrAttendanceController
                              .cmpNmr_getDbDetList.value.isEmpty
                          ? false
                          : true,
                      child: ListDetails()),
                )),
            Obx(() => Container(
                  child: Visibility(
                    visible: companyNmrAttendanceController
                            .cmpNmr_getDbDetList.value.isEmpty
                        ? false
                        : true,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          side: BorderSide(width: 3, color: Colors.black),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () async {
                          await companyNmrAttendanceController.getcmpNMRTablesDatas();
                          if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                          companyNmrAttendanceController.SaveAPI(context,companyNmrAttendanceController.atId);
                          }
                        },
                        child: Text(companyNmrAttendanceController.saveButton.value),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }



  Widget ListDetails() {
    return Container(
      margin: EdgeInsets.all(8),
      height:
          companyNmrAttendanceController.cmpNmr_getDbDetList.value.length == 1
              ? BaseUtitiles.getheightofPercentage(context, 20)
              : BaseUtitiles.getheightofPercentage(context, 55),
      child: ListView.builder(
        itemCount:
            companyNmrAttendanceController.cmpNmr_getDbDetList.value.length,
        itemBuilder: (BuildContext context, int index) {

          companyNmrAttendanceController.textControllersInitiate();
          return Card(
            elevation: 3,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        companyNmrAttendanceController
                            .cmpNmr_getDbDetList.value[index].Labour_No
                            .toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.App_Font_SIZE,
                            color: Colors.white),
                      ),
                      Text(
                        "₹ " +
                            companyNmrAttendanceController
                                .cmpNmr_getDbDetList.value[index].wages
                                .toString(),
                        style: TextStyle(
                            fontSize: RequestConstant.App_Font_SIZE,
                            color: Colors.white),
                      ),
                      Container(
                        height: BaseUtitiles.getheightofPercentage(context, 2),
                        width: BaseUtitiles.getWidthtofPercentage(context, 10),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  RequestConstant.DO_YOU_WANT_DELETE,
                                  style: TextStyle(color: Colors.black),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                      child: Text(RequestConstant.NO,
                                          style:
                                              TextStyle(color: Colors.black)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                  ElevatedButton(
                                      child: Text(RequestConstant.YES,
                                          style:
                                              TextStyle(color: Colors.black)),
                                      onPressed: () {
                                        companyNmrAttendanceController.deleteParticularList(companyNmrAttendanceController.cmpNmr_getDbDetList.value[index]);
                                        companyNmrAttendanceController.cmpNmr_getDbDetList.remove(companyNmrAttendanceController.cmpNmr_getDbDetList.value[index]);
                                        companyNmrAttendanceController.getcmpNMRTablesDatas();
                                        Navigator.pop(context);
                                      }),
                                ],
                              ),
                            );
                          },
                          child: Image.asset('assets/cancle.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 27,
                        child: Text(
                          companyNmrAttendanceController
                              .cmpNmr_getDbDetList.value[index].labourName
                              .toString(),
                          style: TextStyle(
                              fontSize: RequestConstant.App_Font_SIZE,
                              color: Colors.lightGreenAccent),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          companyNmrAttendanceController
                              .cmpNmr_getDbDetList.value[index].shift
                              .toString(),
                          style: TextStyle(
                              fontSize: RequestConstant.App_Font_SIZE,
                              color: Colors.white),
                        ),
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
                                fontSize: RequestConstant.App_Font_SIZE,
                                color: Colors.white),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 5, right: 5),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        width: BaseUtitiles.getWidthtofPercentage(context, 24),
                        child: TextField(
                          readOnly: true,
                          cursorColor: Theme.of(context).primaryColor,
                          textAlign: TextAlign.center,
                          controller: companyNmrAttendanceController.statusText[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5))),
                          ),
                          style: TextStyle(color: Colors.white),
                          onTap:() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatusAlert(value:companyNmrAttendanceController.cmpNmr_getDbDetList.value[index].labourId);
                                });
                          },
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "OT Hrs",
                            style: TextStyle(
                                fontSize: RequestConstant.App_Font_SIZE,
                                color: Colors.white),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 5, right: 5),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        width: BaseUtitiles.getWidthtofPercentage(context, 22),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          textAlign: TextAlign.center,
                          controller:
                              companyNmrAttendanceController.oThrsText[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            companyNmrAttendanceController.updateDBTables();
                          },
                        ),
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
                            "BusFare",
                            style: TextStyle(
                                fontSize: RequestConstant.App_Font_SIZE,
                                color: Colors.white),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 5, right: 5),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        width: BaseUtitiles.getWidthtofPercentage(context, 24),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          textAlign: TextAlign.center,
                          controller:
                              companyNmrAttendanceController.busfareText[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            companyNmrAttendanceController.updateDBTables();
                          },
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "Advance",
                            style: TextStyle(
                                fontSize: RequestConstant.App_Font_SIZE,
                                color: Colors.white),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        width: BaseUtitiles.getWidthtofPercentage(context, 22),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          textAlign: TextAlign.center,
                          controller:
                              companyNmrAttendanceController.advanceText[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            companyNmrAttendanceController.updateDBTables();
                          },
                        ),
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
                            "Remarks",
                            style: TextStyle(
                                fontSize: RequestConstant.App_Font_SIZE,
                                color: Colors.white),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        width: BaseUtitiles.getWidthtofPercentage(context, 72),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          textAlign: TextAlign.center,
                          controller:
                              companyNmrAttendanceController.remarksText[index],
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            companyNmrAttendanceController.updateDBTables();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}
