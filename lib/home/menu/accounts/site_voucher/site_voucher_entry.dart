// import '../../../../app_theme/app_colors.dart';
// import '../../../../controller/auto_yrwise_no_controller.dart';
// import '../../../../controller/commonvoucher_controller.dart';
// import '../../../../controller/dailyentries_controller.dart';
// import '../../../../controller/logincontroller.dart';
// import '../../../../controller/nmrweeklybill_controller.dart';
// import '../../../../controller/projectcontroller.dart';
// import '../../../../controller/sitecontroller.dart';
// import '../../../../controller/sitevoucher_controller.dart';
// import '../../../../controller/subcontcontroller.dart';
// import '../../../../home/menu/accounts/site_voucher/sitevoucher_activity.dart';
// import '../../../../utilities/baseutitiles.dart';
// import '../../../../utilities/requestconstant.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../../../../commonpopup/accountnameadd_alert.dart';
// import '../../../../commonpopup/vouchertype_alert.dart';
//
// class Site_Voucher_EntryScreen extends StatefulWidget {
//   const Site_Voucher_EntryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<Site_Voucher_EntryScreen> createState() =>
//       _Subcont_Nmr_EntryScreenState_Site();
// }
//
// class _Subcont_Nmr_EntryScreenState_Site
//     extends State<Site_Voucher_EntryScreen> {
//   ProjectController projectController = Get.put(ProjectController());
//   SubcontractorController subcontractorController = Get.put(SubcontractorController());
//   SiteController siteController = Get.put(SiteController());
//   AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
//   NMRWklyController nmrWklyController = Get.put(NMRWklyController());
//   DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
//   SiteVoucher_Controller siteVoucher_Controller = Get.put(SiteVoucher_Controller());
//   CommonVoucherController commonVoucherController = Get.put(CommonVoucherController());
//   LoginController loginController=Get.put(LoginController());
//
//   @override
//   void initState() {
//     var duration = Duration(seconds:0);
//     Future.delayed(duration,() async {
//       await projectController.getProjectList(context, 0);
//       await autoYearWiseNoController.SiteVoucherAutoYear();
//       siteVoucher_Controller.netamountCalculation();
//       siteVoucher_Controller.AutoYearwiseSiteVoc.text = autoYearWiseNoController.SiteVoucher_autoYrsWise.value;
//       siteVoucher_Controller.VocID = 0;
//       if (siteVoucher_Controller.editcheck == 1) {
//         siteVoucher_Controller.SaveButton.value = RequestConstant.UPDATE;
//         siteVoucher_Controller.Sitevoucher_EditListApiValue.forEach((element) {
//           siteVoucher_Controller.VocID = element.vocId;
//           siteVoucher_Controller.AutoYearwiseSiteVoc.text = element.vocNo;
//           siteVoucher_Controller.sitevocDate.text = element.vocDate;
//           commonVoucherController.VocType = element.vocType;
//           commonVoucherController.VoucherTypeController.text =
//           element.vocType == "P" ? "Payment" : "Receipt";
//           projectController.projectname.text = element.projectName;
//           projectController.selectedProjectId.value = element.projectId;
//           commonVoucherController.AccountTypename.text = element.accTypeName;
//           commonVoucherController.selectedAccId.value = element.accTypeId;
//           commonVoucherController.Accountname.text = element.accNameName;
//           commonVoucherController.selectedAccnameId.value = element.accNameId;
//           commonVoucherController.selectedAccPayId.value = element.payFor;
//           commonVoucherController.namethrough.text=element.nameThrough;
//           commonVoucherController.selectedPaymodeId.value = element.payMode;
//           // siteVoucher_Controller.Amount.text = element.vocAmt.toString();
//           siteVoucher_Controller.Remarks.text = element.remarks;
//           siteVoucher_Controller.type.value = element.payType == "SP"
//               ? "SiteWise Payment"
//               : "Direct Payment/Office";
//           siteVoucher_Controller.Button.value =
//           element.payType == "SP" ? "List" : "Update";
//           commonVoucherController.AccPayforname.text = element.payForName;
//           commonVoucherController.Paymodename.text = element.payModeName;
//         });
//       }
//       if (siteVoucher_Controller.itemcheck == 0 && siteVoucher_Controller.Active == 0) {
//         siteVoucher_Controller.SaveButton.value = RequestConstant.SAVE;
//         siteVoucher_Controller.Button.value = RequestConstant.SAVE;
//         siteController.selectedsiteId = 0.obs;
//         siteVoucher_Controller.type.value = "Direct Payment/Office";
//         siteVoucher_Controller.delete_Sitevoucher_itemlist_Table();
//         siteVoucher_Controller.Sitevoucher_itemview_GetDbList.clear();
//         // siteVoucher_Controller.Amount.text = "0.00";
//         siteController.selectedsitedropdownName = "--Select--".obs;
//         siteController.getSiteDropdownvalue.value.clear();
//         siteController.Sitename.text = RequestConstant.SELECT;
//         siteController.siteDropdownName.clear();
//         commonVoucherController.VoucherTypeController.text = "Payment";
//         projectController.projectname.text = "--Select--";
//         projectController.selectedProjectId.value=0;
//         commonVoucherController.VocType = "P";
//         commonVoucherController.AccountTypename.text = "--Select--";
//         commonVoucherController.Accountname.text = "--Select--";
//         commonVoucherController.selectedAccnameId=0.obs;
//         commonVoucherController.setSelectedAccPayForListName("A");
//         siteVoucher_Controller.AutoYearwiseSiteVoc.text =
//             autoYearWiseNoController.SiteVoucher_autoYrsWise.value;
//         siteVoucher_Controller.sitevocDate.text =
//             BaseUtitiles.initiateCurrentDateFormat();
//         commonVoucherController.Paymodename.text = "--Select--";
//         commonVoucherController.AccPayforname.text = "--Select--";
//         siteVoucher_Controller.Remarks.text = "";
//         commonVoucherController.Accountname.text="--SELECT--";
//         commonVoucherController.namethrough.text="";
//       }
//     });
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
//                           controller:
//                               siteVoucher_Controller.AutoYearwiseSiteVoc,
//                           readOnly: true,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Theme.of(context).primaryColor,
//                                   width: 1.0),
//                             ),
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
//                           style: TextStyle(fontSize: 13),
//                           readOnly: true,
//                           controller: siteVoucher_Controller.sitevocDate,
//                           decoration: InputDecoration(
//                             contentPadding:
//                                 EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Theme.of(context).primaryColor,
//                                   width: 1.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Theme.of(context).primaryColor,
//                                   width: 1.0),
//                             ),
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.date_range_sharp,
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                           onTap: () async {
//                             var Entrydate = await showDatePicker(
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
//                             siteVoucher_Controller.sitevocDate.text = BaseUtitiles.selectDateFormat(Entrydate!);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 10, bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//                   style:
//                       TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   readOnly: true,
//                   controller: commonVoucherController.VoucherTypeController,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: RequestConstant.VOUCHER_TYPE,
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onTap: () {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return VoucherTypeAlert();
//                         });
//                   },
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 10, bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//                   style:
//                       TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   readOnly: true,
//                   controller: projectController.projectname,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: "Project Name *",
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onTap: () {
//                     if (siteVoucher_Controller.editcheck == 1) {
//
//                     }
//                     else {
//                       projectController.getProjectList(context, 0);
//                     }
//                   },
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 10, bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//                   style:
//                       TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   readOnly: true,
//                   controller: commonVoucherController.AccountTypename,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: RequestConstant.ACCOUNT_TYPE,
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onTap: () {
//                     commonVoucherController.getAccountTypeList(context,0);
//                   },
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 10, bottom: 10),
//                 height: BaseUtitiles.getheightofPercentage(context, 5),
//                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                 child: TextField(
//                   style:
//                       TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
//                   readOnly: true,
//                   controller: commonVoucherController.Accountname,
//                   decoration: new InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: RequestConstant.ACCOUNT_NAME,
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor, width: 1.0),
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
//                           margin: EdgeInsets.only(right: 5, left: 5),
//                           alignment: Alignment.center,
//                           height:
//                               BaseUtitiles.getheightofPercentage(context, 4),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(0),
//                             color: Theme.of(context).primaryColor,
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: Offset(0, 10),
//                                   blurRadius: 50,
//                                   color: Color(0xffEEEEEE)),
//                             ],
//                           ),
//                           child: Icon(Icons.add_circle_outline_rounded,color: Colors.white,),
//                         ),
//                         onTap: () {
//                           if (commonVoucherController.AccountTypename.text == "OTHERS" || commonVoucherController.AccountTypename.text == "SITE-OTHERS" || commonVoucherController.AccountTypename.text == "MATERIAL") {
//                             if (commonVoucherController.Accountname.text == "--Select--" || commonVoucherController.Accountname.text == "--SELECT--") {
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return AccountnameAddAlert();
//                                   });
//                             } else {
//                               BaseUtitiles.showToast("You are not Authorised");
//                             }
//                           } else {
//                             BaseUtitiles.showToast("You are not Authorised");
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
//                           height:
//                               BaseUtitiles.getheightofPercentage(context, 4),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(0),
//                             color: Theme.of(context).primaryColor,
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: Offset(0, 10),
//                                   blurRadius: 50,
//                                   color: Color(0xffEEEEEE)),
//                             ],
//                           ),
//                           child: Icon(Icons.edit,color: Colors.white,),
//                         ),
//                         onTap: () {
//                           if (commonVoucherController.AccountTypename.text ==
//                                   "OTHERS" ||
//                               commonVoucherController.AccountTypename.text ==
//                                   "SITE-OTHERS" ||
//                               commonVoucherController.AccountTypename.text ==
//                                   "MATERIAL") {
//                             if (commonVoucherController.Accountname.text ==
//                                     "--Select--" ||
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
//
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
//                                   color: Color(0xffEEEEEE)),
//                             ],
//                           ),
//                           child: Icon(Icons.delete_forever,color: Colors.white,),
//                         ),
//                         onTap: (){
//                             if(commonVoucherController.AccountTypename.text ==
//                                 "OTHERS" ||
//                                 commonVoucherController.AccountTypename.text ==
//                                     "SITE-OTHERS" ||
//                                 commonVoucherController.AccountTypename.text ==
//                                     "MATERIAL"){
//                               if(commonVoucherController.Accountname.text ==
//                                   "--Select--" ||
//                                   commonVoucherController.Accountname.text ==
//                                       "--SELECT--"){
//
//                               }
//                               else{
//                                 if(loginController.UserType()=="A"){
//                                   commonVoucherController.DeleteAlert(context);
//                                 }
//                                 else{
//                                   BaseUtitiles.showToast("Contact to Admin");
//                                 }
//                               }
//
//                             }
//                             else{
//
//                             }
//                         },
//                       ),
//                     ),
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
//                         color: Color(0xffEEEEEE)),
//                   ],
//                 ),
//                 child: Text(
//                   "Payment Option",
//                   style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 12),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         margin: EdgeInsets.only(left: 10, right: 10),
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           style: TextStyle(
//                               fontSize: RequestConstant.Dropdown_Font_SIZE),
//                           readOnly: true,
//                           controller: commonVoucherController.AccPayforname,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                             labelText:  "Pay For *",
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Theme.of(context).primaryColor,
//                                   width: 1.0),
//                             ),
//                           ),
//                           onTap: () {
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
//                           style: TextStyle(
//                               fontSize: RequestConstant.Dropdown_Font_SIZE),
//                           readOnly: true,
//                           controller: commonVoucherController.Paymodename,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                             labelText:  "Mode of Payment *",
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Theme.of(context).primaryColor,
//                                   width: 1.0),
//                             ),
//                           ),
//                           onTap: () {
//                             commonVoucherController.getPaymodeList(context);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                 margin: EdgeInsets.only(left: 10, right: 10,top: 10),
//                 decoration: BoxDecoration(),
//                 child: TextField(
//                   controller: commonVoucherController.namethrough,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     labelText:  "Name Through",
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     border: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onChanged: (value) {
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
//                         margin: EdgeInsets.only(left: 60, top: 10),
//                         height: BaseUtitiles.getheightofPercentage(context, 4),
//                         child: Text(
//                           "Amount *",
//                           style: TextStyle(fontSize: 13),
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
//                           readOnly: siteVoucher_Controller.Button.value == "List"?true:false,
//                           keyboardType: TextInputType.number,
//                           controller: siteVoucher_Controller.Amount,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                             border: OutlineInputBorder(),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Theme.of(context).primaryColor,
//                                   width: 1.0),
//                             ),
//                           ),
//                           onChanged: (value) {
//                             //nmrWklyController.deduction_paymentCalculation();
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                 margin: EdgeInsets.only(left: 10, right: 10, top: 10),
//                 decoration: BoxDecoration(),
//                 child: TextField(
//                   keyboardType: TextInputType.text,
//                   controller: siteVoucher_Controller.Remarks,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                     labelText: "Remarks",
//                     border: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor, width: 1.0),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     //nmrWklyController.deduction_paymentCalculation();
//                   },
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Radio<String>(
//                     value: 'Direct Payment/Office',
//                     groupValue: siteVoucher_Controller.type.value,
//                     onChanged: (value) {
//                       setState(() {
//                         siteVoucher_Controller.type.value = value!;
//                         siteVoucher_Controller.Button =
//                             RequestConstant.SAVE.obs;
//                       });
//                     },
//                   ),
//                   Container(child: const Text('Direct Payment/Office')),
//                   Radio<String>(
//                     value: 'SiteWise Payment',
//                     groupValue: siteVoucher_Controller.type.value,
//                     onChanged: (value) {
//                       setState(() {
//                         siteVoucher_Controller.type.value = value!;
//                         siteVoucher_Controller.Button =
//                             RequestConstant.LIST.obs;
//                       });
//                     },
//                   ),
//                   Container(child: const Text('SiteWise Payment')),
//                 ],
//               ),
//               Container(
//                 child: Container(
//                   margin: EdgeInsets.only(top: 10, bottom: 10),
//                   height: BaseUtitiles.getheightofPercentage(context, 4),
//                   width: BaseUtitiles.getWidthtofPercentage(context, 24),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor,
//                       side: BorderSide(width: 3, color: Colors.black),
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),
//                     ),
//                     onPressed: () async {
//                         if (siteVoucher_Controller.Button.value == "List") {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Site_Voucher_Activity(1)),
//                           );
//                         } else {
//                           if(projectController.selectedProjectId.value==0 ||commonVoucherController.AccountTypename.text == "--Select--"||commonVoucherController.Accountname.text=="--Select--"||commonVoucherController.Paymodename.text=="--Select--"||commonVoucherController.AccPayforname.text=="--Select--"||double.parse(siteVoucher_Controller.Amount.text)==0.0){
//                             BaseUtitiles.showToast("Some field is missing");
//                           }
//                           else{
//                             siteVoucher_Controller.SaveButtonSitevoucher_ItemlistScreen(context,
//                                 siteVoucher_Controller.VocID != 0
//                                     ? siteVoucher_Controller.VocID
//                                     : 0);
//                           }
//                         }
//
//                     },
//                     child: Text(siteVoucher_Controller.Button.value),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
