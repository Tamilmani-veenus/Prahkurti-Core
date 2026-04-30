//
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../../../controller/comman_controller.dart';
// import '../../../../controller/preapproval_controller.dart';
// import '../../../../utilities/baseutitiles.dart';
// import '../../../../utilities/requestconstant.dart';
//
// class Preapproval_EntryList extends StatefulWidget {
//   const Preapproval_EntryList({Key? key}) : super(key: key);
//
//   @override
//   State<Preapproval_EntryList> createState() => _Preapproval_EntryListState();
// }
//
// class _Preapproval_EntryListState extends State<Preapproval_EntryList> {
//
//   PreApprovalController preApprovalController=Get.put(PreApprovalController());
//   CommanController commanController = Get.put(CommanController());
//
//   TextEditingController editingController = TextEditingController();
//
//   @override
//   void initState() {
//     var duration = Duration(seconds: 0);
//     Future.delayed(duration,() async {
//
//       DateTime currentDate = DateTime.now();
//       DateTime lastDayOfMonth = new DateTime(currentDate.year, currentDate.month - 1, 0);
//       preApprovalController.preApproval_FromdateText.text = lastDayOfMonth.toString().substring(0, 10);
//       preApprovalController.preApproval_TodateText.text = BaseUtitiles.initiateCurrentDateFormat();
//       await preApprovalController.getAttenEntryList();
//       preApprovalController.Entrylist.value=preApprovalController.AttenEtyList.value;
//
//     });
//
//     super.initState();
//   }
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
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Container(
//                     width: BaseUtitiles.getWidthtofPercentage(context,40),
//                     height: BaseUtitiles.getheightofPercentage(context, 4),
//                     margin: EdgeInsets.only(top: 10),
//                     decoration: BoxDecoration(
//                     ),
//                     child: TextField(
//                       readOnly: true,
//                       controller: preApprovalController.preApproval_FromdateText,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.date_range_sharp,
//                             color: Theme.of(context).primaryColor),
//                       ),
//                       onTap: () async {
//                         preApprovalController.Entrylist.value.clear();
//                         var Frdate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                             builder: (context, child) {
//                               return Theme(data: Theme.of(context).copyWith(
//                                 colorScheme: ColorScheme.light(
//                                   primary: Theme.of(context).primaryColor, // header background color
//                                   onPrimary: Colors.white, // header text color
//                                   onSurface: Colors.black, // body text color
//                                 ),
//                                 textButtonTheme: TextButtonThemeData(
//                                   style: TextButton.styleFrom(
//                                     primary: Colors.black, // button text color
//                                   ),
//                                 ),
//                               ),
//                                 child: child!,
//                               );
//                             });
//                         preApprovalController.preApproval_FromdateText.text =
//                             Frdate.toString().substring(0, 10);
//                         preApprovalController.getAttenEntryList();
//                       },
//                     ),
//                   ),
//                   Container(
//                     width: BaseUtitiles.getWidthtofPercentage(context,40),
//                     height: BaseUtitiles.getheightofPercentage(context, 4),
//                     margin: EdgeInsets.only(top: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: TextField(
//                       readOnly: true,
//                       controller: preApprovalController.preApproval_TodateText,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.date_range_sharp,
//                             color: Theme.of(context).primaryColor),
//                       ),
//                       onTap: () async {
//                         preApprovalController.Entrylist.value.clear();
//                         var Frdate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                             builder: (context, child) {
//                               return Theme(data: Theme.of(context).copyWith(
//                                 colorScheme: ColorScheme.light(
//                                   primary: Theme.of(context).primaryColor, // header background color
//                                   onPrimary: Colors.white, // header text color
//                                   onSurface: Colors.black, // body text color
//                                 ),
//                                 textButtonTheme: TextButtonThemeData(
//                                   style: TextButton.styleFrom(
//                                     primary: Colors.black, // button text color
//                                   ),
//                                 ),
//                               ),
//                                 child: child!,
//                               );
//                             });
//                         preApprovalController.preApproval_TodateText.text =
//                             Frdate.toString().substring(0, 10);
//                         preApprovalController.getAttenEntryList();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left:10,top: 10,right: 10),
//               height: BaseUtitiles.getheightofPercentage(context, 5),
//               child: TextField(
//                 onChanged: (value) async {
//                   setState((){
//                     preApprovalController.Entrylist.value=BaseUtitiles.filterSearchResults(value,preApprovalController.AttenEtyList);
//                   });
//
//                 },
//                 controller: editingController,
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: RequestConstant.SEARCH,
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//               ),
//             ),
//             Divider(
//               color: Colors.red,
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
//       margin: EdgeInsets.only(bottom: 3,left: 3,right: 3),
//       height: BaseUtitiles.getheightofPercentage(context, 70),
//       width: BaseUtitiles.getWidthtofPercentage(context, 100),
//       child: Obx(
//             () => ListView.builder(
//             shrinkWrap: true,
//             physics: ScrollPhysics(),
//             itemCount:  preApprovalController.Entrylist.value.length,
//             itemBuilder: (context, index) {
//               return Slidable(
//                 actionPane: SlidableDrawerActionPane(),
//                 secondaryActions: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Visibility(
//                         visible: commanController.deleteMode == 1 ? true : false,
//                         child: IconSlideAction(
//                             icon: Icons.delete,
//                             color: Colors.white10,
//                             foregroundColor: Colors.red,
//                             caption: RequestConstant.DELETE,
//                             onTap: () {
//                               setState(() {
//                                 preApprovalController.DeleteAlert(context,index);
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
//                               preApprovalController.editcheck=1;
//                               preApprovalController.entrycheck=1;
//                               preApprovalController. pendingcheck=0;
//                               FocusScope.of(context).unfocus();
//                               await preApprovalController. EntryList_EditApi(preApprovalController.Entrylist.value[index].preApprovalId,context);
//
//                             }),
//                       ),
//                     ],
//                   )
//                 ],
//
//                 child: Container(
//                  // height: BaseUtitiles.getheightofPercentage(context, 20),
//                   width: BaseUtitiles.getWidthtofPercentage(context, 200),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//
//                     color: Colors.indigo.shade800,
//                     child: Container(
//                       margin: EdgeInsets.all(3),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             margin: EdgeInsets.only(top: 3),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(
//                                   preApprovalController.Entrylist.value[index].preApprovalNo
//                                       .toString(),
//                                   style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   preApprovalController.Entrylist.value[index].entryDate
//                                       .toString(),
//                                   style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
//                                 ),
//                                 // Icon(Icons.remove_red_eye,color: Theme.of(context).primaryColor,)
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(top: 3),
//                             child: Row(
//                               children: <Widget>[
//                                 Expanded(flex: 2, child: Text("Pre Approval Date",style: TextStyle(color: Colors.white),)),
//                                 Expanded(
//                                     flex: 3,
//                                     child: Text(preApprovalController.Entrylist.value[index].preApprovalDate
//                                         .toString(),style: TextStyle(color: Colors.white),)),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(top: 3),
//                             child: Row(
//                               children: <Widget>[
//                                 Expanded(flex: 2, child: Text(RequestConstant.PROJECT_NAME,style: TextStyle(color: Colors.white),)),
//                                 Expanded(
//                                     flex: 3,
//                                     child: Text(preApprovalController.Entrylist.value[index].project
//                                         .toString(),style: TextStyle(color: Colors.white),)),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(top: 3),
//                             child: Row(
//                               children: <Widget>[
//                                 Expanded(flex: 2, child: Text("Pre Approval Type",style: TextStyle(color: Colors.white),)),
//                                 Expanded(
//                                     flex: 3,
//                                     child: Text(preApprovalController.Entrylist.value[index].typeName
//                                         .toString(),style: TextStyle(color: Colors.white),)),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(top: 3),
//                             child: Row(
//                               children: <Widget>[
//                                 Expanded(flex: 2, child: Text(RequestConstant.PREPARED_BY,style: TextStyle(color: Colors.white),)),
//                                 Expanded(
//                                     flex: 3,
//                                     child: Text(preApprovalController.Entrylist.value[index]
//                                         .preparedBy
//                                         .toString(),style: TextStyle(color: Colors.white),)),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//               //
//             }),
//       ),
//     );
//   }
// }
