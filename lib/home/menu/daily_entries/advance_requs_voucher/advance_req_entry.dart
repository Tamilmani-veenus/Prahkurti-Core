import '../../../../app_theme/app_colors.dart';
import '../../../../commonpopup/vouchertype_alert.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/advance_reqvoucher_controller.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/commonvoucher_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../commonpopup/accountnameadd_alert.dart';
import 'advance_sitewisepayment.dart';

// class Advance_Req_Voucher_EntryScreen extends StatefulWidget {
//   const Advance_Req_Voucher_EntryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<Advance_Req_Voucher_EntryScreen> createState() => _Subcont_Nmr_EntryScreenState_Site();
// }
//
// class _Subcont_Nmr_EntryScreenState_Site extends State<Advance_Req_Voucher_EntryScreen> {
//
//
//   AutoYearWiseNoController autoYearWiseNoController=Get.put(AutoYearWiseNoController());
//
//   AdvanceReqVoucherController advanceReqVoucherController=Get.put(AdvanceReqVoucherController());
//   CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
//   ProjectController projectController=Get.put(ProjectController());
//
//
//
//   @override
//   void initState(){
//
//     advanceReqVoucherController.netamountCalculation();
//     advanceReqVoucherController.saveButton.value=RequestConstant.SAVE;
//    if(advanceReqVoucherController.entrycheck==0){
//      advanceReqVoucherController.autoYearWiseNoController.text=autoYearWiseNoController.AdvReqautoYrsWise.value;
//      advanceReqVoucherController.entryDateController.text=BaseUtitiles.initiateCurrentDateFormat();
//      commonVoucherController.VoucherTypeController.text="";
//      projectController.projectname.text="";
//      projectController.selectedProjectId.value=0;
//      commonVoucherController.AccountTypename.text="";
//      commonVoucherController.Accountname.text="";
//      commonVoucherController.AccPayforname.text=RequestConstant.SELECT;
//      commonVoucherController.Paymodename.text=RequestConstant.SELECT;
//      advanceReqVoucherController.remarksController.text="";
//      advanceReqVoucherController.radioType.value="SiteWise Payment";
//    }
//
//    if(advanceReqVoucherController.editcheck==1){
//      advanceReqVoucherController.ButtonChanges(advanceReqVoucherController.editListApiDatas[0].vocId);
//      advanceReqVoucherController.radioType.value="SiteWise Payment";
//      advanceReqVoucherController.editListApiDatas.value.forEach((element) {
//        advanceReqVoucherController.vocId=element.vocId;
//        advanceReqVoucherController.autoYearWiseNoController.text=element.vocNo;
//        advanceReqVoucherController.entryDateController.text=element.vocDate.toString();
//        projectController.projectname.text=element.projectName.toString();
//        projectController.selectedProjectId.value=element.projectId;
//        commonVoucherController.VoucherTypeController.text=element.vocType=="P"?"Payment":"Receipt";
//
//        commonVoucherController.selectedAccId.value=element.accTypeId;
//        commonVoucherController.selectedAccnameId.value=element.accNameId;
//        commonVoucherController.selectedAccPayId.value=element.payFor;
//        commonVoucherController.selectedPaymodeId.value=element.payMode;
//        commonVoucherController.AccountTypename.text=element.accTypeName.toString();
//        commonVoucherController.Accountname.text=element.accNameName.toString();
//        commonVoucherController.AccPayforname.text=element.PayForName.toString();
//        commonVoucherController.Paymodename.text=element.PayModeName.toString();
//
//        advanceReqVoucherController.radioType.value=element.payType.toString();
//      });
//    }
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return   GestureDetector(
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
//                 padding: EdgeInsets.only(left: 20, bottom: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         child: TextField(
//                           controller: advanceReqVoucherController.autoYearWiseNoController,
//                           readOnly: true,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color:Theme.of(context).primaryColor, width: 1.0),
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
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 20),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           readOnly: true,
//                           controller: advanceReqVoucherController.entryDateController,
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
//                                  var Entrydate = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(1900),
//                                   lastDate: DateTime(2100));
//                                  advanceReqVoucherController.entryDateController.text =BaseUtitiles.selectDateFormat(Entrydate!);
//
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
//                   controller: commonVoucherController.VoucherTypeController,
//                   decoration: new InputDecoration(
//                     labelText: RequestConstant.VOUCHER_TYPE,
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onTap: () {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return  VoucherTypeAlert();
//                         });
//                   },
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
//                   ),
//                   onTap: () {
//                       projectController.getProjectList(context,0);
//                   },
//                 ),
//               ),


//               Container(
//                 margin: EdgeInsets.only(top: 10,bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//                   style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   readOnly: true,
//                   controller: commonVoucherController.AccountTypename,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: RequestConstant.ACCOUNT_TYPE,
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder:OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onTap: () {
//                     commonVoucherController.getAccountTypeList(context);
//                   },
//                 ),
//               ),



//               Container(
//                 margin: EdgeInsets.only(top: 10,bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//                   style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   readOnly: true,
//                   controller: commonVoucherController.Accountname,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: RequestConstant.ACCOUNT_NAME,
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onTap: () {

//                     commonVoucherController.getAccountName(context);
//                   },
//                 ),
//               ),


//               Container(
//                 margin: EdgeInsets.only(top: 5),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       flex: 1,
//                       child: InkWell(
//                         child: Container(
//                           margin: EdgeInsets.only(right: 5,left: 5),
//                           alignment: Alignment.center,
//                           height: BaseUtitiles.getheightofPercentage(context, 4),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(0),
//                             color: Theme.of(context).primaryColor,
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: Offset(0, 10),
//                                   blurRadius: 50,
//                                   color: Color(0xffEEEEEE)
//                               ),
//                             ],
//                           ),
//                           child: Icon(Icons.add_circle_outline_rounded),
//                         ),
//                         onTap: (){
//                           if (commonVoucherController.AccountTypename.text ==
//                               "OTHERS" ||
//                               commonVoucherController.AccountTypename.text ==
//                                   "SITE-OTHERS" ||
//                               commonVoucherController.AccountTypename.text ==
//                                   "MATERIAL") {
//                             if (commonVoucherController.Accountname.text ==
//                                 "--Select--" ||
//                                 commonVoucherController.Accountname.text ==
//                                     "--SELECT--") {
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return AccountnameAddAlert();
//                                   });
//                             } else {
//                               BaseUtitiles.showToast("You are Not Authorised");
//                             }
//                           } else {}
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: InkWell(
//                         child: Container(
//                           margin: EdgeInsets.only(right: 5),
//                           alignment: Alignment.center,
//                           height: BaseUtitiles.getheightofPercentage(context, 4),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(0),
//                             color: Theme.of(context).primaryColor,
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: Offset(0, 10),
//                                   blurRadius: 50,
//                                   color: Color(0xffEEEEEE)
//                               ),
//                             ],
//                           ),
//                           child: Icon(Icons.edit),
//                         ),
//                         onTap: (){
//                           if (commonVoucherController.AccountTypename.text ==
//                               "OTHERS" ||
//                               commonVoucherController.AccountTypename.text ==
//                                   "SITE-OTHERS" ||
//                               commonVoucherController.AccountTypename.text ==
//                                   "MATERIAL") {
//                             if (commonVoucherController.Accountname.text ==
//                                 "--Select--" ||
//                                 commonVoucherController.Accountname.text ==
//                                     "--SELECT--") {
//                               BaseUtitiles.showToast("You are Not Authorised");
//                             } else {
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return AccountnameAddAlert();
//                                   });
//                             }
//                           } else {
//                           }
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: InkWell(
//                         child: Container(
//                           margin: EdgeInsets.only(right: 5),
//                           alignment: Alignment.center,
//                           height: BaseUtitiles.getheightofPercentage(context, 4),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(0),
//                             color: Theme.of(context).primaryColor,
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: Offset(0, 10),
//                                   blurRadius: 50,
//                                   color: Color(0xffEEEEEE)
//                               ),
//                             ],
//                           ),
//                           child: Icon(Icons.delete_forever),
//                         ),
//                         onTap: (){
//                           if(commonVoucherController.AccountTypename.text ==
//                               "OTHERS" ||
//                               commonVoucherController.AccountTypename.text ==
//                                   "SITE-OTHERS" ||
//                               commonVoucherController.AccountTypename.text ==
//                                   "MATERIAL"){
//                             if(commonVoucherController.Accountname.text ==
//                                 "--Select--" ||
//                                 commonVoucherController.Accountname.text ==
//                                     "--SELECT--"){
//
//                             }
//                             else{
//                               commonVoucherController.Accountname_DeleteApi(commonVoucherController.selectedAccId.value, commonVoucherController.selectedAccnameId.value);
//                             }
//
//                           }
//                           else{
//
//                           }
//                         },
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),




//               Container(
//                 margin: EdgeInsets.only(top: 10),
//                 alignment: Alignment.center,
//                 height: BaseUtitiles.getheightofPercentage(context, 3),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: Theme.of(context).primaryColor,
//                   boxShadow: [
//                     BoxShadow(
//                         offset: Offset(0, 10),
//                         blurRadius: 50,
//                         color: Color(0xffEEEEEE)
//                     ),
//                   ],
//                 ),
//                 child: Text("Payment Options",style: TextStyle(fontSize: 10),),
//               ),
//


//               Container(
//                 margin: EdgeInsets.only(top: 10),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 10),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                           readOnly: true,
//                           controller: commonVoucherController.AccPayforname,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             labelText: "Pay For",
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                           ),
//                           onTap: (){
//                             commonVoucherController.getPayforList(context);
//                           },
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 10),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                           readOnly: true,
//                           controller: commonVoucherController.Paymodename,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             labelText: "Mode of Pay",
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                             ),
//                           ),
//                           onTap: (){
//                             commonVoucherController.getPaymodeList(context);
//                           },
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),


