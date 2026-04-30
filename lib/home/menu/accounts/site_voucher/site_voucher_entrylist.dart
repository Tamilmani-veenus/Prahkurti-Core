// import '../../../../controller/comman_controller.dart';
// import '../../../../controller/sitevoucher_controller.dart';
// import '../../../../utilities/requestconstant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../../../../utilities/baseutitiles.dart';
//
// class Site_Voucher_EntryListScreen extends StatefulWidget {
//   const Site_Voucher_EntryListScreen({Key? key}) : super(key: key);
//
//   @override
//   State<Site_Voucher_EntryListScreen> createState() =>
//       _Site_Voucher_EntryListScreenState();
// }
//
// class _Site_Voucher_EntryListScreenState
//     extends State<Site_Voucher_EntryListScreen> {
//   TextEditingController editingController = TextEditingController();
//   SiteVoucher_Controller siteVoucher_Controller=Get.put(SiteVoucher_Controller());
//   CommanController commanController = Get.put(CommanController());
//
//
//   @override
//   void initState() {
//     if(siteVoucher_Controller.Active==1){
//       siteVoucher_Controller.Active=0;
//     }
//     else{
//       siteVoucher_Controller.Active=2;
//     }
//     setState(() {
//       siteVoucher_Controller.mainentryList.clear();
//       siteVoucher_Controller.SiteVocEtyList.clear();
//     });
//
//     DateTime currentDate = DateTime.now();
//     DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
//     siteVoucher_Controller.SiteVocEntrylistFrDate.text = lastDayOfMonth.toString().substring(0, 10);
//     siteVoucher_Controller.SiteVocEntrylistToDate.text = currentDate.toString().substring(0, 10);
//     siteVoucher_Controller.getSiteVoc_EntryList();
//     siteVoucher_Controller.SiteVocEtyList.value = siteVoucher_Controller.mainentryList.value;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScopeNode currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus &&
//             currentFocus.focusedChild != null) {
//           FocusManager.instance.primaryFocus?.unfocus();
//         }
//       },
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(top: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       height: BaseUtitiles.getheightofPercentage(context, 4),
//                       margin: EdgeInsets.only(left: 10, right: 20),
//                       decoration: BoxDecoration(),
//                       child: TextField(
//                         style: TextStyle(fontSize: 13),
//                         readOnly: true,
//                         controller: siteVoucher_Controller.SiteVocEntrylistFrDate,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.date_range_sharp,
//                               color: Theme.of(context).primaryColor),
//                         ),
//                         onTap: () async {
//                           siteVoucher_Controller.SiteVocEtyList.clear();
//                           var Frdate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime(2100),
//                               builder: (context, child) {
//                                 return Theme(data: Theme.of(context).copyWith(
//                                   colorScheme: ColorScheme.light(
//                                     primary: Theme.of(context).primaryColor, // header background color
//                                     onPrimary: Colors.white, // header text color
//                                     onSurface: Colors.black, // body text color
//                                   ),
//                                   textButtonTheme: TextButtonThemeData(
//                                     style: TextButton.styleFrom(
//                                       primary: Colors.black, // button text color
//                                     ),
//                                   ),
//                                 ),
//                                   child: child!,
//                                 );
//                               });
//                           siteVoucher_Controller.SiteVocEntrylistFrDate.text = Frdate.toString().substring(0, 10);
//                           siteVoucher_Controller.getSiteVoc_EntryList();
//                         },
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       height: BaseUtitiles.getheightofPercentage(context, 4),
//                       margin: EdgeInsets.only(left: 10, right: 20),
//                       decoration: BoxDecoration(),
//                       child: TextField(
//                         style: TextStyle(fontSize: 13),
//                         readOnly: true,
//                           controller: siteVoucher_Controller.SiteVocEntrylistToDate,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.date_range_sharp,
//                               color: Theme.of(context).primaryColor),
//                         ),
//                         onTap: () async {
//                           siteVoucher_Controller.SiteVocEtyList.clear();
//                           var Todate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime(2100),
//                               builder: (context, child) {
//                                 return Theme(data: Theme.of(context).copyWith(
//                                   colorScheme: ColorScheme.light(
//                                     primary: Theme.of(context).primaryColor, // header background color
//                                     onPrimary: Colors.white, // header text color
//                                     onSurface: Colors.black, // body text color
//                                   ),
//                                   textButtonTheme: TextButtonThemeData(
//                                     style: TextButton.styleFrom(
//                                       primary: Colors.black, // button text color
//                                     ),
//                                   ),
//                                 ), child: child!,
//                                 );
//                               });
//                           siteVoucher_Controller.SiteVocEntrylistToDate.text = Todate.toString().substring(0, 10);
//                           siteVoucher_Controller.getSiteVoc_EntryList();
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left:10,top: 10,right: 10),
//               height: BaseUtitiles.getheightofPercentage(context, 5),
//               child: TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     siteVoucher_Controller.SiteVocEtyList.value = BaseUtitiles.filterSearchResultsStaffVouchers(value, siteVoucher_Controller.mainentryList);
//                   });
//                 },
//                 controller: editingController,
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: "Search",
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//               ),
//             ),
//             Divider(
//               color: Theme.of(context).primaryColor,
//             ),
//             ListDetails(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget ListDetails() {
//     return Container(
//       width: BaseUtitiles.getWidthtofPercentage(context, 100),
//       child: Obx(
//             () => ListView.builder(
//             shrinkWrap: true,
//             physics: ScrollPhysics(),
//             itemCount: siteVoucher_Controller.SiteVocEtyList.value.length,
//             itemBuilder: (context, index) {
//               return Slidable(
//                 actionPane: SlidableDrawerActionPane(),
//                 secondaryActions: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Visibility(
//                         visible: commanController. deleteMode == 1 ? true : false,
//                         child: IconSlideAction(
//                             icon: Icons.delete,
//                             color: Colors.white10,
//                             foregroundColor: Colors.red,
//                             caption: RequestConstant.DELETE,
//                             onTap: () {
//                               setState(() {
//                                 siteVoucher_Controller.DeleteAlert(context,index);
//                               });
//                             }),
//                       ),
//                       Visibility(
//                         visible: commanController.editMode == 1 ? true : false,
//                         child: IconSlideAction(
//                             icon: Icons.edit,
//                             color: Colors.white10,
//                             foregroundColor: Colors.green,
//                             caption: RequestConstant.EDIT,
//                             onTap: () async {
//                               siteVoucher_Controller.Sitevoucher_itemview_GetDbList.value.clear();
//                               FocusScope.of(context).unfocus();
//                               siteVoucher_Controller.Sitevoucher_EditListApiValue.clear();
//                               siteVoucher_Controller.getSiteDetList.value.clear();
//                               await  siteVoucher_Controller.ConsumEntryList_EditApi(siteVoucher_Controller.SiteVocEtyList.value[index].vocId,context);
//                             }),
//                       ),
//                     ],
//                   )
//                 ],
//                 child: Container(
//                   margin: EdgeInsets.only(left: 3,right: 3),
//                   height: BaseUtitiles.getheightofPercentage(context, 20),
//                   width: BaseUtitiles.getWidthtofPercentage(context, 100),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     color: Colors.indigo.shade800,
//                     child: Container(
//                       margin: EdgeInsets.all(3),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[
//                               Expanded(
//                                   flex: 1,
//                                   child: Container(
//
//                                     height: BaseUtitiles.getheightofPercentage(context, 2),
//                                     child: Text(
//                                       siteVoucher_Controller
//                                           .SiteVocEtyList.value[index].vocNo
//                                           .toString(),
//                                       style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
//                                     ),
//                                   )),
//                               Expanded(
//                                   flex: 1,
//                                   child: Container(
//                                     margin: EdgeInsets.only(left: 70),
//                                     height: BaseUtitiles.getheightofPercentage(context, 2),
//                                     child: Text(
//                                       siteVoucher_Controller
//                                           .SiteVocEtyList.value[index].vocDate
//                                           .toString(),
//                                       style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
//                                     ),
//                                   )),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text("Project Name",style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                 flex: 3,
//                                 child: Text(siteVoucher_Controller
//                                     .SiteVocEtyList.value[index].projectName
//                                     .toString(),style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text("Acc Name",style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(siteVoucher_Controller
//                                       .SiteVocEtyList.value[index].accName
//                                       .toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text("Acc Type",style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(siteVoucher_Controller
//                                       .SiteVocEtyList.value[index].accType
//                                       .toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text("Pay For",style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(siteVoucher_Controller
//                                       .SiteVocEtyList.value[index].payFor
//                                       .toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text("Amount",style: TextStyle(color: Colors.white),)),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(siteVoucher_Controller
//                                       .SiteVocEtyList.value[index].vocAmt
//                                       .toString(),style: TextStyle(color: Colors.white),)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
