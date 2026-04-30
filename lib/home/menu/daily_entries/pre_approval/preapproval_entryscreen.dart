//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../controller/auto_yrwise_no_controller.dart';
// import '../../../../controller/logincontroller.dart';
// import '../../../../controller/preapproval_controller.dart';
// import '../../../../controller/projectcontroller.dart';
// import '../../../../utilities/baseutitiles.dart';
// import '../../../../utilities/requestconstant.dart';
//
// class Preapproval_EntryScreen extends StatefulWidget {
//   const Preapproval_EntryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<Preapproval_EntryScreen> createState() => _Preapproval_EntryScreenState();
// }
//
// class _Preapproval_EntryScreenState extends State<Preapproval_EntryScreen> {
//
//   ProjectController projectController = Get.put(ProjectController());
//   PreApprovalController preApprovalController=Get.put(PreApprovalController());
//   LoginController loginController=Get.put(LoginController());
//   AutoYearWiseNoController autoYearWiseNoController=Get.put(AutoYearWiseNoController());
//
//
//   @override
//   void initState() {
//     var duration = Duration(seconds:0);
//     Future.delayed(duration,() async {
//       await autoYearWiseNoController.PreApproval_AutoYearWise();
//       preApprovalController.preApprovalNoText.text = autoYearWiseNoController.preapproval_autoYrsWise.value;
//       if(preApprovalController.pendingcheck==1){
//         preApprovalController.pendingAllDatasList.value.forEach((element) {
//           preApprovalController.appId=element.preApprovalId!;
//           preApprovalController.preApprovalNoText.text = element.preApprovalNo.toString();
//           preApprovalController.preApprovalDateText.text = element.preApprovalDate.toString();
//           preApprovalController.preApprovalLocationText.text =element.location.toString();
//           preApprovalController.preApprovalDescriptionText.text =element.description.toString();
//           preApprovalController.preApproval_AppHrsText.text = element.approxHrs.toString();
//           preApprovalController.preApproval_AppQtyText.text = element.approxQty.toString();
//           preApprovalController.preApproval_ChemicalsText.text = element.chemicalUsed.toString();
//           preApprovalController.preApproval_PlannedDateText.text = element.plannedDate.toString();
//           preApprovalController.preApproval_PreparedbyText.text = element.preparedbyName.toString();
//           projectController.projectname.text=element.project.toString();
//           projectController.selectedProjectId.value=element.projectId!;
//           preApprovalController.typeId.value=element.PreApprovalTypeID!;
//           preApprovalController.preApprovalTypeText.text=element.preApprovalType.toString();
//           preApprovalController.preApproval_EquipmentText.text = element.equipment.toString();
//
//         });
//       }
//       if(preApprovalController.editcheck==1){
//         preApprovalController.EditApiList.value.forEach((element) {
//           preApprovalController.pendingcheck=0;
//           preApprovalController.appId=element.preApprovalId!;
//           preApprovalController.preApprovalNoText.text = element.preApprovalNo.toString();
//           preApprovalController.preApprovalDateText.text = element.preApprovalDate.toString();
//           preApprovalController.preApprovalLocationText.text =element.location.toString();
//           preApprovalController.preApprovalDescriptionText.text =element.description.toString();
//           preApprovalController.preApproval_AppHrsText.text = element.approxHrs.toString();
//           preApprovalController.preApproval_AppQtyText.text = element.approxQty.toString();
//           preApprovalController.preApproval_ChemicalsText.text = element.chemicalUsed.toString();
//           preApprovalController.preApproval_PlannedDateText.text = element.plannedDate.toString();
//           preApprovalController.preApproval_PreparedbyText.text = element.preparedbyName.toString();
//           projectController.projectname.text=element.project.toString();
//           projectController.selectedProjectId.value=element.projectId!;
//           preApprovalController.typeId.value=element.PreApprovalTypeID!;
//           preApprovalController.preApprovalTypeText.text=element.preApprovalType.toString();
//           preApprovalController.preApproval_EquipmentText.text = element.equipment.toString();
//
//         });
//       }
//
//       if(preApprovalController.entrycheck==0){
//         preApprovalController.entrycheck=1;
//         preApprovalController.pendingcheck=0;
//         preApprovalController.preApprovalNoText.text = autoYearWiseNoController.preapproval_autoYrsWise.value;
//         preApprovalController.preApprovalDateText.text = BaseUtitiles.initiateCurrentDateFormat();
//         preApprovalController.appId=0;
//         preApprovalController.preApprovalLocationText.text ="";
//         preApprovalController.preApprovalDescriptionText.text ="";
//         preApprovalController.preApproval_AppHrsText.text = "";
//         preApprovalController.preApproval_AppQtyText.text = "";
//         preApprovalController.preApproval_EquipmentText.text = "";
//         preApprovalController.preApproval_ChemicalsText.text = "";
//         preApprovalController.preApproval_PlannedDateText.text = BaseUtitiles.initiateCurrentDateFormat();
//         preApprovalController.preApproval_PreparedbyText.text = loginController.UserName();
//         projectController.projectname.text="";
//         projectController.selectedProjectId.value=0;
//         preApprovalController.typeId.value=0;
//         preApprovalController.preApprovalTypeText.text="";
//       }
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
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: 8,
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 20, bottom:2),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         child: TextField(
//                           controller: preApprovalController.preApprovalNoText,
//                           readOnly: true,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child:
//                       Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 20),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           readOnly: true,
//                           controller: preApprovalController.preApprovalDateText,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.date_range_sharp,
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                           onTap: () async {
//
//                               var Frdate = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(1900),
//                                   lastDate: DateTime.now(),
//                                   builder: (context, child) {
//                                     return Theme(data: Theme.of(context).copyWith(
//                                       colorScheme: ColorScheme.light(
//                                         primary: Theme.of(context).primaryColor, // header background color
//                                         onPrimary: Colors.white, // header text color
//                                         onSurface: Colors.black, // body text color
//                                       ),
//                                       textButtonTheme: TextButtonThemeData(
//                                         style: TextButton.styleFrom(
//                                           primary: Colors.black, // button text color
//                                         ),
//                                       ),
//                                     ),
//                                       child: child!,
//                                     );
//                                   }
//                               );
//                               preApprovalController.preApprovalDateText.text =BaseUtitiles.selectDateFormat(Frdate!);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 10,bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//                   style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   readOnly: true,
//                   controller: projectController.projectname,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: RequestConstant.PROJECT_NAME,
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//
//                   ),
//                   onTap: () {
//                       projectController.getProjectList(context,0);
//
//                   },
//                 ),
//
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//                   style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   readOnly: true,
//                   controller: preApprovalController.preApprovalTypeText,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: "PreApproval Type",
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//
//                   ),
//
//                   onTap: () {
//
//                     preApprovalController.TypeAlert(context);
//
//                   },
//                 ),
//
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//                   style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   controller: preApprovalController.preApprovalLocationText,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: "Location",
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onTap: () {
//
//                   },
//                 ),
//
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child:
//                 TextField(
//                   style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   controller: preApprovalController.preApprovalDescriptionText,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: "Description",
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//
//                     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                     controller: preApprovalController.preApproval_EquipmentText,
//                     decoration: new InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       labelText:"Equipment to be Used",
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                       ),
//                     ),
//
//                     onTap: () {
//
//                     }
//                 ),
//
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//                     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                     controller: preApprovalController.preApproval_ChemicalsText,
//                     decoration: new InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                       labelText:"Chemicals to be Used",
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                       ),
//                     ),
//
//                     onTap: () {
//
//                     }
//                 ),
//
//               ),
//
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: EdgeInsets.only(left: 20),
//                       child: Text("Approx.Hrs"),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 10,right: 20),
//                       height: BaseUtitiles.getheightofPercentage(context, 5),
//
//                       child: TextField(
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                         controller: preApprovalController.preApproval_AppHrsText,
//                         decoration: new InputDecoration(
//                           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                           ),
//                         ),
//
//                         onTap: () {
//
//                         }
//                       ),
//
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: EdgeInsets.only(left: 20),
//
//                       child: Text("Approx.Qty"),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 10,right: 20),
//                       height: BaseUtitiles.getheightofPercentage(context, 5),
//                       child: TextField(
//                           textAlign: TextAlign.center,
//
//                           style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                           controller: preApprovalController.preApproval_AppQtyText,
//                           decoration: new InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                           ),
//
//                           onTap: () {
//
//                           }
//                       ),
//
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: EdgeInsets.only(left: 20),
//                       child: Text("Planned Date"),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       height: BaseUtitiles.getheightofPercentage(context, 5),
//                       margin: EdgeInsets.only(bottom: 10,right: 20),
//                       decoration: BoxDecoration(),
//                       child: TextField(
//                         readOnly: true,
//                         controller: preApprovalController.preApproval_PlannedDateText,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                           ),
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.date_range_sharp,
//                               color: Theme.of(context).primaryColor),
//                         ),
//                         onTap: () async {
//
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
//                               }
//                           );
//                           preApprovalController.preApproval_PlannedDateText.text =BaseUtitiles.selectDateFormat(Frdate!);
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: EdgeInsets.only(left: 20),
//                       child: Text("Prepared By"),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 10,right: 20),
//                       height: BaseUtitiles.getheightofPercentage(context, 5),
//                       child: TextField(
//                          readOnly: true,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE,color: Colors.indigo),
//                           controller: preApprovalController.preApproval_PreparedbyText,
//                           decoration: new InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                           ),
//
//                           onTap: () {
//
//                           }
//                       ),
//
//                     ),
//                   ),
//                 ],
//               ),
//
//
//               Container(
//                 margin: EdgeInsets.only(top: 20),
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 30),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Theme.of(context).primaryColor,
//                     //background color of button
//                     side: BorderSide(width: 3, color: Colors.black),
//                     //border width and color
//                     elevation: 3,
//                     //elevation of button
//                     shape: RoundedRectangleBorder(
//                       //to set border radius to button
//                         borderRadius: BorderRadius.circular(30)),
//                   ),
//                   onPressed: () {
//                     if(projectController.selectedProjectId.value==0){
//                       BaseUtitiles.showToast("Please Select project Name");
//                     }
//                     else if(preApprovalController.typeId.value==0){
//                       BaseUtitiles.showToast("Please Select Approal Type");
//                     }
//                     else{
//                       preApprovalController.Save_EntryScreen(context,preApprovalController.appId,preApprovalController.pendingcheck==1?1:0);
//                     }
//
//                   },
//                   child: Text(preApprovalController.editcheck==1?"Update":preApprovalController.pendingcheck==1?"Approve":"Save"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
