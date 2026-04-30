// import '../../../../controller/auto_yrwise_no_controller.dart';
//
// import '../../../../controller/logincontroller.dart';
//
// import '../../../../controller/requisitionslip_controller.dart';
//
// import '../../../../controller/staffcontroller.dart';
//
// import '../../../../utilities/baseutitiles.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../utilities/requestconstant.dart';
//
//
//
//
// class RequisitionSlip_EntryScreen extends StatefulWidget {
//
//   const RequisitionSlip_EntryScreen({Key? key}) : super(key: key);
//
//
//
//   @override
//   State<RequisitionSlip_EntryScreen> createState() => _Requisition_EntryScreenState_Site();
// }
//
// class _Requisition_EntryScreenState_Site extends State<RequisitionSlip_EntryScreen> {
//
//
//   AutoYearWiseNoController autoYearWiseNoController=Get.put(AutoYearWiseNoController());
//   StaffController staffController=Get.put(StaffController());
//   LoginController loginController=Get.put(LoginController());
//   RequisitionSlipController requisitionSlipController=Get.put(RequisitionSlipController());
//
//   @override
//   void initState(){
//     if(requisitionSlipController.editCheck==1){
//       requisitionSlipController.saveButton.value=RequestConstant.UPDATE;
//       requisitionSlipController.ReqSlipEditList.forEach((element) {
//         requisitionSlipController.reqId=element.reqId;
//         requisitionSlipController.ReqAutoyearwise.text=element.reqNo;
//         requisitionSlipController.Reqdate.text=element.reqDate;
//         requisitionSlipController.Staffname.text=element.staffName;
//         requisitionSlipController.Location.text="OFFICE";
//         requisitionSlipController.type.value=element.reqType=="L"?"Leave":element.reqType=="O"?"OnDuty":"Permission";
//         requisitionSlipController.Fromdate.text=element.lFrdate;
//         requisitionSlipController.Todate.text=element.lTodate;
//         requisitionSlipController.Reason.text=element.leaveReason;
//         requisitionSlipController.OndutyReason.text=element.perReason;
//         requisitionSlipController.PerReason.text=element.perReason;
//         requisitionSlipController.Totaldays.text=element.totalLeave.toString();
//         requisitionSlipController.ondutyDate.text=element.pFrdate;
//         requisitionSlipController.perDate.text=element.pFrdate;
//         requisitionSlipController.pFromtime.text=element.pFrTime;
//         requisitionSlipController.pTotime.text=element.pToTime;
//         requisitionSlipController.TotalHrs.text=element.totalPerHrs.toString();
//
//
//       });
//     }
//     else{
//       requisitionSlipController.reqId=0;
//       requisitionSlipController.saveButton.value=RequestConstant.SAVE;
//       requisitionSlipController.Staffname.text=loginController.EmpName();
//       requisitionSlipController.Reqdate.text=BaseUtitiles.initiateCurrentDateFormat();
//       requisitionSlipController.Fromdate.text=BaseUtitiles.initiateCurrentDateFormat();
//       requisitionSlipController.Todate.text=BaseUtitiles.initiateCurrentDateFormat();
//       requisitionSlipController.ondutyDate.text=BaseUtitiles.initiateCurrentDateFormat();
//       requisitionSlipController.perDate.text=BaseUtitiles.initiateCurrentDateFormat();
//       requisitionSlipController.ReqAutoyearwise.text=autoYearWiseNoController.RequisitionSlip_autoYrsWise.value;
//       requisitionSlipController.Location.text="OFFICE";
//       requisitionSlipController.Totaldays.text="1";
//       requisitionSlipController.type.value="Leave";
//       requisitionSlipController.TotalHrs.text="0";
//       requisitionSlipController.Reason.text="";
//       requisitionSlipController.OndutyReason.text="";
//       requisitionSlipController.PerReason.text="";
//     }
//
//     super.initState();
//   }
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
//       child: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 1, bottom: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 20,top: 10),
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         child: Text("Request No",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 20),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           readOnly: true,
//                           style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                           controller: requisitionSlipController.ReqAutoyearwise,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                           ),
//                           onChanged: (value){
//                             //nmrWklyController.deduction_paymentCalculation();
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 1, bottom: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 20,top: 10),
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         child: Text("Date",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 20),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           readOnly: true,
//                           style: TextStyle(fontSize: 13),
//                           controller: requisitionSlipController.Reqdate,
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
//
//                               var Entrydate = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(1900),
//                                   lastDate: DateTime(2100));
//                               requisitionSlipController.Reqdate.text =BaseUtitiles.selectDateFormat(Entrydate!);
//
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 1, bottom: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 20,top: 10),
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         child: Text("Staff Name",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 20),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           readOnly: true,
//                           style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                           controller: requisitionSlipController.Staffname,
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
//
//                           onTap: () {
//
//                           },
//                         ),
//
//                       ),
//
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 1, bottom: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 20,top: 10),
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         child: Text("Location",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 20),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           readOnly: true,
//                           style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                           controller: requisitionSlipController.Location,
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
//
//                           onTap: () {
//
//                           },
//                         ),
//
//                       ),
//
//                     ),
//                   ],
//                 ),
//               ),
//               Divider(
//                 thickness: 2,
//                 color: Theme.of(context).primaryColor,
//               ),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children:<Widget> [
//                         Radio<String>(
//                           value: 'Leave',
//                           groupValue: requisitionSlipController.type.value,
//                           onChanged: (value) {
//                           setState(() {
//                             requisitionSlipController.type.value = value!;
//                             requisitionSlipController.PerReason.text="";
//                             requisitionSlipController.OndutyReason.text="";
//                             requisitionSlipController.onFromtime.text="";
//                             requisitionSlipController.pFromtime.text="";
//                             requisitionSlipController.onTotime.text="";
//                             requisitionSlipController.pTotime.text="";
//                             requisitionSlipController.TotalHrs.text="";
//                           });
//                         },
//                         ),
//                   Container(
//                       child: const Text('Leave')),
//                   Radio<String>(
//                     value: 'OnDuty',
//                     groupValue: requisitionSlipController.type.value,
//                     onChanged: (value) {
//                       setState(() {
//                         requisitionSlipController.type.value = value!;
//
//                         requisitionSlipController.PerReason.text="";
//                         requisitionSlipController.pFromtime.text="";
//                         requisitionSlipController.pTotime.text="";
//                         requisitionSlipController.TotalHrs.text="";
//
//                         requisitionSlipController.Reason.text="";
//
//                       });
//                     },
//                   ),
//                   Container( child: const Text('OnDuty')),
//                   Radio<String>(
//                     value: 'Permission',
//                     groupValue: requisitionSlipController.type.value,
//                     onChanged: (value) {
//                       setState(() {
//                         requisitionSlipController.type.value = value!;
//                         requisitionSlipController.Reason.text="";
//                         requisitionSlipController.OndutyReason.text="";
//                         requisitionSlipController.onFromtime.text="";
//                         requisitionSlipController.onTotime.text="";
//                         requisitionSlipController.TotalHrs.text="";
//                       });
//                     },
//                   ),
//                   Container( child: const Text('Permission')),
//                 ],
//               ),
//
//               Divider(
//                 thickness: 2,
//                 color: Theme.of(context).primaryColor,
//               ),
//
//               Obx(() => Container(
//                 child: Visibility(
//                   visible: requisitionSlipController.type.value=="Leave"?true:false,
//                   child: Container(
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.only(left: 1, bottom: 8),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 1,
//                                     child: Container(
//                                       margin: EdgeInsets.only(left: 20,top: 10),
//                                       height: BaseUtitiles.getheightofPercentage(context, 4),
//                                       child: Text("Reason",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Container(
//                                       height: BaseUtitiles.getheightofPercentage(context, 4),
//                                       margin: EdgeInsets.only(left: 10, right: 20),
//                                       decoration: BoxDecoration(),
//                                       child: TextField(
//                                         style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                                         controller: requisitionSlipController.Reason,
//                                         textAlign: TextAlign.center,
//                                         decoration: InputDecoration(
//                                           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                           ),
//                                           border: OutlineInputBorder(),
//                                         ),
//
//                                         onTap: () {
//
//                                         },
//                                       ),
//
//                                     ),
//
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Container(
//                                     height: BaseUtitiles.getheightofPercentage(context, 4),
//                                     width: BaseUtitiles.getWidthtofPercentage(context, 40),
//                                     margin: EdgeInsets.only(left: 5, right: 5),
//                                     decoration: BoxDecoration(),
//                                     child: TextField(
//                                       style: TextStyle(fontSize: 13),
//                                       readOnly: true,
//                                       controller: requisitionSlipController.Fromdate,
//                                       decoration: InputDecoration(
//                                         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                         ),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                         ),
//                                         border: OutlineInputBorder(),
//                                         prefixIcon: Icon(Icons.date_range_sharp,
//                                             color: Theme.of(context).primaryColor),
//                                       ),
//                                       onTap: () async {
//
//                                           var Frdate = await showDatePicker(
//                                               fieldHintText: "From",
//                                               context: context,
//                                               initialDate: DateTime.now(),
//                                               firstDate: DateTime(1900),
//                                               lastDate: DateTime(2100));
//                                           requisitionSlipController.Fromdate.text = BaseUtitiles.selectDateFormat(Frdate!);
//                                           requisitionSlipController.vehicleAge(DateTime.parse(requisitionSlipController.Fromdate.text),DateTime.parse(requisitionSlipController.Todate.text));
//
//                                       },
//                                     ),
//                                   ),
//                                   Container(
//                                     height: BaseUtitiles.getheightofPercentage(context, 4),
//                                     width: BaseUtitiles.getWidthtofPercentage(context, 40),
//                                     margin: EdgeInsets.only(left: 4, right: 5),
//                                     decoration: BoxDecoration(),
//                                     child: TextField(
//                                       readOnly: true,
//                                       style: TextStyle(fontSize: 13),
//                                       controller: requisitionSlipController.Todate,
//                                       decoration: InputDecoration(
//                                         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                         ),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                         ),
//                                         border: OutlineInputBorder(),
//                                         prefixIcon: Icon(Icons.date_range_sharp,
//                                             color: Theme.of(context).primaryColor),
//                                       ),
//                                       onTap: () async {
//                                           var Todate = await showDatePicker(
//                                               context: context,
//                                               initialDate: DateTime.now(),
//                                               firstDate: DateTime(1900),
//                                               lastDate: DateTime(2100));
//                                           requisitionSlipController.Todate.text =BaseUtitiles.selectDateFormat(Todate!);
//                                           requisitionSlipController.vehicleAge(DateTime.parse(requisitionSlipController.Fromdate.text),DateTime.parse(requisitionSlipController.Todate.text));
//
//                                       },
//
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(left: 1, bottom: 8,top: 8),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 1,
//                                     child: Container(
//                                       margin: EdgeInsets.only(left: 20,top: 10),
//                                       height: BaseUtitiles.getheightofPercentage(context, 4),
//                                       child: Text("Total Days",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Container(
//                                       height: BaseUtitiles.getheightofPercentage(context, 4),
//                                       margin: EdgeInsets.only(left: 10, right: 20),
//                                       decoration: BoxDecoration(),
//                                       child: TextField(
//                                         readOnly: true,
//                                         style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                                         controller: requisitionSlipController.Totaldays,
//                                         textAlign: TextAlign.center,
//                                         decoration: InputDecoration(
//                                           contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                           ),
//                                           border: OutlineInputBorder(),
//                                         ),
//
//                                         onTap: () {
//
//                                         },
//                                       ),
//
//                                     ),
//
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Divider(
//                               thickness: 2,
//                               color: Theme.of(context).primaryColor,
//                             )
//                           ],
//                         ),
//                   ),
//                 ),
//               )),
//               Obx(() => Container(
//                 child: Visibility(
//                   visible: requisitionSlipController.type.value=="OnDuty"?true:false,
//                   child: Container(
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.only(left: 1, bottom: 8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 20,top: 10),
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   child: Text("Reason",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   margin: EdgeInsets.only(left: 10, right: 20),
//                                   decoration: BoxDecoration(),
//                                   child: TextField(
//                                     style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                                     controller: requisitionSlipController.OndutyReason,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                     ),
//
//                                     onTap: () {
//
//                                     },
//                                   ),
//
//                                 ),
//
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 1, bottom: 8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 20,top: 10),
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   child: Text("Date",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   margin: EdgeInsets.only(left: 10, right: 20),
//                                   decoration: BoxDecoration(),
//                                   child: TextField(
//                                     readOnly: true,
//                                     style: TextStyle(fontSize: 13),
//                                     controller: requisitionSlipController.ondutyDate,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                       prefixIcon: Icon(Icons.date_range_sharp,
//                                           color: Theme.of(context).primaryColor),
//                                     ),
//                                     onTap: () async {
//
//
//                                       var Entrydate = await showDatePicker(
//                                           context: context,
//                                           initialDate: DateTime.now(),
//                                           firstDate: DateTime(1900),
//                                           lastDate: DateTime(2100));
//                                       requisitionSlipController.ondutyDate.text =BaseUtitiles.selectDateFormat(Entrydate!);
//
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 1, bottom: 8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 20,top: 10),
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   child: Text("From",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   margin: EdgeInsets.only(left: 10, right: 20),
//                                   decoration: BoxDecoration(),
//                                   child: TextField(
//                                     style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                                     controller: requisitionSlipController.onFromtime,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                     ),
//
//                                     onTap: () {
//
//                                     },
//                                   ),
//
//                                 ),
//
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 20,top: 10),
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   child: Text("To",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   margin: EdgeInsets.only(left: 10, right: 20),
//                                   decoration: BoxDecoration(),
//                                   child: TextField(
//
//                                     style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                                     controller: requisitionSlipController.onTotime,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                     ),
//
//                                     onTap: () {
//
//                                     },
//                                   ),
//
//                                 ),
//
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 1, bottom: 8,top: 8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 20,top: 10),
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   child: Text("Total Hours",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   margin: EdgeInsets.only(left: 10, right: 20),
//                                   decoration: BoxDecoration(),
//                                   child: TextField(
//
//                                     style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                                     controller: requisitionSlipController.TotalHrs,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                     ),
//
//                                     onTap: () {
//
//                                     },
//                                   ),
//
//                                 ),
//
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider(
//                           thickness: 2,
//                           color: Theme.of(context).primaryColor,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//
//               Obx(() => Container(
//                 child: Visibility(
//                   visible: requisitionSlipController.type.value=="Permission"?true:false,
//                   child: Container(
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.only(left: 1, bottom: 8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 20,top: 10),
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   child: Text("Reason",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   margin: EdgeInsets.only(left: 10, right: 20),
//                                   decoration: BoxDecoration(),
//                                   child: TextField(
//                                     style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                                     controller: requisitionSlipController.PerReason,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                     ),
//
//                                     onTap: () {
//
//                                     },
//                                   ),
//
//                                 ),
//
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 1, bottom: 8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 20,top: 10),
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   child: Text("Date",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   margin: EdgeInsets.only(left: 10, right: 20),
//                                   decoration: BoxDecoration(),
//                                   child: TextField(
//                                     readOnly: true,
//                                     style: TextStyle(fontSize: 13),
//                                     controller: requisitionSlipController.perDate,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                       prefixIcon: Icon(Icons.date_range_sharp,
//                                           color: Theme.of(context).primaryColor),
//                                     ),
//                                     onTap: () async {
//
//
//                                       var Entrydate = await showDatePicker(
//                                           context: context,
//                                           initialDate: DateTime.now(),
//                                           firstDate: DateTime(1900),
//                                           lastDate: DateTime(2100));
//                                       requisitionSlipController.perDate.text =BaseUtitiles.selectDateFormat(Entrydate!);
//
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 1, bottom: 8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 20,top: 10),
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   child: Text("From",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   margin: EdgeInsets.only(left: 10, right: 20),
//                                   decoration: BoxDecoration(),
//                                   child: TextField(
//                                     style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                                     controller: requisitionSlipController.pFromtime,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                     ),
//
//                                     onTap: () {
//
//                                     },
//                                   ),
//
//                                 ),
//
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 20,top: 10),
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   child: Text("To",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   margin: EdgeInsets.only(left: 10, right: 20),
//                                   decoration: BoxDecoration(),
//                                   child: TextField(
//
//                                     style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                                     controller: requisitionSlipController.pTotime,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                     ),
//
//                                     onTap: () {
//
//                                     },
//                                   ),
//
//                                 ),
//
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 1, bottom: 8,top: 8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 20,top: 10),
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   child: Text("Total Hours",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                                   margin: EdgeInsets.only(left: 10, right: 20),
//                                   decoration: BoxDecoration(),
//                                   child: TextField(
//
//                                     style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
//                                     controller: requisitionSlipController.TotalHrs,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                                       ),
//                                       border: OutlineInputBorder(),
//                                     ),
//
//                                     onTap: () {
//
//                                     },
//                                   ),
//
//                                 ),
//
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider(
//                           thickness: 2,
//                           color: Theme.of(context).primaryColor,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//
//               Container(
//                 margin: EdgeInsets.only(top: 10,bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Theme.of(context).primaryColor,
//                     side: BorderSide(width: 3, color: Colors.black),
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                   ),
//                   onPressed: () async {
//
//                    requisitionSlipController.SaveButton_MaterialIntentScreen(context,requisitionSlipController.reqId!=0?requisitionSlipController.reqId:0);
//
//                   },
//                   child: Text( requisitionSlipController.saveButton.value),
//                 ),
//               ),
//
//               Divider(
//                 thickness: 2,
//                 color: Theme.of(context).primaryColor,
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
