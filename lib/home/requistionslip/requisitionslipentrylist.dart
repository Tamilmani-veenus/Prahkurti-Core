//
// import '../../../../controller/mrn_request_indent_controller.dart';
// import '../../../../utilities/requestconstant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
//
// import '../../../../utilities/baseutitiles.dart';
// import '../../controller/requisitionslip_controller.dart';
//
// class RequisitionSlipEntryListScreen extends StatefulWidget {
//   const RequisitionSlipEntryListScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RequisitionSlipEntryListScreen> createState() =>
//       _RequisitionSlipEntryListScreenState();
// }
//
// class _RequisitionSlipEntryListScreenState
//     extends State<RequisitionSlipEntryListScreen> {
//   TextEditingController editingController = TextEditingController();
//   MRN_Request_Controller mrn_request_controller=Get.put(MRN_Request_Controller());
//   RequisitionSlipController requisitionSlipController=Get.put(RequisitionSlipController());
//
//   @override
//   void initState() {
//     requisitionSlipController.ReqSlipEtyList.clear();
//     requisitionSlipController.mainentrylist.value.clear();
//
//     DateTime currentDate = DateTime.now();
//     DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
//     requisitionSlipController.EntrylistFromdate.text = lastDayOfMonth.toString().substring(0, 10);
//     requisitionSlipController.EntrylistTodate.text = currentDate.toString().substring(0, 10);
//     requisitionSlipController.getRequisitionslip_EntryList();
//     requisitionSlipController.ReqSlipEtyList.value = requisitionSlipController.mainentrylist.value;
//
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
//                         controller: requisitionSlipController.EntrylistFromdate,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.date_range_sharp,
//                               color: Theme.of(context).primaryColor),
//                         ),
//                         onTap: () async {
//                           requisitionSlipController.ReqSlipEtyList.clear();
//                           var Frdate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime(2100));
//                           requisitionSlipController.EntrylistFromdate.text = Frdate.toString().substring(0, 10);
//                           requisitionSlipController.getRequisitionslip_EntryList();
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
//                         controller: requisitionSlipController.EntrylistTodate,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.date_range_sharp,
//                               color: Theme.of(context).primaryColor),
//                         ),
//                         onTap: () async {
//                           requisitionSlipController.ReqSlipEtyList.clear();
//                           var Todate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime(2100));
//                           requisitionSlipController.EntrylistTodate.text =
//                               Todate.toString().substring(0, 10);
//                           requisitionSlipController.getRequisitionslip_EntryList();
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10),
//               height: BaseUtitiles.getheightofPercentage(context, 5),
//               child: TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     requisitionSlipController.ReqSlipEtyList.value =BaseUtitiles.filterSearchResultsemployee(value,requisitionSlipController.mainentrylist);
//                   });
//                 },
//                 controller: editingController,
//                 decoration: InputDecoration(
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
//             itemCount: requisitionSlipController.ReqSlipEtyList.value.length,
//             itemBuilder: (context, index) {
//               return Slidable(
//                 actionPane: SlidableDrawerActionPane(),
//                 secondaryActions: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Visibility(
//                         visible: true,
//                         child: IconSlideAction(
//                             icon: Icons.delete,
//                             color: Colors.white10,
//                             foregroundColor: Colors.red,
//                             caption: RequestConstant.DELETE,
//                             onTap: () {
//                               setState(() {
//                                 requisitionSlipController.Requisition_DeleteApi(requisitionSlipController.ReqSlipEtyList.value[index].requestionId,requisitionSlipController.ReqSlipEtyList.value[index].requestionNo);
//                                 requisitionSlipController.ReqSlipEtyList.removeAt(index);
//                               });
//                             }),
//                       ),
//                       Visibility(
//                         visible: true,
//                         child: IconSlideAction(
//                             icon: Icons.edit,
//                             color: Colors.white10,
//                             foregroundColor: Colors.green,
//                             caption: RequestConstant.EDIT,
//                             onTap: () async {
//
//                               requisitionSlipController.ReqSlipEditList.clear();
//
//                               FocusScope.of(context).unfocus();
//                               requisitionSlipController.Requisitionslip_EditApi(requisitionSlipController.ReqSlipEtyList[index].requestionId, context);
//                             }),
//                       ),
//                     ],
//                   )
//                 ],
//                 child: Container(
//                   margin: EdgeInsets.all(3),
//                   height: BaseUtitiles.getheightofPercentage(context,15),
//                   width: BaseUtitiles.getWidthtofPercentage(context, 100),
//                   child: Card(
//                     color: Colors.indigo.shade800,
//                     child: Container(
//                       margin: EdgeInsets.all(3),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text("Request No",style: TextStyle(color: Colors.white))),
//                               Expanded(
//                                 flex: 3,
//                                 child: Text(requisitionSlipController
//                                     .ReqSlipEtyList.value[index].requestionNo
//                                     .toString(),
//                                   style: TextStyle(color: Colors.yellow),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text("Type",style: TextStyle(color: Colors.white))),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(requisitionSlipController
//                                       .ReqSlipEtyList.value[index].reqType
//                                       .toString(),
//                                       style: TextStyle(color:Colors.red)
//                                   )),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text("Employee",style: TextStyle(color: Colors.white))),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(requisitionSlipController
//                                       .ReqSlipEtyList.value[index].employee
//                                       .toString(),style: TextStyle(color: Colors.yellow))),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(flex: 2, child: Text("Status",style: TextStyle(color: Colors.white))),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(requisitionSlipController
//                                       .ReqSlipEtyList.value[index].status
//                                       .toString(),style: TextStyle(color: Colors.yellow))),
//                             ],
//                           ),
//
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