//
//               Container(
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                 margin: EdgeInsets.only(left: 10, right: 10,top: 10),
//                 decoration: BoxDecoration(),
//                 child: TextField(
//                   readOnly: true,
//                   controller: commonVoucherController.Accountname,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: "Name Through",
//                     border: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onChanged: (value){
//                     //nmrWklyController.deduction_paymentCalculation();
//                   },
//                 ),
//               ),

//               Container(
//                 margin: EdgeInsets.only(top: 2),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 60,top: 10),
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         child: Text("Amount",style: TextStyle(fontSize: 13),),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 10),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           readOnly: true,
//                           keyboardType: TextInputType.number,
//                           controller: advanceReqVoucherController.entry_amount,
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
//
//                   ],
//                 ),
//               ),
//               Container(
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                 margin: EdgeInsets.only(left: 10, right: 10,top: 10),
//                 decoration: BoxDecoration(),
//                 child: TextField(
//                   keyboardType: TextInputType.text,
//                   controller: advanceReqVoucherController.remarksController,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: "Remarks",
//                     border: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onChanged: (value){
//                     //nmrWklyController.deduction_paymentCalculation();
//                   },
//                 ),
//               ),
//               Visibility(
//                 visible: false,
//                 child: Row(
//                   children:<Widget> [
//                     Radio<String>(
//                       value: 'SiteWise Payment',
//                       groupValue: advanceReqVoucherController.radioType.value,
//                       onChanged: (value) {
//                         setState(() {
//                           advanceReqVoucherController.radioType.value = value!;
//                         });
//                       },
//                     ),
//                     Container( child: const Text('SiteWise Payment')),
//
//                   ],
//                 ),
//               ),
//
//               Visibility(
//                 visible: false,
//                 child: Container(
//                   margin: EdgeInsets.only(top: 10,bottom: 10),
//                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                   width: BaseUtitiles.getWidthtofPercentage(context, 24),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor,
//                       side: BorderSide(width: 3, color: Colors.brown),
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),
//                     ),
//                     onPressed: () async {
//
//                     },
//                     child: Text("List"),
//                   ),
//                 ),
//               ),
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

