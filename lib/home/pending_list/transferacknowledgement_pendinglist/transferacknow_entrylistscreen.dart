// import '../../../home/pending_list/transferacknowledgement_pendinglist/transferacknow_entryscreen.dart';
// import '../../../../controller/pendinglistcontroller.dart';
// import '../../../../utilities/requestconstant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import '../../../constants/ui_constant/icons_const.dart';
// import '../../../controller/transfer_acknowledgment_pending_controller.dart';
// import '../../../utilities/baseutitiles.dart';
// class TransferacknowEntryList extends StatefulWidget {
//   const TransferacknowEntryList({Key? key}) : super(key: key);
//
//   @override
//   State<TransferacknowEntryList> createState() => _TransferacknowEntryListState();
// }
//
// class _TransferacknowEntryListState extends State<TransferacknowEntryList> {
//   TransferAcknowledgmentPendingController transferAcknowController=Get.put(TransferAcknowledgmentPendingController());
//   PendingListController pendingListController=Get.put(PendingListController());
//   TextEditingController editingController = TextEditingController();
//
//   @override
//   void initState() {
//     if(transferAcknowController.entrycheck==2){
//       transferAcknowController.entrycheck=0;
//     }
//     else{
//       transferAcknowController.entrycheck=1;
//     }
//
//     transferAcknowController.entrylistDatas.clear();
//     transferAcknowController.mainentrylist.value.clear();
//
//     DateTime currentDate = DateTime.now();
//     DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
//     transferAcknowController.entrylist_fromDate.text = lastDayOfMonth.toString().substring(0, 10);
//     transferAcknowController.entrylist_toDate.text = currentDate.toString().substring(0, 10);
//     transferAcknowController.getEntryList();
//     transferAcknowController.entrylistDatas.value = transferAcknowController.mainentrylist.value;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async{
//         await pendingListController.getPendingList();
//         return true;
//       },
//       child: GestureDetector(
//         onTap: () {
//           FocusScopeNode currentFocus = FocusScope.of(context);
//           if (!currentFocus.hasPrimaryFocus &&
//               currentFocus.focusedChild != null) {
//             FocusManager.instance.primaryFocus?.unfocus();
//           }
//         },
//         child: SafeArea(
//           top: false,
//           child: Scaffold(
//             floatingActionButton: FloatingActionButton.extended(
//               onPressed: (){
//                 transferAcknowController.entrycheck =0;
//                 transferAcknowController.editcheck =0;
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => TransferAcknow_EntryScreen()));
//               },
//               label: Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,),),
//               icon: Icon(Icons.add, color: Colors.white, size: RequestConstant.Heading_Font_SIZE, ),
//               backgroundColor: Theme.of(context).primaryColor,
//             ),
//
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 40),
//                   Container(
//                     margin: EdgeInsets.only(left: 15, right: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Transfer Acknowledgment",
//                           style: TextStyle(
//                               fontSize: RequestConstant.Heading_Font_SIZE,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text(
//                               "Back",
//                               style: TextStyle(color: Colors.grey, fontSize: 18),
//                             ))
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 3),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           width: BaseUtitiles.getWidthtofPercentage(context, 38),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(color: Colors.white70, width: 1),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 3),
//                               child: TextFormField(
//                                 readOnly: true,
//                                 controller: transferAcknowController.entrylist_fromDate,
//                                 cursorColor: Colors.black,
//                                 style: TextStyle(color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.zero,
//                                   border: InputBorder.none,
//                                   labelText: "From Date",
//                                   labelStyle: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: RequestConstant.Lable_Font_SIZE),
//                                   prefixIconConstraints:
//                                   BoxConstraints(minWidth: 0, minHeight: 0),
//                                   prefixIcon: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: 8, horizontal: 8),
//                                     child: ConstIcons.date,
//
//                                   ),
//                                 ),
//                                 onTap: () async {
//                                   var Frdate = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(2010),
//                                       lastDate: DateTime.now(),
//                                       builder: (context, child) {
//                                         return Theme(
//                                           data: Theme.of(context).copyWith(
//                                             colorScheme: ColorScheme.light(
//                                               primary: Theme.of(context).primaryColor,
//                                               onPrimary: Colors.white,
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
//                                   transferAcknowController.entrylist_fromDate.text = Frdate.toString().substring(0, 10);
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
//                         Container(
//                           width: BaseUtitiles.getWidthtofPercentage(context, 38),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(color: Colors.white70, width: 1),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 3),
//                               child: TextFormField(
//                                 readOnly: true,
//                                 controller: transferAcknowController.entrylist_toDate,
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
//                                       padding: EdgeInsets.symmetric(
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
//                                   transferAcknowController.entrylist_toDate.text =
//                                       Todate.toString().substring(0, 10);
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
//                         Container(
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   primary: Theme.of(context).primaryColor),
//                               onPressed: () async {
//                                 setState(() {
//                                   transferAcknowController.getEntryList();
//                                 });
//                               },
//                               child: Center(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(top: 13, bottom: 13),
//                                     child: Text("SHOW",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: RequestConstant.App_Font_SIZE,
//                                             fontWeight: FontWeight.bold)),
//                                   ))),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 30),
//
//                   SingleChildScrollView(
//                     physics: BouncingScrollPhysics(),
//                     child: Container(
//                       height: BaseUtitiles.getheightofPercentage(context, 80),
//                       decoration: BoxDecoration(
//                         color: Colors.white70,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: const Radius.circular(40.0),
//                           topRight: const Radius.circular(40.0),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(left: 15, right: 15, top: 10),
//                             child: TextField(
//                               cursorColor: Theme.of(context).primaryColor,
//                               controller: editingController,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 prefixIcon: Padding(
//                                   padding: EdgeInsets.only(bottom: 10, left: 15),
//                                   child: ConstIcons.list_Search,
//                                 ),
//                                 hintText: "Search..",
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 isDense: true,
//                               ),
//                               onEditingComplete: () {
//                                 FocusScope.of(context).unfocus();
//                               },
//                               textInputAction: TextInputAction.search,
//                               onChanged: (value) {
//                                 setState(() {
//                                   transferAcknowController.entrylistDatas.value = BaseUtitiles.filterSearchResultstransfer(value,transferAcknowController.mainentrylist);
//                                 });
//                               },
//                             ),
//                           ),
//
//                           ListDetails(),
//
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   // Column(
//                   //   crossAxisAlignment: CrossAxisAlignment.start,
//                   //   children: <Widget>[
//                   //     Container(
//                   //       margin: EdgeInsets.only(top: 10),
//                   //       child: Row(
//                   //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   //         children: <Widget>[
//                   //           Expanded(
//                   //             flex: 2,
//                   //             child: Container(
//                   //               height: BaseUtitiles.getheightofPercentage(context, 4),
//                   //               margin: EdgeInsets.only(left: 10, right: 20),
//                   //               decoration: BoxDecoration(),
//                   //               child: TextField(
//                   //                 style: TextStyle(fontSize: 13),
//                   //                 readOnly: true,
//                   //                 controller: transferAcknowController.entrylist_fromDate,
//                   //                 decoration: InputDecoration(
//                   //                   contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                   //                   border: OutlineInputBorder(),
//                   //                   prefixIcon: Icon(Icons.date_range_sharp,
//                   //                       color: Theme.of(context).primaryColor),
//                   //                 ),
//                   //                 onTap: () async {
//                   //                   transferAcknowController.entrylistDatas.clear();
//                   //                   var Frdate = await showDatePicker(
//                   //                       context: context,
//                   //                       initialDate: DateTime.now(),
//                   //                       firstDate: DateTime(1900),
//                   //                       lastDate: DateTime(2100),
//                   //                       builder: (context, child) {
//                   //                         return Theme(data: Theme.of(context).copyWith(
//                   //                           colorScheme: ColorScheme.light(
//                   //                             primary: Theme.of(context).primaryColor, // header background color
//                   //                             onPrimary: Colors.white, // header text color
//                   //                             onSurface: Colors.black, // body text color
//                   //                           ),
//                   //                           textButtonTheme: TextButtonThemeData(
//                   //                             style: TextButton.styleFrom(
//                   //                               primary: Colors.black, // button text color
//                   //                             ),
//                   //                           ),
//                   //                         ),
//                   //                           child: child!,
//                   //                         );
//                   //                       });
//                   //                   transferAcknowController.entrylist_fromDate.text = Frdate.toString().substring(0, 10);
//                   //                   transferAcknowController.getEntryList();
//                   //                 },
//                   //               ),
//                   //             ),
//                   //           ),
//                   //           Expanded(
//                   //             flex: 2,
//                   //             child: Container(
//                   //               height: BaseUtitiles.getheightofPercentage(context, 4),
//                   //               margin: EdgeInsets.only(left: 10, right: 20),
//                   //               decoration: BoxDecoration(),
//                   //               child: TextField(
//                   //                 style: TextStyle(fontSize: 13),
//                   //                 readOnly: true,
//                   //                 controller: transferAcknowController.entrylist_toDate,
//                   //                 decoration: InputDecoration(
//                   //                   contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                   //                   border: OutlineInputBorder(),
//                   //                   prefixIcon: Icon(Icons.date_range_sharp,
//                   //                       color: Theme.of(context).primaryColor),
//                   //                 ),
//                   //                 onTap: () async {
//                   //                   transferAcknowController.entrylistDatas.clear();
//                   //                   var Todate = await showDatePicker(
//                   //                       context: context,
//                   //                       initialDate: DateTime.now(),
//                   //                       firstDate: DateTime(1900),
//                   //                       lastDate: DateTime(2100),
//                   //                       builder: (context, child) {
//                   //                         return Theme(data: Theme.of(context).copyWith(
//                   //                           colorScheme: ColorScheme.light(
//                   //                             primary: Theme.of(context).primaryColor, // header background color
//                   //                             onPrimary: Colors.white, // header text color
//                   //                             onSurface: Colors.black, // body text color
//                   //                           ),
//                   //                           textButtonTheme: TextButtonThemeData(
//                   //                             style: TextButton.styleFrom(
//                   //                               primary: Colors.black, // button text color
//                   //                             ),
//                   //                           ),
//                   //                         ),
//                   //                           child: child!,
//                   //                         );
//                   //                       });
//                   //                   transferAcknowController.entrylist_toDate.text =
//                   //                       Todate.toString().substring(0, 10);
//                   //                   transferAcknowController.getEntryList();
//                   //                 },
//                   //               ),
//                   //             ),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     ),
//                   //     Container(
//                   //       margin: EdgeInsets.only(left:10,top: 10,right: 10),
//                   //       height: BaseUtitiles.getheightofPercentage(context, 5),
//                   //       child: TextField(
//                   //         onChanged: (value) {
//                   //           setState(() {
//                   //             transferAcknowController.entrylistDatas.value = BaseUtitiles.filterSearchResultstransfer(value,transferAcknowController.mainentrylist);
//                   //           });
//                   //         },
//                   //         controller: editingController,
//                   //         decoration: InputDecoration(
//                   //             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                   //             labelText: "Search",
//                   //             prefixIcon: Icon(
//                   //               Icons.search,
//                   //               color: Theme.of(context).primaryColor,
//                   //             ),
//                   //             border: OutlineInputBorder(
//                   //                 borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//                   //       ),
//                   //     ),
//                   //     Divider(
//                   //       color: Theme.of(context).primaryColor,
//                   //     ),
//                   //     ListDetails(),
//                   //   ],
//                   // ),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget ListDetails() {
//     return Container(
//       height: BaseUtitiles.getheightofPercentage(context, 69),
//       child: Column(
//         children: [
//           Container(
//             height: BaseUtitiles.getheightofPercentage(context, 68),
//             child: Obx(
//                   () => ListView.builder(
//                   shrinkWrap: true,
//                   physics: ScrollPhysics(),
//                   padding: EdgeInsets.zero,
//                   itemCount: transferAcknowController.entrylistDatas.value.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.only(left: 3, right: 3),
//                       child: Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: Container(
//                           margin: EdgeInsets.all(3),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//
//                                       Container(
//                                         width: BaseUtitiles.getWidthtofPercentage(context, 50),
//                                         child: Row(
//                                           children: [
//                                             Container(
//                                               margin: EdgeInsets.only(left: 5, right: 3),
//                                               child: ConstIcons.list_date, ),
//                                             Text(
//                                               transferAcknowController
//                                                   .entrylistDatas.value[index].exdate
//                                                   .toString(),
//                                               style: TextStyle(
//                                                   color: Theme.of(context).primaryColor,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(right: 10),
//                                     child: Text(
//                                       transferAcknowController.entrylistDatas.value[index].ackNo.toString(),
//                                       style: TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                               Row(
//                                 children: <Widget>[
//                                   Container(
//                                     margin: EdgeInsets.only(top: 5, left: 10),
//                                     child: Text(""),
//                                   ),
//                                   Expanded(
//                                       flex: 3,
//                                       child: Text(
//                                         "From Project",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,),
//                                       )),
//                                   Expanded(
//                                       flex: 8,
//                                       child: Text(
//                                         transferAcknowController
//                                             .entrylistDatas.value[index].fromProject
//                                             .toString(),
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       )),
//                                 ],
//                               ),
//                               Divider(thickness: 1),
//                               Row(
//                                 children: <Widget>[
//                                   Container(
//                                     margin: EdgeInsets.only(left: 10),
//                                     child: Text(""),
//                                   ),
//                                   Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         "To Project",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black),
//                                       )),
//                                   Expanded(
//                                       flex: 4,
//                                       child: Text(
//                                           transferAcknowController.entrylistDatas.value[index].toProject.toString(),
//                                         style: TextStyle(color: Colors.black),
//                                       )),
//                                   Expanded(
//                                       flex: 1,
//                                       child: IconButton(
//                                           onPressed: () {
//                                             showModalBottomSheet(
//                                                 context: context,
//                                                 shape: RoundedRectangleBorder(
//                                                   // <-- SEE HERE
//                                                   borderRadius: BorderRadius.vertical(
//                                                       top: Radius.circular(25.0)),
//                                                 ),
//                                                 builder: (context) {
//                                                   return Container(
//                                                     margin: EdgeInsets.only(left: 15),
//                                                     height: BaseUtitiles.getheightofPercentage(context, 25),
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                       children: [
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                           children: [
//                                                             Expanded(
//                                                               child: Container(
//                                                                 margin: EdgeInsets.only(
//                                                                     right: 10),
//                                                                 child: Text(
//                                                                   transferAcknowController.entrylistDatas.value[index].ackNo.toString(),
//                                                                   style: TextStyle(
//                                                                       fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                       color: Theme.of(
//                                                                           context)
//                                                                           .primaryColor),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             IconButton(
//                                                               onPressed: () {
//                                                                 Navigator.pop(context);
//                                                               },
//                                                               icon:  ConstIcons.cancle,)
//                                                           ],
//                                                         ),
//                                                         InkWell(
//                                                             child: Row(
//                                                               children: [
//                                                                 Card(
//                                                                   color: Colors
//                                                                       .lightGreen,
//                                                                   child: Padding(
//                                                                     padding:
//                                                                     const EdgeInsets
//                                                                         .all(8),
//                                                                     child: Icon(
//                                                                       Icons.edit,
//                                                                       color: Colors
//                                                                           .white,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 SizedBox(width: 5),
//                                                                 Text(
//                                                                   "Edit",
//                                                                   style: TextStyle(
//                                                                       color:
//                                                                       Colors.grey,
//                                                                       fontSize: 15),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                             onTap: () async {
//                                                               transferAcknowController.entrycheck=1;
//                                                               transferAcknowController.deleteDetTableDatas();
//                                                               transferAcknowController.readListdata.value.clear();
//                                                               transferAcknowController.getTransferDetList.value.clear();
//                                                               transferAcknowController.editlistDatas.value.clear();
//                                                               await transferAcknowController.EntryList_EditApi(transferAcknowController.entrylistDatas.value[index].ackMasId,transferAcknowController.entrylistDatas.value[index].transferId,context);
//                                                               Navigator.pop(context);
//                                                               FocusScope.of(context).unfocus();
//                                                             }),
//                                                         Container(
//                                                             margin: EdgeInsets.only(
//                                                                 right: 20),
//                                                             child: Divider(
//                                                                 thickness: 1)),
//                                                         InkWell(
//                                                             child: Row(
//                                                               children: [
//                                                                 Card(
//                                                                   color: Colors.red,
//                                                                   child: Padding(
//                                                                     padding:
//                                                                     const EdgeInsets
//                                                                         .all(8),
//                                                                     child: Icon(
//                                                                       Icons
//                                                                           .delete_forever,
//                                                                       color: Colors
//                                                                           .white,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 SizedBox(width: 5),
//                                                                 Text(
//                                                                   "Delete",
//                                                                   style: TextStyle(
//                                                                       color:
//                                                                       Colors.grey,
//                                                                       fontSize: 15),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                             onTap: () async {
//                                                               Navigator.pop(context);
//                                                               transferAcknowController.DeleteAlert(context, index);
//                                                             }),
//                                                         SizedBox(height: 20)
//                                                       ],
//                                                     ),
//                                                   );
//                                                 });
//                                           },
//                                           icon: Icon(
//                                             Icons.arrow_drop_down_circle_outlined,
//                                             color: Theme.of(context).primaryColor,
//                                           )))
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//
//                     //   Slidable(
//                     //   actionPane: SlidableDrawerActionPane(),
//                     //   secondaryActions: [
//                     //     Column(
//                     //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     //       children: <Widget>[
//                     //         Visibility(
//                     //           visible: true,
//                     //           child: IconSlideAction(
//                     //               icon: Icons.delete,
//                     //               color: Colors.white24,
//                     //               foregroundColor: Colors.red,
//                     //               caption: RequestConstant.DELETE,
//                     //               onTap: () {
//                     //                 setState(() {
//                     //                   transferAcknowController.DeleteAlert(context,index);
//                     //                 });
//                     //               }),
//                     //         ),
//                     //         Visibility(
//                     //           visible: true,
//                     //           child: IconSlideAction(
//                     //               icon: Icons.edit,
//                     //               color: Colors.white24,
//                     //               foregroundColor: Colors.green,
//                     //               caption: RequestConstant.EDIT,
//                     //               onTap: () async {
//                     //                 transferAcknowController.entrycheck=1;
//                     //                 transferAcknowController.deleteDetTableDatas();
//                     //                 transferAcknowController.readListdata.value.clear();
//                     //                 transferAcknowController.getTransferDetList.value.clear();
//                     //                 transferAcknowController.editlistDatas.value.clear();
//                     //                 FocusScope.of(context).unfocus();
//                     //                 await transferAcknowController.EntryList_EditApi(transferAcknowController.entrylistDatas.value[index].ackMasId,transferAcknowController.entrylistDatas.value[index].transferId,context);
//                     //
//                     //               }),
//                     //         ),
//                     //       ],
//                     //     )
//                     //   ],
//                     //   child: Container(
//                     //     margin: EdgeInsets.only(left: 3,right: 3),
//                     //     height: BaseUtitiles.getheightofPercentage(context,12),
//                     //     width: BaseUtitiles.getWidthtofPercentage(context, 100),
//                     //     child: Card(
//                     //       shape: RoundedRectangleBorder(
//                     //         borderRadius: BorderRadius.circular(10.0),
//                     //       ),
//                     //       elevation: 3,
//                     //       color: Colors.indigo.shade800,
//                     //       child: Container(
//                     //         margin: EdgeInsets.all(3),
//                     //         child: Column(
//                     //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //           children: <Widget>[
//                     //             Row(
//                     //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     //               children: <Widget>[
//                     //                 Expanded(
//                     //                     flex: 1,
//                     //                     child: Container(
//                     //
//                     //                       height: BaseUtitiles.getheightofPercentage(context, 2),
//                     //                       child: Text(
//                     //                         transferAcknowController
//                     //                             .entrylistDatas.value[index].ackNo
//                     //                             .toString(),
//                     //                         style: TextStyle(color: Colors.yellow),
//                     //                       ),
//                     //                     )),
//                     //                 Expanded(
//                     //                     flex: 1,
//                     //                     child: Container(
//                     //                       margin: EdgeInsets.only(left: 70),
//                     //                       height: BaseUtitiles.getheightofPercentage(context, 2),
//                     //                       child: Text(
//                     //                         transferAcknowController
//                     //                             .entrylistDatas.value[index].exdate
//                     //                             .toString(),
//                     //                         style: TextStyle(color: Colors.yellow),
//                     //                       ),
//                     //                     )),
//                     //               ],
//                     //             ),
//                     //             Row(
//                     //               children: <Widget>[
//                     //                 Expanded(flex: 2, child: Text("From Project",style: TextStyle(color: Colors.white),)),
//                     //                 Expanded(
//                     //                   flex: 3,
//                     //                   child: Text(transferAcknowController
//                     //                       .entrylistDatas.value[index].fromProject
//                     //                       .toString(),style: TextStyle(color: Colors.white),
//                     //                   ),
//                     //                 ),
//                     //               ],
//                     //             ),
//                     //             Row(
//                     //               children: <Widget>[
//                     //                 Expanded(flex: 2, child: Text("TO Project",style: TextStyle(color: Colors.white),)),
//                     //                 Expanded(
//                     //                     flex: 3,
//                     //                     child: Text(transferAcknowController
//                     //                         .entrylistDatas.value[index].toProject
//                     //                         .toString(),style: TextStyle(color: Colors.white),)),
//                     //               ],
//                     //             ),
//                     //           ],
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ),
//                     // );
//
//
//                   }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
