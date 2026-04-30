// import '../../../../controller/attendancecontroller.dart';
// import '../../../../controller/cashbook_site_controller.dart';
// import '../../../../controller/expensencecontroller.dart';
// import '../../../../controller/projectcontroller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../utilities/baseutitiles.dart';
// import '../../../../utilities/requestconstant.dart';
//
//
// class Case_Book_Site extends StatefulWidget {
//   const Case_Book_Site({Key? key}) : super(key: key);
//
//   @override
//   State<Case_Book_Site> createState() => _Case_Book_SiteState();
// }
//
// class _Case_Book_SiteState extends State<Case_Book_Site> {
//   final ProjectController projectController=Get.put(ProjectController());
//
//   final AttendanceController attendanceController=Get.put(AttendanceController());
//
//   final ExpensesController expensesController=Get.put(ExpensesController());
//
//   CashBookSiteController cashBookSiteController=Get.put(CashBookSiteController());
//
//   // HDTRefreshController _hdtRefreshController = HDTRefreshController();
//   @override
//   void initState() {
//
//     DateTime currentDate = DateTime.now();
//     DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
//     cashBookSiteController.cashbooksite_frdateController.text = lastDayOfMonth.toString().substring(0, 10);
//     cashBookSiteController.cashbooksite_todateController.text = currentDate.toString().substring(0, 10);
//     projectController.projectname.text="--Select--";
//     projectController.selectedProjectId.value=0;
//     cashBookSiteController.cashsiteDatas.clear();
//     cashBookSiteController.totalDebit.text = "0.0";
//     cashBookSiteController.totalCredit.text ="0.0";
//     cashBookSiteController.closingDebit.text = "0.0";
//     cashBookSiteController.closingCredit.text ="0.0";
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         FocusScopeNode currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus &&
//             currentFocus.focusedChild != null) {
//           FocusManager.instance.primaryFocus?.unfocus();
//         }
//       },
//       child: Scaffold(
//         bottomNavigationBar: bouttomNavigation(),
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           title: Text("Cash Book/Site"),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(top: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 20),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           style: TextStyle(fontSize: 13),
//                           readOnly: true,
//                           controller: cashBookSiteController.cashbooksite_frdateController,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             border: OutlineInputBorder(),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color:Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color:Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                             prefixIcon: Icon(Icons.date_range_sharp,
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                           onTap: () async {
//                             cashBookSiteController.cashsiteDatas.clear();
//                             var Frdate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(1900),
//                                 lastDate: DateTime(2100),
//                                 builder: (context, child) {
//                                   return Theme(data: Theme.of(context).copyWith(
//                                     colorScheme: ColorScheme.light(
//                                       primary: Theme.of(context).primaryColor, // header background color
//                                       onPrimary: Colors.white, // header text color
//                                       onSurface: Colors.black, // body text color
//                                     ),
//                                     textButtonTheme: TextButtonThemeData(
//                                       style: TextButton.styleFrom(
//                                         primary: Colors.black, // button text color
//                                       ),
//                                     ),
//                                   ),
//                                     child: child!,
//                                   );
//                                 });
//                             cashBookSiteController.cashbooksite_frdateController.text = Frdate.toString().substring(0, 10);
//                             await cashBookSiteController.getcashbooksitedetails();
//                             cashBookSiteController.calculations();
//                           },
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 20),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           style: TextStyle(fontSize: 13),
//                           readOnly: true,
//                           controller: cashBookSiteController.cashbooksite_todateController,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color:Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color:Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.date_range_sharp,
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                           onTap: () async {
//                             cashBookSiteController.cashsiteDatas.clear();
//                             var Todate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(1900),
//                                 lastDate: DateTime(2100),
//                                 builder: (context, child) {
//                                   return Theme(data: Theme.of(context).copyWith(
//                                     colorScheme: ColorScheme.light(
//                                       primary: Theme.of(context).primaryColor, // header background color
//                                       onPrimary: Colors.white, // header text color
//                                       onSurface: Colors.black, // body text color
//                                     ),
//                                     textButtonTheme: TextButtonThemeData(
//                                       style: TextButton.styleFrom(
//                                         primary: Colors.black, // button text color
//                                       ),
//                                     ),
//                                   ),
//                                     child: child!,
//                                   );
//                                 });
//                             cashBookSiteController.cashbooksite_todateController.text = Todate.toString().substring(0, 10);
//                             await cashBookSiteController.getcashbooksitedetails();
//                             cashBookSiteController.calculations();
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 margin:
//                 EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 92),
//                 child: TextField(
//                   style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   readOnly: true,
//                   controller: projectController.projectname,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: "ProjectName",
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color:Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color:Theme.of(context).primaryColor, width: 1.0),
//                     ),
//
//                   ),
//
//                   onTap: () {
//                     setState(() {
//                       projectController.getProjectList(context,0);
//                     });
//
//                   },
//                 ),
//
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 margin: EdgeInsets.only(top:5,bottom: 5),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Theme
//                         .of(context)
//                         .primaryColor,
//                     side: BorderSide(width: 3, color: Colors.black),
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                   ),
//                   onPressed: () async {
//                     setState(()  {
//                         cashBookSiteController.getcashbooksitedetails();
//                     });
//
//                   },
//                   child: Text("Show"),
//                 ),
//               ),
//               Obx(()=>Visibility(
//                 visible: cashBookSiteController.cashsiteDatas.value.length>0?true:false,
//                 child:Container()
//                 // Container(
//                 //   height: BaseUtitiles.getheightofPercentage(context, 55),
//                 //   width:2000,
//                 //   child: HorizontalDataTable(
//                 //     leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 25),
//                 //     rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 155),
//                 //     isFixedHeader: true,
//                 //     headerWidgets: _getTitleWidget(),
//                 //     leftSideItemBuilder: _generateFirstColumnRow,
//                 //     rightSideItemBuilder: _generateRightHandSideColumnRow,
//                 //     itemCount: cashBookSiteController.cashsiteDatas.value.length,
//                 //     rowSeparatorWidget: const Divider(
//                 //       color: Colors.black54,
//                 //       height: 1.0,
//                 //       thickness: 0.0,
//                 //     ),
//                 //     leftHandSideColBackgroundColor: Colors.white24,
//                 //     rightHandSideColBackgroundColor: Colors.white24,
//                 //     verticalScrollbarStyle: const ScrollbarStyle(
//                 //       thumbColor: Colors.yellow,
//                 //       isAlwaysShown: true,
//                 //       thickness: 4.0,
//                 //       radius: Radius.circular(5.0),
//                 //     ),
//                 //     horizontalScrollbarStyle: const ScrollbarStyle(
//                 //       thumbColor: Colors.white24,
//                 //       isAlwaysShown: true,
//                 //       thickness: 4.0,
//                 //       radius: Radius.circular(5.0),
//                 //     ),
//                 //     enablePullToRefresh: false,
//                 //     refreshIndicator: const WaterDropHeader(),
//                 //     refreshIndicatorHeight: 60,
//                 //     onRefresh: () async {
//                 //       //Do sth
//                 //       await Future.delayed(const Duration(milliseconds: 500));
//                 //       _hdtRefreshController.refreshCompleted();
//                 //     },
//                 //     enablePullToLoadNewData: false,
//                 //     loadIndicator: const ClassicFooter(),
//                 //     onLoad: () async {
//                 //       //Do sth
//                 //       await Future.delayed(const Duration(milliseconds: 500));
//                 //       _hdtRefreshController.loadComplete();
//                 //     },
//                 //     htdRefreshController: _hdtRefreshController,
//                 //   ),
//                 // ),
//               )
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _getTitleWidget() {
//     return [
//       _getTitleItemWidget('Date', BaseUtitiles.getWidthtofPercentage(context, 25)),
//       _getTitleItemWidget('Particulars', BaseUtitiles.getWidthtofPercentage(context, 37)),
//       _getTitleItemWidget('Voc Type', BaseUtitiles.getWidthtofPercentage(context, 37)),
//       _getTitleItemWidget('Debit', BaseUtitiles.getWidthtofPercentage(context, 22)),
//       _getTitleItemWidget('Credit',BaseUtitiles.getWidthtofPercentage(context, 22)),
//       _getTitleItemWidget('Remarks', BaseUtitiles.getWidthtofPercentage(context, 37)),
//     ];
//   }
//
//   Widget _getTitleItemWidget(String label, double width) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//       width: width,
//       height: BaseUtitiles.getheightofPercentage(context, 6),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateFirstColumnRow(BuildContext context, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,  // red as border color
//         ),
//       ),
//       child: Text(cashBookSiteController.cashsiteDatas.value[index].vocdate.toString()),
//       height: BaseUtitiles.getheightofPercentage(context,9),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//     );
//   }
//
//   Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
//     return Row(
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(cashBookSiteController.cashsiteDatas.value[index].descriptions.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,37),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(cashBookSiteController.cashsiteDatas.value[index].vocType.toString()),
//           width: BaseUtitiles.getWidthtofPercentage(context,37),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(cashBookSiteController.cashsiteDatas.value[index].debit.toString()),
//           width:  BaseUtitiles.getWidthtofPercentage(context,22),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(cashBookSiteController.cashsiteDatas.value[index].credit.toString()),
//           width:  BaseUtitiles.getWidthtofPercentage(context,22),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,  // red as border color
//             ),
//           ),
//           child: Text(cashBookSiteController.cashsiteDatas.value[index].remarks.toString()),
//           width:  BaseUtitiles.getWidthtofPercentage(context,37),
//           height: BaseUtitiles.getheightofPercentage(context,9),
//           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//         ),
//
//       ],
//     );
//   }
//
//   Widget bouttomNavigation(){
//     return Container(
//       height: BaseUtitiles.getheightofPercentage(context, 10),
//       color:Theme.of(context).primaryColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(left: 10,right: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text("Total   ",style: TextStyle(color: Colors.yellow),),
//                 Container(
//                   height: BaseUtitiles.getheightofPercentage(context,4),
//                   width: BaseUtitiles.getWidthtofPercentage(context,25),
//                   child: TextField(
//                     readOnly: true,
//                     cursorColor:Theme.of(context).primaryColor,
//                     textAlign: TextAlign.center,
//                     controller: cashBookSiteController.totalDebit,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(10))),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(10))),
//                     ),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 Container(
//                   height: BaseUtitiles.getheightofPercentage(context,4),
//                   width: BaseUtitiles.getWidthtofPercentage(context,25),
//                   child: TextField(
//                     readOnly: true,
//                     cursorColor:Theme.of(context).primaryColor,
//                     textAlign: TextAlign.center,
//                     controller: cashBookSiteController.totalCredit,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(10))),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(10))),
//                     ),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10,right: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text("Closing",style: TextStyle(color: Colors.yellow),),
//                 Container(
//                   height: BaseUtitiles.getheightofPercentage(context,4),
//                   width: BaseUtitiles.getWidthtofPercentage(context,25),
//                   child: TextField(
//                     readOnly: true,
//                     cursorColor:Theme.of(context).primaryColor,
//                     textAlign: TextAlign.center,
//                     controller: cashBookSiteController.closingDebit,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(10))),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(10))),
//                     ),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 Container(
//                   height: BaseUtitiles.getheightofPercentage(context,4),
//                   width: BaseUtitiles.getWidthtofPercentage(context,25),
//                   child: TextField(
//                     readOnly: true,
//                     cursorColor:Theme.of(context).primaryColor,
//                     textAlign: TextAlign.center,
//                     controller: cashBookSiteController.closingCredit,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(10))),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(10))),
//                     ),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//
//         ],
//       ),
//     );
//   }
//
// }