class Advance_Req_Voucher_EntryScreen extends StatefulWidget {
  const Advance_Req_Voucher_EntryScreen({Key? key}) : super(key: key);

  @override
  State<Advance_Req_Voucher_EntryScreen> createState() => _Subcont_Nmr_EntryScreenState_Site();
}

class _Subcont_Nmr_EntryScreenState_Site extends State<Advance_Req_Voucher_EntryScreen> {

  AutoYearWiseNoController autoYearWiseNoController=Get.put(AutoYearWiseNoController());

  AdvanceReqVoucherController advanceReqVoucherController=Get.put(AdvanceReqVoucherController());
  CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
  ProjectController projectController=Get.put(ProjectController());
  // CommanController commanController = Get.put(CommanController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  @override
  void initState(){
    advanceReqVoucherController.netamountCalculation();
    advanceReqVoucherController.saveButton.value=RequestConstant.SUBMIT;
     projectController.getProjectList();
    if(advanceReqVoucherController.entrycheck==0){
      advanceReqVoucherController.autoYearWiseNoController.text=autoYearWiseNoController.AdvReqautoYrsWise.value;
      advanceReqVoucherController.entryDateController.text=BaseUtitiles.initiateCurrentDateFormat();
      commonVoucherController.VoucherTypeController.text="";
      projectController.projectname.text="";
      projectController.selectedProjectId.value=0;
      commonVoucherController.AccountTypename.text="";
      commonVoucherController.Accountname.text="";
      commonVoucherController.AccPayforname.text=RequestConstant.SELECT;
      commonVoucherController.Paymodename.text=RequestConstant.SELECT;
      advanceReqVoucherController.remarksController.text="";
      advanceReqVoucherController.radioType.value="SiteWise Payment";
    }
    if(advanceReqVoucherController.editcheck==1){
      advanceReqVoucherController.ButtonChanges(advanceReqVoucherController.editListApiDatas[0].vocId);
      advanceReqVoucherController.radioType.value="SiteWise Payment";
      advanceReqVoucherController.editListApiDatas.value.forEach((element) {
        advanceReqVoucherController.vocId=element.vocId;
        advanceReqVoucherController.autoYearWiseNoController.text=element.vocNo;
        advanceReqVoucherController.entryDateController.text=element.vocDate.toString();
        projectController.projectname.text=element.projectName.toString();
        projectController.selectedProjectId.value=element.projectId;
        commonVoucherController.VoucherTypeController.text=element.vocType=="P"?"Payment":"Receipt";
        commonVoucherController.selectedAccTypeId.value=element.accTypeId;
        commonVoucherController.selectedAccnameId.value=element.accNameId;
        commonVoucherController.selectedAccPayId.value=element.payFor;
        commonVoucherController.selectedPaymodeId.value=element.payMode;
        commonVoucherController.AccountTypename.text=element.accTypeName.toString();
        commonVoucherController.Accountname.text=element.accNameName.toString();
        commonVoucherController.AccPayforname.text=element.PayForName.toString();
        commonVoucherController.Paymodename.text=element.PayModeName.toString();
        advanceReqVoucherController.radioType.value=element.payType.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Advance Requisition Voucher",
                          style: TextStyle(
                              fontSize: RequestConstant.Heading_Font_SIZE,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.grey, fontSize: 18),
                            ))
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Container(
                     width: BaseUtitiles.getWidthtofPercentage(context, 50),
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: advanceReqVoucherController.autoYearWiseNoController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Request No",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.requestNo),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '\u26A0 Enter user name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: BaseUtitiles.getWidthtofPercentage(context, 35),
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                            child: TextFormField(
                              readOnly: true,
                              controller: advanceReqVoucherController.entryDateController,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                labelText: "Due Date",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 0, minHeight: 0),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: ConstIcons.date),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '\u26A0 Enter user name';
                                }
                                return null;
                              },
                              onTap: () async {
                                if(advanceReqVoucherController.editcheck==1){

                                }
                                else{
                                  var Entrydate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
                                      builder: (context, child) {
                                        return Theme(data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Theme.of(context).primaryColor, // header background color
                                            onPrimary: Colors.white, // header text color
                                            onSurface: Colors.black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Colors.black, // button text color
                                            ),
                                          ),
                                        ),
                                          child: child!,
                                        );
                                      });
                                  advanceReqVoucherController.entryDateController.text =BaseUtitiles.selectDateFormat(Entrydate!);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: commonVoucherController.VoucherTypeController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "VOC Type",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.types),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return  VoucherTypeAlert();
                                });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: projectController.projectname,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Project Name",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.projectName),
                          ),
                          onTap: () {
                            setState(() {
                              bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value );
                            });
                          },

                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: commonVoucherController.AccountTypename,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "ACC Type",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.types),
                          ),
                          onTap: () async {
                          // await commonVoucherController.getAccountTypeList(context, 1);
                            bottomsheetControllers.AccountType(context,
                                commonVoucherController.getdropDownvalue.value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: commonVoucherController.Accountname,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "ACC Name",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.accountName),
                          ),
                          onTap: () async {
                           await commonVoucherController.getAccountName();
                           bottomsheetControllers.AccountName(context, commonVoucherController.getaccdropDownvalue.value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.only(right: 5,left: 5),
                              alignment: Alignment.center,
                              height: BaseUtitiles.getheightofPercentage(context, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: Color(0xffEEEEEE)
                                  ),
                                ],
                              ),
                              child: Icon(Icons.add_circle_outline_rounded, color: Colors.white),
                            ),
                            onTap: (){
                              if (commonVoucherController.AccountTypename.text ==
                                  "OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "SITE-OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "MATERIAL") {
                                if (commonVoucherController.Accountname.text ==
                                    "--Select--" ||
                                    commonVoucherController.Accountname.text ==
                                        "--SELECT--") {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AccountnameAddAlert();
                                      });
                                } else {
                                  BaseUtitiles.showToast("You are Not Authorised");
                                }
                              } else {}
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              alignment: Alignment.center,
                              height: BaseUtitiles.getheightofPercentage(context, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: Color(0xffEEEEEE)
                                  ),
                                ],
                              ),
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                            onTap: (){
                              if (commonVoucherController.AccountTypename.text ==
                                  "OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "SITE-OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "MATERIAL") {
                                if (commonVoucherController.Accountname.text ==
                                    "--Select--" ||
                                    commonVoucherController.Accountname.text ==
                                        "--SELECT--") {
                                  BaseUtitiles.showToast("You are Not Authorised");
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AccountnameAddAlert();
                                      });
                                }
                              } else {
                              }
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              alignment: Alignment.center,
                              height: BaseUtitiles.getheightofPercentage(context, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: Color(0xffEEEEEE)
                                  ),
                                ],
                              ),
                              child: Icon(Icons.delete_forever, color: Colors.white),
                            ),
                            onTap: (){
                              if(commonVoucherController.AccountTypename.text ==
                                  "OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "SITE-OTHERS" ||
                                  commonVoucherController.AccountTypename.text ==
                                      "MATERIAL"){
                                if(commonVoucherController.Accountname.text ==
                                    "--Select--" ||
                                    commonVoucherController.Accountname.text ==
                                        "--SELECT--"){

                                }
                                else{
                                  commonVoucherController.Accountname_DeleteApi(commonVoucherController.selectedAccnameId.value);
                                }
                              }
                              else{

                              }
                            },
                          ),
                        ),

                      ],
                    ),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        alignment: Alignment.center,
                        height: BaseUtitiles.getheightofPercentage(context, 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Payment Options",
                            style: TextStyle(
                                fontSize: RequestConstant.ALERT_Font_SIZE,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(top: 10),
                  //   alignment: Alignment.center,
                  //   height: BaseUtitiles.getheightofPercentage(context, 3),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     color: Theme.of(context).primaryColor,
                  //     boxShadow: [
                  //       BoxShadow(
                  //           offset: Offset(0, 10),
                  //           blurRadius: 50,
                  //           color: Color(0xffEEEEEE)
                  //       ),
                  //     ],
                  //   ),
                  //   child: Text("Payment Options",style: TextStyle(fontSize: 10),),
                  // ),

                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          controller: commonVoucherController.namethrough,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Name Through",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.namethrough),
                          ),
                          onTap: () {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: commonVoucherController.AccPayforname,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Pay For",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.payfor),
                          ),
                          onTap: () async {
                            await commonVoucherController.getPayforList();
                            bottomsheetControllers.Payfor(
                                context,
                                commonVoucherController
                                    .getPayfordropDownvalue.value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                readOnly: true,
                                controller: commonVoucherController.Paymodename,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Mode of Pay",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.modeofpay),
                                ),
                                onTap: () async {
                                  // await commonVoucherController.getPaymodeList(context);
                                  setState(() {
                                    bottomsheetControllers.ModeofPay(
                                        context, commonVoucherController.getpaymodedropDownvalue.value);
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 Enter user name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                controller: advanceReqVoucherController.entry_amount,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Amount",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.amount),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 Enter user name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(top: 10),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         flex: 1,
                  //         child: Container(
                  //           height: BaseUtitiles.getheightofPercentage(context, 4),
                  //           margin: EdgeInsets.only(left: 10, right: 10),
                  //           decoration: BoxDecoration(),
                  //           child: TextField(
                  //             style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                  //             readOnly: true,
                  //             controller: commonVoucherController.AccPayforname,
                  //             textAlign: TextAlign.center,
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  //               labelText: "Pay For",
                  //               border: OutlineInputBorder(),
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                  //               ),
                  //             ),
                  //             onTap: (){
                  //               commonVoucherController.getPayforList(context);
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Container(
                  //           height: BaseUtitiles.getheightofPercentage(context, 4),
                  //           margin: EdgeInsets.only(left: 10, right: 10),
                  //           decoration: BoxDecoration(),
                  //           child: TextField(
                  //             style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                  //             readOnly: true,
                  //             controller: commonVoucherController.Paymodename,
                  //             textAlign: TextAlign.center,
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  //               labelText: "Mode of Pay",
                  //               border: OutlineInputBorder(),
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                  //               ),
                  //             ),
                  //             onTap: (){
                  //               commonVoucherController.getPaymodeList(context);
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //
                  // Container(
                  //   margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       side: BorderSide(color: Colors.white70, width: 1),
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     elevation: 3,
                  //     child: Padding(
                  //       padding:
                  //       const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                  //       child: TextFormField(
                  //         controller: commonVoucherController.namethrough,
                  //         cursorColor: Colors.black,
                  //         style: TextStyle(color: Colors.black),
                  //         decoration: InputDecoration(
                  //           contentPadding: EdgeInsets.zero,
                  //           border: InputBorder.none,
                  //           labelText: "Name Through",
                  //           labelStyle: TextStyle(
                  //               color: Colors.grey,
                  //               fontSize: RequestConstant.Lable_Font_SIZE),
                  //           prefixIconConstraints:
                  //           BoxConstraints(minWidth: 0, minHeight: 0),
                  //           prefixIcon: Padding(
                  //               padding: EdgeInsets.symmetric(
                  //                   vertical: 8, horizontal: 8),
                  //               child: Icon(Icons.account_circle,
                  //                   color: Theme.of(context).primaryColor)),
                  //         ),
                  //         onTap: () {
                  //
                  //
                  //         },
                  //
                  //         validator: (value) {
                  //           if (value!.isEmpty) {
                  //             return '\u26A0 Enter user name';
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //
                  // Container(
                  //   margin: EdgeInsets.only(top: 2),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         flex: 1,
                  //         child: Container(
                  //           margin: EdgeInsets.only(left: 60,top: 10),
                  //           height: BaseUtitiles.getheightofPercentage(context, 4),
                  //           child: Text("Amount",style: TextStyle(fontSize: 13),),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Container(
                  //           height: BaseUtitiles.getheightofPercentage(context, 4),
                  //           margin: EdgeInsets.only(left: 10, right: 10),
                  //           decoration: BoxDecoration(),
                  //           child: TextField(
                  //             readOnly: true,
                  //             keyboardType: TextInputType.number,
                  //             controller: advanceReqVoucherController.entry_amount,
                  //             textAlign: TextAlign.center,
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  //               border: OutlineInputBorder(),
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                  //               ),
                  //             ),
                  //             onChanged: (value){
                  //               //nmrWklyController.deduction_paymentCalculation();
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(

                          controller: advanceReqVoucherController.remarksController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Remarks",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.remarks),
                          ),


                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter user name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Setmybackground,
                          ),
                          onPressed: () {
                            if(projectController.selectedProjectId.value==0){
                              BaseUtitiles.showToast("Please select Project Name");
                            }
                            else{
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          advance_sitewisepayment()));
                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return SitewisePaymentAlert();
                              //     });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add, color: Theme.of(context).primaryColor,),
                              SizedBox(width: 5),
                              Text("Add Items", style: TextStyle(color: Theme.of(context).primaryColor),),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: BaseUtitiles.getheightofPercentage(context, 18)),

                ],
              ),
            ),

            Obx(()=>Container(
              child: Visibility(
                visible: advanceReqVoucherController.ItemGetTableListdata.value.isEmpty?false:true,
                child: Container(
                  height: BaseUtitiles.getheightofPercentage(context, 100),
                  child: DraggableScrollableSheet(
                    minChildSize: 0.1,
                    maxChildSize: 0.9,
                    initialChildSize: 0.3,
                    builder: (BuildContext context, ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Setmybackground,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height * 0.9,
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    children: [
                                      // SizedBox(height: 30),

                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: ListDetails(context, scrollController)

                                      ),


                                    ],
                                  ),
                                )),
                            IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20, bottom: 20),
                                      height: 5,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),


                ),
              ),
            )),

          ],
        ),

        bottomNavigationBar: Container(
          height: BaseUtitiles.getheightofPercentage(context, 4),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color:  advanceReqVoucherController.checkColor == 0 ? Colors.white : Theme.of(context).primaryColor ,
                    ),
                    alignment: Alignment.center,
                    child: Text("Reset",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                          color:  advanceReqVoucherController.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white ),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      advanceReqVoucherController.checkColor = 1;
                    });
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 20 , right: 20),
                    height: BaseUtitiles.getheightofPercentage(context, 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: advanceReqVoucherController.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white  ,
                    ),
                    alignment: Alignment.center,
                    child: Text(advanceReqVoucherController.editcheck==1? "Re-Submit":"Submit",  style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                        color:  advanceReqVoucherController.checkColor == 0 ? Colors.white :  Theme.of(context).primaryColor ),),
                  ),
                  onTap: () async {
                    //   advanceReqVoucherController.checkColor = 0;
                    //   BaseUtitiles.showLoadingDialog(context,Colors.cyan);
                    // await  advanceReqVoucherController.SaveApi_ItemlistScreen(context,advanceReqVoucherController.vocId);
                    // await  advanceReqVoucherController.getItemlistTablesDatas();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ListDetails(BuildContext context, ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5)),
          Obx(() => ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: ScrollPhysics(),
          itemCount: advanceReqVoucherController.ItemGetTableListdata.length,
          itemBuilder: (BuildContext context, int index) {
            advanceReqVoucherController.itemlist_textControllersInitiate();
            return Container(
              margin: EdgeInsets.only(left: 5, right: 5,bottom: 10,top: 10),
              child: Column(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    margin: EdgeInsets.only(left: 5,right: 5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Text(
                                  advanceReqVoucherController.ItemGetTableListdata[index].siteName.toString(),
                                  style: TextStyle(
                                      color: Colors.blue.shade800,fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  child:
                                  Container(
                                    height:
                                    BaseUtitiles.getheightofPercentage(context,2),
                                    width: BaseUtitiles.getWidthtofPercentage(context, 8),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AlertDialog(
                                                title: Text(RequestConstant.DO_YOU_WANT_DELETE),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                      child: Text(RequestConstant.NO),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }
                                                  ),
                                                  ElevatedButton(
                                                      child: Text(RequestConstant.YES),
                                                      onPressed: () {
                                                        advanceReqVoucherController.deleteParticularList(advanceReqVoucherController.ItemGetTableListdata.value[index]);
                                                        advanceReqVoucherController.ItemGetTableListdata.remove(advanceReqVoucherController.ItemGetTableListdata[index]);
                                                        advanceReqVoucherController.getItemlistTablesDatas();
                                                        Navigator.pop(context);
                                                      }
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                      child: Image.asset('assets/cancle.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,

                            children:<Widget> [
                              Expanded(

                                  child: Text("Site Name",style: TextStyle(color: Colors.black),)),
                              Expanded(
                                  child: Text(advanceReqVoucherController.ItemGetTableListdata[index].siteName.toString(),style: TextStyle(color: Colors.black),)), //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:<Widget> [
                              Expanded(child: Text("Payment Type",style: TextStyle(color: Colors.black),)),
                              Expanded(child: Text(advanceReqVoucherController.ItemGetTableListdata[index].paymentType.toString(),style: TextStyle(color: Colors.black),)), //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:<Widget> [
                              Expanded(child: Text("Amount",style: TextStyle(color: Colors.black),)),
                              Expanded(child: Text(advanceReqVoucherController.ItemGetTableListdata[index].amount.toString(),style: TextStyle(color: Colors.black),)), //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:<Widget> [
                              Expanded(child: Text("Net Amount",style: TextStyle(color: Colors.black),)),
                              Expanded(child: Text(advanceReqVoucherController.ItemGetTableListdata[index].netAmount.toString(),style: TextStyle(color: Colors.black),)), //   Text(inward_controller.inwardItemListdatas[index].inwQty.toString(),style: TextStyle(color: Colors.white),)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            );
          },
    )),
        ],
      )
    );
  }
}