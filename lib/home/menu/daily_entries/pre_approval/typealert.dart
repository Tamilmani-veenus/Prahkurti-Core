//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../controller/preapproval_controller.dart';
// import '../../../../utilities/baseutitiles.dart';
// import '../../../../utilities/requestconstant.dart';
// class PreApprovalTypeAlert extends StatefulWidget {
//   const PreApprovalTypeAlert({Key? key, required this.list }) : super(key: key);
//   final List list;
//
//   @override
//   State<PreApprovalTypeAlert> createState() => _PreApprovalTypeAlertState();
// }
//
// class _PreApprovalTypeAlertState extends State<PreApprovalTypeAlert> {
//
//   TextEditingController editingController = TextEditingController();
//   // PreApprovalController preApprovalController=Get.put(PreApprovalController());
//
//   @override
//   void initState() {
//    preApprovalController.searchTypelist.value.clear();
//    preApprovalController.searchTypelist.value=widget.list;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  AlertDialog(
//       contentPadding: EdgeInsets.all(5.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       content: SingleChildScrollView(
//         child: Container(
//           //height: BaseUtitiles.getheightofPercentage(context, 60),
//           child: Column(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(top: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                 child: TextField(
//                   onChanged: (value) {
//                     setState(() {
//                       preApprovalController.searchTypelist.value=BaseUtitiles.typeNamePopupAlert(value,widget.list);
//                     });
//                   },
//                   controller: editingController,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       labelText: "Search",
//                       labelStyle: TextStyle(
//
//                           fontStyle: FontStyle.italic, fontSize: RequestConstant.App_Font_SIZE),
//                       prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 80),
//                 height: BaseUtitiles.getheightofPercentage(context, 38),
//                 child: ListView.builder(
//                     itemCount: preApprovalController.searchTypelist.value.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: () async{
//                           preApprovalController.setSelectedStaffID(preApprovalController.searchTypelist.value[index].typeName!);
//                           Navigator.pop(context);
//
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Column(
//                               mainAxisAlignment:
//                               MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Container(
//                                     width:
//                                     BaseUtitiles.getWidthtofPercentage(
//                                         context, 60),
//                                     child: Text(preApprovalController.searchTypelist.value[index].typeName
//                                         .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
//                                 Divider(
//                                   color: Theme.of(context).primaryColorLight,
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
