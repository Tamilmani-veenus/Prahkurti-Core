import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/attendancecontroller.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/comman_controller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/projectcontroller.dart';
import '../../controller/subcontcontroller.dart';
import '../../newhome/maindashboard/dashboard.dart';
import '../../newhome/maindashboard/dashboard_otheruser.dart';
import '../../utilities/baseutitiles.dart';

import '../../utilities/requestconstant.dart';

class CompanyNmrAtdReport extends StatefulWidget {
  const CompanyNmrAtdReport({Key? key}) : super(key: key);

  @override
  State<CompanyNmrAtdReport> createState() => _CompanyNmrAtdReportState();
}

class _CompanyNmrAtdReportState extends State<CompanyNmrAtdReport> {

  final ProjectController projectController=Get.put(ProjectController());
  final SubcontractorController subcontractorController=Get.put(SubcontractorController());
  final AttendanceController attendanceController=Get.put(AttendanceController());
  LoginController loginController=Get.put(LoginController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  @override
  void initState() {
    projectController.getProjectList();
    subcontractorController.getLabourList(context);

    attendanceController.FromdateController.clear();
    attendanceController.TodateController.clear();

    DateTime currentDate = DateTime. now();

    attendanceController.FromdateController.text=currentDate.toString().substring(0,10);
    attendanceController.TodateController.text=currentDate.toString().substring(0,10);

    projectController.projectname.text="--Select--";
    projectController.selectedProjectId.value=0;
    subcontractorController.LabournameText.text="--Select--";
    subcontractorController.labourId.value=0;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setmybackground,
      body: SingleChildScrollView(
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
                    "Company NMR Report",
                    style: TextStyle(
                        fontSize: RequestConstant.Heading_Font_SIZE,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        if(loginController.user.value.userType=="A"){
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => Dashboard_screen()));
                        }
                        else{
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
                        }
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
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
                          controller: attendanceController.FromdateController,
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
                            attendanceController.FromdateController.text = Frdate.toString().substring(0, 10);
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
                  Container(
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
                          controller: attendanceController.TodateController,
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
                            attendanceController.TodateController.text = Todate.toString().substring(0, 10);
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
                          child: ConstIcons.projectName

                      ),
                    ),
                    onTap: () {
                      // await projectController.getProjectList(context, 0);
                      setState(() {
                        bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value );
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
                    controller: subcontractorController.LabournameText,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      labelText: "Labour Name",
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
                        bottomsheetControllers.LabourName(context, subcontractorController.labourList.value);
                        // commanController.ProjectName(context, projectController.getdropDownvalue.value );
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: attendanceController.checkColor == 0
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
                            color: attendanceController.checkColor == 0
                                ? Colors.white
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  onTap: () async {
                   await download(loginController.user.value.userId!,loginController.user.value.userType!,projectController.selectedProjectId.value,subcontractorController.labourId.value,attendanceController.FromdateController.text,attendanceController.TodateController.text,projectController.projectname.text,subcontractorController.LabournameText.text);
                  },
                ),
              ],
            ),


            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: <Widget>[
            //     Container(
            //       margin: EdgeInsets.only(top: 7,left: 4),
            //       width: BaseUtitiles.getWidthtofPercentage(context,40),
            //       height: BaseUtitiles.getheightofPercentage(context,4),
            //       child: TextField(
            //         readOnly: true,
            //         controller: attendanceController.FromdateController,
            //         decoration: InputDecoration(
            //           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            //           ),
            //           enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            //           ),
            //           border: OutlineInputBorder(),
            //           prefixIcon: Icon(Icons.date_range_sharp,
            //               color: Theme.of(context).primaryColor),
            //         ),
            //         onTap: () async {
            //           var Frdate = await showDatePicker(
            //               context: context,
            //               initialDate: DateTime.now(),
            //               firstDate: DateTime(1900),
            //               lastDate: DateTime(2100),
            //               builder: (context, child) {
            //                 return Theme(data: Theme.of(context).copyWith(
            //                   colorScheme: ColorScheme.light(
            //                     primary: Theme.of(context).primaryColor, // header background color
            //                     onPrimary: Colors.white, // header text color
            //                     onSurface: Colors.black, // body text color
            //                   ),
            //                   textButtonTheme: TextButtonThemeData(
            //                     style: TextButton.styleFrom(
            //                       primary: Colors.black, // button text color
            //                     ),
            //                   ),
            //                 ),
            //                   child: child!,
            //                 );
            //               });
            //           attendanceController.FromdateController.text = Frdate.toString().substring(0, 10);
            //         },
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.only(top: 7,right: 4),
            //       width: BaseUtitiles.getWidthtofPercentage(context,40),
            //       height: BaseUtitiles.getheightofPercentage(context,4),
            //       child: TextField(
            //         readOnly: true,
            //         controller: attendanceController.TodateController,
            //         decoration: InputDecoration(
            //           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            //           ),
            //           enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            //           ),
            //           border: OutlineInputBorder(),
            //           prefixIcon: Icon(Icons.date_range_sharp,
            //               color: Theme.of(context).primaryColor),
            //         ),
            //         onTap: () async {
            //           var Frdate = await showDatePicker(
            //
            //               context: context,
            //               initialDate: DateTime.now(),
            //               firstDate: DateTime(1900),
            //               lastDate: DateTime(2100),
            //               builder: (context, child) {
            //                 return Theme(data: Theme.of(context).copyWith(
            //                   colorScheme: ColorScheme.light(
            //                     primary: Theme.of(context).primaryColor, // header background color
            //                     onPrimary: Colors.white, // header text color
            //                     onSurface: Colors.black, // body text color
            //                   ),
            //                   textButtonTheme: TextButtonThemeData(
            //                     style: TextButton.styleFrom(
            //                       primary: Colors.black, // button text color
            //                     ),
            //                   ),
            //                 ),
            //                   child: child!,
            //                 );
            //               });
            //           attendanceController.TodateController.text = Frdate.toString().substring(0, 10);
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //   alignment: Alignment.center,
            //   margin:
            //   EdgeInsets.only(left: 20, right: 20, top: 13, bottom: 10),
            //   height: BaseUtitiles.getheightofPercentage(context, 5),
            //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
            //   child: TextField(
            //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
            //     readOnly: true,
            //     controller: projectController.projectname,
            //     decoration: new InputDecoration(
            //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            //       labelText: "ProjectName",
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            //       ),
            //     ),
            //
            //     onTap: () {
            //       projectController.getProjectList(context,0);
            //
            //     },
            //   ),
            //
            // ),
            // Container(
            //   alignment: Alignment.center,
            //   margin:
            //   EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            //   height: BaseUtitiles.getheightofPercentage(context, 5),
            //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
            //   child: TextField(
            //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
            //     readOnly: true,
            //     controller: subcontractorController.LabournameText,
            //     decoration: new InputDecoration(
            //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            //       labelText: "Labour Name",
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            //       ),
            //
            //     ),
            //
            //     onTap: () {
            //       subcontractorController.getLabourList(context);
            //     },
            //   ),
            //
            // ),
            // Center(
            //   child: Container(
            //     margin: EdgeInsets.only(top: 10, bottom: 10),
            //     height: BaseUtitiles.getheightofPercentage(context, 4),
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         primary: Theme.of(context).primaryColor,
            //         side: BorderSide(width: 3, color: Colors.black),
            //         elevation: 3,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(30)),
            //       ),
            //       onPressed: () async {
            //         download(loginController.user.value.userId!,loginController.user.value.userType!,projectController.selectedProjectId.value,subcontractorController.labourId.value,attendanceController.FromdateController.text,attendanceController.TodateController.text,projectController.projectname.text,subcontractorController.LabournameText.text);
            //       },
            //       child: Text("PDF Download"),
            //     ),
            //   ),
            // ),
            // // Divider(),
            // // ListDetails(),

          ],
        ),
      ),
    );
  }

  download(int uid,String uType,int pId,int labId,String fdate,String todate,String pname,String lName){
    launch('https://veenussofttech.in/sunassociates/MobileReports/CompanyAttMobileRPT.aspx?uid=$uid&utype=$uType&Typ=1&PRJID=$pId&LBRID=$labId&Frdate=$fdate&Todate=$todate&PRJ=$pname&LBR=$lName');
    print('https://veenussofttech.in/sunassociates/MobileReports/CompanyAttMobileRPT.aspx?uid=$uid&utype=$uType&Typ=1&PRJID=$pId&LBRID=$labId&Frdate=$fdate&Todate=$todate&PRJ=$pname&LBR=$lName');
  }

}
