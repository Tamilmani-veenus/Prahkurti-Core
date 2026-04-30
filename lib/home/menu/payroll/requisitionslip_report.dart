// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../app_theme/app_colors.dart';
// import '../../../commonpopup/worktype_alert.dart';
// import '../../../constants/ui_constant/icons_const.dart';
// import '../../../controller/bottomsheet_Controllers.dart';
// import '../../../controller/companycontroller.dart';
// import '../../../controller/logincontroller.dart';
// import '../../../controller/reports_controller.dart';
// import '../../../controller/requisitionslip_controller.dart';
// import '../../../controller/requisitionslip_controller_new.dart';
// import '../../../controller/staffcontroller.dart';
// import '../../../utilities/apiconstant.dart';
// import '../../../utilities/baseutitiles.dart';
// import '../../../utilities/requestconstant.dart';
//
// class RequisitionslipReport extends StatefulWidget {
//   const RequisitionslipReport({super.key});
//
//   @override
//   State<RequisitionslipReport> createState() => _RequisitionslipReportState();
// }
//
// class _RequisitionslipReportState extends State<RequisitionslipReport> {
//
//   final CompanyController companyController = Get.put(CompanyController());
//   final BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
//   final ReportsController reportsController = Get.put(ReportsController());
//   final RequisitionSlipControllerNew requisitionSlipController = Get.put(RequisitionSlipControllerNew());
//   final StaffController staffController = Get.put(StaffController());
//   final LoginController loginController = Get.put(LoginController());
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     Future.delayed(const Duration(seconds: 0),() async {
//       companyController.CompanyName.text = "--SELECT--";
//       companyController.selectedCompanyId.value = 0;
//       requisitionSlipController.reqSlip=1;
//       DateTime currentDate = DateTime. now();
//       requisitionSlipController.Staffname.text = loginController.user.value.empName.toString();
//       requisitionSlipController.selectedstaffId.value = loginController.user.value.empId!;
//      await companyController.getCompanyList(context, 0);
//      await staffController.get_staffDropdowntList(context);
//      requisitionSlipController.Staffname.text = loginController.user.value.empName.toString();
//      requisitionSlipController.selectedstaffId.value = loginController.user.value.empId!;
//      requisitionSlipController.reportFromDate.text = currentDate.toString().substring(0,10);
//      requisitionSlipController.reportToDate.text = currentDate.toString().substring(0,10);
//      requisitionSlipController.reqLeaveType.text="--All--";
//      requisitionSlipController.leaveType.value = "A";
//
//      // if(loginController.user.value.userType == 'A'){
//      //   await staffController.get_staffDropdowntList(context);
//      // }else{
//      //   requisitionSlipController.Staffname.text = loginController.user.value.empName.toString();
//      //   requisitionSlipController.selectedstaffId.value = loginController.user.value.empId!;
//      // }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Setmybackground,
//       body: GestureDetector(
//         onTap: () {
//           FocusScopeNode currentFocus = FocusScope.of(context);
//           if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
//             FocusManager.instance.primaryFocus?.unfocus();
//           }
//         },
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * 3 / 100,),
//                 Container(
//                   margin: const EdgeInsets.only(left: 15, right: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                        const Expanded(
//                          flex: 3,
//                          child: Text(
//                           "Requisition Report",
//                           style: TextStyle(
//                               fontSize: RequestConstant.Heading_Font_SIZE,
//                               fontWeight: FontWeight.bold),
//                          ),
//                        ),
//                       Expanded(
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text("Back",
//                             style: TextStyle(color: Colors.grey, fontSize: 18),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 Container(
//                   margin: const EdgeInsets.only(top: 3, left: 10, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(color: Colors.white70, width: 1),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           elevation: 3,
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 3),
//                             child: TextFormField(
//                               readOnly: true,
//                               controller: requisitionSlipController.reportFromDate,
//                               cursorColor: Colors.black,
//                               style: const TextStyle(color: Colors.black),
//                               decoration: const InputDecoration(
//                                 contentPadding: EdgeInsets.zero,
//                                 border: InputBorder.none,
//                                 labelText: "From Date",
//                                 labelStyle: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: RequestConstant.Lable_Font_SIZE),
//                                 prefixIconConstraints:
//                                 BoxConstraints(minWidth: 0, minHeight: 0),
//                                 prefixIcon: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 8, horizontal: 8),
//                                   child: ConstIcons.date,
//                                 ),
//                               ),
//                               onTap: () async {
//                                 var Frdate = await showDatePicker(
//                                     context: context,
//                                     initialDate: DateTime.now(),
//                                     firstDate: DateTime(2010),
//                                     lastDate: DateTime.now(),
//                                     builder: (context, child) {
//                                       return Theme(
//                                         data: Theme.of(context).copyWith(
//                                           colorScheme: ColorScheme.light(
//                                             primary: Theme.of(context).primaryColor,
//                                             onPrimary: Colors.white,
//                                             onSurface:
//                                             Colors.black, // body text color
//                                           ),
//                                           textButtonTheme: TextButtonThemeData(
//                                             style: TextButton.styleFrom(
//                                               primary:
//                                               Colors.black, // button text color
//                                             ),
//                                           ),
//                                         ),
//                                         child: child!,
//                                       );
//                                     });
//                                 requisitionSlipController.reportFromDate.text = Frdate.toString().substring(0, 10);
//                               },
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Select Date';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           width: BaseUtitiles.getWidthtofPercentage(context, 38),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               side: const BorderSide(color: Colors.white70, width: 1),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 3),
//                               child: TextFormField(
//                                 readOnly: true,
//                                 controller: requisitionSlipController.reportToDate,
//                                 cursorColor: Colors.black,
//                                 style: TextStyle(color: Colors.black),
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.zero,
//                                   border: InputBorder.none,
//                                   labelText: "To Date",
//                                   labelStyle: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: RequestConstant.Lable_Font_SIZE),
//                                   prefixIconConstraints:
//                                   BoxConstraints(minWidth: 0, minHeight: 0),
//                                   prefixIcon: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 8),
//                                       child: Icon(Icons.calendar_month,
//                                           color: Theme.of(context).primaryColor)),
//                                 ),
//                                 onTap: () async {
//                                   var Todate = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(2010),
//                                       lastDate: DateTime.now(),
//                                       builder: (context, child) {
//                                         return Theme(
//                                           data: Theme.of(context).copyWith(
//                                             colorScheme: ColorScheme.light(
//                                               primary: Theme.of(context).primaryColor,
//                                               // header background color
//                                               onPrimary: Colors.white,
//                                               // header text color
//                                               onSurface:
//                                               Colors.black, // body text color
//                                             ),
//                                             textButtonTheme: TextButtonThemeData(
//                                               style: TextButton.styleFrom(
//                                                 primary:
//                                                 Colors.black, // button text color
//                                               ),
//                                             ),
//                                           ),
//                                           child: child!,
//                                         );
//                                       });
//                                   requisitionSlipController.reportToDate.text = Todate.toString().substring(0, 10);
//                                 },
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Select Date';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       // Container(
//                       //   child: ElevatedButton(
//                       //       style: ElevatedButton.styleFrom(
//                       //           primary: Theme.of(context).primaryColor),
//                       //       onPressed: () async {
//                       //         setState(() {
//                       //           mrn_request_controller.getMrn_Req_EntryList();
//                       //         });
//                       //       },
//                       //       child: Center(
//                       //           child: Padding(
//                       //             padding: const EdgeInsets.only(top: 13, bottom: 13),
//                       //             child: Text("SHOW",
//                       //                 style: TextStyle(
//                       //                     color: Colors.white,
//                       //                     fontSize: RequestConstant.App_Font_SIZE,
//                       //                     fontWeight: FontWeight.bold)),
//                       //           ))),
//                       // ),
//                     ],
//                   ),
//                 ),
//
//                 Container(
//                   margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       side: const BorderSide(color: Colors.white70, width: 1),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 3,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
//                       child: TextFormField(
//                         maxLines: null,
//                         readOnly: true,
//                         controller: companyController.CompanyName,
//                         cursorColor: Colors.black,
//                         style: const TextStyle(color: Colors.black),
//                         decoration: const InputDecoration(
//                           contentPadding: EdgeInsets.zero,
//                           border: InputBorder.none,
//                           labelText: RequestConstant.COMPANY_NAME,
//                           labelStyle: TextStyle(
//                               color: Colors.grey,
//                               fontSize: RequestConstant.Lable_Font_SIZE),
//                           prefixIconConstraints:
//                           BoxConstraints(minWidth: 0, minHeight: 0),
//                           prefixIcon: Padding(
//                               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                               child: ConstIcons.siteName),
//                         ),
//                         onTap: () {
//                           setState(() {
//                             setState(() {
//                               bottomsheetControllers.CompanyName(context,companyController.getdropDownvalue.value );
//                             });
//                             // companyController.projectname_CompanyWise.text = "";
//                             // companyController.selectedProjectId_CompanyWise.value = 0;
//                             // expensesController.reportExpensesList.value.clear();
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Container(
//                 //   margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
//                 //   child: Card(
//                 //     shape: RoundedRectangleBorder(
//                 //       side: const BorderSide(color: Colors.white70, width: 1),
//                 //       borderRadius: BorderRadius.circular(15),
//                 //     ),
//                 //     elevation: 3,
//                 //     child: Padding(
//                 //       padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
//                 //       child: TextFormField(
//                 //         readOnly: true,
//                 //         controller: reportsController.projectname,
//                 //         cursorColor: Colors.black,
//                 //         style: const TextStyle(color: Colors.black),
//                 //         decoration: const InputDecoration(
//                 //           contentPadding: EdgeInsets.zero,
//                 //           border: InputBorder.none,
//                 //           labelText: "Project Name",
//                 //           labelStyle: TextStyle(
//                 //               color: Colors.grey,
//                 //               fontSize: RequestConstant.Lable_Font_SIZE),
//                 //           prefixIconConstraints:
//                 //           BoxConstraints(minWidth: 0, minHeight: 0),
//                 //           prefixIcon: Padding(
//                 //               padding:
//                 //               EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                 //               child: ConstIcons.projectName),
//                 //         ),
//                 //         onTap: () {
//                 //           // await projectController.getProjectList(context, 0);
//                 //           setState(() {
//                 //             bottomsheetControllers.projectNameReport(context, reportsController.getProjectdropDownvalue.value);
//                 //             // textclear();
//                 //           });
//                 //         },
//                 //         validator: (value) {
//                 //           if (value!.isEmpty || value == "--Select--") {
//                 //             return '\u26A0 Please select project name.';
//                 //           }
//                 //           return null;
//                 //         },
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//
//                 Container(
//                   margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       side: const BorderSide(color: Colors.white70, width: 1),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 3,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
//                       child: TextFormField(
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         readOnly: true,
//                         controller: requisitionSlipController.Staffname,
//                         cursorColor: Colors.black,
//                         style: const TextStyle(color: Colors.black),
//                         decoration: const InputDecoration(
//                           contentPadding: EdgeInsets.zero,
//                           border: InputBorder.none,
//                           labelText: "Staff Name",
//                           labelStyle: TextStyle(
//                               color: Colors.grey,
//                               fontSize: RequestConstant.Lable_Font_SIZE),
//                           prefixIconConstraints:
//                           BoxConstraints(minWidth: 0, minHeight: 0),
//                           prefixIcon: Padding(
//                               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                               child: ConstIcons.projectName),
//                         ),
//                         onTap: () async {
//                           // setState(() {
//                           if(loginController.user.value.userType == "A"){
//                             Future.delayed(const Duration(seconds: 0),()async {
//                               // await bottomsheetControllers.StaffName(context, staffController.getStaffDropdownvalue.value, requisitionSlipController.reqSlip);
//                             });
//                           }
//                           FocusScope.of(context).unfocus();
//                           // });
//                         },
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return '\u26A0 Please select Staff Name.';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.only(top: 5, left: 10, right: 10),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(color: Colors.white70, width: 1),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 3,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
//                       child: TextFormField(
//                         readOnly: true,
//                         controller: requisitionSlipController.reqLeaveType,
//                         cursorColor: Colors.black,
//                         style: TextStyle(color: Colors.black),
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.zero,
//                           border: InputBorder.none,
//                           labelText: "Requisition Type",
//                           labelStyle: TextStyle(
//                               color: Colors.grey,
//                               fontSize: RequestConstant.Lable_Font_SIZE),
//                           prefixIconConstraints:
//                           BoxConstraints(minWidth: 0, minHeight: 0),
//                           prefixIcon: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 8, horizontal: 8),
//                               child: ConstIcons.types
//                           ),
//                         ),
//                         onTap: () {
//                           showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 // return  LeaveReqTypeAlert();
//                                 return  null!;
//                               });
//                         },
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return '\u26A0 Please select work type';
//                           }
//                           return null;
//                         },
//
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.only(top: 10,),
//                   child: IntrinsicHeight(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//
//                         InkWell(
//                           child: Container(
//                             margin: EdgeInsets.only(left: 20, right: 20, top: 10),
//                             height: BaseUtitiles.getheightofPercentage(context, 4),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               color: requisitionSlipController.checkColor == 0
//                                   ? Theme.of(context).primaryColor
//                                   : Colors.white,
//                             ),
//                             alignment: Alignment.center,
//                             child:
//                             Padding(
//                               padding: const EdgeInsets.all(5),
//                               child: Text("List View",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: RequestConstant.Lable_Font_SIZE,
//                                     color: requisitionSlipController.checkColor == 0
//                                         ? Colors.white
//                                         : Theme.of(context).primaryColor),
//                               ),
//                             ),
//                           ),
//                           onTap: () async {
//                             if(_formKey.currentState!.validate()){
//                               setState(() {
//                                 reportsController.getReqLeave(
//                                     requisitionSlipController.selectedstaffId.value,
//                                     companyController.selectedCompanyId.value,
//                                     requisitionSlipController.reportFromDate.text,
//                                     requisitionSlipController.reportToDate.text,
//                                     requisitionSlipController.leaveType.value
//                                 );
//                               });
//                             }
//                           },
//                         ),
//
//                         VerticalDivider(
//                           color: Colors.grey.shade400,
//                           width: 5,
//                           thickness: 2,
//                           indent: 15,
//                           endIndent: 8, //Spacing at the bottom of divider.
//                         ),
//
//                         InkWell(
//                           child: Container(
//                             margin: EdgeInsets.only(left: 20, right: 20, top: 10),
//                             height: BaseUtitiles.getheightofPercentage(context, 4),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               color: requisitionSlipController.checkColor == 0
//                                   ? Theme.of(context).primaryColor
//                                   : Colors.white,
//                             ),
//                             alignment: Alignment.center,
//                             child:
//                             Padding(
//                               padding: const EdgeInsets.all(5),
//                               child: Text("PDF Download",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: RequestConstant.Lable_Font_SIZE,
//                                     color: requisitionSlipController.checkColor == 0
//                                         ? Colors.white
//                                         : Theme.of(context).primaryColor),
//                               ),
//                             ),
//                           ),
//                           onTap: () async {
//                             if(_formKey.currentState!.validate())
//                             {
//                               _formKey.currentState!.save();
//                               await download(loginController.user.value.userId!, loginController.user.value.userType!, companyController.selectedCompanyId.value, requisitionSlipController.selectedstaffId.value, requisitionSlipController.leaveType.value, requisitionSlipController.reportFromDate.text, requisitionSlipController.reportToDate.text
//                               );
//                             }
//                           },
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2),),
//
//                 ListDetails(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   download(int uid,String uType,int compId,int staffId,String reqLevTpye,String fdate,String todate){
//     // launch('${ApiConstant.Web_URL}MobileReports/Mobile_Staff_Leave_RPT.aspx?UID=$uid&UTYPE=$uType&COMPID=$compId&STAFFID=$staffId&LEVTYPE=$reqLevTpye&FDT=$fdate&TDT=$todate');
//     // if (kDebugMode) {
//     //   print('${ApiConstant.Web_URL}MobileReports/Mobile_Staff_Leave_RPT.aspx?UID=$uid&UTYPE=$uType&COMPID=$compId&STAFFID=$staffId&LEVTYPE=$reqLevTpye&FDT=$fdate&TDT=$todate');
//     // }
//   }
//
//   Widget ListDetails(){
//     return SizedBox(
//       height:BaseUtitiles.getheightofPercentage(context,50),
//       child: Column(
//         children: [
//           Expanded(
//             child: Container(
//               height:BaseUtitiles.getheightofPercentage(context,48),
//               width: BaseUtitiles.getWidthtofPercentage(context,100),
//               child: Obx(()=>ListView.builder(
//                   shrinkWrap: true,
//                   physics: BouncingScrollPhysics(),
//                   padding: EdgeInsets.zero,
//                   itemCount: reportsController.ReqLevList.value.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
//                       child: Card(
//                         color: Colors.white,
//                         child: Container(
//                           margin: EdgeInsets.only(left: 10, right: 3, top: 5, bottom: 5),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[
//                               Container(
//                                 margin: EdgeInsets.only( right: 10),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Row(
//                                       children: [
//                                         ConstIcons.list_date,
//                                         Text(
//                                             reportsController.ReqLevList.value[index].eDate.toString(),
//                                           style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     Text(
//                                       reportsController.ReqLevList.value[index].requestionNo.toString(),
//                                       style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
//
//                                   ],
//                                 ),
//                               ),
//                               // SizedBox(height: 5,),
//                               //
//                               // Row(
//                               //   children: [
//                               //     Expanded(
//                               //         flex: 2,
//                               //         child: Text("Shift",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                               //
//                               //     Expanded(
//                               //       flex: 2,
//                               //       child: Text(
//                               //         (attendanceController
//                               //             .attendanceDatas.value[index].shiftName.toString()),style: TextStyle(color: Colors.black),
//                               //       ),
//                               //     ),
//                               //   ],
//                               // ),
//
//
//                               SizedBox(height: 5,),
//
//                               // Row(
//                               //   children: <Widget>[
//                               //     Expanded(
//                               //         flex: 2,
//                               //         child: Text("App Status",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                               //     Expanded(
//                               //       flex: 3,
//                               //       child: Text((attendanceController.attendanceDatas.value[index].appStatus.toString().toUpperCase()),
//                               //         style: attendanceController.attendanceDatas.value[index].appStatus =="Pending in Approval" ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold) : TextStyle(color: Colors.green, fontWeight: FontWeight.bold) ,
//                               //       ),
//                               //     ),
//                               //   ],
//                               // ),
//
//                               Row(
//                                 children:<Widget> [
//                                   Expanded(
//                                       flex: 2,
//                                       child: Text("Staff",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                   Expanded(
//                                     flex: 3,
//                                     child:Text(
//                                       reportsController.ReqLevList.value[index].employee.toString(),
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//
//                               SizedBox(height: 3,),
//
//                               Row(
//                                 children:<Widget> [
//                                   Expanded(
//                                       flex: 2,
//                                       child: Text("ReqLeaveType",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                   Expanded(
//                                     flex: 3,
//                                     child:Text(
//                                         reportsController.ReqLevList.value[index].reqType.toString(),
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//                               SizedBox(height: 3,),
//                               Obx(() => reportsController.ReqLevList.value[index].reqType == "LEAVE"
//                                   ? Column(
//                                   children: [
//                                     Row(
//                                       children:<Widget> [
//                                         Expanded(
//                                             flex: 2,
//                                             child: Text("Leave FrDate",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                         Expanded(
//                                           flex: 3,
//                                           child:Text(
//                                             reportsController.ReqLevList.value[index].leaveFrmDate.toString(),
//                                             style: TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//
//                                     SizedBox(height: 3,),
//
//                                     Row(
//                                       children:<Widget> [
//                                         Expanded(
//                                             flex: 2,
//                                             child: Text("Leave ToDate",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                         Expanded(
//                                           flex: 3,
//                                           child:Text(
//                                             reportsController.ReqLevList.value[index].leaveToDate.toString(),
//                                             style: TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//
//                                     SizedBox(height: 3,),
//
//                                     Row(
//                                       children:<Widget> [
//                                         Expanded(
//                                             flex: 2,
//                                             child: Text("Total Leave",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                         Expanded(
//                                           flex: 3,
//                                           child:Text(
//                                             reportsController.ReqLevList.value[index].perTotDays.toString(),
//                                             style: TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//
//                                     SizedBox(height: 3,),
//
//                                     Row(
//                                       children:<Widget> [
//                                         Expanded(
//                                             flex: 2,
//                                             child: Text("Reason",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                         Expanded(
//                                           flex: 3,
//                                           child:Text(
//                                             reportsController.ReqLevList.value[index].leaveReason.toString(),
//                                             style: TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//
//                                   ],
//                                                                   )
//                                   : reportsController.ReqLevList.value[index].reqType == "ON DUTY"
//                                   ? Column(
//                                 children: [
//                                   Row(
//                                     children:<Widget> [
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Date",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                       Expanded(
//                                         flex: 3,
//                                         child:Text(
//                                           reportsController.ReqLevList.value[index].perFrmDate.toString(),
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                   SizedBox(height: 3,),
//
//                                   Row(
//                                     children:<Widget> [
//                                       Expanded(
//                                           flex: 4,
//                                           child: Text("From Time",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                       Expanded(
//                                         flex: 2,
//                                         child:Text(
//                                           reportsController.ReqLevList.value[index].perFrmTime.toString(),
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("To Time",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                       Expanded(
//                                         flex: 2,
//                                         child:Text(
//                                           reportsController.ReqLevList.value[index].perToTime.toString(),
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//
//                                     ],
//                                   ),
//
//                                   SizedBox(height: 3,),
//
//                                   Row(
//                                     children:<Widget> [
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Total Hours",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                       Expanded(
//                                         flex: 3,
//                                         child:Text(
//                                           reportsController.ReqLevList.value[index].perTotHours.toString(),
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                   SizedBox(height: 3,),
//
//                                   Row(
//                                     children:<Widget> [
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Reason",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                       Expanded(
//                                         flex: 3,
//                                         child:Text(
//                                           reportsController.ReqLevList.value[index].leaveReason.toString(),
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                 ],
//                               )
//                                   : reportsController.ReqLevList.value[index].reqType == "PERMISSION"
//                                   ? Column(
//                                 children: [
//                                   Row(
//                                     children:<Widget> [
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Date",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                       Expanded(
//                                         flex: 3,
//                                         child:Text(
//                                           reportsController.ReqLevList.value[index].perFrmDate.toString(),
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                   SizedBox(height: 3,),
//
//                                   Row(
//                                     children:<Widget> [
//                                       Expanded(
//                                           flex: 4,
//                                           child: Text("From Time",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                       Expanded(
//                                         flex: 2,
//                                         child:Text(
//                                           reportsController.ReqLevList.value[index].perFrmTime.toString(),
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("To Time",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                       Expanded(
//                                         flex: 2,
//                                         child:Text(
//                                           reportsController.ReqLevList.value[index].perToTime.toString(),
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                   SizedBox(height: 3,),
//
//                                   Row(
//                                     children:<Widget> [
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Total Hours",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                       Expanded(
//                                         flex: 3,
//                                         child:Text(
//                                           reportsController.ReqLevList.value[index].perTotHours.toString(),
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                   SizedBox(height: 3,),
//
//                                   Row(
//                                     children:<Widget> [
//                                       Expanded(
//                                           flex: 2,
//                                           child: Text("Reason",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                       Expanded(
//                                         flex: 3,
//                                         child:Text(
//                                           reportsController.ReqLevList.value[index].leaveReason.toString(),
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                 ],
//                               )
//                                   : Container()
//                               ),
//
//
//                               SizedBox(height: 3,),
//
//                               Row(
//                                 children:<Widget> [
//                                   Expanded(
//                                       flex: 2,
//                                       child: Text("Status",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//                                   Expanded(
//                                     flex: 3,
//                                     child:Text(
//                                       reportsController.ReqLevList.value[index].status.toString(),
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                           color:
//                                       reportsController.ReqLevList.value[index].status.toString() == "Rejected"
//                                           ?  Colors.red
//                                           : reportsController.ReqLevList.value[index].status.toString() == "Approved"
//                                           ?  Colors.green
//                                           : reportsController.ReqLevList.value[index].status.toString() == "Not Approved"
//                                           ? Colors.orange
//                                           : Colors.black),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//                               SizedBox(height: 3,),
//
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }
