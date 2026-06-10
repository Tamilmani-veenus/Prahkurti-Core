// import 'package:animate_do/animate_do.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import '../../../../constants/storage_constant.dart';
// import '../../../../controller/auto_yrwise_no_controller.dart';
// import '../../../../controller/comman_controller.dart';
// import '../../../../controller/logincontroller.dart';
// import '../../../../controller/menu_controller.dart';
// import '../../../../controller/pendinglistcontroller.dart';
// import '../../../../controller/projectcontroller.dart';
// import '../../../../controller/stocksite_controller.dart';
// import '../../../../controller/subcontcontroller.dart';
// import '../../../../home/dashboard/subcontractor_outstanding.dart';
// import '../../../../home/dashboard/supplier_outstanding.dart';
// import '../../../../home/pending_list/pending_list.dart';
// import '../../../../home/stock_site/stock_site.dart';
// import '../../../../models/authendication_model.dart';
// import '../../../../provider/daily_wrkdone_dprNew_provider.dart';
// import '../../../../utilities/baseutitiles.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/companycontroller.dart';
// import '../controller/requisitionslip_controller.dart';
// import '../login/animation_signinpage/welcomepage.dart';
// import 'account_settings/account_setting.dart';
// import 'attendance_report/attendance_report.dart';
// import 'company_nmr_atd_report/company_nmrattd_report.dart';
// import 'dashboard/expenses.dart';
// import 'dpr_report/dpr_report.dart';
// import 'inward_report/inward_report.dart';
// import 'menu/menulist.dart';
// import 'mrn_report/mrn_report.dart';
// import 'weeklybill_report/weeklybillreport.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final Duration initialDelay = Duration(seconds: 1);
//   late User users;
//   LoginController loginController = Get.put(LoginController());
//   ProjectController projectController = Get.put(ProjectController());
//   SubcontractorController subcontractorController = Get.put(SubcontractorController());
//   final CompanyController Companycontroller = Get.put(CompanyController());
//   final StockSiteController stockSiteController=Get.put(StockSiteController());
//   final AutoYearWiseNoController autoYearWiseNoController=Get.put(AutoYearWiseNoController());
//   final MenuController menuController=Get.put(MenuController());
//   final PendingListController pendingListController=Get.put(PendingListController());
//   RequisitionSlipController requisitionSlipController=Get.put(RequisitionSlipController());
//   CommanController commanController=Get.put(CommanController());
//
//
//
//   String? supplier = "assets/supplier.png";
//
//
//
//   @override
//   void initState() {
//     autoyrwise();
//     super.initState();
//   }
//
//   autoyrwise() async{
//     users = loginController.user.value;
//     await menuController.getMenuList();
//     await DPR_New_Provider.getMaterial();
//     await pendingListController.getPendingList();
//     await autoYearWiseNoController.AutoYearWise();
//     await autoYearWiseNoController.NMR_AutoYearWise();
//     await autoYearWiseNoController.DPR_NEW_AutoYearWise();
//     await autoYearWiseNoController.DPR_AutoYearWise();
//     await autoYearWiseNoController.DPR_Labour_AutoYearWise();
//     await autoYearWiseNoController.directBill_AutoYearWise();
//     await autoYearWiseNoController.InwardPending_AutoYearWise();
//     await autoYearWiseNoController.TransferBetProject_AutoYearWise();
//     await autoYearWiseNoController.TransferBetSite_AutoYearWise();
//     await autoYearWiseNoController.ADVREQVoucher_AutoYearWise();
//     await autoYearWiseNoController.SiteVoucherAutoYear();
//     await autoYearWiseNoController.StaffVocAutoYear();
//     await autoYearWiseNoController.MRNRequest_AutoYearWise();
//     await autoYearWiseNoController.CompanyNMR_AutoYearWise();
//     await autoYearWiseNoController.Consumprion_AutoYearWise();
//     await autoYearWiseNoController.Boq_Revised_AutoYearWise();
//     await autoYearWiseNoController.RequisitionSlipAutoYr();
//     await autoYearWiseNoController.PreApproval_AutoYearWise();
//   }
//
//
//   Future<bool> showExitPopup() async {
//     return await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Exit App!'),
//         content: Text('Do you want to exit an App?'),
//         actions:[
//           ElevatedButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child:Text('No'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child:Text('Yes'),
//           ),
//         ],
//       ),
//     )??false;
//   }
//
//
//
//
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
//       child: WillPopScope(
//         onWillPop: showExitPopup,
//         child: Scaffold(
//             appBar: AppBar(
//               backgroundColor: Theme.of(context).primaryColor,
//               title: Text('ANISH'),
//             ),
//             drawer: NavDrawer(),
//             body: Container(
//               color: Colors.white,
//               child: Stack(
//                 children: <Widget>[
//                   SingleChildScrollView(
//                     child: Column(
//                       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         CustomPaint(
//                           child: Container(
//                             width: BaseUtitiles.getWidthtofPercentage(context, 110),
//                             height: BaseUtitiles.getheightofPercentage(context, 12),
//                           ),
//                           painter: HeaderCurvedContainer(),
//                         ),
//
//
//                         FadeInDown(
//                           duration: Duration(seconds: 2),
//                           child: Container(
//                             margin: EdgeInsets.only(top: 1),
//                             child: Align(
//                               alignment: Alignment.bottomCenter,
//                               child: Text(
//                                 'Welcome! '+loginController.UserName(),
//                                 style: TextStyle(fontSize: 20, color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                         loginController.UserType()=="A"?
//                         Container(
//                           margin: EdgeInsets.only(top: 100),
//                           width: BaseUtitiles.getWidthtofPercentage(context, 80),
//                           height: BaseUtitiles.getheightofPercentage(context, 40),
//                           padding: new EdgeInsets.all(10.0),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                             color: Colors.white,
//                             elevation: 20,
//                             shadowColor: Theme.of(context).primaryColor,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: <Widget>[
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children:<Widget> [
//                                     FadeInUp(
//                                       duration: Duration(seconds: 2),
//                                       child: InkWell(
//                                         child: Card(
//                                           elevation: 20.0,
//                                           child: Container(
//                                             child: Icon(Icons.account_balance,size: 60,color: Theme.of(context).primaryColor),
//
//                                           ),
//                                         ),
//                                         onTap: (){
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(builder: (context) => Expenses()),
//                                           );
//                                           BaseUtitiles.showToast("Project Expenses");
//                                         },
//                                       ),
//                                     ),
//                                     FadeInUp(
//                                       duration: Duration(seconds: 2),
//                                       child: InkWell(
//                                         child: Card(
//                                           elevation: 20.0,
//                                           child: Container(
//                                             child: Icon(Icons.admin_panel_settings,size: 60,color: Theme.of(context).primaryColor),
//                                           ),
//                                         ),
//                                         onTap: (){
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) => Supplieroutstanding()),
//                                           );
//                                           BaseUtitiles.showToast("Supplier O/S");
//                                         },
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children:<Widget> [
//                                     FadeInLeft(
//                                       duration: Duration(seconds: 2),
//                                       child: Container(
//                                         child: Text("Project Expenses",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
//
//                                       ),
//                                     ),
//                                     FadeInLeft(
//                                       duration: Duration(seconds: 2),
//                                       child: Container(
//                                         child: Text("Supplier O/S",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children:<Widget> [
//                                     FadeInUp(
//                                       duration: Duration(seconds: 2),
//                                       child: InkWell(
//                                         child: Card(
//                                           elevation: 20.0,
//                                           child: Container(
//                                             child: Icon(Icons.assignment_ind_outlined,size: 60,color: Theme.of(context).primaryColor),
//                                           ),
//                                         ),
//                                         onTap: (){
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) => Subcontractoroutstanding()),
//                                           );
//                                           BaseUtitiles.showToast("Subcontractor O/S");
//                                         },
//                                       ),
//                                     ),
//                                     FadeInUp(
//                                       duration: Duration(seconds: 2),
//                                       child: InkWell(
//                                         child: Card(
//                                           elevation: 20.0,
//                                           child: Container(
//                                             child: Icon(Icons.account_balance_wallet_sharp,size: 60,color: Theme.of(context).primaryColor),
//                                           ),
//                                         ),
//                                         onTap: (){
//
//                                         },
//                                       ),
//                                     )
//
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children:<Widget> [
//                                     FadeInLeft(
//                                       duration: Duration(seconds: 2),
//                                       child: Container(
//                                         margin: EdgeInsets.only(right: 20),
//                                         child: Text("Subcontractor O/S",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
//
//                                       ),
//                                     ),
//                                     FadeInLeft(
//                                       duration: Duration(seconds: 2),
//                                       child: Container(
//                                         margin: EdgeInsets.only(right: 20),
//                                         child: Text("Client O/S",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       :Container(
//                           margin: EdgeInsets.only(top: 100),
//                             child: Image.asset('assets/upload.gif'),
//                         )
//                       ],
//                     ),
//                   ),
//
//                   SlidingUpPanel(
//                     backdropEnabled:true,
//                     panelSnapping:true,
//                     panel: Center(
//                         child: PendingList()),
//                     collapsed: Container(
//                       color:Theme.of(context).primaryColor,
//                       child: Center(
//                         child: Column(
//                           children: [
//                             Icon(Icons.keyboard_capslock_sharp,color: Colors.white,),
//                             Container(
//                               margin: EdgeInsets.only(top: 22),
//                               child: Text(
//                                 "APPROVAL PENDING",
//                                 style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     onPanelOpened: (){
//                       setState(() {
//                         pendingListController.getPendingList();
//                       });
//                     },
//
//                   )
//                 ],
//               ),
//             )
//
//         ),
//       ),
//     );
//   }
//
//   Widget NavDrawer() {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountName: Text(users.userName!,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold)),
//             accountEmail: Text("NeoHeights",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Text(
//                 users.userType!,
//                 style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           FadeInLeft(
//             duration: Duration(seconds: 1),
//             child: ListTile(
//               leading: Icon(
//                 Icons.home_filled,
//                 color: Theme.of(context).primaryColor,
//               ),
//               title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           FadeInLeft(
//             duration: Duration(seconds: 1),
//             child: ListTile(
//               leading:
//               Icon(Icons.menu_open, color: Theme.of(context).primaryColor),
//               title: Text('Menu',style: TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () async{
//                 await menuController.getMenuList();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) =>  MenuScreen()),
//                 );
//               },
//             ),
//           ),
//           // FadeInLeft(
//           //   duration: Duration(seconds: 1),
//           //   child: ListTile(
//           //     leading: Icon(Icons.pending, color: Theme.of(context).primaryColor),
//           //     title: Text('Pending List',style: TextStyle(fontWeight: FontWeight.bold)),
//           //     onTap: () {
//           //       Navigator.push(
//           //         context,
//           //         MaterialPageRoute(builder: (context) => PendingList()),
//           //       );
//           //     },
//           //   ),
//           // ),
//           FadeInLeft(
//             duration: Duration(seconds: 1),
//             child: ListTile(
//               leading: Icon(Icons.sticky_note_2_outlined,
//                   color: Theme.of(context).primaryColor),
//               title: Text('Stock at site',style: TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) =>  StockSite()),
//                 );
//               },
//             ),
//           ),
//           // FadeInLeft(
//           //   duration: Duration(seconds: 1),
//           //   child: ListTile(
//           //     leading: Icon(Icons.article_rounded,
//           //         color: Theme.of(context).primaryColor),
//           //     title: Text('Requisation Slip',style: TextStyle(fontWeight: FontWeight.bold)),
//           //     onTap: () {
//           //       Navigator.push(
//           //         context,
//           //         MaterialPageRoute(builder: (context) =>  requistion_Activity(0)),
//           //       );
//           //     },
//           //   ),
//           // ),
//
//           Divider(color: Colors.grey),
//           Text("  Reports",style: TextStyle(fontWeight: FontWeight.bold)),
//           FadeInRight(
//             duration: Duration(seconds: 1),
//             child: ListTile(
//               leading:
//               Icon(Icons.read_more, color: Theme.of(context).primaryColor),
//               title: Text('Attendance Report',style: TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AttendanceReport()),
//                 );
//               },
//             ),
//           ),
//           FadeInRight(
//             duration: Duration(seconds: 1),
//             child: ListTile(
//               leading:
//               Icon(Icons.read_more, color: Theme.of(context).primaryColor),
//               title: Text('Company NMR Report',style: TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CompanyNmrAtdReport()),
//                 );
//               },
//             ),
//           ),
//           FadeInRight(
//             duration: Duration(seconds: 1),
//             child: ListTile(
//               leading: Icon(Icons.reorder_outlined,
//                   color: Theme.of(context).primaryColor),
//               title: Text('MRN Report',style: TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MRNReport()),
//                 );
//               },
//             ),
//           ),
//           FadeInRight(
//             duration: Duration(seconds: 1),
//             child: ListTile(
//               leading: Icon(Icons.analytics_outlined,
//                   color: Theme.of(context).primaryColor),
//               title: Text('Inward Report',style: TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => InwardReport()),
//                 );
//               },
//             ),
//           ),
//           FadeInRight(
//             duration: Duration(seconds: 1),
//             child: ListTile(
//               leading: Icon(Icons.sticky_note_2,
//                   color: Theme.of(context).primaryColor),
//               title: Text('DPR Report',style: TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) =>  DPRReport()),
//                 );
//               },
//             ),
//           ),
//
//           // FadeInRight(
//           //   duration: Duration(seconds: 1),
//           //   child: ListTile(
//           //     leading: Icon(Icons.add_task_rounded,
//           //         color: Theme.of(context).primaryColor),
//           //     title: Text('Weekly Bill Report',style: TextStyle(fontWeight: FontWeight.bold)),
//           //     onTap: () {
//           //       Navigator.push(
//           //         context,
//           //         MaterialPageRoute(builder: (context) =>  WklyBillReport()),
//           //       );
//           //     },
//           //   ),
//           // ),
//
//
//           Divider(color: Colors.grey),
//           Text("  Settings",style: TextStyle(fontWeight: FontWeight.bold)),
//           FadeInLeft(
//             duration: Duration(seconds: 1),
//             child: ListTile(
//               leading:
//               Icon(Icons.settings, color: Theme.of(context).primaryColor),
//               title: Text('Account Settings',style: TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) =>  AccountSettings()),
//                 );
//               },
//             ),
//           ),
//           FadeInLeft(
//             duration: Duration(seconds: 1),
//             child: ListTile(
//               leading:
//               Icon(Icons.exit_to_app, color: Theme.of(context).primaryColor),
//               title: Text('Logout',style: TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () {
//                 logoutPopup(context);
//               },
//             ),
//           ),
//           // FadeInLeft(
//           //   duration: Duration(seconds: 1),
//           //   child: ListTile(
//           //     leading:
//           //     Icon(Icons.exit_to_app, color: Theme.of(context).primaryColor),
//           //     title: Text('Pdf Report',style: TextStyle(fontWeight: FontWeight.bold)),
//           //     onTap: () {
//           //      launch('http:49.204.232.115:8080/AnishNew/ZDailyEntries/SubCont_ItmQty_Measr_print.aspx?Type=B&work_id=21');
//           //     },
//           //   ),
//           // ),
//
//           ListTile(
//             title: Text('App version '+loginController.version,style: TextStyle(fontWeight: FontWeight.bold)),
//             onTap: () {
//
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future logoutPopup(BuildContext context) async {
//     return await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Alert!'),
//         content: Text('Do you want to logout?'),
//         actions:[
//           ElevatedButton(
//             onPressed: () {
//               return Navigator.of(context).pop();
//             },
//             child:Text('No'),
//           ),
//           ElevatedButton(
//             onPressed: (){
//               SessionStorage.removeUser();
//               BaseUtitiles.showToast('Logout Successfully');
//               Navigator.of(context).pop();
//               Navigator.pushReplacement(
//                 context,
//                 // MaterialPageRoute(builder: (context) => LoginScreen()),
//                 MaterialPageRoute(builder: (context) => Welcome_Page()),
//               );
//
//             },
//             child:Text('Yes'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class HeaderCurvedContainer extends CustomPainter {
//
//   @override
//   void paint(Canvas canvas, dynamic size) {
//     Paint paint = Paint()..color = Colors.indigo.shade700;
//     Path path = Path()
//       ..relativeLineTo(0, 150)
//       ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
//       ..relativeLineTo(0, -150)
//       ..close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
